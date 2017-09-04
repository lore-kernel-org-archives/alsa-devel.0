From: Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
Subject: [PATCH 7/7] ASoC: arizona: Add device tree binding doc for volume limits
Date: Mon, 4 Sep 2017 16:41:54 +0100
Message-ID: <20170904154154.4395-8-ckeepax@opensource.cirrus.com>
References: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170904154154.4395-1-ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/wlf,arizona.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,arizona.txt b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
index 4e67224488d8..e172c62dc2df 100644
--- a/Documentation/devicetree/bindings/sound/wlf,arizona.txt
+++ b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
@@ -47,3 +47,7 @@ Optional properties:
     See the datasheet for values.
     The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
     wm8998, wm1814)
+
+  - wlf,out-volume-limit : The volume limit value that should be applied to each
+    output channel. See the datasheet for exact values. Channels are specified
+    in the order OUT1L, OUT1R, OUT2L, OUT2R, etc.
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
