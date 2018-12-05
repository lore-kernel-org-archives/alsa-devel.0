From: Rob Herring <robh@kernel.org>
Subject: [PATCH] ASoC: Use of_node_name_eq for node name
	comparisons
Date: Wed,  5 Dec 2018 13:50:49 -0600
Message-ID: <20181205195050.4759-33-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by alsa0.perex.cz (Postfix) with ESMTP id AD0C8267BA5
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 20:51:29 +0100 (CET)
Received: by mail-ot1-f66.google.com with SMTP id n8so15943044otl.6
 for <alsa-devel@alsa-project.org>; Wed, 05 Dec 2018 11:51:29 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

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
index 85b46f0eae0f..e9a1acffcf5b 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -216,7 +216,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	i = 0;
 	for_each_child_of_node(node, np) {
 		is_fe = false;
-		if (strcmp(np->name, PREFIX "cpu") == 0)
+		if (of_node_name_eq(np, PREFIX "cpu"))
 			is_fe = true;
 
 		ret = asoc_simple_card_dai_link_of(np, priv, daifmt, i, is_fe);
-- 
2.19.1
