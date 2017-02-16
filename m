From: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 1/3] ASoC: zx-tdm: add bindings doc for zte's tdm  controller
Date: Thu, 16 Feb 2017 19:05:04 +0800
Message-ID: <1487243106-22841-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds dt-binding documentation for zte's tdm controller.

Signed-off-by: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/zte,tdm.txt          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,tdm.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,tdm.txt b/Documentation/devicetree/bindings/sound/zte,tdm.txt
new file mode 100644
index 0000000..8ffc39e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,tdm.txt
@@ -0,0 +1,30 @@
+ZTE TDM DAI driver
+
+Required properties:
+
+- compatible : should be one of the following.
+       * zte,zx296718-tdm
+- reg : physical base address of the controller and length of memory mapped
+    region.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "wclk" for the wclk.
+               "pclk" for the pclk.
+-#clock-cells: should be 1.
+- zte,tdm-dma-sysctrl : Reference to the sysctrl controller controlling
+    the dma. includes:
+	phandle of sysctrl.
+	register offset in sysctrl for control dma.
+	mask of the register that be written to sysctrl.
+
+Example:
+
+	tdm: tdm@1487000 {
+		compatible = "zte,zx296718-tdm";
+		reg = <0x01487000 0x1000>;
+		clocks = <&audiocrm AUDIO_TDM_WCLK>, <&audiocrm AUDIO_TDM_PCLK>;
+		clock-names = "wclk", "pclk";
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tdm_global_pin>;
+		zte,tdm-dma-sysctrl = <&sysctrl 0x10c 4>;
+	};
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
