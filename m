From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Use of_node_name_eq for node name comparisons" to the asoc tree
Date: Thu,  6 Dec 2018 20:26:02 +0000 (GMT)
Message-ID: <20181206202602.639D711252F7@debutante.sirena.org.uk>
References: <20181205195050.4759-33-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-33-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.orgMark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.orgTimur Tabi <timur@kernel.org>Xiubo Li <Xiubo.Lee@gmail.com>Takashi Iwai <tiwai@suse.com>Liam Girdwood <lgirdwood@gmail.com>Nicolin Chen <nicoleotsuka@gmail.com>Mark Brown <broonie@kernel.org>Fabio Estevam <fabio.estevam@nxp.com>linuxppc-dev@lists.ozlabs.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Use of_node_name_eq for node name comparisons

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

>From 1d52a74ea2300158f87196fa381cde52d98cf4e4 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 13:50:49 -0600
Subject: [PATCH] ASoC: Use of_node_name_eq for node name comparisons

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For the FSL ASoC card, the full node names appear to be "ssi", "esai",
and "sai", so there's not any reason to use strstr and of_node_name_eq
can be used instead.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c       | 6 +++---
 sound/soc/generic/simple-scu-card.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 44433b20435c..81f2fe2c6d23 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -571,17 +571,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Common settings for corresponding Freescale CPU DAI driver */
-	if (strstr(cpu_np->name, "ssi")) {
+	if (of_node_name_eq(cpu_np, "ssi")) {
 		/* Only SSI needs to configure AUDMUX */
 		ret = fsl_asoc_card_audmux_init(np, priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to init audmux\n");
 			goto asrc_fail;
 		}
-	} else if (strstr(cpu_np->name, "esai")) {
+	} else if (of_node_name_eq(cpu_np, "esai")) {
 		priv->cpu_priv.sysclk_id[1] = ESAI_HCKT_EXTAL;
 		priv->cpu_priv.sysclk_id[0] = ESAI_HCKR_EXTAL;
-	} else if (strstr(cpu_np->name, "sai")) {
+	} else if (of_node_name_eq(cpu_np, "sai")) {
 		priv->cpu_priv.sysclk_id[1] = FSL_SAI_CLK_MAST1;
 		priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
 	}
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 7ae1901b2f85..656abe2015e1 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -223,7 +223,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	i = 0;
 	for_each_child_of_node(node, np) {
 		is_fe = false;
-		if (strcmp(np->name, PREFIX "cpu") == 0)
+		if (of_node_name_eq(np, PREFIX "cpu"))
 			is_fe = true;
 
 		ret = asoc_simple_card_dai_link_of(np, priv, daifmt, i, is_fe);
-- 
2.19.0.rc2
