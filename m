From: <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 07/11] ASoC: tlv320aic3x: Add regulators to DT bindings document
Date: Tue, 17 Sep 2013 12:26:06 +0300
Message-ID: <5281fbfa7e5a2090a2949c7b3941debbbc5ac397.1379409268.git.jsarha@ti.com>
References: <cover.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: peter.ujfalusi-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Add regulator properties to tlv320aic3x DT bindings document.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index f47c3f5..11e24b2 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -17,10 +17,17 @@ Optional properties:
 	3 - MICBIAS output is connected to AVDD,
 	If this node is not mentioned or if the value is incorrect, then MicBias
 	is powered down.
+- AVDD-supply, IOVDD-supply, DRVDD-supply, DVDD-supply : power supplies for the
+  device as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
 Example:
 
 tlv320aic3x: tlv320aic3x@1b {
 	compatible = "ti,tlv320aic3x";
 	reg = <0x1b>;
+
+	AVDD-supply = <&regulator>;
+	IOVDD-supply = <&regulator>;
+	DRVDD-supply = <&regulator>;
+	DVDD-supply = <&regulator>;
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
