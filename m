From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] pass ELD to HDMI/DP audio driver
Date: Wed, 29 Jun 2011 14:20:13 +0800
Message-ID: <20110629062013.GA17296@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 29156246DC
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 08:20:19 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>
Cc: Keith Packard <keithp@keithp.com>, Wang Zhenyu <zhenyu.z.wang@intel.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Zhao Yakui <yakui.zhao@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Add ELD support for Eaglelake, IbexPeak/Ironlake and SandyBridge/CougarPoint.

ELD (EDID-Like Data) describes to the HDMI/DP audio driver the audio
capabilities of the plugged monitor. It's built and passed to audio
driver in 2 steps:

(1) at get_modes time, parse EDID and save ELD to drm_connector.eld[]

(2) at mode_set time, write drm_connector.eld[] to the Transcoder's hw
    ELD buffer and set the ELD_valid bit to inform HDMI/DP audio driver

ELD selection policy: it's possible for one encoder to be associated
with multiple connectors (ie. monitors), in which case the first found
ELD will be used. This policy may not be suitable for all users, but
let's start it simple first.

The impact of ELD selection policy: assume there are two monitors, one
supports stereo playback and the other has 8-channel output; cloned
display mode is used, so that the two monitors are associated with the
same internal encoder. If only the stereo playback capability is reported,
the user won't be able to start 8-channel playback; if the 8-channel ELD
is reported, then user space applications may send 8-channel samples
down, however the user may actually be listening to the 2-channel
monitor and not connecting speakers to the 8-channel monitor. Overall,
it's more safe to report maximum profiles to the user space, so that
the user can at least be able to do 8-channel playback if he want to.

This patch is tested OK on G45/HDMI and IbexPeak/HDMI. DisplayPort is
tested on several IbexPeak and Sandybridge boxes, however not working,
possibly due to hardware/monitor problems.

One known problem is that the GEN6_AUD_CNTL_ST/DIP_Port_Select field
is always 0 (reserved). Without knowing the port number, I worked it
around by setting the ELD_valid bit for ALL the three ports.

CC: Zhao Yakui <yakui.zhao@intel.com>
CC: Wang Zhenyu <zhenyu.z.wang@intel.com>
CC: Jeremy Bush <contractfrombelow@gmail.com>
CC: Christopher White <c.white@pulseforce.com>
CC: "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 drivers/gpu/drm/drm_edid.c           |  171 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_drv.h      |    2 
 drivers/gpu/drm/i915/i915_reg.h      |   20 ++
 drivers/gpu/drm/i915/intel_display.c |  119 +++++++++++++++++
 drivers/gpu/drm/i915/intel_dp.c      |    2 
 drivers/gpu/drm/i915/intel_drv.h     |    3 
 drivers/gpu/drm/i915/intel_hdmi.c    |    2 
 drivers/gpu/drm/i915/intel_modes.c   |    2 
 include/drm/drm_crtc.h               |   10 +
 include/drm/drm_edid.h               |    9 +
 10 files changed, 340 insertions(+)

--- sound-2.6.orig/drivers/gpu/drm/drm_edid.c	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/drm_edid.c	2011-06-29 14:13:20.000000000 +0800
@@ -1292,6 +1292,7 @@ add_detailed_modes(struct drm_connector 
 #define HDMI_IDENTIFIER 0x000C03
 #define AUDIO_BLOCK	0x01
 #define VENDOR_BLOCK    0x03
+#define SPEAKER_BLOCK	0x04
 #define EDID_BASIC_AUDIO	(1 << 6)
 
 /**
@@ -1320,6 +1321,176 @@ u8 *drm_find_cea_extension(struct edid *
 }
 EXPORT_SYMBOL(drm_find_cea_extension);
 
+static void
+parse_hdmi_vsdb(struct drm_connector *connector, uint8_t *db)
+{
+	connector->eld[5] |= (db[6] >> 7) << 1;  /* Supports_AI */
+
+	connector->dvi_dual = db[6] & 1;
+	connector->max_tmds_clock = db[7] * 5;
+
+	connector->latency_present[0] = db[8] >> 7;
+	connector->latency_present[1] = (db[8] >> 6) & 1;
+	connector->video_latency[0] = db[9];
+	connector->audio_latency[0] = db[10];
+	connector->video_latency[1] = db[11];
+	connector->audio_latency[1] = db[12];
+
+	DRM_LOG_KMS("HDMI: DVI dual %d, "
+		    "max TMDS clock %d, "
+		    "latency present %d %d, "
+		    "video latency %d %d, "
+		    "audio latency %d %d\n",
+		    connector->dvi_dual,
+		    connector->max_tmds_clock,
+	      (int) connector->latency_present[0],
+	      (int) connector->latency_present[1],
+		    connector->video_latency[0],
+		    connector->video_latency[1],
+		    connector->audio_latency[0],
+		    connector->audio_latency[1]);
+}
+
+static void
+monitor_name(struct detailed_timing *t, void *data)
+{
+	if (t->data.other_data.type == EDID_DETAIL_MONITOR_NAME)
+		*(u8 **)data = t->data.other_data.data.str.str;
+}
+
+/**
+ * drm_edid_to_eld - build ELD from EDID
+ * @connector: connector corresponding to the HDMI/DP sink
+ * @edid: EDID to parse
+ *
+ * Fill the ELD (EDID-Like Data) buffer for passing to the audio driver.
+ * Some ELD fields are left to the graphics driver caller:
+ * - Conn_Type
+ * - HDCP
+ * - Port_ID
+ */
+void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
+{
+	uint8_t *eld = connector->eld;
+	u8 *cea;
+	u8 *name;
+	u8 *db;
+	int sad_count = 0;
+	int mnl;
+	int dbl;
+
+	memset(eld, 0, sizeof(connector->eld));
+
+	cea = drm_find_cea_extension(edid);
+	if (!cea) {
+		DRM_DEBUG_KMS("ELD: no CEA Extension found\n");
+		return;
+	}
+
+	name = NULL;
+	drm_for_each_detailed_block((u8 *)edid, monitor_name, &name);
+	for (mnl = 0; name && mnl < 13; mnl++) {
+		if (name[mnl] == 0x0a)
+			break;
+		eld[20 + mnl] = name[mnl];
+	}
+	eld[4] = (cea[1] << 5) | mnl;
+	DRM_DEBUG_KMS("ELD monitor %s\n", eld + 20);
+
+	eld[0] = 2 << 3;		/* ELD version: 2 */
+
+	eld[16] = edid->mfg_id[0];
+	eld[17] = edid->mfg_id[1];
+	eld[18] = edid->prod_code[0];
+	eld[19] = edid->prod_code[1];
+
+	for (db = cea + 4; db < cea + cea[2]; db += dbl + 1) {
+		dbl = db[0] & 0x1f;
+
+		switch ((db[0] & 0xe0) >> 5) {
+		case AUDIO_BLOCK:	/* Audio Data Block, contains SADs */
+			sad_count = dbl / 3;
+			memcpy(eld + 20 + mnl, &db[1], dbl);
+			break;
+		case SPEAKER_BLOCK:	/* Speaker Allocation Data Block */
+			eld[7] = db[1];
+			break;
+		case VENDOR_BLOCK:
+			/* HDMI Vendor-Specific Data Block */
+			if (db[1] == 0x03 && db[2] == 0x0c && db[3] == 0)
+				parse_hdmi_vsdb(connector, db);
+			break;
+		default:
+			break;
+		}
+	}
+	eld[5] |= sad_count << 4;
+	eld[2] = (20 + mnl + sad_count * 3 + 3) / 4;
+
+	DRM_DEBUG_KMS("ELD size %d, SAD count %d\n", (int)eld[2], sad_count);
+}
+EXPORT_SYMBOL(drm_edid_to_eld);
+
+/**
+ * drm_av_sync_delay - HDMI/DP sink audio-video sync delay in milli-seconds
+ * @connector: connector associated with the HDMI/DP sink
+ * @mode: the display mode
+ */
+int drm_av_sync_delay(struct drm_connector *connector,
+		      struct drm_display_mode *mode)
+{
+	int i = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
+	int a, v;
+
+	if (!connector->latency_present[0])
+		return 0;
+	if (!connector->latency_present[1])
+		i = 0;
+
+	a = connector->audio_latency[i];
+	v = connector->video_latency[i];
+
+	/*
+	 * HDMI/DP sink doesn't support audio or video?
+	 */
+	if (a == 255 || v == 255)
+		return 0;
+
+	/*
+	 * Convert raw edid values to milli-seconds.
+	 * Treat unknown latency as 0ms.
+	 */
+	if (a)
+		a = 2 * (a - 1);
+	if (v)
+		v = 2 * (v - 1);
+
+	return max(v - a, 0);
+}
+EXPORT_SYMBOL(drm_av_sync_delay);
+
+/**
+ * drm_select_eld - select one ELD from multiple HDMI/DP sinks
+ * @encoder: the encoder just changed display mode
+ * @mode: the adjusted display mode
+ *
+ * It's possible for one encoder to be associated with multiple HDMI/DP sinks.
+ * The policy is now hard coded to simply use the first HDMI/DP sink's ELD.
+ */
+struct drm_connector *drm_select_eld(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode)
+{
+	struct drm_connector *connector;
+	struct drm_device *dev = encoder->dev;
+
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
+		if (connector->encoder == encoder)
+			return connector;
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_select_eld);
+
 /**
  * drm_detect_hdmi_monitor - detect whether monitor is hdmi.
  * @edid: monitor EDID information
--- sound-2.6.orig/drivers/gpu/drm/i915/intel_hdmi.c	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/i915/intel_hdmi.c	2011-06-29 13:19:35.000000000 +0800
@@ -151,6 +151,8 @@ static void intel_hdmi_mode_set(struct d
 	POSTING_READ(intel_hdmi->sdvox_reg);
 
 	intel_hdmi_set_avi_infoframe(encoder);
+
+	intel_write_eld(encoder, crtc, adjusted_mode);
 }
 
 static void intel_hdmi_dpms(struct drm_encoder *encoder, int mode)
--- sound-2.6.orig/include/drm/drm_edid.h	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/include/drm/drm_edid.h	2011-06-29 13:19:35.000000000 +0800
@@ -230,4 +230,13 @@ struct edid {
 
 #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
 
+struct drm_encoder;
+struct drm_connector;
+struct drm_display_mode;
+void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid);
+int drm_av_sync_delay(struct drm_connector *connector,
+		      struct drm_display_mode *mode);
+struct drm_connector *drm_select_eld(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode);
+
 #endif /* __DRM_EDID_H__ */
--- sound-2.6.orig/drivers/gpu/drm/i915/intel_display.c	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/i915/intel_display.c	2011-06-29 14:05:05.000000000 +0800
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
+#include <drm/drm_edid.h>
 #include "drmP.h"
 #include "intel_drv.h"
 #include "i915_drm.h"
@@ -5297,6 +5298,121 @@ static int intel_crtc_mode_set(struct dr
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
+	int hdmiw_hdmiedid;
+	int aud_cntl_st;
+
+	i = to_intel_crtc(crtc)->pipe;
+	hdmiw_hdmiedid = GEN6_HDMIW_HDMIEDID_A + i * 0x100;
+	aud_cntl_st = GEN6_AUD_CNTL_ST_A + i * 0x100;
+
+	DRM_DEBUG_DRIVER("ELD on pipe %c\n", pipe_name(i));
+
+	i = I915_READ(aud_cntl_st);
+	i = (i >> 29) & 0x3;		/* DIP_Port_Select, 0x1 = PortB */
+	if (!i) {
+		DRM_DEBUG_DRIVER("Audio directed to unknown port\n");
+		/* operate blindly on all ports */
+		eldv = GEN6_ELD_VALIDB;
+		eldv |= GEN6_ELD_VALIDB << 4;
+		eldv |= GEN6_ELD_VALIDB << 8;
+	} else {
+		DRM_DEBUG_DRIVER("ELD on port %c\n", 'A' + i);
+		eldv = GEN6_ELD_VALIDB << ((i - 1) * 4);
+	}
+
+	i = I915_READ(GEN6_AUD_CNTL_ST2);
+	i &= ~eldv;
+	I915_WRITE(GEN6_AUD_CNTL_ST2, i);
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
+	i &= ~GEN6_ELD_ADDRESS;
+	I915_WRITE(aud_cntl_st, i);
+
+	i = I915_READ(aud_cntl_st);
+	len = (i & GEN6_ELD_BUFFER_SIZE) >> 10;
+	len = min_t(uint8_t, eld[2], len);
+	DRM_DEBUG_DRIVER("ELD size %d\n", len);
+	for (i = 0; i < len; i++)
+		I915_WRITE(hdmiw_hdmiedid, *((uint32_t *)eld + i));
+
+	i = I915_READ(GEN6_AUD_CNTL_ST2);
+	i |= eldv;
+	I915_WRITE(GEN6_AUD_CNTL_ST2, i);
+}
+
+void intel_write_eld(struct drm_encoder *encoder,
+		     struct drm_crtc *crtc,
+		     struct drm_display_mode *mode)
+{
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
@@ -7636,6 +7752,7 @@ static void intel_init_display(struct dr
 			}
 			dev_priv->display.fdi_link_train = ironlake_fdi_link_train;
 			dev_priv->display.init_clock_gating = ironlake_init_clock_gating;
+			dev_priv->display.write_eld = ironlake_write_eld;
 		} else if (IS_GEN6(dev)) {
 			if (SNB_READ_WM0_LATENCY()) {
 				dev_priv->display.update_wm = sandybridge_update_wm;
@@ -7646,6 +7763,7 @@ static void intel_init_display(struct dr
 			}
 			dev_priv->display.fdi_link_train = gen6_fdi_link_train;
 			dev_priv->display.init_clock_gating = gen6_init_clock_gating;
+			dev_priv->display.write_eld = ironlake_write_eld;
 		} else if (IS_IVYBRIDGE(dev)) {
 			/* FIXME: detect B0+ stepping and use auto training */
 			dev_priv->display.fdi_link_train = ivb_manual_fdi_link_train;
@@ -7676,6 +7794,7 @@ static void intel_init_display(struct dr
 		} else
 			dev_priv->display.update_wm = pineview_update_wm;
 	} else if (IS_G4X(dev)) {
+		dev_priv->display.write_eld = g4x_write_eld;
 		dev_priv->display.update_wm = g4x_update_wm;
 		dev_priv->display.init_clock_gating = g4x_init_clock_gating;
 	} else if (IS_GEN4(dev)) {
--- sound-2.6.orig/drivers/gpu/drm/i915/i915_reg.h	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/i915/i915_reg.h	2011-06-29 13:19:35.000000000 +0800
@@ -3436,4 +3436,24 @@
 #define   GEN6_PCODE_WRITE_MIN_FREQ_TABLE	0x9
 #define GEN6_PCODE_DATA				0x138128
 
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
+#define GEN6_HDMIW_HDMIEDID_A		0xE2050
+#define GEN6_AUD_CNTL_ST_A		0xE20B4
+#define GEN6_ELD_BUFFER_SIZE		(0x1f << 10)
+#define GEN6_ELD_ADDRESS		(0x1f << 5)
+#define GEN6_ELD_ACK			(1 << 4)
+#define GEN6_AUD_CNTL_ST2		0xE20C0
+#define GEN6_ELD_VALIDB			(1 << 0)
+#define GEN6_CP_READYB			(1 << 1)
+
 #endif /* _I915_REG_H_ */
--- sound-2.6.orig/drivers/gpu/drm/i915/intel_drv.h	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/i915/intel_drv.h	2011-06-29 13:19:35.000000000 +0800
@@ -346,4 +346,7 @@ extern void intel_fb_output_poll_changed
 extern void intel_fb_restore_mode(struct drm_device *dev);
 
 extern void intel_init_clock_gating(struct drm_device *dev);
+extern void intel_write_eld(struct drm_encoder *encoder,
+			    struct drm_crtc *crtc,
+			    struct drm_display_mode *mode);
 #endif /* __INTEL_DRV_H__ */
--- sound-2.6.orig/drivers/gpu/drm/i915/intel_modes.c	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/i915/intel_modes.c	2011-06-29 13:19:35.000000000 +0800
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
--- sound-2.6.orig/include/drm/drm_crtc.h	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/include/drm/drm_crtc.h	2011-06-29 13:19:35.000000000 +0800
@@ -464,6 +464,8 @@ enum drm_connector_force {
 /* DACs should rarely do this without a lot of testing */
 #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
 
+#define MAX_ELD_BYTES	128
+
 /**
  * drm_connector - central DRM connector control structure
  * @crtc: CRTC this connector is currently connected to, NULL if none
@@ -520,6 +522,14 @@ struct drm_connector {
 	uint32_t encoder_ids[DRM_CONNECTOR_MAX_ENCODER];
 	uint32_t force_encoder_id;
 	struct drm_encoder *encoder; /* currently active encoder */
+
+	/* EDID bits */
+	uint8_t eld[MAX_ELD_BYTES];
+	bool dvi_dual;
+	int max_tmds_clock;	/* in MHz */
+	bool latency_present[2];
+	int video_latency[2];	/* [0]: progressive, [1]: interlaced */
+	int audio_latency[2];
 };
 
 /**
--- sound-2.6.orig/drivers/gpu/drm/i915/intel_dp.c	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/i915/intel_dp.c	2011-06-29 13:19:35.000000000 +0800
@@ -793,6 +793,8 @@ intel_dp_mode_set(struct drm_encoder *en
 		else
 			intel_dp->DP |= DP_PLL_FREQ_270MHZ;
 	}
+
+	intel_write_eld(encoder, crtc, adjusted_mode);
 }
 
 static void ironlake_edp_panel_vdd_on(struct intel_dp *intel_dp)
--- sound-2.6.orig/drivers/gpu/drm/i915/i915_drv.h	2011-06-29 13:18:31.000000000 +0800
+++ sound-2.6/drivers/gpu/drm/i915/i915_drv.h	2011-06-29 13:19:35.000000000 +0800
@@ -208,6 +208,8 @@ struct drm_i915_display_funcs {
 			     struct drm_display_mode *adjusted_mode,
 			     int x, int y,
 			     struct drm_framebuffer *old_fb);
+	void (*write_eld)(struct drm_connector *connector,
+			  struct drm_crtc *crtc);
 	void (*fdi_link_train)(struct drm_crtc *crtc);
 	void (*init_clock_gating)(struct drm_device *dev);
 	void (*init_pch_clock_gating)(struct drm_device *dev);
