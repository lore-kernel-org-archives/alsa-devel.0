From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Add trace event for
	snd_soc_cache_sync()
Date: Fri, 21 Jan 2011 14:35:48 +0000
Message-ID: <1295620548-26297-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F53E24616
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 15:35:56 +0100 (CET)
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

This patch makes it easier to see which of the register writes are part
of the cache syncing functionality.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/trace/events/asoc.h |    9 +++++++++
 sound/soc/soc-cache.c       |    5 +++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 186e84d..7efed81 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -59,6 +59,15 @@ DEFINE_EVENT(snd_soc_reg, snd_soc_reg_read,
 
 );
 
+DEFINE_EVENT(snd_soc_reg, snd_soc_cache_sync,
+
+	TP_PROTO(struct snd_soc_codec *codec, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(codec, reg, val)
+
+);
+
 DECLARE_EVENT_CLASS(snd_soc_card,
 
 	TP_PROTO(struct snd_soc_card *card, int val),
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index f834839..accd96e 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -18,6 +18,8 @@
 #include <linux/bitmap.h>
 #include <linux/rbtree.h>
 
+#include <trace/events/asoc.h>
+
 static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
@@ -895,6 +897,7 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 		codec->cache_bypass = 0;
 		if (ret)
 			return ret;
+		trace_snd_soc_cache_sync(codec, rbnode->reg, val);
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
 			rbnode->reg, val);
 	}
@@ -1155,6 +1158,7 @@ static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 		codec->cache_bypass = 0;
 		if (ret)
 			return ret;
+		trace_snd_soc_cache_sync(codec, i, val);
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
 			i, val);
 	}
@@ -1415,6 +1419,7 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 		ret = snd_soc_write(codec, i, val);
 		if (ret)
 			return ret;
+		trace_snd_soc_cache_sync(codec, i, val);
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
 			i, val);
 	}
-- 
1.7.3.5
