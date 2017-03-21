From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 4/6] regulator: arizona-micbias: Add description of micbias binding
Date: Tue, 21 Mar 2017 14:45:37 +0000
Message-ID: <1490107539-23995-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490107539-23995-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490107539-23995-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add the new micbias regulators into the Arizona regulator binding
document.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/devicetree/bindings/regulator/arizona-regulator.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
index 443564d..68a13d5 100644
--- a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
@@ -15,3 +15,9 @@ Optional subnodes:
     Documentation/devicetree/bindings/regulator/regulator.txt
   - micvdd : Initial data for the MICVDD regulator, as covered in
     Documentation/devicetree/bindings/regulator/regulator.txt
+
+  - MICBIASx : Initial data for the MICBIAS regulators, as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt but the
+    following additional properties are also supported:
+      - wlf,ext-cap : Specifies if the MICBIAS has external decoupling
+        capacitors attached.
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
