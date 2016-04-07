From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 5/5 v4] ASoC: dwc: Update DOCUMENTATION for I2S Driver
Date: Thu,  7 Apr 2016 17:53:59 +0100
Message-ID: <ce97e6bb7ddb71e532c4066334ceead4d4d3e692.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com, architt@codeaurora.org, airlied@linux.ie, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, Jose Abreu <Jose.Abreu@synopsys.com>
List-Id: alsa-devel@alsa-project.org

This patch updates documentation for the Designware I2S
driver.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
---

This patch was only introduced in v4.

 Documentation/devicetree/bindings/sound/designware-i2s.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
index 7bb5424..f3b5c17 100644
--- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/designware-i2s.txt
@@ -7,6 +7,10 @@ Required properties:
    clocks. The controller expects one clock: the clock used as the sampling
    rate reference clock sample.
  - clock-names : "i2sclk" for the sample rate reference clock.
+
+ Optional properties:
+ - snps,use-dmaengine: If set the driver will use ALSA DMA engine. If set
+   it is required to use the properties 'dmas' and 'dma-names'.
  - dmas: Pairs of phandle and specifier for the DMA channels that are used by
    the core. The core expects one or two dma channels: one for transmit and
    one for receive.
@@ -26,6 +30,7 @@ Example:
 		clocks = <&scpi_i2sclk 0>;
 		clock-names = "i2sclk";
 		#sound-dai-cells = <0>;
+		snps,use-dmaengine;
 		dmas = <&dma0 5>;
 		dma-names = "tx";
 	};
-- 
1.9.1
