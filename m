From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/13] drm: bridge/dw_hdmi: remove
 mhsyncpolarity/mvsyncpolarity/minterlaced
Date: Sat, 09 May 2015 11:26:21 +0100
Message-ID: <E1Yr1xd-0006ks-Vr@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150509102501.GO2067@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Remove the struct hdmi_vmode mhsyncpolarity/mvsyncpolarity/minterlaced
members, which are only used within a single function.  We can directly
reference the appropriate mode->flags instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index a8bd3fbf4300..75728ba552d0 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -82,9 +82,6 @@ static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
 
 struct hdmi_vmode {
 	bool mdvi;
-	bool mhsyncpolarity;
-	bool mvsyncpolarity;
-	bool minterlaced;
 	bool mdataenablepolarity;
 
 	unsigned int mpixelclock;
@@ -1024,9 +1021,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
 	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
 
-	vmode->mhsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
-	vmode->mvsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
-	vmode->minterlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
 	vmode->mpixelclock = mode->clock * 1000;
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
@@ -1036,13 +1030,13 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
 
-	inv_val |= (vmode->mvsyncpolarity ?
+	inv_val |= mode->flags & DRM_MODE_FLAG_PVSYNC ?
 		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_HIGH :
-		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_LOW);
+		HDMI_FC_INVIDCONF_VSYNC_IN_POLARITY_ACTIVE_LOW;
 
-	inv_val |= (vmode->mhsyncpolarity ?
+	inv_val |= mode->flags & DRM_MODE_FLAG_PHSYNC ?
 		HDMI_FC_INVIDCONF_HSYNC_IN_POLARITY_ACTIVE_HIGH :
-		HDMI_FC_INVIDCONF_HSYNC_IN_POLARITY_ACTIVE_LOW);
+		HDMI_FC_INVIDCONF_HSYNC_IN_POLARITY_ACTIVE_LOW;
 
 	inv_val |= (vmode->mdataenablepolarity ?
 		HDMI_FC_INVIDCONF_DE_IN_POLARITY_ACTIVE_HIGH :
@@ -1051,13 +1045,13 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	if (hdmi->vic == 39)
 		inv_val |= HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_HIGH;
 	else
-		inv_val |= (vmode->minterlaced ?
+		inv_val |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
 			HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_HIGH :
-			HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_LOW);
+			HDMI_FC_INVIDCONF_R_V_BLANK_IN_OSC_ACTIVE_LOW;
 
-	inv_val |= (vmode->minterlaced ?
+	inv_val |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
 		HDMI_FC_INVIDCONF_IN_I_P_INTERLACED :
-		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE);
+		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE;
 
 	inv_val |= (vmode->mdvi ?
 		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE :
-- 
1.8.3.1
