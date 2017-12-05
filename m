From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 1/2] dt-bindings: sound: add bindings for TAS6424
Date: Tue, 5 Dec 2017 09:54:11 -0600
Message-ID: <20171205155412.20137-2-afd@ti.com>
References: <20171205155412.20137-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171205155412.20137-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Michael Stecklein <m-stecklein-l0cyMroinI0@public.gmane.org>

Add the bindings for the TAS6424 digital amplifier.

Signed-off-by: Michael Stecklein <m-stecklein-l0cyMroinI0@public.gmane.org>
Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/sound/ti,tas6424.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
new file mode 100644
index 000000000000..1c4ada0eef4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -0,0 +1,20 @@
+Texas Instruments TAS6424 Quad-Channel Audio amplifier
+
+The TAS6424 serial control bus communicates through I2C protocols.
+
+Required properties:
+	- compatible: "ti,tas6424" - TAS6424
+	- reg: I2C slave address
+	- sound-dai-cells: must be equal to 0
+
+Example:
+
+tas6424: tas6424@6a {
+	compatible = "ti,tas6424";
+	reg = <0x6a>;
+
+	#sound-dai-cells = <0>;
+};
+
+For more product information please see the link below:
+http://www.ti.com/product/TAS6424-Q1
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
