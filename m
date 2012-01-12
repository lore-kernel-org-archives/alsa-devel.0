From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use regmap update bits operation for
	drivers using regmap
Date: Thu, 12 Jan 2012 00:32:46 -0800
Message-ID: <1326357167-891-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 658C5247E6
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 09:32:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If a driver is using regmap directly ensure that we're coherent with
non-ASoC register updates by using the regmap API directly to do our
read/modify/write cycles. This will bypass the ASoC cache but drivers
using regmap directly should not be using the ASoC cache.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   25 +++++++++++++++----------
 sound/soc/soc-dapm.c |   27 +++++++++++++++++----------
 sound/soc/soc-io.c   |    1 +
 4 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0992dff..fde163b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -559,6 +559,7 @@ struct snd_soc_codec {
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int sysfs_registered:1; /* codec has been sysfs registered */
 	unsigned int cache_init:1; /* codec cache has been initialized */
+	unsigned int using_regmap:1; /* using regmap access */
 	u32 cache_only;  /* Suppress writes to hardware */
 	u32 cache_sync; /* Cache needs to be synced to hardware */
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3986520..07ab062e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1865,23 +1865,28 @@ EXPORT_SYMBOL_GPL(snd_soc_bulk_write_raw);
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
 				unsigned int mask, unsigned int value)
 {
-	int change;
+	bool change;
 	unsigned int old, new;
 	int ret;
 
-	ret = snd_soc_read(codec, reg);
-	if (ret < 0)
-		return ret;
-
-	old = ret;
-	new = (old & ~mask) | (value & mask);
-	change = old != new;
-	if (change) {
-		ret = snd_soc_write(codec, reg, new);
+	if (codec->using_regmap) {
+		ret = regmap_update_bits_check(codec->control_data, reg,
+					       mask, value, &change);
+	} else {
+		ret = snd_soc_read(codec, reg);
 		if (ret < 0)
 			return ret;
+
+		old = ret;
+		new = (old & ~mask) | (value & mask);
+		change = old != new;
+		if (change)
+			ret = snd_soc_write(codec, reg, new);
 	}
 
+	if (ret < 0)
+		return ret;
+
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_update_bits);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3ad1f59..3b8eaa8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -197,21 +197,28 @@ static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
 static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
 	unsigned short reg, unsigned int mask, unsigned int value)
 {
-	int change;
+	bool change;
 	unsigned int old, new;
 	int ret;
 
-	ret = soc_widget_read(w, reg);
-	if (ret < 0)
-		return ret;
-
-	old = ret;
-	new = (old & ~mask) | (value & mask);
-	change = old != new;
-	if (change) {
-		ret = soc_widget_write(w, reg, new);
+	if (w->codec && w->codec->using_regmap) {
+		ret = regmap_update_bits_check(w->codec->control_data,
+					       reg, mask, value, &change);
+		if (ret != 0)
+			return ret;
+	} else {
+		ret = soc_widget_read(w, reg);
 		if (ret < 0)
 			return ret;
+
+		old = ret;
+		new = (old & ~mask) | (value & mask);
+		change = old != new;
+		if (change) {
+			ret = soc_widget_write(w, reg, new);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return change;
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index c8610cb..39ba507 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -140,6 +140,7 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
+		codec->using_regmap = true;
 		break;
 
 	default:
-- 
1.7.7.3
