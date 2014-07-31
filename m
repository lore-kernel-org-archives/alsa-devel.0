From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch -next] ASoC: fsl_asrc: fix an error code in fsl_asrc_probe()
Date: Thu, 31 Jul 2014 12:32:09 +0300
Message-ID: <20140731093209.GF30276@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a cut and paste bug so it returns success instead of the error
code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index b9a2888..b04438c 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -826,7 +826,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	asrc_priv->mem_clk = devm_clk_get(&pdev->dev, "mem");
 	if (IS_ERR(asrc_priv->mem_clk)) {
 		dev_err(&pdev->dev, "failed to get mem clock\n");
-		return PTR_ERR(asrc_priv->ipg_clk);
+		return PTR_ERR(asrc_priv->mem_clk);
 	}
 
 	asrc_priv->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
