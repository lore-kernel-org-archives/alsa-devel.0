From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: Add irq parameter to DOCUMENTATION" to the asoc tree
Date: Mon, 13 Jun 2016 17:54:37 +0100
Message-ID: <E1bCV8H-0004aa-If@finisterre>
References: <49fab21a9c10576cb0c5d6a2bb0e19c7bcfb732f.1463996627.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <49fab21a9c10576cb0c5d6a2bb0e19c7bcfb732f.1463996627.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Jose Abreu <joabreu@synopsys.com>, Rob Herring <robh@kernel.org>, Carlos Palminha <palminha@synopsys.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>Rob Herring <robh@kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>alsa-devel@alsa-project.orgRob Herring <robh@kernel.org>Liam Girdwood <lgirdwood@gmail.com>linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.orgMark Brown <broonie@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: Add irq parameter to DOCUMENTATION

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

>From 5aa1418defb0e88fb7f70c5b112d531cfcede851 Mon Sep 17 00:00:00 2001
From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Thu, 9 Jun 2016 12:47:06 +0100
Subject: [PATCH] ASoC: dwc: Add irq parameter to DOCUMENTATION

A parameter description for the interruptions of the
I2S controller was added.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/designware-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
index 7bb54247f8e8..6a536d570e29 100644
--- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/designware-i2s.txt
@@ -12,6 +12,10 @@ Required properties:
    one for receive.
  - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
 
+Optional properties:
+ - interrupts: The interrupt line number for the I2S controller. Add this
+   parameter if the I2S controller that you are using does not support DMA.
+
 For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
 properties please check:
 	* resource-names.txt
-- 
2.8.1
