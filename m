From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: soc-cache: cache a pointer to the
	last accessed rbtree block
Date: Mon,  2 May 2011 13:26:21 +0100
Message-ID: <1304339181-27648-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1304339181-27648-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 442AF24374
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 14:26:24 +0200 (CEST)
In-Reply-To: <1304339181-27648-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

Whenever we are doing a read or a write through the rbtree code, we'll
cache the a pointer to the register block.  To avoid looking up the register
everytime we do a read or a write, we first check if it can be found in
the cached register block, otherwise we go through the slow path and in the
end we cache the pointer to the register block.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index c518b6e..09048ea 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -608,6 +608,7 @@ struct snd_soc_rbtree_node {
 
 struct snd_soc_rbtree_ctx {
 	struct rb_root root;
+	struct snd_soc_rbtree_node *cached_rbnode;
 };
 
 static inline int snd_soc_rbtree_block_count(void)
@@ -727,11 +728,25 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct snd_soc_rbtree_node *rbnode;
 	struct snd_soc_rbtree_reg_blk *regblk;
-	struct snd_soc_rbtree_reg_blk *baseblk;
+	struct snd_soc_rbtree_reg_blk *baseblk, *topblk;
 	unsigned int base_reg;
 	int blkcount, i;
 
 	rbtree_ctx = codec->reg_cache;
+	/* handle cached write */
+	rbnode = rbtree_ctx->cached_rbnode;
+	if (rbnode) {
+		baseblk = snd_soc_rbtree_base_block(rbnode);
+		topblk = snd_soc_rbtree_top_block(rbnode);
+		if (reg >= baseblk->reg && reg <= topblk->reg) {
+			regblk = &rbnode->block[reg - baseblk->reg];
+			if (regblk->value == value)
+				return 0;
+			regblk->value = value;
+			return 0;
+		}
+	}
+	/* if not cached, look it up in the rbtree and cache it */
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
 		baseblk = snd_soc_rbtree_base_block(rbnode);
@@ -739,6 +754,7 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 		if (regblk->value == value)
 			return 0;
 		regblk->value = value;
+		rbtree_ctx->cached_rbnode = rbnode;
 	} else {
 		/* bail out early, no need to create the rbnode yet */
 		if (!value)
@@ -761,6 +777,7 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 				regblk->value = value;
 		}
 		snd_soc_rbtree_insert(&rbtree_ctx->root, rbnode);
+		rbtree_ctx->cached_rbnode = rbnode;
 	}
 
 	return 0;
@@ -771,13 +788,25 @@ static int snd_soc_rbtree_cache_read(struct snd_soc_codec *codec,
 {
 	struct snd_soc_rbtree_ctx *rbtree_ctx;
 	struct snd_soc_rbtree_node *rbnode;
-	struct snd_soc_rbtree_reg_blk *baseblk;
+	struct snd_soc_rbtree_reg_blk *baseblk, *topblk;
 
 	rbtree_ctx = codec->reg_cache;
+	/* handle cached read */
+	rbnode = rbtree_ctx->cached_rbnode;
+	if (rbnode) {
+		baseblk = snd_soc_rbtree_base_block(rbnode);
+		topblk = snd_soc_rbtree_top_block(rbnode);
+		if (reg >= baseblk->reg && reg <= topblk->reg) {
+			*value = rbnode->block[reg - baseblk->reg].value;
+			return 0;
+		}
+	}
+	/* if not cached, look it up in the rbtree and cache it */
 	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
 	if (rbnode) {
 		baseblk = snd_soc_rbtree_base_block(rbnode);
 		*value = rbnode->block[reg - baseblk->reg].value;
+		rbtree_ctx->cached_rbnode = rbnode;
 	} else {
 		/* uninitialized registers default to 0 */
 		*value = 0;
@@ -831,6 +860,7 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 
 	rbtree_ctx = codec->reg_cache;
 	rbtree_ctx->root = RB_ROOT;
+	rbtree_ctx->cached_rbnode = NULL;
 
 	if (!codec->reg_def_copy)
 		return 0;
-- 
1.7.5
