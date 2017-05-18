From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 2/4] ASoC: cs35l35: Add DT handling for Inductor
Date: Thu, 18 May 2017 16:32:37 +0100
Message-ID: <1495121559-1063-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495121559-1063-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>

Need to specify the inductor size in nH. This is a required property.

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/cs35l35.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
index 016b768..77ee75c 100644
--- a/Documentation/devicetree/bindings/sound/cs35l35.txt
+++ b/Documentation/devicetree/bindings/sound/cs35l35.txt
@@ -16,6 +16,9 @@ Required properties:
     (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
     for further information relating to interrupt properties)
 
+ - cirrus,boost-ind-nanohenry: Inductor value for boost converter. The value is
+    in nH and they can be values of 1000nH, 1200nH, 1500nH, and 2200nH.
+
 Optional properties:
   - reset-gpios : gpio used to reset the amplifier
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
