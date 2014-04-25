From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 16/17] ARM: omap2plus_defconfig: Enable OMAP5 HDMI support
Date: Sat, 26 Apr 2014 00:16:54 +0300
Message-ID: <dab95ca6b8261c6eadf8dd4e01c873d1c72de572.1398453425.git.jsarha@ti.com>
References: <cover.1398453425.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch is here only as an example on how to enable HDMI video for
OMAP5 uEVM. Adds CONFIG_GPIO_PCA953X=y and CONFIG_OMAP5_DSS_HDMI=y.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 35c42aa..363733e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -157,6 +157,7 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
+CONFIG_GPIO_PCA953X=y
 CONFIG_W1=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_LM75=m
@@ -190,6 +191,7 @@ CONFIG_FB_TILEBLITTING=y
 CONFIG_OMAP2_DSS=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
+CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_FB_OMAP2=y
 CONFIG_DISPLAY_ENCODER_TFP410=m
 CONFIG_DISPLAY_ENCODER_TPD12S015=m
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
