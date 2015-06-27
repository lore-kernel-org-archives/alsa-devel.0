From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
Date: Sun, 28 Jun 2015 00:51:13 +0200
Message-ID: <558F28E1.7040204@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E711261A8B
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 00:51:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Currently the AC'97 mode in fsl_ssi driver isn't functional.

This patch implements the following changes to make it work
properly:
* IPG clock have to be enabled during AC'97 CODEC
register access,
* AC'97 DAI driver struct need the same probe method as
I2S one to setup DMA params,
* AC'97 bus can support asymmetric playback/capture rates,
* Check whether setting AC'97 ops succeeded and
clean them on removal so the driver can be reloaded,
* AC'97 CODEC will be instantiated in AC'97 mode,
* Set DAI format function small fixes in AC'97 mode.

Tested on UDOO board.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c7647e0..9a63df2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -900,14 +900,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		return -EINVAL;
+		if (!fsl_ssi_is_ac97(ssi_private))
+			return -EINVAL;
 	}
 
 	stcr |= strcr;
 	srcr |= strcr;
 
-	if (ssi_private->cpu_dai_drv.symmetric_rates) {
-		/* Need to clear RXDIR when using SYNC mode */
+	if (ssi_private->cpu_dai_drv.symmetric_rates
+		|| fsl_ssi_is_ac97(ssi_private)) {
+		/* Need to clear RXDIR when using SYNC or AC97 mode */
 		srcr &= ~CCSR_SSI_SRCR_RXDIR;
 		scr |= CCSR_SSI_SCR_SYN;
 	}
@@ -1101,6 +1103,7 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.bus_control = true,
+	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
@@ -1127,10 +1130,17 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	struct regmap *regs = fsl_ac97_data->regs;
 	unsigned int lreg;
 	unsigned int lval;
+	int ret;
 
 	if (reg > 0x7f)
 		return;
 
+	ret = clk_prepare_enable(fsl_ac97_data->clk);
+	if (ret) {
+		pr_err("ac97 write clk_prepare_enable failed: %d\n",
+			ret);
+		return;
+	}
 
 	lreg = reg <<  12;
 	regmap_write(regs, CCSR_SSI_SACADD, lreg);
@@ -1141,6 +1151,8 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	regmap_update_bits(regs, CCSR_SSI_SACNT, CCSR_SSI_SACNT_RDWR_MASK,
 			CCSR_SSI_SACNT_WR);
 	udelay(100);
+
+	clk_disable_unprepare(fsl_ac97_data->clk);
 }
 
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
@@ -1151,6 +1163,14 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 	unsigned short val = -1;
 	u32 reg_val;
 	unsigned int lreg;
+	int ret;
+
+	ret = clk_prepare_enable(fsl_ac97_data->clk);
+	if (ret) {
+		pr_err("ac97 read clk_prepare_enable failed: %d\n",
+			ret);
+		return -1;
+	}
 
 	lreg = (reg & 0x7f) <<  12;
 	regmap_write(regs, CCSR_SSI_SACADD, lreg);
@@ -1162,6 +1182,8 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 	regmap_read(regs, CCSR_SSI_SACDAT, &reg_val);
 	val = (reg_val >> 4) & 0xffff;
 
+	clk_disable_unprepare(fsl_ac97_data->clk);
+
 	return val;
 }
 
@@ -1291,6 +1313,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *iomem;
 	char name[64];
+	bool newbinding;
 
 	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
 	if (!of_id || !of_id->data)
@@ -1320,7 +1343,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 		fsl_ac97_data = ssi_private;
 
-		snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "could not set AC'97 ops\n");
+			return ret;
+		}
 	} else {
 		/* Initialize this copy of the CPU DAI driver structure */
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
@@ -1357,7 +1384,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	/* Are the RX and the TX clocks locked? */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
-		ssi_private->cpu_dai_drv.symmetric_rates = 1;
+		if (!fsl_ssi_is_ac97(ssi_private))
+			ssi_private->cpu_dai_drv.symmetric_rates = 1;
+
 		ssi_private->cpu_dai_drv.symmetric_channels = 1;
 		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
 	}
@@ -1405,7 +1434,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	 * that the machine driver uses new binding which does not require
 	 * SSI driver to trigger machine driver's probe.
 	 */
-	if (!of_get_property(np, "codec-handle", NULL))
+	newbinding = !of_get_property(np, "codec-handle", NULL);
+	if (newbinding)
 		goto done;
 
 	/* Trigger the machine driver's probe function.  The platform driver
@@ -1434,6 +1464,27 @@ done:
 		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
 				     ssi_private->dai_fmt);
 
+	if (newbinding && fsl_ssi_is_ac97(ssi_private)) {
+		u32 ssi_idx;
+
+		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
+		if (ret) {
+			dev_err(&pdev->dev, "cannot get SSI index property\n");
+			goto error_sound_card;
+		}
+
+		ssi_private->pdev =
+			platform_device_register_data(NULL,
+					"ac97-codec", ssi_idx, NULL, 0);
+		if (IS_ERR(ssi_private->pdev)) {
+			ret = PTR_ERR(ssi_private->pdev);
+			dev_err(&pdev->dev,
+				"failed to register AC97 codec platform: %d\n",
+				ret);
+			goto error_sound_card;
+		}
+	}
+
 	return 0;
 
 error_sound_card:
@@ -1458,6 +1509,9 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
+	if (fsl_ssi_is_ac97(ssi_private))
+		snd_soc_set_ac97_ops(NULL);
+
 	return 0;
 }
 
