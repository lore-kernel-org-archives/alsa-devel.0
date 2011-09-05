From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/2 v2] drm/i915: pass ELD to HDMI/DP audio
	driver
Date: Mon, 5 Sep 2011 14:51:40 +0800
Message-ID: <20110905065140.GC20230@localhost>
References: <20110905062320.GA7535@localhost>
	<20110905062534.GA20230@localhost>
	<20110905065042.GB20230@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 91F28103848
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 08:51:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110905065042.GB20230@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Keith Packard <keithp@keithp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Zhenyu <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Chris Wilson <chris@chris-wilson.co.uk>, Zhao Yakui <yakui.zhao@intel.com>, "Fu,
	Michael" <michael.fu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, James Cloos <cloos@jhcloos.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, Paul Menzel <paulepanter@users.sourceforge.net>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Add ELD support for Intel Eaglelake, IbexPeak/Ironlake,
SandyBridge/CougarPoint and IvyBridge/PantherPoint chips.

ELD (EDID-Like Data) describes to the HDMI/DP audio driver the audio
capabilities of the plugged monitor. It's built and passed to audio
driver in 2 steps:

(1) at get_modes time, parse EDID and save ELD to drm_connector.eld[]

(2) at mode_set time, write drm_connector.eld[] to the Transcoder's hw
    ELD buffer and set the ELD_valid bit to inform HDMI/DP audio driver

This patch is tested OK on G45/HDMI, IbexPeak/HDMI and IvyBridge/HDMI+DP.
Test scheme: plug in the HDMI/DP monitor, and run

        cat /proc/asound/card0/eld*

to check if the monitor name, HDMI/DP type, etc. show up correctly.

Minor imperfection: the GEN5_AUD_CNTL_ST/DIP_Port_Select field always
reads 0 (reserved). Without knowing the port number, I worked it around
by setting the ELD_valid bit for ALL the three ports. It's tested to not
be a problem, because the audio driver will either find unpresent
monitor or invalid ELD data and abort rightfully even when it sees the
ELD_valid indicator.

Thanks to Zhenyu and Pierre-Louis for a lot of valuable help and testing.

CC: Zhao Yakui <yakui.zhao@intel.com>
CC: Wang Zhenyu <zhenyu.z.wang@intel.com>
CC: Jeremy Bush <contractfrombelow@gmail.com>
CC: Christopher White <c.white@pulseforce.com>
CC: Paul Menzel <paulepanter@users.sourceforge.net>
CC: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h      |    2 
 drivers/gpu/drm/i915/i915_reg.h      |   25 ++++
 drivers/gpu/drm/i915/intel_display.c |  131 ++++++++++++++++++++++++-
 drivers/gpu/drm/i915/intel_dp.c      |    6 -
 drivers/gpu/drm/i915/intel_drv.h     |    2 
 drivers/gpu/drm/i915/intel_hdmi.c    |    3 
 drivers/gpu/drm/i915/intel_modes.c   |    2 
 7 files changed, 169 insertions(+), 2 deletions(-)

--- linux-next.orig/drivers/gpu/drm/i915/intel_hdmi.c	2011-09-05 14:12:08.000000000 +0800
+++ linux-next/drivers/gpu/drm/i915/intel_hdmi.c	2011-09-05 14:12:31.000000000 +0800
@@ -245,8 +245,11 @@ static void intel_hdmi_mode_set(struct d
 		sdvox |= HDMI_MODE_SELECT;
 
 	if (intel_hdmi->has_audio) {
+		DRM_DEBUG_DRIVER("Enabling HDMI audio on pipe %c\n",
+				 pipe_name(intel_crtc->pipe));
 		sdvox |= SDVO_AUDIO_ENABLE;
 		sdvox |= SDVO_NULL_PACKETS_DURING_VSYNC;
+		intel_write_eld(encoder, adjusted_mode);
 	}
 
 	if (intel_crtc->pipe == 1) {
--- linux-next.orig/drivers/gpu/drm/i915/intel_display.c	2011-09-05 14:12:08.000000000 +0800
+++ linux-next/drivers/gpu/drm/i915/intel_display.c	2011-09-05 14:46:21.000000000 +0800
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
+#include <drm/drm_edid.h>
 #include "drmP.h"
 #include "intel_drv.h"
 #include "i915_drm.h"
@@ -5667,6 +5668,131 @@ static int intel_crtc_mode_set(struct dr
 	return ret;
 }
 
+static void g4x_write_eld(struct drm_connector *connector,
+			  struct drm_crtc *crtc)
+{
+	struct drm_i915_private *dev_priv = connector->dev->dev_private;
+	uint8_t *eld = connector->eld;
+	uint32_t eldv;
+	uint32_t len;
+	uint32_t i;
+
+	i = I915_READ(G4X_AUD_VID_DID);
+
+	if (i == INTEL_AUDIO_DEVBLC || i == INTEL_AUDIO_DEVCL)
+		eldv = G4X_ELDV_DEVCL_DEVBLC;
+	else
+		eldv = G4X_ELDV_DEVCTG;
+
+	i = I915_READ(G4X_AUD_CNTL_ST);
+	i &= ~(eldv | G4X_ELD_ADDR);
+	len = (i >> 9) & 0x1f;		/* ELD buffer size */
+	I915_WRITE(G4X_AUD_CNTL_ST, i);
+
+	if (!eld[0])
+		return;
+
+	len = min_t(uint8_t, eld[2], len);
+	DRM_DEBUG_DRIVER("writing %d ELD dword(s) on pipe %c\n",
+			 len, pipe_name(to_intel_crtc(crtc)->pipe));
+	for (i = 0; i < len; i++)
+		I915_WRITE(G4X_HDMIW_HDMIEDID, *((uint32_t *)eld + i));
+
+	i = I915_READ(G4X_AUD_CNTL_ST);
+	i |= eldv;
+	I915_WRITE(G4X_AUD_CNTL_ST, i);
+}
+
+static void ironlake_write_eld(struct drm_connector *connector,
+				     struct drm_crtc *crtc)
+{
+	struct drm_i915_private *dev_priv = connector->dev->dev_private;
+	uint8_t *eld = connector->eld;
+	uint32_t eldv;
+	uint32_t i;
+	int len;
+	int aud_cntl_st;
+	int aud_cntl_st2;
+	int hdmiw_hdmiedid;
+
+	if (IS_IVYBRIDGE(connector->dev)) {
+		aud_cntl_st = GEN7_AUD_CNTRL_ST_A;
+		aud_cntl_st2 = GEN7_AUD_CNTRL_ST2;
+		hdmiw_hdmiedid = GEN7_HDMIW_HDMIEDID_A;
+	} else {
+		aud_cntl_st = GEN5_AUD_CNTL_ST_A;
+		aud_cntl_st2 = GEN5_AUD_CNTL_ST2;
+		hdmiw_hdmiedid = GEN5_HDMIW_HDMIEDID_A;
+	}
+
+	i = to_intel_crtc(crtc)->pipe;
+	hdmiw_hdmiedid += i * 0x100;
+	aud_cntl_st += i * 0x100;
+
+	i = I915_READ(aud_cntl_st);
+	i = (i >> 29) & 0x3;		/* DIP_Port_Select, 0x1 = PortB */
+	if (!i) {
+		DRM_DEBUG_DRIVER("Audio directed to unknown port\n");
+		/* operate blindly on all ports */
+		eldv = GEN5_ELD_VALIDB;
+		eldv |= GEN5_ELD_VALIDB << 4;
+		eldv |= GEN5_ELD_VALIDB << 8;
+	} else {
+		DRM_DEBUG_DRIVER("ELD on port %c\n", 'A' + i);
+		eldv = GEN5_ELD_VALIDB << ((i - 1) * 4);
+	}
+
+	i = I915_READ(aud_cntl_st2);
+	i &= ~eldv;
+	I915_WRITE(aud_cntl_st2, i);
+
+	if (!eld[0])
+		return;
+
+	if (intel_pipe_has_type(crtc, INTEL_OUTPUT_DISPLAYPORT)) {
+		DRM_DEBUG_DRIVER("ELD: DisplayPort detected\n");
+		eld[5] |= (1 << 2);	/* Conn_Type, 0x1 = DisplayPort */
+	}
+
+	i = I915_READ(aud_cntl_st);
+	i &= ~GEN5_ELD_ADDRESS;
+	I915_WRITE(aud_cntl_st, i);
+
+	len = min_t(uint8_t, eld[2], 21);	/* 84 bytes of hw ELD buffer */
+	DRM_DEBUG_DRIVER("writing %d ELD dword(s) on pipe %c\n",
+			 len, pipe_name(to_intel_crtc(crtc)->pipe));
+	for (i = 0; i < len; i++)
+		I915_WRITE(hdmiw_hdmiedid, *((uint32_t *)eld + i));
+
+	i = I915_READ(aud_cntl_st2);
+	i |= eldv;
+	I915_WRITE(aud_cntl_st2, i);
+}
+
+void intel_write_eld(struct drm_encoder *encoder,
+		     struct drm_display_mode *mode)
+{
+	struct drm_crtc *crtc = encoder->crtc;
+	struct drm_connector *connector;
+	struct drm_device *dev = encoder->dev;
+	struct drm_i915_private *dev_priv = dev->dev_private;
+
+	connector = drm_select_eld(encoder, mode);
+	if (!connector)
+		return;
+
+	DRM_DEBUG_DRIVER("ELD on [CONNECTOR:%d:%s], [ENCODER:%d:%s]\n",
+			 connector->base.id,
+			 drm_get_connector_name(connector),
+			 connector->encoder->base.id,
+			 drm_get_encoder_name(connector->encoder));
+
+	connector->eld[6] = drm_av_sync_delay(connector, mode) / 2;
+
+	if (dev_priv->display.write_eld)
+		dev_priv->display.write_eld(connector, crtc);
+}
+
 /** Loads the palette/gamma unit for the CRTC with the prepared values */
 void intel_crtc_load_lut(struct drm_crtc *crtc)
 {
@@ -8183,6 +8309,7 @@ static void intel_init_display(struct dr
 			}
 			dev_priv->display.fdi_link_train = ironlake_fdi_link_train;
 			dev_priv->display.init_clock_gating = ironlake_init_clock_gating;
+			dev_priv->display.write_eld = ironlake_write_eld;
 		} else if (IS_GEN6(dev)) {
 			if (SNB_READ_WM0_LATENCY()) {
 				dev_priv->display.update_wm = sandybridge_update_wm;
@@ -8193,6 +8320,7 @@ static void intel_init_display(struct dr
 			}
 			dev_priv->display.fdi_link_train = gen6_fdi_link_train;
 			dev_priv->display.init_clock_gating = gen6_init_clock_gating;
+			dev_priv->display.write_eld = ironlake_write_eld;
 		} else if (IS_IVYBRIDGE(dev)) {
 			/* FIXME: detect B0+ stepping and use auto training */
 			dev_priv->display.fdi_link_train = ivb_manual_fdi_link_train;
@@ -8204,7 +8332,7 @@ static void intel_init_display(struct dr
 				dev_priv->display.update_wm = NULL;
 			}
 			dev_priv->display.init_clock_gating = ivybridge_init_clock_gating;
-
+			dev_priv->display.write_eld = ironlake_write_eld;
 		} else
 			dev_priv->display.update_wm = NULL;
 	} else if (IS_PINEVIEW(dev)) {
@@ -8224,6 +8352,7 @@ static void intel_init_display(struct dr
 			dev_priv->display.update_wm = pineview_update_wm;
 		dev_priv->display.init_clock_gating = gen3_init_clock_gating;
 	} else if (IS_G4X(dev)) {
+		dev_priv->display.write_eld = g4x_write_eld;
 		dev_priv->display.update_wm = g4x_update_wm;
 		dev_priv->display.init_clock_gating = g4x_init_clock_gating;
 	} else if (IS_GEN4(dev)) {
--- linux-next.orig/drivers/gpu/drm/i915/i915_reg.h	2011-09-05 14:12:08.000000000 +0800
+++ linux-next/drivers/gpu/drm/i915/i915_reg.h	2011-09-05 14:12:31.000000000 +0800
@@ -3470,4 +3470,29 @@
 #define GEN6_PCODE_DATA				0x138128
 #define   GEN6_PCODE_FREQ_IA_RATIO_SHIFT	8
 
+#define G4X_AUD_VID_DID			0x62020
+#define INTEL_AUDIO_DEVCL		0x808629FB
+#define INTEL_AUDIO_DEVBLC		0x80862801
+#define INTEL_AUDIO_DEVCTG		0x80862802
+
+#define G4X_AUD_CNTL_ST			0x620B4
+#define G4X_ELDV_DEVCL_DEVBLC		(1 << 13)
+#define G4X_ELDV_DEVCTG			(1 << 14)
+#define G4X_ELD_ADDR			(0xf << 5)
+#define G4X_ELD_ACK			(1 << 4)
+#define G4X_HDMIW_HDMIEDID		0x6210C
+
+#define GEN5_HDMIW_HDMIEDID_A		0xE2050
+#define GEN5_AUD_CNTL_ST_A		0xE20B4
+#define GEN5_ELD_BUFFER_SIZE		(0x1f << 10)
+#define GEN5_ELD_ADDRESS		(0x1f << 5)
+#define GEN5_ELD_ACK			(1 << 4)
+#define GEN5_AUD_CNTL_ST2		0xE20C0
+#define GEN5_ELD_VALIDB			(1 << 0)
+#define GEN5_CP_READYB			(1 << 1)
+
+#define GEN7_HDMIW_HDMIEDID_A		0xE5050
+#define GEN7_AUD_CNTRL_ST_A		0xE50B4
+#define GEN7_AUD_CNTRL_ST2		0xE50C0
+
 #endif /* _I915_REG_H_ */
--- linux-next.orig/drivers/gpu/drm/i915/intel_drv.h	2011-09-05 14:12:08.000000000 +0800
+++ linux-next/drivers/gpu/drm/i915/intel_drv.h	2011-09-05 14:12:31.000000000 +0800
@@ -380,4 +380,6 @@ extern void intel_fb_output_poll_changed
 extern void intel_fb_restore_mode(struct drm_device *dev);
 
 extern void intel_init_clock_gating(struct drm_device *dev);
+extern void intel_write_eld(struct drm_encoder *encoder,
+			    struct drm_display_mode *mode);
 #endif /* __INTEL_DRV_H__ */
--- linux-next.orig/drivers/gpu/drm/i915/intel_modes.c	2011-09-05 14:12:08.000000000 +0800
+++ linux-next/drivers/gpu/drm/i915/intel_modes.c	2011-09-05 14:12:31.000000000 +0800
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/fb.h>
+#include <drm/drm_edid.h>
 #include "drmP.h"
 #include "intel_drv.h"
 #include "i915_drv.h"
@@ -74,6 +75,7 @@ int intel_ddc_get_modes(struct drm_conne
 	if (edid) {
 		drm_mode_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
+		drm_edid_to_eld(connector, edid);
 		connector->display_info.raw_edid = NULL;
 		kfree(edid);
 	}
--- linux-next.orig/drivers/gpu/drm/i915/intel_dp.c	2011-09-05 14:12:08.000000000 +0800
+++ linux-next/drivers/gpu/drm/i915/intel_dp.c	2011-09-05 14:12:31.000000000 +0800
@@ -773,8 +773,12 @@ intel_dp_mode_set(struct drm_encoder *en
 		intel_dp->DP |= DP_PORT_WIDTH_4;
 		break;
 	}
-	if (intel_dp->has_audio)
+	if (intel_dp->has_audio) {
+		DRM_DEBUG_DRIVER("Enabling DP audio on pipe %c\n",
+				 pipe_name(intel_crtc->pipe));
 		intel_dp->DP |= DP_AUDIO_OUTPUT_ENABLE;
+		intel_write_eld(encoder, adjusted_mode);
+	}
 
 	memset(intel_dp->link_configuration, 0, DP_LINK_CONFIGURATION_SIZE);
 	intel_dp->link_configuration[0] = intel_dp->link_bw;
--- linux-next.orig/drivers/gpu/drm/i915/i915_drv.h	2011-09-05 14:12:08.000000000 +0800
+++ linux-next/drivers/gpu/drm/i915/i915_drv.h	2011-09-05 14:12:31.000000000 +0800
@@ -209,6 +209,8 @@ struct drm_i915_display_funcs {
 			     struct drm_display_mode *adjusted_mode,
 			     int x, int y,
 			     struct drm_framebuffer *old_fb);
+	void (*write_eld)(struct drm_connector *connector,
+			  struct drm_crtc *crtc);
 	void (*fdi_link_train)(struct drm_crtc *crtc);
 	void (*init_clock_gating)(struct drm_device *dev);
 	void (*init_pch_clock_gating)(struct drm_device *dev);
