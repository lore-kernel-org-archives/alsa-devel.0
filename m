From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2 v3] ASoC: soc-cache: Cache a pointer to the
	last accessed rbnode
Date: Thu, 19 May 2011 13:45:30 +0100
Message-ID: <1305809130-18410-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1305809130-18410-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82BFA103A2C
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 14:45:39 +0200 (CEST)
In-Reply-To: <1305809130-18410-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

Whenever we are doing a read or a write through the rbtree code, we'll
cache a pointer to the rbnode.  To avoid looking up the register
everytime we do a read or a write, we first check if it can be found in
the cached register block, otherwise we traverse the rbtree and finally
cache the rbnode for future use.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index b72f591..73656f6 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -492,6 +492,7 @@ struct snd_soc_rbtree_node {
 
 struct snd_soc_rbtree_ctx {
 	struct rb_root root;
+	struct snd_soc_rbtree_node *cached_rbnode;
 };
 
 static inline void snd_soc_rbtree_get_base_top_reg(
@@ -668,11 +669,28 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 	struct rb_node *node;
 	unsigned int val;
 	unsigned int reg_tmp;
+	unsigned int base_reg, top_reg;
 	unsigned int pos;
 	int i;
 	int ret;
 
 	rbtree_ctx = codec->reg_cache;
+	/* look up the required register in the cached rbnode */
+	rbnode = rbtree_ctx->cached_rbnode;
+	if (rbnode) {
+		snd_soc_rbtree_get_base_top_reg(rbnode, &base_reg, &top_reg);
+		if (reg >= base_reg && reg <= top_reg) {
+			reg_tmp = reg - base_reg;
+			val = snd_soc_rbtree_get_register(rbnode, reg_tmp);
+			if (val == value)
+				return 0;
+			snd_soc_rbtree_set_register(rbnode, reg_tmp, value);
+			return 0;
+		}
+	}
+	/* if we can't locate it in the cached rbnode we'll have
+	 * to traverse the rbtree looking for it.
+	 */
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
 		reg_tmp = reg - rbnode->base_reg;
@@ -680,6 +698,7 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 		if (val == value)
 			return 0;
 		snd_soc_rbtree_set_register(rbnode, reg_tmp, value);
+		rbtree_ctx->cached_rbnode = rbnode;
 	} else {
 		/* bail out early, no need to create the rbnode yet */
 		if (!value)
@@ -701,6 +720,7 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 								     reg, value);
 				if (ret)
 					return ret;
+				rbtree_ctx->cached_rbnode = rbnode_tmp;
 				return 0;
 			}
 		}
@@ -723,6 +743,7 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 		}
 		snd_soc_rbtree_set_register(rbnode, 0, value);
 		snd_soc_rbtree_insert(&rbtree_ctx->root, rbnode);
+		rbtree_ctx->cached_rbnode = rbnode;
 	}
 
 	return 0;
@@ -733,13 +754,28 @@ static int snd_soc_rbtree_cache_read(struct snd_soc_codec *codec,
 {
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct snd_soc_rbtree_node *rbnode;
+	unsigned int base_reg, top_reg;
 	unsigned int reg_tmp;
 
 	rbtree_ctx = codec->reg_cache;
+	/* look up the required register in the cached rbnode */
+	rbnode = rbtree_ctx->cached_rbnode;
+	if (rbnode) {
+		snd_soc_rbtree_get_base_top_reg(rbnode, &base_reg, &top_reg);
+		if (reg >= base_reg && reg <= top_reg) {
+			reg_tmp = reg - base_reg;
+			*value = snd_soc_rbtree_get_register(rbnode, reg_tmp);
+			return 0;
+		}
+	}
+	/* if we can't locate it in the cached rbnode we'll have
+	 * to traverse the rbtree looking for it.
+	 */
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
 		reg_tmp = reg - rbnode->base_reg;
 		*value = snd_soc_rbtree_get_register(rbnode, reg_tmp);
+		rbtree_ctx->cached_rbnode = rbnode;
 	} else {
 		/* uninitialized registers default to 0 */
 		*value = 0;
@@ -790,6 +826,7 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 
 	rbtree_ctx = codec->reg_cache;
 	rbtree_ctx->root = RB_ROOT;
+	rbtree_ctx->cached_rbnode = NULL;
 
 	if (!codec->reg_def_copy)
 		return 0;
-- 
1.7.5.1
