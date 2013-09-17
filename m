From: <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 08/11] ASoC: tlv320aic3x: Add codec pins to DT bindings document
Date: Tue, 17 Sep 2013 12:26:07 +0300
Message-ID: <6ea3d67f8bc283bb7ab0087ccefe411bb2487603.1379409268.git.jsarha@ti.com>
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

Add list of codec pins to tlv320aic3x DT bindings document.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index 11e24b2..2b76c81 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -20,6 +20,25 @@ Optional properties:
 - AVDD-supply, IOVDD-supply, DRVDD-supply, DVDD-supply : power supplies for the
   device as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
+CODEC output pins:
+  * LLOUT
+  * RLOUT
+  * MONO_LOUT
+  * HPLOUT
+  * HPROUT
+  * HPLCOM
+  * HPRCOM
+
+CODEC input pins:
+  * MIC3L
+  * MIC3R
+  * LINE1L
+  * LINE2L
+  * LINE1R
+  * LINE2R
+
+The pins can be used in referring sound node's audio-routing property.
+
 Example:
 
 tlv320aic3x: tlv320aic3x@1b {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
