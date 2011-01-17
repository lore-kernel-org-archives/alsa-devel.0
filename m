From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8995: Add regulator handling code
Date: Mon, 17 Jan 2011 11:00:12 +0000
Message-ID: <1295262012-6074-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A96C2103820
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 12:00:20 +0100 (CET)
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

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8995.c |  102 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index f0f678d..7d56341 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -30,6 +31,18 @@
 
 #include "wm8995.h"
 
+#define WM8995_NUM_SUPPLIES 8
+static const char *wm8995_supply_names[WM8995_NUM_SUPPLIES] = {
+	"DCVDD",
+	"DBVDD1",
+	"DBVDD2",
+	"DBVDD3",
+	"AVDD1",
+	"AVDD2",
+	"CPVDD",
+	"MICVDD"
+};
+
 static const u16 wm8995_reg_defs[WM8995_MAX_REGISTER + 1] = {
 	[0]     = 0x8995, [5]     = 0x0100, [16]    = 0x000b, [17]    = 0x000b,
 	[24]    = 0x02c0, [25]    = 0x02c0, [26]    = 0x02c0, [27]    = 0x02c0,
@@ -126,8 +139,37 @@ struct wm8995_priv {
 	int mclk[2];
 	int aifclk[2];
 	struct fll_config fll[2], fll_suspend[2];
+	struct regulator_bulk_data supplies[WM8995_NUM_SUPPLIES];
+	struct notifier_block disable_nb[WM8995_NUM_SUPPLIES];
+	struct snd_soc_codec *codec;
 };
 
+/*
+ * We can't use the same notifier block for more than one supply and
+ * there's no way I can see to get from a callback to the caller
+ * except container_of().
+ */
+#define WM8995_REGULATOR_EVENT(n) \
+static int wm8995_regulator_event_##n(struct notifier_block *nb, \
+				      unsigned long event, void *data)    \
+{ \
+	struct wm8995_priv *wm8995 = container_of(nb, struct wm8995_priv, \
+				     disable_nb[n]); \
+	if (event & REGULATOR_EVENT_DISABLE) { \
+		wm8995->codec->cache_sync = 1; \
+	} \
+	return 0; \
+}
+
+WM8995_REGULATOR_EVENT(0)
+WM8995_REGULATOR_EVENT(1)
+WM8995_REGULATOR_EVENT(2)
+WM8995_REGULATOR_EVENT(3)
+WM8995_REGULATOR_EVENT(4)
+WM8995_REGULATOR_EVENT(5)
+WM8995_REGULATOR_EVENT(6)
+WM8995_REGULATOR_EVENT(7)
+
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -7200, 75, 1);
 static const DECLARE_TLV_DB_SCALE(in1lr_pga_tlv, -1650, 150, 0);
 static const DECLARE_TLV_DB_SCALE(in1l_boost_tlv, 0, 600, 0);
@@ -1483,6 +1525,11 @@ static int wm8995_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			ret = regulator_bulk_enable(ARRAY_SIZE(wm8995->supplies),
+						    wm8995->supplies);
+			if (ret)
+				return ret;
+
 			ret = snd_soc_cache_sync(codec);
 			if (ret) {
 				dev_err(codec->dev,
@@ -1492,13 +1539,13 @@ static int wm8995_set_bias_level(struct snd_soc_codec *codec,
 
 			snd_soc_update_bits(codec, WM8995_POWER_MANAGEMENT_1,
 					    WM8995_BG_ENA_MASK, WM8995_BG_ENA);
-
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		snd_soc_update_bits(codec, WM8995_POWER_MANAGEMENT_1,
 				    WM8995_BG_ENA_MASK, 0);
-		codec->cache_sync = 1;
+		regulator_bulk_disable(ARRAY_SIZE(wm8995->supplies),
+				       wm8995->supplies);
 		break;
 	}
 
@@ -1537,10 +1584,12 @@ static int wm8995_remove(struct snd_soc_codec *codec)
 static int wm8995_probe(struct snd_soc_codec *codec)
 {
 	struct wm8995_priv *wm8995;
+	int i;
 	int ret;
 
 	codec->dapm.idle_bias_off = 1;
 	wm8995 = snd_soc_codec_get_drvdata(codec);
+	wm8995->codec = codec;
 
 	ret = snd_soc_codec_set_cache_io(codec, 16, 16, wm8995->control_type);
 	if (ret < 0) {
@@ -1548,21 +1597,58 @@ static int wm8995_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(wm8995->supplies); i++)
+		wm8995->supplies[i].supply = wm8995_supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8995->supplies),
+				 wm8995->supplies);
+	if (ret) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	wm8995->disable_nb[0].notifier_call = wm8995_regulator_event_0;
+	wm8995->disable_nb[1].notifier_call = wm8995_regulator_event_1;
+	wm8995->disable_nb[2].notifier_call = wm8995_regulator_event_2;
+	wm8995->disable_nb[3].notifier_call = wm8995_regulator_event_3;
+	wm8995->disable_nb[4].notifier_call = wm8995_regulator_event_4;
+	wm8995->disable_nb[5].notifier_call = wm8995_regulator_event_5;
+	wm8995->disable_nb[6].notifier_call = wm8995_regulator_event_6;
+	wm8995->disable_nb[7].notifier_call = wm8995_regulator_event_7;
+
+	/* This should really be moved into the regulator core */
+	for (i = 0; i < ARRAY_SIZE(wm8995->supplies); i++) {
+		ret = regulator_register_notifier(wm8995->supplies[i].consumer,
+						  &wm8995->disable_nb[i]);
+		if (ret) {
+			dev_err(codec->dev,
+				"Failed to register regulator notifier: %d\n",
+				ret);
+		}
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8995->supplies),
+				    wm8995->supplies);
+	if (ret) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_reg_get;
+	}
+
 	ret = snd_soc_read(codec, WM8995_SOFTWARE_RESET);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to read device ID: %d\n", ret);
-		return ret;
+		goto err_reg_enable;
 	}
 
 	if (ret != 0x8995) {
 		dev_err(codec->dev, "Invalid device ID: %#x\n", ret);
-		return -EINVAL;
+		goto err_reg_enable;
 	}
 
 	ret = snd_soc_write(codec, WM8995_SOFTWARE_RESET, 0);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
-		return ret;
+		goto err_reg_enable;
 	}
 
 	wm8995_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -1597,6 +1683,12 @@ static int wm8995_probe(struct snd_soc_codec *codec)
 				ARRAY_SIZE(wm8995_intercon));
 
 	return 0;
+
+err_reg_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8995->supplies), wm8995->supplies);
+err_reg_get:
+	regulator_bulk_free(ARRAY_SIZE(wm8995->supplies), wm8995->supplies);
+	return ret;
 }
 
 #define WM8995_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-- 
1.7.3.5
