From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 15/19] ASoC: tlv320aic31xx: Reset registers
	during power up
Date: Wed, 29 Nov 2017 15:32:56 -0600
Message-ID: <20171129213300.20021-16-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 45B36267957
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 22:33:06 +0100 (CET)
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Add a reset function that toggles the reset line if available or uses
the software reset command otherwise. Use this in power up to ensure the
registers are in a sane state. This is useful when the driver module
is reloaded, or after Kexec, warm-reboots, etc..

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index b51c2777e8d1..77ae8f36a943 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1031,6 +1031,24 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
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
 static void aic31xx_clk_on(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
@@ -1074,11 +1092,11 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
-	if (aic31xx->gpio_reset) {
-		gpiod_set_value(aic31xx->gpio_reset, 0);
-		udelay(100);
-	}
 	regcache_cache_only(aic31xx->regmap, false);
+
+	/* Reset device registers for a consistent power-on like state */
+	aic31xx_reset(aic31xx);
+
 	ret = regcache_sync(aic31xx->regmap);
 	if (ret) {
 		dev_err(codec->dev,
-- 
2.15.0
