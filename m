From: <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5640: Add minimal support for RT5642
Date: Thu, 17 Apr 2014 10:24:06 +0800
Message-ID: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EC24264F41
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 04:24:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, jarkko.nikula@linux.intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

We have been using rt5640.c codec driver with RT5642 codec chip before commit
022d21f004c1 ("ASoC: rt5640: add rt5639 support"). That commits starts using
device ID reading in reset register for adding device specific controls and
routes runtime.

Now since device ID appears to be different between RT5640 and RT5642 the 
driver doesn't add those controls and routes that are valid also on RT5642.

Fix this by adding a device ID found by debugging and minimal code for 
supporting RT5642.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
This patch add a mask for reading the device ID. This can remove the affect of
other bits which is not related to device ID.

---
 sound/soc/codecs/rt5640.c |  8 +++++---
 sound/soc/codecs/rt5640.h | 10 +++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6674372..79635ee 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1997,8 +1997,9 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, RT5640_MICBIAS, 0x0030, 0x0030);
 	snd_soc_update_bits(codec, RT5640_DSP_PATH2, 0xfc00, 0x0c00);
 
-	switch (snd_soc_read(codec, RT5640_RESET)) {
-	case RT5640_RESET_ID:
+	switch (snd_soc_read(codec, RT5640_RESET) & RT5640_ID_MASK) {
+	case RT5640_ID_5640:
+	case RT5640_ID_5642:
 		snd_soc_add_codec_controls(codec,
 			rt5640_specific_snd_controls,
 			ARRAY_SIZE(rt5640_specific_snd_controls));
@@ -2009,7 +2010,7 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 			rt5640_specific_dapm_routes,
 			ARRAY_SIZE(rt5640_specific_dapm_routes));
 		break;
-	case RT5639_RESET_ID:
+	case RT5640_ID_5639:
 		snd_soc_dapm_new_controls(&codec->dapm,
 			rt5639_specific_dapm_widgets,
 			ARRAY_SIZE(rt5639_specific_dapm_widgets));
@@ -2149,6 +2150,7 @@ static const struct regmap_config rt5640_regmap = {
 static const struct i2c_device_id rt5640_i2c_id[] = {
 	{ "rt5640", 0 },
 	{ "rt5639", 0 },
+	{ "rt5642", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 3b50459..ded2059 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -14,9 +14,6 @@
 
 #include <sound/rt5640.h>
 
-#define RT5639_RESET_ID				0x0008
-#define RT5640_RESET_ID				0x000c
-
 /* Info */
 #define RT5640_RESET				0x00
 #define RT5640_VENDOR_ID			0xfd
@@ -195,6 +192,13 @@
 #define RT5640_R_VOL_MASK			(0x3f)
 #define RT5640_R_VOL_SFT			0
 
+/* SW Reset & Device ID (0x00) */
+#define RT5640_ID_MASK				(0x3 << 1)
+#define RT5640_ID_5639				(0x0 << 1)
+#define RT5640_ID_5640				(0x1 << 1)
+#define RT5640_ID_5642				(0x3 << 1)
+
+
 /* IN1 and IN2 Control (0x0d) */
 /* IN3 and IN4 Control (0x0e) */
 #define RT5640_BST_SFT1				12
-- 
1.8.1.1.439.g50a6b54
