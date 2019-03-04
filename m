From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: fix S/PDIF DAI" to the asoc
	tree
Date: Mon,  4 Mar 2019 00:06:12 +0000 (GMT)
Message-ID: <20190304000612.B4476440083@finisterre.ee.mobilebroadband>
References: <E1gzNdq-000598-RJ@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34B2FF89714
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 01:06:16 +0100 (CET)
In-Reply-To: <E1gzNdq-000598-RJ@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: fix S/PDIF DAI

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2e95f984aae4cf0608d0ba2189c756f2bd50b44a Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Thu, 28 Feb 2019 15:30:34 +0000
Subject: [PATCH] ASoC: hdmi-codec: fix S/PDIF DAI

When using the S/PDIF DAI, there is no requirement to call
snd_soc_dai_set_fmt() as there is no DAI format definition that defines
S/PDIF.  In any case, S/PDIF does not have separate clocks, this is
embedded into the data stream.

Consequently, when attempting to use TDA998x in S/PDIF mode, the attempt
to configure TDA998x via the hw_params callback fails as the
hdmi_codec_daifmt is left initialised to zero.

Since the S/PDIF DAI will only be used by S/PDIF, prepare the
hdmi_codec_daifmt structure for this format.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 118 +++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index e5b6769b9797..d5f73c837281 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -529,73 +529,71 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	struct hdmi_codec_daifmt cf = { 0 };
-	int ret = 0;
 
 	dev_dbg(dai->dev, "%s()\n", __func__);
 
-	if (dai->id == DAI_ID_SPDIF) {
-		cf.fmt = HDMI_SPDIF;
-	} else {
-		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-		case SND_SOC_DAIFMT_CBM_CFM:
-			cf.bit_clk_master = 1;
-			cf.frame_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFM:
-			cf.frame_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBM_CFS:
-			cf.bit_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFS:
-			break;
-		default:
-			return -EINVAL;
-		}
+	if (dai->id == DAI_ID_SPDIF)
+		return 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cf.bit_clk_master = 1;
+		cf.frame_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		cf.frame_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		cf.bit_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-		case SND_SOC_DAIFMT_NB_NF:
-			break;
-		case SND_SOC_DAIFMT_NB_IF:
-			cf.frame_clk_inv = 1;
-			break;
-		case SND_SOC_DAIFMT_IB_NF:
-			cf.bit_clk_inv = 1;
-			break;
-		case SND_SOC_DAIFMT_IB_IF:
-			cf.frame_clk_inv = 1;
-			cf.bit_clk_inv = 1;
-			break;
-		}
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		cf.frame_clk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		cf.bit_clk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		cf.frame_clk_inv = 1;
+		cf.bit_clk_inv = 1;
+		break;
+	}
 
-		switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-		case SND_SOC_DAIFMT_I2S:
-			cf.fmt = HDMI_I2S;
-			break;
-		case SND_SOC_DAIFMT_DSP_A:
-			cf.fmt = HDMI_DSP_A;
-			break;
-		case SND_SOC_DAIFMT_DSP_B:
-			cf.fmt = HDMI_DSP_B;
-			break;
-		case SND_SOC_DAIFMT_RIGHT_J:
-			cf.fmt = HDMI_RIGHT_J;
-			break;
-		case SND_SOC_DAIFMT_LEFT_J:
-			cf.fmt = HDMI_LEFT_J;
-			break;
-		case SND_SOC_DAIFMT_AC97:
-			cf.fmt = HDMI_AC97;
-			break;
-		default:
-			dev_err(dai->dev, "Invalid DAI interface format\n");
-			return -EINVAL;
-		}
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		cf.fmt = HDMI_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		cf.fmt = HDMI_DSP_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		cf.fmt = HDMI_DSP_B;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		cf.fmt = HDMI_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		cf.fmt = HDMI_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_AC97:
+		cf.fmt = HDMI_AC97;
+		break;
+	default:
+		dev_err(dai->dev, "Invalid DAI interface format\n");
+		return -EINVAL;
 	}
 
 	hcp->daifmt[dai->id] = cf;
 
-	return ret;
+	return 0;
 }
 
 static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
@@ -792,8 +790,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		i++;
 	}
 
-	if (hcd->spdif)
+	if (hcd->spdif) {
 		hcp->daidrv[i] = hdmi_spdif_dai;
+		hcp->daifmt[DAI_ID_SPDIF].fmt = HDMI_SPDIF;
+	}
 
 	dev_set_drvdata(dev, hcp);
 
-- 
2.20.1
