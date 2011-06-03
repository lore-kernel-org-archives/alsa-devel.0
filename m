From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Suppress restore of default register
	values for rbtree cache sync
Date: Fri,  3 Jun 2011 16:37:15 +0100
Message-ID: <1307115435-18213-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF1D3243D9
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 17:37:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently the rbtree code will write out the entire register map when
doing a cache sync which is wasteful and will slow things down. Check
to see if the value we're about to write is the default and don't bother
restoring it if it is, either the value will have been retained or the
device will have been reset and holds the value already.

We should really store the defaults in the nodes but this resolves the
immediate issue.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index d8ce34c..d82ab42 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -607,7 +607,7 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 	struct rb_node *node;
 	struct snd_soc_rbtree_node *rbnode;
 	unsigned int regtmp;
-	unsigned int val;
+	unsigned int val, def;
 	int ret;
 	int i;
 
@@ -619,6 +619,11 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 			WARN_ON(codec->writable_register &&
 				codec->writable_register(codec, regtmp));
 			val = snd_soc_rbtree_get_register(rbnode, i);
+			def = snd_soc_get_cache_val(codec->reg_def_copy, i,
+						    rbnode->word_size);
+			if (val == def)
+				continue;
+
 			codec->cache_bypass = 1;
 			ret = snd_soc_write(codec, regtmp, val);
 			codec->cache_bypass = 0;
-- 
1.7.5.3
