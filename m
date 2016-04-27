From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2 v6] ASoC: dwc: Update DOCUMENTATION for I2S Driver
Date: Wed, 27 Apr 2016 11:05:20 +0100
Message-ID: <30ee79f0744cdf3561d43654f1ecf3d486bf7a08.1461749984.git.joabreu@synopsys.com>
References: <cover.1461749984.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1461749984.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1461749984.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1461749984.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Carlos Palminha <CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch updates documentation for the Designware I2S
driver.

Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Carlos Palminha <palminha-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---

No changes v5 -> v6.

Changes v4 -> v5:
* interrupts is now required property
* Drop 'snps-use-dmaengine' property

This patch was only introduced in v4.

 Documentation/devicetree/bindings/sound/designware-i2s.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
index 7bb5424..27a728f 100644
--- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/designware-i2s.txt
@@ -3,14 +3,18 @@ DesignWare I2S controller
 Required properties:
  - compatible : Must be "snps,designware-i2s"
  - reg : Must contain the I2S core's registers location and length
+ - interrupts: <IRQ> where IRQ is the interrupt number.
  - clocks : Pairs of phandle and specifier referencing the controller's
    clocks. The controller expects one clock: the clock used as the sampling
    rate reference clock sample.
  - clock-names : "i2sclk" for the sample rate reference clock.
+
+Optional properties:
  - dmas: Pairs of phandle and specifier for the DMA channels that are used by
    the core. The core expects one or two dma channels: one for transmit and
-   one for receive.
- - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
+   one for receive. Set this parameter if the I2S DMA block is enabled.
+ - dma-names : "tx" for the transmit channel, "rx" for the receive channel. Set
+   this parameter if the I2S DMA block is enabled.
 
 For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
 properties please check:
@@ -23,6 +27,7 @@ Example:
 	soc_i2s: i2s@7ff90000 {
 		compatible = "snps,designware-i2s";
 		reg = <0x0 0x7ff90000 0x0 0x1000>;
+		interrupts = <15>;
 		clocks = <&scpi_i2sclk 0>;
 		clock-names = "i2sclk";
 		#sound-dai-cells = <0>;
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
