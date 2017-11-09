From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 11/17] ASoC: tlv320aic31xx: Reset registers during probe
Date: Wed, 8 Nov 2017 18:27:35 -0600
Message-ID: <20171109002741.10897-12-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109002741.10897-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Add a reset function that toggles the reset line if available or uses
the software reset command otherwise. Use this in probe to ensure the
registers are in a sane state. This is useful when the driver module
is reloaded, or after Kexec, warm-reboots, etc..

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e58b7a4e0402..98e9ba3ee708 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1037,6 +1037,24 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int aic31xx_reset(struct aic31xx_priv *aic31xx)
+{
+	int ret = 0;
+
+	if (aic31xx->gpio_reset) {
+		gpiod_set_value(aic31xx->gpio_reset, 1);
+		ndelay(10); /* At least 10ns */
+		gpiod_set_value(aic31xx->gpio_reset, 0);
+	} else {
+		ret = regmap_write(aic31xx->regmap, AIC31XX_RESET, 1);
+		if (ret < 0)
+			dev_err(aic31xx->dev, "Could not reset device\n");
+	}
+	mdelay(1); /* At least 1ms */
+
+	return ret;
+}
+
 static int aic31xx_regulator_event(struct notifier_block *nb,
 				   unsigned long event, void *data)
 {
@@ -1362,6 +1380,9 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* Reset device registers for a consistent power-on like state */
+	aic31xx_reset(aic31xx);
+
 	if (aic31xx->codec_type & DAC31XX_BIT)
 		return snd_soc_register_codec(&i2c->dev,
 				&soc_codec_driver_aic31xx,
-- 
2.15.0
