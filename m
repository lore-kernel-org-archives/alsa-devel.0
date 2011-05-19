From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2 v3] ASoC: soc-cache: Block based rbtree
	compression
Date: Thu, 19 May 2011 13:45:29 +0100
Message-ID: <1305809130-18410-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6025110384B
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 14:45:39 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch prepares the ground for the actual rbtree optimization patch
which will save a pointer to the last accessed rbnode that was used
in either the read() or write() functions.

Each rbnode manages a variable length block of registers.  There can be no
two nodes with overlapping blocks.  Each block has a base register and a
currently top register, all the other registers, if any, lie in between these
two and in ascending order.

The reasoning behind the construction of this rbtree is simple.  In the
snd_soc_rbtree_cache_init() function, we iterate over the register defaults
provided by the driver.  For each register value that is non-zero we
insert it in the rbtree.  In order to determine in which rbnode we need
to add the register, we first look if there is another register already
added that is adjacent to the one we are about to add.  If that is the case
we append it in that rbnode block, otherwise we create a new rbnode
with a single register in its block and add it to the tree.

In the next patch, where a cached rbnode is used by both the write() and the
read() functions, we also check if the register we are about to add is in the
cached rbnode (the least recently accessed one) and if so we append it in that
rbnode block.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |  232 +++++++++++++++++++++++++++++++++++++------------
 1 files changed, 177 insertions(+), 55 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 06b7b81..b72f591 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -483,31 +483,85 @@ static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
 }
 
 struct snd_soc_rbtree_node {
-	struct rb_node node;
-	unsigned int reg;
-	unsigned int value;
-	unsigned int defval;
+	struct rb_node node; /* the actual rbtree node holding this block */
+	unsigned int base_reg; /* base register handled by this block */
+	unsigned int word_size; /* number of bytes needed to represent the register index */
+	void *block; /* block of adjacent registers */
+	unsigned int blklen; /* number of registers available in the block */
 } __attribute__ ((packed));
 
 struct snd_soc_rbtree_ctx {
 	struct rb_root root;
 };
 
+static inline void snd_soc_rbtree_get_base_top_reg(
+	struct snd_soc_rbtree_node *rbnode,
+	unsigned int *base, unsigned int *top)
+{
+	*base = rbnode->base_reg;
+	*top = rbnode->base_reg + rbnode->blklen - 1;
+}
+
+static unsigned int snd_soc_rbtree_get_register(
+	struct snd_soc_rbtree_node *rbnode, unsigned int idx)
+{
+	unsigned int val;
+
+	switch (rbnode->word_size) {
+	case 1: {
+		u8 *p = rbnode->block;
+		val = p[idx];
+		return val;
+	}
+	case 2: {
+		u16 *p = rbnode->block;
+		val = p[idx];
+		return val;
+	}
+	default:
+		BUG();
+		break;
+	}
+	return -1;
+}
+
+static void snd_soc_rbtree_set_register(struct snd_soc_rbtree_node *rbnode,
+					unsigned int idx, unsigned int val)
+{
+	switch (rbnode->word_size) {
+	case 1: {
+		u8 *p = rbnode->block;
+		p[idx] = val;
+		break;
+	}
+	case 2: {
+		u16 *p = rbnode->block;
+		p[idx] = val;
+		break;
+	}
+	default:
+		BUG();
+		break;
+	}
+}
+
 static struct snd_soc_rbtree_node *snd_soc_rbtree_lookup(
 	struct rb_root *root, unsigned int reg)
 {
 	struct rb_node *node;
 	struct snd_soc_rbtree_node *rbnode;
+	unsigned int base_reg, top_reg;
 
 	node = root->rb_node;
 	while (node) {
 		rbnode = container_of(node, struct snd_soc_rbtree_node, node);
-		if (rbnode->reg < reg)
-			node = node->rb_left;
-		else if (rbnode->reg > reg)
-			node = node->rb_right;
-		else
+		snd_soc_rbtree_get_base_top_reg(rbnode, &base_reg, &top_reg);
+		if (reg >= base_reg && reg <= top_reg)
 			return rbnode;
+		else if (reg > top_reg)
+			node = node->rb_right;
+		else if (reg < base_reg)
+			node = node->rb_left;
 	}
 
 	return NULL;
@@ -518,19 +572,28 @@ static int snd_soc_rbtree_insert(struct rb_root *root,
 {
 	struct rb_node **new, *parent;
 	struct snd_soc_rbtree_node *rbnode_tmp;
+	unsigned int base_reg_tmp, top_reg_tmp;
+	unsigned int base_reg;
 
 	parent = NULL;
 	new = &root->rb_node;
 	while (*new) {
 		rbnode_tmp = container_of(*new, struct snd_soc_rbtree_node,
 					  node);
+		/* base and top registers of the current rbnode */
+		snd_soc_rbtree_get_base_top_reg(rbnode_tmp, &base_reg_tmp,
+						&top_reg_tmp);
+		/* base register of the rbnode to be added */
+		base_reg = rbnode->base_reg;
 		parent = *new;
-		if (rbnode_tmp->reg < rbnode->reg)
-			new = &((*new)->rb_left);
-		else if (rbnode_tmp->reg > rbnode->reg)
-			new = &((*new)->rb_right);
-		else
+		/* if this register has already been inserted, just return */
+		if (base_reg >= base_reg_tmp &&
+		    base_reg <= top_reg_tmp)
 			return 0;
+		else if (base_reg > top_reg_tmp)
+			new = &((*new)->rb_right);
+		else if (base_reg < base_reg_tmp)
+			new = &((*new)->rb_left);
 	}
 
 	/* insert the node into the rbtree */
@@ -545,57 +608,120 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct rb_node *node;
 	struct snd_soc_rbtree_node *rbnode;
+	unsigned int regtmp;
 	unsigned int val;
 	int ret;
+	int i;
 
 	rbtree_ctx = codec->reg_cache;
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
+			regtmp = rbnode->base_reg + i;
+			WARN_ON(codec->writable_register &&
+				codec->writable_register(codec, regtmp));
+			val = snd_soc_rbtree_get_register(rbnode, i);
+			codec->cache_bypass = 1;
+			ret = snd_soc_write(codec, regtmp, val);
+			codec->cache_bypass = 0;
+			if (ret)
+				return ret;
+			dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
+				regtmp, val);
+		}
 	}
 
 	return 0;
 }
 
+static int snd_soc_rbtree_insert_to_block(struct snd_soc_rbtree_node *rbnode,
+					  unsigned int pos, unsigned int reg,
+					  unsigned int value)
+{
+	u8 *blk;
+
+	blk = krealloc(rbnode->block,
+		       (rbnode->blklen + 1) * rbnode->word_size, GFP_KERNEL);
+	if (!blk)
+		return -ENOMEM;
+
+	/* insert the register value in the correct place in the rbnode block */
+	memmove(blk + (pos + 1) * rbnode->word_size,
+		blk + pos * rbnode->word_size,
+		(rbnode->blklen - pos) * rbnode->word_size);
+
+	/* update the rbnode block, its size and the base register */
+	rbnode->block = blk;
+	rbnode->blklen++;
+	if (!pos)
+		rbnode->base_reg = reg;
+
+	snd_soc_rbtree_set_register(rbnode, pos, value);
+	return 0;
+}
+
 static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 				      unsigned int reg, unsigned int value)
 {
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
-	struct snd_soc_rbtree_node *rbnode;
+	struct snd_soc_rbtree_node *rbnode, *rbnode_tmp;
+	struct rb_node *node;
+	unsigned int val;
+	unsigned int reg_tmp;
+	unsigned int pos;
+	int i;
+	int ret;
 
 	rbtree_ctx = codec->reg_cache;
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
-		if (rbnode->value == value)
+		reg_tmp = reg - rbnode->base_reg;
+		val = snd_soc_rbtree_get_register(rbnode, reg_tmp);
+		if (val == value)
 			return 0;
-		rbnode->value = value;
+		snd_soc_rbtree_set_register(rbnode, reg_tmp, value);
 	} else {
 		/* bail out early, no need to create the rbnode yet */
 		if (!value)
 			return 0;
-		/*
-		 * for uninitialized registers whose value is changed
-		 * from the default zero, create an rbnode and insert
-		 * it into the tree.
+		/* look for an adjacent register to the one we are about to add */
+		for (node = rb_first(&rbtree_ctx->root); node;
+		     node = rb_next(node)) {
+			rbnode_tmp = rb_entry(node, struct snd_soc_rbtree_node, node);
+			for (i = 0; i < rbnode_tmp->blklen; ++i) {
+				reg_tmp = rbnode_tmp->base_reg + i;
+				if (abs(reg_tmp - reg) != 1)
+					continue;
+				/* decide where in the block to place our register */
+				if (reg_tmp + 1 == reg)
+					pos = i + 1;
+				else
+					pos = i;
+				ret = snd_soc_rbtree_insert_to_block(rbnode_tmp, pos,
+								     reg, value);
+				if (ret)
+					return ret;
+				return 0;
+			}
+		}
+		/* we did not manage to find a place to insert it in an existing
+		 * block so create a new rbnode with a single register in its block.
+		 * This block will get populated further if any other adjacent
+		 * registers get modified in the future.
 		 */
 		rbnode = kzalloc(sizeof *rbnode, GFP_KERNEL);
 		if (!rbnode)
 			return -ENOMEM;
-		rbnode->reg = reg;
-		rbnode->value = value;
+		rbnode->blklen = 1;
+		rbnode->base_reg = reg;
+		rbnode->word_size = codec->driver->reg_word_size;
+		rbnode->block = kmalloc(rbnode->blklen * rbnode->word_size,
+					GFP_KERNEL);
+		if (!rbnode->block) {
+			kfree(rbnode);
+			return -ENOMEM;
+		}
+		snd_soc_rbtree_set_register(rbnode, 0, value);
 		snd_soc_rbtree_insert(&rbtree_ctx->root, rbnode);
 	}
 
@@ -607,11 +733,13 @@ static int snd_soc_rbtree_cache_read(struct snd_soc_codec *codec,
 {
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct snd_soc_rbtree_node *rbnode;
+	unsigned int reg_tmp;
 
 	rbtree_ctx = codec->reg_cache;
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
-		*value = rbnode->value;
+		reg_tmp = reg - rbnode->base_reg;
+		*value = snd_soc_rbtree_get_register(rbnode, reg_tmp);
 	} else {
 		/* uninitialized registers default to 0 */
 		*value = 0;
@@ -637,6 +765,7 @@ static int snd_soc_rbtree_cache_exit(struct snd_soc_codec *codec)
 		rbtree_node = rb_entry(next, struct snd_soc_rbtree_node, node);
 		next = rb_next(&rbtree_node->node);
 		rb_erase(&rbtree_node->node, &rbtree_ctx->root);
+		kfree(rbtree_node->block);
 		kfree(rbtree_node);
 	}
 
@@ -649,10 +778,9 @@ static int snd_soc_rbtree_cache_exit(struct snd_soc_codec *codec)
 
 static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 {
-	struct snd_soc_rbtree_node *rbtree_node;
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
-	unsigned int val;
 	unsigned int word_size;
+	unsigned int val;
 	int i;
 	int ret;
 
@@ -666,28 +794,22 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	if (!codec->reg_def_copy)
 		return 0;
 
-	/*
-	 * populate the rbtree with the initialized registers.  All other
-	 * registers will be inserted when they are first modified.
-	 */
 	word_size = codec->driver->reg_word_size;
 	for (i = 0; i < codec->driver->reg_cache_size; ++i) {
-		val = snd_soc_get_cache_val(codec->reg_def_copy, i, word_size);
+		val = snd_soc_get_cache_val(codec->reg_def_copy, i,
+					    word_size);
 		if (!val)
 			continue;
-		rbtree_node = kzalloc(sizeof *rbtree_node, GFP_KERNEL);
-		if (!rbtree_node) {
-			ret = -ENOMEM;
-			snd_soc_cache_exit(codec);
-			break;
-		}
-		rbtree_node->reg = i;
-		rbtree_node->value = val;
-		rbtree_node->defval = val;
-		snd_soc_rbtree_insert(&rbtree_ctx->root, rbtree_node);
+		ret = snd_soc_rbtree_cache_write(codec, i, val);
+		if (ret)
+			goto err;
 	}
 
 	return 0;
+
+err:
+	snd_soc_cache_exit(codec);
+	return ret;
 }
 
 #ifdef CONFIG_SND_SOC_CACHE_LZO
-- 
1.7.5.1
