From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320aic31xx: Add support for
	tlv320dac3101
Date: Thu, 10 Nov 2016 09:55:55 +0200
Message-ID: <20161110075555.7878-3-peter.ujfalusi@ti.com>
References: <20161110075555.7878-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id D403F266670
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 08:55:56 +0100 (CET)
In-Reply-To: <20161110075555.7878-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: nikita.yoush@cogentembedded.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The DAC3101 is mostly identical to DAC3100 with the exception that it has
stereo speaker AMP instead of mono used in DAC3100.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 1 +
 sound/soc/codecs/tlv320aic31xx.c                          | 2 ++
 sound/soc/codecs/tlv320aic31xx.h                          | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index 9340d2ddcc54..6fbba562eaa7 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -12,6 +12,7 @@ Required properties:
     "ti,tlv320aic3120" - TLV320AIC3120 (mono speaker amp, MiniDSP)
     "ti,tlv320aic3111" - TLV320AIC3111 (stereo speaker amp, MiniDSP)
     "ti,tlv320dac3100" - TLV320DAC3100 (no ADC, mono speaker amp, no MiniDSP)
+    "ti,tlv320dac3101" - TLV320DAC3101 (no ADC, stereo speaker amp, no MiniDSP)
 
 - reg - <int> -  I2C slave address
 - HPVDD-supply, SPRVDD-supply, SPLVDD-supply, AVDD-supply, IOVDD-supply,
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 8880f6be3336..f8a90ba8cd71 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1254,6 +1254,7 @@ static const struct of_device_id tlv320aic31xx_of_match[] = {
 	{ .compatible = "ti,tlv320aic3120" },
 	{ .compatible = "ti,tlv320aic3111" },
 	{ .compatible = "ti,tlv320dac3100" },
+	{ .compatible = "ti,tlv320dac3101" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320aic31xx_of_match);
@@ -1380,6 +1381,7 @@ static const struct i2c_device_id aic31xx_i2c_id[] = {
 	{ "tlv320aic3120", AIC3120 },
 	{ "tlv320aic3111", AIC3111 },
 	{ "tlv320dac3100", DAC3100 },
+	{ "tlv320dac3101", DAC3101 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 5acd5b69fb83..730fb2058869 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -32,6 +32,7 @@ enum aic31xx_type {
 	AIC3120 = AIC31XX_MINIDSP_BIT,
 	AIC3111 = (AIC31XX_STEREO_CLASS_D_BIT | AIC31XX_MINIDSP_BIT),
 	DAC3100 = DAC31XX_BIT,
+	DAC3101 = DAC31XX_BIT | AIC31XX_STEREO_CLASS_D_BIT,
 };
 
 struct aic31xx_pdata {
-- 
2.10.2
