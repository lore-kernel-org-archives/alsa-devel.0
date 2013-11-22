From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/4] ASoC: wm8991: Move basic initialisation to
	I2C level probe
Date: Fri, 22 Nov 2013 13:39:15 +0000
Message-ID: <1385127556-1661-3-git-send-email-broonie@kernel.org>
References: <1385127556-1661-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A19D0264F1E
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 14:39:26 +0100 (CET)
In-Reply-To: <1385127556-1661-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This is better practice, though some of this stuff ought not to be here at
all.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8991.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 7006f9732af6..5fdcf788e990 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -111,8 +111,6 @@ static bool wm8991_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-#define wm8991_reset(c) snd_soc_write(c, WM8991_RESET, 0)
-
 static const unsigned int rec_mix_tlv[] = {
 	TLV_DB_RANGE_HEAD(1),
 	0, 7, TLV_DB_LINEAR_ITEM(-1500, 600),
@@ -1264,31 +1262,8 @@ static int wm8991_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = wm8991_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
-	}
-
 	wm8991_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_update_bits(codec, WM8991_AUDIO_INTERFACE_4,
-			    WM8991_ALRCGPIO1, WM8991_ALRCGPIO1);
-
-	snd_soc_update_bits(codec, WM8991_GPIO1_GPIO2,
-			    WM8991_GPIO1_SEL_MASK, 1);
-
-	snd_soc_update_bits(codec, WM8991_POWER_MANAGEMENT_1,
-			    WM8991_VREF_ENA | WM8991_VMID_MODE_MASK,
-			    WM8991_VREF_ENA | WM8991_VMID_MODE_MASK);
-
-	snd_soc_update_bits(codec, WM8991_POWER_MANAGEMENT_2,
-			    WM8991_OPCLK_ENA, WM8991_OPCLK_ENA);
-
-	snd_soc_write(codec, WM8991_DAC_CTRL, 0);
-	snd_soc_write(codec, WM8991_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
-	snd_soc_write(codec, WM8991_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
-
 	return 0;
 }
 
@@ -1372,6 +1347,31 @@ static int wm8991_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8991);
 
+	ret = regmap_write(wm8991->regmap, WM8991_RESET, 0);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to issue reset: %d\n", ret);
+		return ret;
+	}
+
+	regmap_update_bits(wm8991->regmap, WM8991_AUDIO_INTERFACE_4,
+			   WM8991_ALRCGPIO1, WM8991_ALRCGPIO1);
+
+	regmap_update_bits(wm8991->regmap, WM8991_GPIO1_GPIO2,
+			   WM8991_GPIO1_SEL_MASK, 1);
+
+	regmap_update_bits(wm8991->regmap, WM8991_POWER_MANAGEMENT_1,
+			   WM8991_VREF_ENA | WM8991_VMID_MODE_MASK,
+			   WM8991_VREF_ENA | WM8991_VMID_MODE_MASK);
+
+	regmap_update_bits(wm8991->regmap, WM8991_POWER_MANAGEMENT_2,
+			   WM8991_OPCLK_ENA, WM8991_OPCLK_ENA);
+
+	regmap_write(wm8991->regmap, WM8991_DAC_CTRL, 0);
+	regmap_write(wm8991->regmap, WM8991_LEFT_OUTPUT_VOLUME,
+		     0x50 | (1<<8));
+	regmap_write(wm8991->regmap, WM8991_RIGHT_OUTPUT_VOLUME,
+		     0x50 | (1<<8));
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8991, &wm8991_dai, 1);
 
-- 
1.8.4.4
