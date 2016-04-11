From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/6] ASoC: davinci-mcbsp: add binding for McBSP
Date: Mon, 11 Apr 2016 13:45:12 +0200
Message-ID: <1460375117-4311-2-git-send-email-petr@barix.com>
References: <1460375117-4311-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460375117-4311-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add devicetree binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx
MultiChannel Buffered Serial Port (McBSP)

The optional register range "dat" is not implemented at the moment.
The current driver supports only DMA into RX/TX registers but no FIFO.
Once the FIFO is implemented in the driver the "dat" range will be used.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
---
v1: initial
v2: add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
    remove "-audio" postfix from the compatible string
    remove "channel-combine" property

 .../devicetree/bindings/sound/davinci-mcbsp.txt    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
new file mode 100644
index 000000000000..de45865c3863
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
@@ -0,0 +1,51 @@
+Texas Instruments DaVinci McBSP module
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
+audio interface found in some TI DaVinci processors like the OMAP-L138 or AM180x.
+
+
+Required properties:
+~~~~~~~~~~~~~~~~~~~~
+- compatible : "ti,da850-mcbsp"
+
+- reg : physical base address and length of the controller memory mapped
+        region(s).
+- reg-names : Should contain:
+        * "mpu" for the main registers (required). For compatibility with
+          existing software, it is recommended this is the first entry.
+        * "dat" for the data FIFO (optional).
+
+- dmas: three element list of DMA controller phandles, DMA request line and
+	TC channel ordered triplets.
+- dma-names: identifier string for each DMA request line in the dmas property.
+	These strings correspond 1:1 with the ordered pairs in dmas. The dma
+	identifiers must be "rx" and "tx".
+
+Optional properties:
+~~~~~~~~~~~~~~~~~~~~
+- interrupts : Interrupt numbers for McBSP
+- interrupt-names : Known interrupt names are "rx" and "tx"
+
+- pinctrl-0: Should specify pin control group used for this controller.
+- pinctrl-names: Should contain only one value - "default", for more details
+        please refer to pinctrl-bindings.txt
+
+Example (AM1808):
+~~~~~~~~~~~~~~~~~
+
+mcbsp0: mcbsp@1d10000 {
+	compatible = "ti,da850-mcbsp";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp0_pins>;
+
+	reg = 	<0x00110000 0x1000>,
+		<0x00310000 0x1000>;
+	reg-names = "mpu", "dat";
+	interrupts = <97 98>;
+	interrupts-names = "rx", "tx";
+	dmas = <&edma0 3 1
+		&edma0 2 1>;
+	dma-names = "tx", "rx";
+	status = "okay";
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
