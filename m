From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v6 11/17] ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
Date: Mon, 12 Feb 2018 14:03:19 -0800
Message-ID: <1518473005-14090-12-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Since there is a helper function, use it to help readability.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 00dfdc7..7e15b30 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1110,10 +1110,9 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 
-	if (ssi->soc->imx && ssi->use_dma) {
-		dai->playback_dma_data = &ssi->dma_params_tx;
-		dai->capture_dma_data = &ssi->dma_params_rx;
-	}
+	if (ssi->soc->imx && ssi->use_dma)
+		snd_soc_dai_init_dma_data(dai, &ssi->dma_params_tx,
+					  &ssi->dma_params_rx);
 
 	return 0;
 }
-- 
2.1.4
