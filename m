From: Vitaly Wool <vitalywool@gmail.com>
Subject: [PATCH] davinci-evm: extend it to support DM81xx and
	derivatives
Date: Wed, 12 Jul 2017 12:43:18 +0200
Message-ID: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id BAF81266ECA
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 12:43:21 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id g21so2106625lfk.1
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 03:43:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, trini@konsulko.com
List-Id: alsa-devel@alsa-project.org

Having worked closely with TI DM8148/DM8168 EVMs I came across
many derivatives of these boards which didn't use the standard
codec but had something like wm897x instead. They all would fit
davinci-evm driver nicely if it had support for audio CPU clock
divisor and slightly more generic naming. So this patch adds
support for reading CPU divisor from a DT and slightly changes
names of helper/init functions to be more generic.

It also adds support for DaVinci boards that use wm8978 codec.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 .../bindings/sound/davinci-evm-audio.txt           |  6 +-
 sound/soc/davinci/davinci-evm.c                    | 66 ++++++++++++++++++++--
 2 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
index 963e100514c2..e76966a06f22 100644
--- a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
@@ -1,7 +1,9 @@
-* Texas Instruments SoC audio setups with TLV320AIC3X Codec
+* Texas Instruments SoC audio setups with TLV320AIC3X/WM89XX codecs
 
 Required properties:
 - compatible : "ti,da830-evm-audio" : forDM365/DA8xx/OMAPL1x/AM33xx
+	       "ti,dm8168-evm-audio" : for DM81xx with TLV320AIC3x
+	       "ti,dm8168-evm-audio-wm8978" : for DM81xx with WM897x
 - ti,model : The user-visible name of this sound complex.
 - ti,audio-codec : The phandle of the TLV320AIC3x audio codec
 - ti,mcasp-controller : The phandle of the McASP controller
@@ -14,6 +16,8 @@ Optional properties:
 - ti,codec-clock-rate : The Codec Clock rate (in Hz) applied to the Codec.
 - clocks : Reference to the master clock
 - clock-names : The clock should be named "mclk"
+- ti,cpu-clkdiv : CPU clock divisor (if codec and cpu are clocked at
+  different rates)
 - Either codec-clock-rate or the codec-clock reference has to be defined. If
   the both are defined the driver attempts to set referenced clock to the
   defined rate and takes the rate from the clock reference.
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7a369e0f2093..aa8e11583a84 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -26,7 +26,8 @@
 
 struct snd_soc_card_drvdata_davinci {
 	struct clk *mclk;
-	unsigned sysclk;
+	unsigned int sysclk;
+	unsigned int clkdiv;
 };
 
 static int evm_startup(struct snd_pcm_substream *substream)
@@ -61,8 +62,11 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_card *soc_card = rtd->card;
 	int ret = 0;
-	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
-			   snd_soc_card_get_drvdata(soc_card))->sysclk;
+	unsigned int sysclk = ((struct snd_soc_card_drvdata_davinci *)
+				snd_soc_card_get_drvdata(soc_card))->sysclk;
+	unsigned int clkdiv = ((struct snd_soc_card_drvdata_davinci *)
+				snd_soc_card_get_drvdata(soc_card))->clkdiv;
+
 
 	/* set the codec system clock */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
@@ -74,6 +78,13 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/* set the CPU system clock divisor */
+	if (clkdiv) {
+		ret = snd_soc_dai_set_clkdiv(cpu_dai, 0, clkdiv);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -84,7 +95,7 @@ static struct snd_soc_ops evm_ops = {
 };
 
 /* davinci-evm machine dapm widgets */
-static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget evm_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
@@ -121,8 +132,8 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	/* Add davinci-evm specific widgets */
-	snd_soc_dapm_new_controls(&card->dapm, aic3x_dapm_widgets,
-				  ARRAY_SIZE(aic3x_dapm_widgets));
+	snd_soc_dapm_new_controls(&card->dapm, evm_dapm_widgets,
+				  ARRAY_SIZE(evm_dapm_widgets));
 
 	if (np) {
 		ret = snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
@@ -142,6 +153,28 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+/* Logic for a non-aic3x (e. g. wm89xx) connected to a davinci-evm */
+static int evm_simple_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct device_node *np = card->dev->of_node;
+
+	/* Add davinci-evm specific widgets */
+	snd_soc_dapm_new_controls(&card->dapm, evm_dapm_widgets,
+				  ARRAY_SIZE(evm_dapm_widgets));
+
+	/* audio routing is optional here */
+	if (np)
+		snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
+
+	/* not connected */
+	snd_soc_dapm_nc_pin(&card->dapm, "MONO_LOUT");
+	snd_soc_dapm_nc_pin(&card->dapm, "HPLCOM");
+	snd_soc_dapm_nc_pin(&card->dapm, "HPRCOM");
+
+	return 0;
+}
+
 /* davinci-evm digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link dm6446_evm_dai = {
 	.name = "TLV320AIC3X",
@@ -340,11 +373,29 @@ static struct snd_soc_dai_link evm_dai_tlv320aic3x = {
 		   SND_SOC_DAIFMT_IB_NF,
 };
 
+static struct snd_soc_dai_link evm_dai_wm8978 = {
+	.name		= "wm8978",
+	.stream_name	= "wm8978",
+	.codec_dai_name	= "wm8978-hifi",
+	.ops            = &evm_ops,
+	.init           = evm_simple_init,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM |
+		 SND_SOC_DAIFMT_IB_NF,
+};
+
 static const struct of_device_id davinci_evm_dt_ids[] = {
 	{
 		.compatible = "ti,da830-evm-audio",
 		.data = (void *) &evm_dai_tlv320aic3x,
 	},
+	{
+		.compatible = "ti,dm8168-evm-audio",
+		.data = (void *) &evm_dai_tlv320aic3x,
+	},
+	{
+		.compatible = "ti,dm8168-evm-audio-wm8978",
+		.data = (void *) &evm_dai_wm8978,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, davinci_evm_dt_ids);
@@ -422,6 +473,9 @@ static int davinci_evm_probe(struct platform_device *pdev)
 				 requestd_rate, drvdata->sysclk);
 	}
 
+	/* CPU clock divisor may need to be provided for e. g. wm897x */
+	of_property_read_u32(np, "ti,cpu-clkdiv", &drvdata->clkdiv);
+
 	snd_soc_card_set_drvdata(&evm_soc_card, drvdata);
 	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
 
-- 
2.11.0
