From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 09/17] ASoC: fsl-ssi: make fsl,
	mode property optional
Date: Mon, 28 Apr 2014 12:54:50 +0200
Message-ID: <1398682498-24357-10-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4EC6A261600
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 12:55:26 +0200 (CEST)
In-Reply-To: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The simple soundcard binding has its own way for specifying the dai
format. To be able to use this binding we have to make the fsl,mode
property optional. As the property is used in existing devicetrees
keep the option around for compatibility reasons.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f2255cb..3821dac 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -564,12 +564,9 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
- * fsl_ssi_set_dai_fmt - configure Digital Audio Interface Format.
- */
-static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
+		unsigned int fmt)
 {
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	u32 strcr = 0, stcr, srcr, scr, mask;
 	u8 wm;
@@ -707,6 +704,17 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		fsl_ssi_setup_ac97(ssi_private);
 
 	return 0;
+
+}
+
+/**
+ * fsl_ssi_set_dai_fmt - configure Digital Audio Interface Format.
+ */
+static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+
+	return _fsl_ssi_set_dai_fmt(ssi_private, fmt);
 }
 
 /**
@@ -1130,7 +1138,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	const uint32_t *iprop;
 	struct resource res;
 	char name[64];
-	bool ac97 = false;
 
 	/* SSIs that are not connected on the board should have a
 	 *      status = "disabled"
@@ -1143,14 +1150,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
-	sprop = of_get_property(np, "fsl,mode", NULL);
-	if (!sprop) {
-		dev_err(&pdev->dev, "fsl,mode property is necessary\n");
-		return -EINVAL;
-	}
-	if (!strcmp(sprop, "ac97-slave"))
-		ac97 = true;
-
 	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private),
 			GFP_KERNEL);
 	if (!ssi_private) {
@@ -1160,10 +1159,19 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ssi_private->soc = of_id->data;
 
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (sprop) {
+		if (!strcmp(sprop, "ac97-slave"))
+			ssi_private->dai_fmt = SND_SOC_DAIFMT_AC97;
+		else if (!strcmp(sprop, "i2s-slave"))
+			ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
+				SND_SOC_DAIFMT_CBM_CFM;
+	}
+
 	ssi_private->use_dma = !of_property_read_bool(np,
 			"fsl,fiq-stream-filter");
 
-	if (ac97) {
+	if (fsl_ssi_is_ac97(ssi_private)) {
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
 				sizeof(fsl_ssi_ac97_dai));
 
@@ -1274,6 +1282,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
+	if (ssi_private->dai_fmt)
+		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
+
 	return 0;
 
 error_sound_card:
-- 
1.9.1
