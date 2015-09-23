From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [alsa-devel][PATCH 2/3] dt-binding: Add sunxi SPDIF
 machine driver
Date: Wed, 23 Sep 2015 20:04:53 +0200
Message-ID: <1443031494-32469-3-git-send-email-codekipper@gmail.com>
References: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBS6TROYAKGQESCX34AI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1443031494-32469-1-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add device tree bindings for the SPDIF machine driver for Allwinner SoC
devices.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../bindings/sound/sunxi-audio-spdif.txt           | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
new file mode 100644
index 0000000..b9e8152
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
@@ -0,0 +1,36 @@
+Allwinner audio complex with S/PDIF transceiver
+
+Required properties:
+
+  - compatible		: "Allwinner,sunxi-audio-spdif"
+
+  - model		: The user-visible name of this sound complex
+
+  - spdif-controller	: The phandle of the Allwinner S/PDIF controller
+
+
+Optional properties:
+
+  - spdif-out		: This is a boolean property. If present, the
+			  transmitting function of S/PDIF will be enabled,
+			  indicating there's a physical S/PDIF out connector
+			  or jack on the board or it's connecting to some
+			  other IP block, such as an HDMI encoder or
+			  display-controller.
+
+  - spdif-in		: This is a boolean property. If present, the receiving
+			  function of S/PDIF will be enabled, indicating there
+			  is a physical S/PDIF in connector/jack on the board.
+
+* Note: At least one of these two properties should be set in the DT binding.
+
+
+Example:
+
+sound-spdif {
+	compatible = "allwinner,sunxi-audio-spdif";
+	model = "sunxi-spdif";
+	spdif-controller = <&spdif>;
+	spdif-out;
+	spdif-in;
+};
-- 
2.5.3
