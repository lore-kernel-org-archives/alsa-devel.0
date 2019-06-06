From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: eukrea-tlv320: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:30 +0100 (BST)
Message-ID: <20190606212631.0C50C440046@finisterre.sirena.org.uk>
References: <8736knicr4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D820FF89790
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:31 +0200 (CEST)
In-Reply-To: <8736knicr4.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: eukrea-tlv320: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 3219d9c734627cdf9beee3fd2d136e8fbacb5fcd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:15:54 +0900
Subject: [PATCH] ASoC: fsl: eukrea-tlv320: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index d648268cb454..6f3b768489f6 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -61,13 +61,18 @@ static const struct snd_soc_ops eukrea_tlv320_snd_ops = {
 	.hw_params	= eukrea_tlv320_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "tlv320aic23-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
-	.codec_dai_name	= "tlv320aic23-hifi",
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &eukrea_tlv320_snd_ops,
+	SND_SOC_DAILINK_REG(hifi),
 };
 
 static struct snd_soc_card eukrea_tlv320 = {
@@ -104,7 +109,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 
 		codec_np = of_parse_phandle(ssi_np, "codec-handle", 0);
 		if (codec_np)
-			eukrea_tlv320_dai.codec_of_node = codec_np;
+			eukrea_tlv320_dai.codecs->of_node = codec_np;
 		else
 			dev_err(&pdev->dev, "codec-handle node missing or invalid.\n");
 
@@ -128,12 +133,12 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		int_port--;
 		ext_port--;
 
-		eukrea_tlv320_dai.cpu_of_node = ssi_np;
-		eukrea_tlv320_dai.platform_of_node = ssi_np;
+		eukrea_tlv320_dai.cpus->of_node = ssi_np;
+		eukrea_tlv320_dai.platforms->of_node = ssi_np;
 	} else {
-		eukrea_tlv320_dai.cpu_dai_name = "imx-ssi.0";
-		eukrea_tlv320_dai.platform_name = "imx-ssi.0";
-		eukrea_tlv320_dai.codec_name = "tlv320aic23-codec.0-001a";
+		eukrea_tlv320_dai.cpus->dai_name = "imx-ssi.0";
+		eukrea_tlv320_dai.platforms->name = "imx-ssi.0";
+		eukrea_tlv320_dai.codecs->name = "tlv320aic23-codec.0-001a";
 		eukrea_tlv320.name = "cpuimx-audio";
 	}
 
-- 
2.20.1
