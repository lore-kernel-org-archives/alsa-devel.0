From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: Use snd_soc_dai_init_dma_data()
Date: Fri, 20 Dec 2013 12:35:33 +0800
Message-ID: <1387514133-17463-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Makes the code slightly shorter

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 50a797e..9c89f97 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -377,8 +377,8 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
 
-	cpu_dai->playback_dma_data = &sai->dma_params_tx;
-	cpu_dai->capture_dma_data = &sai->dma_params_rx;
+	snd_soc_dai_init_dma_data(cpu_dai, &sai->dma_params_tx,
+				&sai->dma_params_rx);
 
 	snd_soc_dai_set_drvdata(cpu_dai, sai);
 
-- 
1.8.4
