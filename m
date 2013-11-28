From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 3/4] dt: Add bindings documentation for the ADI AXI-SPDIF audio controller
Date: Thu, 28 Nov 2013 20:02:51 +0100
Message-ID: <1385665372-29477-3-git-send-email-lars@metafoo.de>
References: <1385665372-29477-1-git-send-email-lars@metafoo.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385665372-29477-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds the devicetree documentation for the ADI AXI-SPDIF audio
controller. The controller has:
 * One set of memory mapped register
 * Two clocks, one for the memory mapped register interface, one used as the
   audio reference clock
 * A DMA interface for the transmit data

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 .../devicetree/bindings/sound/adi,axi-spdif-tx.txt | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
new file mode 100644
index 0000000..489ba9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
@@ -0,0 +1,29 @@
+ADI AXI-SPDIF controller
+
+Required properties:
+ - compatible : Must be "adi,axi-spdif-1.00.a"
+ - reg : Must contain SPDIF registers location and length
+ - clocks : Clock specifier providing a handle to the controller's clocks. The
+   controller expects two clocks, the clock used for the AXI interface and the
+   clock used as the sample rate reference clock.
+ - clock-names: "axi" for the clock to the AXI interface, "ref" for the sample
+   rate reference clock.
+ - dma : Phandle to the dma channels for the transmit DMA.
+ - dma-names : Must be "tx"
+
+For more details on the 'dma', 'dma-names', 'clock' and 'clock-names' properties
+please check:
+	* resource-names.txt
+	* clock/clock-bindings.txt
+	* dma/dma.txt
+
+Example:
+
+	spdif: spdif@0x77400000 {
+		compatible = "adi,axi-spdif-tx-1.00.a";
+		reg = <0x77600000 0x1000>;
+		clocks = <&clk 15 &audio_clock>;
+		clock-names = "axi", "ref";
+		dmas = <&ps7_dma 0>;
+		dma-names = "tx";
+	};
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
