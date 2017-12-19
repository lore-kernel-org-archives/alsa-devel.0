From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v1 09/15] ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
Date: Tue, 19 Dec 2017 09:00:13 -0800
Message-ID: <1513702819-42310-10-git-send-email-nicoleotsuka@gmail.com>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Since there is a helper function, use it to help readability.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b51591e..fd756dd 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1100,10 +1100,9 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
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
2.7.4
