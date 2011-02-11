From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2 2.6.38] ASoC: soc-cache: Apply the
	cache_bypass option
Date: Fri, 11 Feb 2011 14:54:02 +0000
Message-ID: <1297436042-18324-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1297436042-18324-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB5B410387F
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 15:54:04 +0100 (CET)
In-Reply-To: <1297436042-18324-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

Incorporate the use of the cache_bypass functionality in the
syncing functions.  The snd_soc_flat_cache_sync() need not be
hooked as there is no performance benefit from using the
cache_bypass option.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 799e376..9d43bee 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -847,7 +847,9 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 		ret = snd_soc_cache_read(codec, rbnode->reg, &val);
 		if (ret)
 			return ret;
+		codec->cache_bypass = 1;
 		ret = snd_soc_write(codec, rbnode->reg, val);
+		codec->cache_bypass = 0;
 		if (ret)
 			return ret;
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
@@ -1134,7 +1136,9 @@ static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
+		codec->cache_bypass = 1;
 		ret = snd_soc_write(codec, i, val);
+		codec->cache_bypass = 0;
 		if (ret)
 			return ret;
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
-- 
1.7.4
