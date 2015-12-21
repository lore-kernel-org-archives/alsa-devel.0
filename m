From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v1 2/2] dt-bindings: sound: add devicetree document for rt5616
Date: Mon, 21 Dec 2015 22:56:08 +0800
Message-ID: <1450709768-14898-1-git-send-email-wxt@rock-chips.com>
References: <1450703894-32623-2-git-send-email-wxt@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450703894-32623-2-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add the description for rt5616 codec.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v1:
- As Heiko comments, remove the not exist option properties.

 Documentation/devicetree/bindings/sound/rt5616.txt | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Documentation/devicetree/bindings/sound/rt5616.txt
new file mode 100644
index 0000000..2030a22
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5616.txt
@@ -0,0 +1,36 @@
+RT5616 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5616".
+
+- reg : The I2C address of the device.
+
+Pins on the device (for linking into audio routes) for RT5616:
+
+  * IN1P
+  * IN2P
+  * IN2N
+  * LOUTL
+  * LOUTR
+  * CPN2
+  * CPP2
+  * CPN1
+  * CPP1
+  * HPO_R
+  * HPO_L
+  * ADCDAT1
+  * DACDAT1
+  * LRCK1
+  * BCLK1
+  * MCLK
+  * GPIO1
+
+Example:
+
+rt5616 {
+	compatible = "realtek,rt5616";
+	reg = <0x1b>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
