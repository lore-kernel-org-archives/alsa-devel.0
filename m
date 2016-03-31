From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 5/5] dt/bindings: sound: new chip added into TAS571x binding
Date: Thu, 31 Mar 2016 13:54:01 +0200
Message-ID: <1459425241-21941-5-git-send-email-petr@barix.com>
References: <1459425241-21941-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459425241-21941-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This adds the TAS5721 into the TAS571x binding.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
v1: <initial>

v2: formatting of the "compatible" strings amended

v3: <no change>

 Documentation/devicetree/bindings/sound/tas571x.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
index 0ac31d8..b4959f1 100644
--- a/Documentation/devicetree/bindings/sound/tas571x.txt
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -1,4 +1,4 @@
-Texas Instruments TAS5711/TAS5717/TAS5719 stereo power amplifiers
+Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers
 
 The codec is controlled through an I2C interface.  It also has two other
 signals that can be wired up to GPIOs: reset (strongly recommended), and
@@ -6,7 +6,11 @@ powerdown (optional).
 
 Required properties:
 
-- compatible: "ti,tas5711", "ti,tas5717", or "ti,tas5719"
+- compatible: should be one of the following:
+  - "ti,tas5711",
+  - "ti,tas5717",
+  - "ti,tas5719",
+  - "ti,tas5721"
 - reg: The I2C address of the device
 - #sound-dai-cells: must be equal to 0
 
@@ -25,6 +29,8 @@ Optional properties:
 - PVDD_B-supply: regulator phandle for the PVDD_B supply (5711)
 - PVDD_C-supply: regulator phandle for the PVDD_C supply (5711)
 - PVDD_D-supply: regulator phandle for the PVDD_D supply (5711)
+- DRVDD-supply: regulator phandle for the DRVDD supply (5721)
+- PVDD-supply: regulator phandle for the PVDD supply (5721)
 
 Example:
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
