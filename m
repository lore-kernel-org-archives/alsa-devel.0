From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: soc-cache: Add support for rbtree
	based register caching
Date: Thu,  4 Nov 2010 14:22:44 +0000
Message-ID: <1288880564-31957-5-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1F3D10389D
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 15:22:57 +0100 (CET)
In-Reply-To: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for rbtree compression when storing the
register cache.  It does this by not adding any uninitialized registers
(those whose value is 0).  If any of those registers is written
with a nonzero value they get added into the rbtree.

Consider a sample device with a large sparse register map.  The
register indices are between [0, 0x31ff].  An array of 12800 registers
is thus created each of which is 2 bytes.  This results in a 25kB
region.  This array normally lives outside soc-core, normally in the
driver itself.  The original soc-core code would kmemdup this region
resulting in 50kB total memory.  When using the rbtree compression
technique and __devinitconst on the original array the figures are
as follows.  For this typical device, you might have 100 initialized
registers, that is registers that are nonzero by default.  We build
an rbtree with 100 nodes, each of which is 21 bytes.  This results
in ~2kB of memory.  Assuming that the target arch can freeup the
memory used by the initial __devinitconst array, we end up using
about ~2kB bytes of actual memory.  The memory footprint will increase
as uninitialized registers get written and thus new nodes created in
the rbtree.  In practice, most of those registers are never changed.
If the target arch can't freeup the __devinitconst array, we end up
using a total of ~27kB.  The difference between the rbtree and the LZO
caching techniques, is that if using the LZO technique the size of
the cache will increase slower as more uninitialized registers get
changed.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    3 +-
 sound/soc/soc-cache.c |  233 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8135b3c..6e9f511 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -256,7 +256,8 @@ enum snd_soc_control_type {
 
 enum snd_soc_compress_type {
 	SND_SOC_NO_COMPRESSION,
-	SND_SOC_LZO_COMPRESSION
+	SND_SOC_LZO_COMPRESSION,
+	SND_SOC_RBTREE_COMPRESSION
 };
 
 int snd_soc_register_platform(struct device *dev,
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 63b7fe9..3d85ac0 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -16,6 +16,7 @@
 #include <sound/soc.h>
 #include <linux/lzo.h>
 #include <linux/bitmap.h>
+#include <linux/rbtree.h>
 
 /* serialize access to *cache_read() and *cache_write() */
 static DEFINE_MUTEX(cache_rw_mutex);
@@ -759,6 +760,230 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
 
+struct snd_soc_rbtree_node {
+	struct rb_node node;
+	unsigned int dirty:1;
+	unsigned int reg;
+	unsigned int value;
+} __attribute__ ((packed));
+
+struct snd_soc_rbtree_ctx {
+	struct rb_root root;
+};
+
+static struct snd_soc_rbtree_node *snd_soc_rbtree_lookup(
+	struct rb_root *root, unsigned int reg)
+{
+	struct rb_node *node;
+	struct snd_soc_rbtree_node *rbnode;
+
+	node = root->rb_node;
+	while (node) {
+		rbnode = container_of(node, struct snd_soc_rbtree_node, node);
+		if (rbnode->reg < reg)
+			node = node->rb_left;
+		else if (rbnode->reg > reg)
+			node = node->rb_right;
+		else
+			return rbnode;
+	}
+
+	return NULL;
+}
+
+
+static int snd_soc_rbtree_insert(struct rb_root *root,
+				 struct snd_soc_rbtree_node *rbnode)
+{
+	struct rb_node **new, *parent;
+	struct snd_soc_rbtree_node *rbnode_tmp;
+
+	parent = NULL;
+	new = &root->rb_node;
+	while (*new) {
+		rbnode_tmp = container_of(*new, struct snd_soc_rbtree_node,
+					  node);
+		parent = *new;
+		if (rbnode_tmp->reg < rbnode->reg)
+			new = &((*new)->rb_left);
+		else if (rbnode_tmp->reg > rbnode->reg)
+			new = &((*new)->rb_right);
+		else
+			return 0;
+	}
+
+	/* insert the node into the rbtree */
+	rb_link_node(&rbnode->node, parent, new);
+	rb_insert_color(&rbnode->node, root);
+
+	return 1;
+}
+
+static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
+{
+	struct snd_soc_rbtree_ctx *rbtree_ctx;
+	struct rb_node *node;
+	struct snd_soc_rbtree_node *rbnode;
+	unsigned int val;
+
+	rbtree_ctx = codec->reg_cache;
+	for (node = rb_first(&rbtree_ctx->root); node; node = rb_next(node)) {
+		rbnode = rb_entry(node, struct snd_soc_rbtree_node, node);
+		if (!rbnode->dirty)
+			continue;
+		snd_soc_cache_read(codec, rbnode->reg, &val);
+		snd_soc_write(codec, rbnode->reg, val);
+		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
+			rbnode->reg, val);
+	}
+
+	return 0;
+}
+
+static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
+				      unsigned int reg, unsigned int value)
+{
+	struct snd_soc_rbtree_ctx *rbtree_ctx;
+	struct snd_soc_rbtree_node *rbnode;
+
+	rbtree_ctx = codec->reg_cache;
+	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
+	if (rbnode) {
+		if (rbnode->value == value)
+			return 0;
+		rbnode->value = value;
+	} else {
+		/* bail out early, no need to create the rbnode yet */
+		if (!value)
+			return 0;
+		/*
+		 * for uninitialized registers whose value is changed
+		 * from the default zero, create an rbnode and insert
+		 * it into the tree.
+		 */
+		rbnode = kzalloc(sizeof *rbnode, GFP_KERNEL);
+		if (!rbnode)
+			return -ENOMEM;
+		rbnode->reg = reg;
+		rbnode->value = value;
+		snd_soc_rbtree_insert(&rbtree_ctx->root, rbnode);
+	}
+	/* remember that we have to sync this register */
+	rbnode->dirty = 1;
+
+	return 0;
+}
+
+static int snd_soc_rbtree_cache_read(struct snd_soc_codec *codec,
+				     unsigned int reg, unsigned int *value)
+{
+	struct snd_soc_rbtree_ctx *rbtree_ctx;
+	struct snd_soc_rbtree_node *rbnode;
+
+	rbtree_ctx = codec->reg_cache;
+	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
+	if (rbnode) {
+		*value = rbnode->value;
+	} else {
+		/* uninitialized registers default to 0 */
+		*value = 0;
+	}
+
+	return 0;
+}
+
+static int snd_soc_rbtree_cache_exit(struct snd_soc_codec *codec)
+{
+	struct rb_node *next;
+	struct snd_soc_rbtree_ctx *rbtree_ctx;
+	struct snd_soc_rbtree_node *rbtree_node;
+
+	/* if we've already been called then just return */
+	rbtree_ctx = codec->reg_cache;
+	if (!rbtree_ctx)
+		return 0;
+
+	/* free up the rbtree */
+	next = rb_first(&rbtree_ctx->root);
+	while (next) {
+		rbtree_node = rb_entry(next, struct snd_soc_rbtree_node, node);
+		next = rb_next(&rbtree_node->node);
+		rb_erase(&rbtree_node->node, &rbtree_ctx->root);
+		kfree(rbtree_node);
+	}
+
+	/* release the resources */
+	kfree(codec->reg_cache);
+	codec->reg_cache = NULL;
+
+	return 0;
+}
+
+static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
+{
+	struct snd_soc_rbtree_ctx *rbtree_ctx;
+
+	codec->reg_cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
+	if (!codec->reg_cache)
+		return -ENOMEM;
+
+	rbtree_ctx = codec->reg_cache;
+	rbtree_ctx->root = RB_ROOT;
+
+	if (!codec->driver->reg_cache_default)
+		return 0;
+
+/*
+ * populate the rbtree with the initialized registers.  All other
+ * registers will be inserted into the tree when they are first written.
+ *
+ * The reasoning behind this, is that we need to step through and
+ * dereference the cache in u8/u16 increments without sacrificing
+ * portability.  This could also be done using memcpy() but that would
+ * be slightly more cryptic.
+ */
+#define snd_soc_rbtree_populate(cache)					\
+({									\
+	int ret, i;							\
+	struct snd_soc_rbtree_node *rbtree_node;			\
+									\
+	ret = 0;							\
+	cache = codec->driver->reg_cache_default;			\
+	for (i = 0; i < codec->driver->reg_cache_size; ++i) {		\
+		if (!cache[i])						\
+			continue;					\
+		rbtree_node = kzalloc(sizeof *rbtree_node, GFP_KERNEL);	\
+		if (!rbtree_node) {					\
+			ret = -ENOMEM;					\
+			snd_soc_cache_exit(codec);			\
+			break;						\
+		}							\
+		rbtree_node->reg = i;					\
+		rbtree_node->value = cache[i];				\
+		snd_soc_rbtree_insert(&rbtree_ctx->root,		\
+				      rbtree_node);			\
+	}								\
+	ret;								\
+})
+
+	switch (codec->driver->reg_word_size) {
+	case 1: {
+		const u8 *cache;
+
+		return snd_soc_rbtree_populate(cache);
+	}
+	case 2: {
+		const u16 *cache;
+
+		return snd_soc_rbtree_populate(cache);
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 struct snd_soc_lzo_ctx {
 	void *wmem;
 	void *dst;
@@ -1292,6 +1517,14 @@ static const struct snd_soc_cache_ops cache_types[] = {
 		.read = snd_soc_lzo_cache_read,
 		.write = snd_soc_lzo_cache_write,
 		.sync = snd_soc_lzo_cache_sync
+	},
+	{
+		.id = SND_SOC_RBTREE_COMPRESSION,
+		.init = snd_soc_rbtree_cache_init,
+		.exit = snd_soc_rbtree_cache_exit,
+		.read = snd_soc_rbtree_cache_read,
+		.write = snd_soc_rbtree_cache_write,
+		.sync = snd_soc_rbtree_cache_sync
 	}
 };
 
-- 
1.7.3.2
