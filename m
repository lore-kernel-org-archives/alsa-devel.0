From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/2] Documentation: bindings: Add the Allwinner
 A10 codec bindings
Date: Sat, 12 Sep 2015 15:26:23 +0200
Message-ID: <1442064384-23379-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBDEU2GXQKGQEOU4LF6A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1442064384-23379-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The Allwinner SoCs have an in-SoC audio controller taking the role of a DAI
and a codec.

Add the binding documentation for that controller on the A10.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
new file mode 100644
index 000000000000..680144b74ae9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -0,0 +1,33 @@
+* Allwinner A10 Codec
+
+Required properties:
+- compatible: must be either "allwinner,sun4i-a10-codec" or
+  "allwinner,sun7i-a20-codec"
+- reg: must contain the registers location and length
+- interrupts: must contain the codec interrupt
+- dmas: DMA channels for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should include "tx" and "rx".
+- clocks: a list of phandle + clock-specifer pairs, one for each entry
+  in clock-names.
+- clock-names: should contain followings:
+   - "apb": the parent APB clock for this controller
+   - "codec": the parent module clock
+- routing : A list of the connections between audio components.  Each
+  entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source.
+
+
+Example:
+codec: codec@01c22c00 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun7i-a20-codec";
+	reg = <0x01c22c00 0x40>;
+	interrupts = <0 30 4>;
+	clocks = <&apb0_gates 0>, <&codec_clk>;
+	clock-names = "apb", "codec";
+	dmas = <&dma 0 19>, <&dma 0 19>;
+	dma-names = "rx", "tx";
+	routing = "Headphone Jack", "HP Right",
+		  "Headphone Jack", "HP Left";
+};
-- 
2.5.1
