From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH v2 2/4] ASoC: wm8804: Update binding documentation to include reset GPIO
Date: Tue,  7 Apr 2015 12:55:08 +0100
Message-ID: <1428407710-26152-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428407710-26152-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428407710-26152-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, info-Ht5PubfIbSajfpyLsbbDOw@public.gmane.org, sapthagiri.baratam-sjhevXS25z0S+FvcfC7Uqw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/wm8804.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8804.txt b/Documentation/devicetree/bindings/sound/wm8804.txt
index 10ef076..6fd124b 100644
--- a/Documentation/devicetree/bindings/sound/wm8804.txt
+++ b/Documentation/devicetree/bindings/sound/wm8804.txt
@@ -13,6 +13,10 @@ Required properties:
   - PVDD-supply, DVDD-supply : Power supplies for the device, as covered
     in Documentation/devicetree/bindings/regulator/regulator.txt
 
+Optional properties:
+
+  - wlf,reset-gpio: A GPIO specifier for the GPIO controlling the reset pin
+
 Example:
 
 codec: wm8804@1a {
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
