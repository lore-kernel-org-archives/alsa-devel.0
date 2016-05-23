From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 4/4 v7] ASoC: dwc: Add irq parameter to DOCUMENTATION
Date: Mon, 23 May 2016 11:02:25 +0100
Message-ID: <49fab21a9c10576cb0c5d6a2bb0e19c7bcfb732f.1463996627.git.joabreu@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463996627.git.joabreu@synopsys.com>
In-Reply-To: <cover.1463996627.git.joabreu@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A parameter description for the interruptions of the
I2S controller was added. This interrupt parameter
should only be set when I2S does not have DMA support.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes v6 -> v7:
* interrupts is now optional property

No changes v5 -> v6.

Changes v4 -> v5:
* interrupts is now required property
* Drop 'snps-use-dmaengine' property

This patch was only introduced in v4.

 Documentation/devicetree/bindings/sound/designware-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
index 7bb5424..6a536d5 100644
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
1.9.1
