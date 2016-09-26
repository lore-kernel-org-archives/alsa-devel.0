From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] ASoC: da7219: Reset codec gracefully, if still active
Date: Mon, 26 Sep 2016 14:29:20 +0100
Message-ID: <4c191834ee78d57c9e9d60b758d9ef767a47a523.1474896038.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1474896038.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474896038.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Xing Zheng <zhengxing@rock-chips.com>, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

Currently the reset code in i2c_probe only resets the AAD part of
the device and not the entire codec. This patch updates the driver
to resolve this and ensures that if the codec is still active from
a previous boot then the audio paths are powered down prior to
reset.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 30 +++++++++++++++++++++++++++---
 sound/soc/codecs/da7219.h |  5 +++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 9d08c11..eecb6d6 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1925,7 +1925,8 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct da7219_priv *da7219;
-	int ret;
+	unsigned int system_active, system_status;
+	int i, ret;
 
 	da7219 = devm_kzalloc(&i2c->dev, sizeof(struct da7219_priv),
 			      GFP_KERNEL);
@@ -1941,14 +1942,37 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	/* Software reset codec. */
+	regcache_cache_bypass(da7219->regmap, true);
+
+	/* Disable audio paths if still active from previous start */
+	regmap_read(da7219->regmap, DA7219_SYSTEM_ACTIVE, &system_active);
+	if (system_active) {
+		regmap_write(da7219->regmap, DA7219_GAIN_RAMP_CTRL,
+			     DA7219_GAIN_RAMP_RATE_NOMINAL);
+		regmap_write(da7219->regmap, DA7219_SYSTEM_MODES_INPUT, 0x00);
+		regmap_write(da7219->regmap, DA7219_SYSTEM_MODES_OUTPUT, 0x01);
+
+		for (i = 0; i < DA7219_SYS_STAT_CHECK_RETRIES; ++i) {
+			regmap_read(da7219->regmap, DA7219_SYSTEM_STATUS,
+				    &system_status);
+			if (!system_status)
+				break;
+
+			msleep(DA7219_SYS_STAT_CHECK_DELAY);
+		}
+	}
+
+	/* Soft reset codec */
 	regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
 			  DA7219_ACCDET_EN_MASK, 0);
 	regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
-			  DA7219_CIF_REG_SOFT_RESET_MASK, 0);
+			  DA7219_CIF_REG_SOFT_RESET_MASK,
+			  DA7219_CIF_REG_SOFT_RESET_MASK);
 	regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
 			  DA7219_SYSTEM_ACTIVE_MASK, 0);
 
+	regcache_cache_bypass(da7219->regmap, false);
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da7219,
 				     &da7219_dai, 1);
 	if (ret < 0) {
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 545576d..f1b3ad8 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -578,6 +578,7 @@
 #define DA7219_GAIN_RAMP_RATE_SHIFT	0
 #define DA7219_GAIN_RAMP_RATE_MASK	(0x3 << 0)
 #define DA7219_GAIN_RAMP_RATE_X8	(0x0 << 0)
+#define DA7219_GAIN_RAMP_RATE_NOMINAL	(0x1 << 0)
 #define DA7219_GAIN_RAMP_RATE_MAX	4
 
 /* DA7219_PC_COUNT = 0x94 */
@@ -772,6 +773,10 @@
 /* SRM */
 #define DA7219_SRM_CHECK_RETRIES	8
 
+/* System Controller */
+#define DA7219_SYS_STAT_CHECK_RETRIES	6
+#define DA7219_SYS_STAT_CHECK_DELAY	50
+
 enum da7219_clk_src {
 	DA7219_CLKSRC_MCLK = 0,
 	DA7219_CLKSRC_MCLK_SQR,
-- 
1.9.3
