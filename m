From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH_V2 2/4] dt: sound: jz4740: Add binding documentation for jz4740-i2s
Date: Mon, 26 Jan 2015 13:15:36 +0000
Message-ID: <1422278138-51097-3-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422278138-51097-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422278138-51097-1-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds binding for the jz4740-i2s driver.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

---
The jz4740 is platform only at the moment.

But DT support is being added

See http://patchwork.linux-mips.org/bundle/paulburton/ci20-v3.20/

V2 changes: Added DMA bindings for later on
---
 .../bindings/sound/ingenic,jz4740-i2s.txt           | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
new file mode 100644
index 0000000..75206cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
@@ -0,0 +1,21 @@
+Ingenic JZ4740 I2S controller
+
+Required properties:
+- compatible : "ingenic,jz4740-i2s"
+- reg : I2S registers location and length
+- clocks : AIC and I2S PLL clock specifiers.
+- clock-names: "aic" and "i2s"
+
+Example:
+
+i2s: i2s@10020000 {
+	compatible = "ingenic,jz4740-i2s";
+	reg = <0x10020000 0x94>;
+
+	clocks = <&cgu JZ4740_CLK_AIC>, <&cgu JZ4740_CLK_I2SPLL>;
+	clock-names = "aic", "i2s";
+
+	dmas = <&dma 2>, <&dma 3>;
+	dma-names = "tx", "rx";
+
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
