From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 15/17] ARM: omap2plus_defconfig: Build DSS HDMI support for OMAP4 in kernel
Date: Sat, 26 Apr 2014 00:16:53 +0300
Message-ID: <b89da4a7028685dfb7834e27fc063292cf0b87aa.1398453425.git.jsarha@ti.com>
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
Panda board. In addition to this patch omapdss.def_disp=hdmi parameter
should be added to kernel command line in order to enable HDMI video.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/configs/omap2plus_defconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a966795..35c42aa 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -187,14 +187,14 @@ CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
-CONFIG_OMAP2_DSS=m
+CONFIG_OMAP2_DSS=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
-CONFIG_FB_OMAP2=m
+CONFIG_FB_OMAP2=y
 CONFIG_DISPLAY_ENCODER_TFP410=m
 CONFIG_DISPLAY_ENCODER_TPD12S015=m
-CONFIG_DISPLAY_CONNECTOR_DVI=m
-CONFIG_DISPLAY_CONNECTOR_HDMI=m
+CONFIG_DISPLAY_CONNECTOR_DVI=y
+CONFIG_DISPLAY_CONNECTOR_HDMI=y
 CONFIG_DISPLAY_PANEL_DPI=m
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
