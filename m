From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: soc-cache: block based rbtree
	compression
Date: Mon,  2 May 2011 13:26:20 +0100
Message-ID: <1304339181-27648-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 422AB24371
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 14:26:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch prepares the ground for the actual rbtree optimization patch
which will save a pointer to the last accessed register block that was used
in either the read() or write() functions.

Each node manages a block of up to RBTREE_BLOCK_NUM registers.  There can be
no two nodes with overlapping blocks.  Currently there is no check in the code
to scream in case that ever happens.  Each block has a base and top register,
all others lie in between these registers.  Note that variable length blocks
aren't supported.  So if you have an interval [8, 15] and only some of those
registers actually exist on the device, the block will have the non-existent
registers as zero.  There is also no way of reporting that any of those
non-existent registers were accessed/modified.

The larger the block size, the more probable it is that one of the
managed registers is non-zero, and therefore the node will need to be
allocated at initialization time and waste space.

If register N is accessed and it is not part of any of the current
blocks in the rbtree, a new node is created with a base register
which is floor(N / RBTREE_BLOCK_NUM) * RBTREE_BLOCK_NUM and a top
register as base_register + RBTREE_BLOCK_NUM - 1.  All other registers
in the block are initialized as expected and the node is inserted into
the tree.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  177 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 128 insertions(+), 49 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a217db2..c518b6e 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -593,32 +593,58 @@ static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
 	return -1;
 }
 
-struct snd_soc_rbtree_node {
-	struct rb_node node;
+struct snd_soc_rbtree_reg_blk {
 	unsigned int reg;
 	unsigned int value;
 	unsigned int defval;
 } __attribute__ ((packed));
 
+#define RBTREE_BLOCK_NUM 32
+struct snd_soc_rbtree_node {
+	struct rb_node node;
+	struct snd_soc_rbtree_reg_blk block[RBTREE_BLOCK_NUM];
+	unsigned int blklen;
+} __attribute__ ((packed));
+
 struct snd_soc_rbtree_ctx {
 	struct rb_root root;
 };
 
+static inline int snd_soc_rbtree_block_count(void)
+{
+	return RBTREE_BLOCK_NUM;
+}
+
+static inline struct snd_soc_rbtree_reg_blk *snd_soc_rbtree_base_block(
+	struct snd_soc_rbtree_node *rbnode)
+{
+	return &rbnode->block[0];
+}
+
+static inline struct snd_soc_rbtree_reg_blk *snd_soc_rbtree_top_block(
+	struct snd_soc_rbtree_node *rbnode)
+{
+	return &rbnode->block[snd_soc_rbtree_block_count() - 1];
+}
+
 static struct snd_soc_rbtree_node *snd_soc_rbtree_lookup(
 	struct rb_root *root, unsigned int reg)
 {
 	struct rb_node *node;
 	struct snd_soc_rbtree_node *rbnode;
+	struct snd_soc_rbtree_reg_blk *baseblk, *topblk;
 
 	node = root->rb_node;
 	while (node) {
 		rbnode = container_of(node, struct snd_soc_rbtree_node, node);
-		if (rbnode->reg < reg)
-			node = node->rb_left;
-		else if (rbnode->reg > reg)
-			node = node->rb_right;
-		else
+		baseblk = snd_soc_rbtree_base_block(rbnode);
+		topblk = snd_soc_rbtree_top_block(rbnode);
+		if (reg >= baseblk->reg && reg <= topblk->reg)
 			return rbnode;
+		else if (reg > topblk->reg)
+			node = node->rb_right;
+		else if (reg < baseblk->reg)
+			node = node->rb_left;
 	}
 
 	return NULL;
@@ -629,19 +655,28 @@ static int snd_soc_rbtree_insert(struct rb_root *root,
 {
 	struct rb_node **new, *parent;
 	struct snd_soc_rbtree_node *rbnode_tmp;
+	struct snd_soc_rbtree_reg_blk *baseblk_tmp, *topblk_tmp;
+	struct snd_soc_rbtree_reg_blk *baseblk;
 
 	parent = NULL;
 	new = &root->rb_node;
 	while (*new) {
 		rbnode_tmp = container_of(*new, struct snd_soc_rbtree_node,
 					  node);
+		/* base and top blocks of the current rbnode */
+		baseblk_tmp = snd_soc_rbtree_base_block(rbnode_tmp);
+		topblk_tmp = snd_soc_rbtree_top_block(rbnode_tmp);
+		/* base block of the rbnode to be added */
+		baseblk = snd_soc_rbtree_base_block(rbnode);
 		parent = *new;
-		if (rbnode_tmp->reg < rbnode->reg)
-			new = &((*new)->rb_left);
-		else if (rbnode_tmp->reg > rbnode->reg)
-			new = &((*new)->rb_right);
-		else
+		/* if this block has already been inserted, just return */
+		if (baseblk->reg >= baseblk_tmp->reg &&
+		    baseblk->reg <= topblk_tmp->reg)
 			return 0;
+		else if (baseblk->reg > topblk_tmp->reg)
+			new = &((*new)->rb_right);
+		else if (baseblk->reg < baseblk_tmp->reg)
+			new = &((*new)->rb_left);
 	}
 
 	/* insert the node into the rbtree */
@@ -656,26 +691,31 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct rb_node *node;
 	struct snd_soc_rbtree_node *rbnode;
-	unsigned int val;
+	struct snd_soc_rbtree_reg_blk *regblk;
+	unsigned int val, i;
 	int ret;
 
 	rbtree_ctx = codec->reg_cache;
+	/* for each node sync all its blocks */
 	for (node = rb_first(&rbtree_ctx->root); node; node = rb_next(node)) {
 		rbnode = rb_entry(node, struct snd_soc_rbtree_node, node);
-		if (rbnode->value == rbnode->defval)
-			continue;
-		WARN_ON(codec->writable_register &&
-			codec->writable_register(codec, rbnode->reg));
-		ret = snd_soc_cache_read(codec, rbnode->reg, &val);
-		if (ret)
-			return ret;
-		codec->cache_bypass = 1;
-		ret = snd_soc_write(codec, rbnode->reg, val);
-		codec->cache_bypass = 0;
-		if (ret)
-			return ret;
-		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
-			rbnode->reg, val);
+		for (i = 0; i < rbnode->blklen; ++i) {
+			regblk = &rbnode->block[i];
+			if (regblk->value == regblk->defval)
+				continue;
+			WARN_ON(codec->writable_register &&
+				codec->writable_register(codec, regblk->reg));
+			ret = snd_soc_cache_read(codec, regblk->reg, &val);
+			if (ret)
+				return ret;
+			codec->cache_bypass = 1;
+			ret = snd_soc_write(codec, regblk->reg, val);
+			codec->cache_bypass = 0;
+			if (ret)
+				return ret;
+			dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
+				regblk->reg, val);
+		}
 	}
 
 	return 0;
@@ -686,27 +726,40 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 {
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct snd_soc_rbtree_node *rbnode;
+	struct snd_soc_rbtree_reg_blk *regblk;
+	struct snd_soc_rbtree_reg_blk *baseblk;
+	unsigned int base_reg;
+	int blkcount, i;
 
 	rbtree_ctx = codec->reg_cache;
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
-		if (rbnode->value == value)
+		baseblk = snd_soc_rbtree_base_block(rbnode);
+		regblk = &rbnode->block[reg - baseblk->reg];
+		if (regblk->value == value)
 			return 0;
-		rbnode->value = value;
+		regblk->value = value;
 	} else {
 		/* bail out early, no need to create the rbnode yet */
 		if (!value)
 			return 0;
 		/*
-		 * for uninitialized registers whose value is changed
-		 * from the default zero, create an rbnode and insert
-		 * it into the tree.
+		 * if the value of any of the uninitialized registers in a
+		 * block is changed from the default zero, create an rbnode
+		 * and insert it into the tree.  Make sure to initialize all
+		 * the registers in the block.
 		 */
 		rbnode = kzalloc(sizeof *rbnode, GFP_KERNEL);
 		if (!rbnode)
 			return -ENOMEM;
-		rbnode->reg = reg;
-		rbnode->value = value;
+		blkcount = snd_soc_rbtree_block_count();
+		base_reg = (reg / blkcount) * blkcount;
+		for (i = 0; i < blkcount; ++i) {
+			regblk = &rbnode->block[i];
+			regblk->reg = base_reg + i;
+			if (regblk->reg == reg)
+				regblk->value = value;
+		}
 		snd_soc_rbtree_insert(&rbtree_ctx->root, rbnode);
 	}
 
@@ -718,11 +771,13 @@ static int snd_soc_rbtree_cache_read(struct snd_soc_codec *codec,
 {
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct snd_soc_rbtree_node *rbnode;
+	struct snd_soc_rbtree_reg_blk *baseblk;
 
 	rbtree_ctx = codec->reg_cache;
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
-		*value = rbnode->value;
+		baseblk = snd_soc_rbtree_base_block(rbnode);
+		*value = rbnode->block[reg - baseblk->reg].value;
 	} else {
 		/* uninitialized registers default to 0 */
 		*value = 0;
@@ -762,10 +817,13 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 {
 	struct snd_soc_rbtree_node *rbtree_node;
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
-	unsigned int val;
+	unsigned int reg, val;
 	unsigned int word_size;
-	int i;
+	int i, j;
 	int ret;
+	int blkcount;
+	int numblocks;
+	int flag;
 
 	codec->reg_cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
 	if (!codec->reg_cache)
@@ -777,28 +835,49 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	if (!codec->reg_def_copy)
 		return 0;
 
-	/*
-	 * populate the rbtree with the initialized registers.  All other
-	 * registers will be inserted when they are first modified.
-	 */
 	word_size = codec->driver->reg_word_size;
-	for (i = 0; i < codec->driver->reg_cache_size; ++i) {
-		val = snd_soc_get_cache_val(codec->reg_def_copy, i, word_size);
-		if (!val)
+	blkcount = snd_soc_rbtree_block_count();
+	numblocks = (codec->driver->reg_cache_size - 1 + blkcount) / blkcount;
+	for (i = 0; i < numblocks; ++i) {
+		/* check if a block is comprised of uninitialized registers only */
+		for (j = 0, flag = 0; j < blkcount; ++j) {
+			reg = i * blkcount + j;
+			if (reg >= codec->driver->reg_cache_size)
+				break;
+			val = snd_soc_get_cache_val(codec->reg_def_copy,
+						    reg, word_size);
+			if (val) {
+				flag = 1;
+				break;
+			}
+		}
+		/* ignore this block until one of its registers is modified */
+		if (!flag)
 			continue;
 		rbtree_node = kzalloc(sizeof *rbtree_node, GFP_KERNEL);
 		if (!rbtree_node) {
 			ret = -ENOMEM;
-			snd_soc_cache_exit(codec);
-			break;
+			goto err;
+		}
+		/* initialize the register block */
+		for (j = 0; j < blkcount; ++j) {
+			reg = i * blkcount + j;
+			if (reg >= codec->driver->reg_cache_size)
+				break;
+			val = snd_soc_get_cache_val(codec->reg_def_copy, reg, word_size);
+			rbtree_node->block[j].reg = reg;
+			rbtree_node->block[j].value = val;
+			rbtree_node->block[j].defval = val;
 		}
-		rbtree_node->reg = i;
-		rbtree_node->value = val;
-		rbtree_node->defval = val;
+		rbtree_node->blklen = j;
 		snd_soc_rbtree_insert(&rbtree_ctx->root, rbtree_node);
 	}
 
 	return 0;
+
+err:
+	snd_soc_cache_exit(codec);
+	return ret;
 }
 
 #ifdef CONFIG_SND_SOC_CACHE_LZO
-- 
1.7.5
