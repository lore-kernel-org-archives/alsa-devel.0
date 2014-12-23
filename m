From: Andrew Jackson <andrew.jackson-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 4/5] ASoC: dwc: Add documentation for I2S DT
Date: Tue, 23 Dec 2014 13:56:26 +0000
Message-ID: <ffbfb442b3ba3d7dec5a7ba3e0e596678d4e74e5.1419342218.git.Andrew.Jackson@arm.com>
References: <cover.1419342218.git.Andrew.Jackson@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1419342218.git.Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
In-Reply-To: <cover.1419342218.git.Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
References: <cover.1419342218.git.Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rajeev Kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>

Add documentation for Designware I2S hardware block.  The block requires
one clock (for audio sampling) and DMA channels for receive and transmit.

Signed-off-by: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/sound/designware-i2s.txt   |   31 ++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
new file mode 100644
index 0000000..7bb5424
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/designware-i2s.txt
@@ -0,0 +1,31 @@
+DesignWare I2S controller
+
+Required properties:
+ - compatible : Must be "snps,designware-i2s"
+ - reg : Must contain the I2S core's registers location and length
+ - clocks : Pairs of phandle and specifier referencing the controller's
+   clocks. The controller expects one clock: the clock used as the sampling
+   rate reference clock sample.
+ - clock-names : "i2sclk" for the sample rate reference clock.
+ - dmas: Pairs of phandle and specifier for the DMA channels that are used by
+   the core. The core expects one or two dma channels: one for transmit and
+   one for receive.
+ - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
+
+For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
+properties please check:
+	* resource-names.txt
+	* clock/clock-bindings.txt
+	* dma/dma.txt
+
+Example:
+
+	soc_i2s: i2s@7ff90000 {
+		compatible = "snps,designware-i2s";
+		reg = <0x0 0x7ff90000 0x0 0x1000>;
+		clocks = <&scpi_i2sclk 0>;
+		clock-names = "i2sclk";
+		#sound-dai-cells = <0>;
+		dmas = <&dma0 5>;
+		dma-names = "tx";
+	};
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
