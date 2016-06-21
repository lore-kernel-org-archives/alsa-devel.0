From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: cs53l30: Add MUTE pin control support
	via GPIO
Date: Mon, 20 Jun 2016 18:54:44 -0700
Message-ID: <1466474084-6775-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B81726666D
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 03:54:58 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id c74so175929pfb.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 18:54:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brian.austin@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The codec chip has a physical MUTE pin to let users control it via
GPIO. So this patch add a mute control support to the driver.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 .../devicetree/bindings/sound/cs53l30.txt          |  2 ++
 sound/soc/codecs/cs53l30.c                         | 30 ++++++++++++++++++++++
 sound/soc/codecs/cs53l30.h                         |  1 +
 3 files changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs53l30.txt b/Documentation/devicetree/bindings/sound/cs53l30.txt
index 18d6b99..6f7d3c8 100644
--- a/Documentation/devicetree/bindings/sound/cs53l30.txt
+++ b/Documentation/devicetree/bindings/sound/cs53l30.txt
@@ -13,6 +13,8 @@ Optional properties:
 
   - reset-gpios : a GPIO spec for the reset pin.
 
+  - mute-gpios : a GPIO spec for the MUTE pin.
+
   - cirrus,micbias-lvl : Set the output voltage level on the MICBIAS Pin.
 			 0 = Hi-Z
 			 1 = 1.80 V
diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index b0a64a1..5988b5c 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -35,6 +35,7 @@ struct cs53l30_private {
 	struct regulator_bulk_data	supplies[CS53L30_NUM_SUPPLIES];
 	struct regmap			*regmap;
 	struct gpio_desc		*reset_gpio;
+	struct gpio_desc		*mute_gpio;
 	struct clk			*mclk;
 	bool				use_sdout2;
 	u32				mclk_rate;
@@ -833,6 +834,16 @@ static int cs53l30_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int cs53l30_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+
+	if (priv->mute_gpio)
+		gpiod_set_value_cansleep(priv->mute_gpio, mute);
+
+	return 0;
+}
+
 /* SNDRV_PCM_RATE_KNOT -> 12000, 24000 Hz, limit with constraint list */
 #define CS53L30_RATES (SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
 
@@ -846,6 +857,7 @@ static const struct snd_soc_dai_ops cs53l30_ops = {
 	.set_sysclk = cs53l30_set_sysclk,
 	.set_tristate = cs53l30_set_tristate,
 	.set_tdm_slot = cs53l30_set_dai_tdm_slot,
+	.mute_stream = cs53l30_mute_stream,
 };
 
 static struct snd_soc_dai_driver cs53l30_dai = {
@@ -991,6 +1003,24 @@ static int cs53l30_i2c_probe(struct i2c_client *client,
 		cs53l30->mclk = NULL;
 	}
 
+	/* Fetch the MUTE control */
+	cs53l30->mute_gpio = devm_gpiod_get_optional(dev, "mute",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(cs53l30->mute_gpio)) {
+		ret = PTR_ERR(cs53l30->mute_gpio);
+		goto error;
+	}
+
+	if (cs53l30->mute_gpio) {
+		/* Enable MUTE controls via MUTE pin */
+		regmap_write(cs53l30->regmap, CS53L30_MUTEP_CTL1,
+			     CS53L30_MUTEP_CTL1_MUTEALL);
+		/* Flip the polarity of MUTE pin */
+		if (gpiod_is_active_low(cs53l30->mute_gpio))
+			regmap_update_bits(cs53l30->regmap, CS53L30_MUTEP_CTL2,
+					   CS53L30_MUTE_PIN_POLARITY, 0);
+	}
+
 	if (!of_property_read_u8(np, "cirrus,micbias-lvl", &val))
 		regmap_update_bits(cs53l30->regmap, CS53L30_MICBIAS_CTL,
 				   CS53L30_MIC_BIAS_CTRL_MASK, val);
diff --git a/sound/soc/codecs/cs53l30.h b/sound/soc/codecs/cs53l30.h
index 0dd4afb..5e39da5 100644
--- a/sound/soc/codecs/cs53l30.h
+++ b/sound/soc/codecs/cs53l30.h
@@ -253,6 +253,7 @@
 #define CS53L30_MUTE_MB_ALL_PDN_MASK	(1 << CS53L30_MUTE_MB_ALL_PDN_SHIFT)
 #define CS53L30_MUTE_MB_ALL_PDN		(1 << CS53L30_MUTE_MB_ALL_PDN_SHIFT)
 
+#define CS53L30_MUTEP_CTL1_MUTEALL	(0xdf)
 #define CS53L30_MUTEP_CTL1_DEFAULT	(0)
 
 /* R32 (0x20) CS53L30_MUTEP_CTL2 - MUTE Pin Control 2 */
-- 
2.1.4
