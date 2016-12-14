From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: Fix PIO mode initialization" to the asoc tree
Date: Wed, 14 Dec 2016 18:03:23 +0000
Message-ID: <E1cHDtj-00075Y-UT@debutante>
References: <1ded72e27be422c2591fb252ea30b87cdbb7e7b1.1481626830.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1ded72e27be422c2591fb252ea30b87cdbb7e7b1.1481626830.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Jose Abreu <joabreu@synopsys.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: Fix PIO mode initialization

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6fce983f9b3ef51d47e647b2cff15049ef803781 Mon Sep 17 00:00:00 2001
From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Tue, 13 Dec 2016 11:03:49 +0000
Subject: [PATCH] ASoC: dwc: Fix PIO mode initialization

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 2998954a1c74..bdf8398cbc81 100644
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
2.11.0
