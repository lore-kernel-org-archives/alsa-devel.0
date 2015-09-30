From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 1/4] dt-bindings: add sunxi SPDIF transceiver bindings
Date: Wed, 30 Sep 2015 19:50:55 +0200
Message-ID: <1443635458-8873-2-git-send-email-codekipper@gmail.com>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBCGCWCYAKGQE6ADCOBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1443635458-8873-1-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add devicetree bindings for the SPDIF transceiver found on
found on Allwinners A10, A20 and A31 SoCs.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/sound/sunxi,spdif.txt      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/sunxi,spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
new file mode 100644
index 0000000..1868722
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
@@ -0,0 +1,49 @@
+Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
+
+The Allwinner S/PDIF audio block is a transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+
+Required properties:
+
+  - compatible		: should be one of the following:
+    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
+    - "allwinner,sun7i-a20-spdif": for the Allwinner A20 SoC
+    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
+
+  - reg			: Offset and length of the register set for the device.
+
+  - interrupts		: Contains the spdif interrupt.
+
+  - dmas		: Generic dma devicetree binding as described in
+			  Documentation/devicetree/bindings/dma/dma.txt.
+
+  - dma-names		: Two dmas have to be defined, "tx" and "rx".
+
+  - clocks		: Contains an entry for each entry in clock-names.
+
+  - clock-names		: Includes the following entries:
+	"apb"		  clock for the spdif bus.
+	"audio"		  clock from the audio pll.
+	"spdif"		  clock for spdif controller.
+
+Optional:
+
+  - spdif-in		: Enable block for capturing an SPDIF signal.
+
+  - spdif-out		: Enable block for transmitting an SPDIF signal.
+
+Example:
+
+spdif: spdif@01c21000 {
+	compatible = "allwinner,sun4i-a10-spdif";
+	reg = <0x01c21000 0x40>;
+	interrupts = <13>;
+	clocks = <&apb0_gates 1>, <&pll2 0>, <&spdif_clk>;
+	clock-names = "apb", "audio", "spdif";
+	dmas = <&dma 0 2>, <&dma 0 2>;
+	dma-names = "rx", "tx";
+	spdif-in = "disabled";
+	spdif-out = "okay";
+	status = "okay";
+};
-- 
1.9.1
