From: Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] dt-bindings: sgtl5000: Remove leading zero from '@0a' notation
Date: Wed, 25 Oct 2017 15:24:50 -0200
Message-ID: <1508952290-18794-1-git-send-email-marco.franchi@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marcofrk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Improve the binding example by removing the leading 0 from '@0a' notation,
which fixes the following build warning:

Warning (unit_address_format): Node /sgtl5000@0a unit name should not have leading 0s

Signed-off-by: Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 7a73a9d..060cb4a 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -37,7 +37,7 @@ VDDIO		1.8V		2.5V		3.3V
 
 Example:
 
-codec: sgtl5000@0a {
+codec: sgtl5000@a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
 	clocks = <&clks 150>;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
