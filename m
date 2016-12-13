From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH] ASoC: dwc: Fix PIO mode initialization
Date: Tue, 13 Dec 2016 11:03:49 +0000
Message-ID: <1ded72e27be422c2591fb252ea30b87cdbb7e7b1.1481626830.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We can no longer rely on the return value of
devm_snd_dmaengine_pcm_register(...) to check if the DMA
handle is declared in the DT.

Previously this check activated PIO mode but currently
dma_request_chan returns either a valid channel or -EPROBE_DEFER.

In order to activate PIO mode check instead if the interrupt
line is declared. This reflects better what is documented in
the DT bindings (see Documentation/devicetree/bindings/sound/
designware-i2s.txt).

Also, initialize use_pio variable which was never being set
causing PIO mode to never work.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/dwc/designware_i2s.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 2998954..bdf8398 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -681,22 +681,19 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (!pdata) {
-		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
-		if (ret == -EPROBE_DEFER) {
-			dev_err(&pdev->dev,
-				"failed to register PCM, deferring probe\n");
-			return ret;
-		} else if (ret) {
-			dev_err(&pdev->dev,
-				"Could not register DMA PCM: %d\n"
-				"falling back to PIO mode\n", ret);
+		if (irq >= 0) {
 			ret = dw_pcm_register(pdev);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"Could not register PIO PCM: %d\n",
+			dev->use_pio = true;
+		} else {
+			ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
+					0);
+			dev->use_pio = false;
+		}
+
+		if (ret) {
+			dev_err(&pdev->dev, "could not register pcm: %d\n",
 					ret);
-				goto err_clk_disable;
-			}
+			goto err_clk_disable;
 		}
 	}
 
-- 
1.9.1
