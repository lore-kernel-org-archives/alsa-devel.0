From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH v3] pass ELD to HDMI/DP audio driver
Date: Mon, 1 Aug 2011 21:51:40 +0800
Message-ID: <20110801135140.GA24205@localhost>
References: <20110729130759.37aca083@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20110729130759.37aca083@jbarnes-desktop>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jesse,

> On Wed, 29 Jun 2011 21:10:13 +0800
> Wu Fengguang <fengguang.wu@intel.com> wrote:
> 
> > Update: according to the spec, limit max a/v latencies to 500ms and
> > avoid overflowing the ELD field Aud_Synch_Delay[7:0].
> > 
> > Thanks to Pierre for pointing this out!
> > 
> > btw, the drm_edid_to_eld() function reuses some code from Ben Skeggs.
> > Ben, please add your Signed-off-by if the patch looks OK to you :)
> 
> Looks like this needs to be refreshed against Keith's drm-intel-next
> tree (some trivial conflicts).

Yeah. Below is the updated patch that also fixes an ELD size bug.
There are still known bugs: when hot plug an HDMI monitor, I get these
dmesg, which show that

1) intel_write_eld() is not called at all
   It seems we need to call intel_write_eld() in other places besides
   inside ->mode_set(). Is ->detect() the right place to do so? In
   other words, are there established connector<=>encoder mapping
   that can be queried inside intel_hdmi_detect()/intel_dp_detect()?

2) intel_dp_detect() is called even though it's an HDMI monitor
   connected to an HDMI jack.. It may be a bug specific to the
   hardware I'm testing (attached its full dmesg).

[  904.770682] [drm:pch_irq_handler], PCH transcoder audio interrupt
[  904.773254] [drm:i915_hotplug_work_func], running encoder hotplug functions
[  904.776021] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[  904.779110] [drm:intel_crt_detect], CRT not detected via hotplug
[  904.781912] [drm:output_poll_execute], [CONNECTOR:11:VGA-1] status updated from 2 to 2
[  904.930301] [drm:drm_detect_monitor_audio], Monitor has basic audio support
[  904.933109] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[  904.935934] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[  904.939263] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[  904.942100] [drm:output_poll_execute], [CONNECTOR:14:HDMI-A-1] status updated from 1 to 1
[  904.945746] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  904.950279] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  904.953273] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  904.955753] [drm:intel_dp_detect], DPCD: 0000000000000000
[  904.956870] [drm:output_poll_execute], [CONNECTOR:17:DP-1] status updated from 2 to 2

> I tested this on a Sandy Bridge laptop I have but wasn't able to get
> audio through my DP->HDMI dongle to my HDMI TV.
> 
> Does the HDMI HDA codec need any special parameters to work?

No. The HDMI audio should just work, given that the HDMI audio device
is somehow selected as the output:

        $ aplay -l
        **** List of PLAYBACK Hardware Devices ****
        card 0: Intel [HDA Intel], device 0: ALC888 Analog [ALC888 Analog]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        card 0: Intel [HDA Intel], device 1: ALC888 Digital [ALC888 Digital]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        card 0: Intel [HDA Intel], device 3: HDMI 0 [HDMI 0]
          Subdevices: 1/1
          Subdevice #0: subdevice #0

        $ aplay -Dplughw:0,3 XXX.wav # hw:0,3 is the first HDMI device
        $ mplayer -ao alsa:device=hw=0.3 XXX.mp3

To verify this patch:

        $ cat /proc/asound/card0/eld*  # examine the HDMI ELD contents

Thanks,
Fengguang
---
Subject: pass ELD to HDMI/DP audio driver
Date: Fri May 20 19:59:33 CST 2011

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
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 drivers/gpu/drm/drm_edid.c           |  171 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_drv.h      |    2 
 drivers/gpu/drm/i915/i915_reg.h      |   20 ++
 drivers/gpu/drm/i915/intel_display.c |  118 +++++++++++++++++
 drivers/gpu/drm/i915/intel_dp.c      |    2 
 drivers/gpu/drm/i915/intel_drv.h     |    3 
 drivers/gpu/drm/i915/intel_hdmi.c    |    3 
 drivers/gpu/drm/i915/intel_modes.c   |    2 
 include/drm/drm_crtc.h               |    9 +
 include/drm/drm_edid.h               |    9 +
 10 files changed, 339 insertions(+)

--- linux-drm.orig/drivers/gpu/drm/drm_edid.c	2011-08-01 16:23:58.360000000 +0800
+++ linux-drm/drivers/gpu/drm/drm_edid.c	2011-08-01 16:25:07.155999999 +0800
@@ -1277,6 +1277,7 @@ find_cea_block(struct edid *edid)
 #define HDMI_IDENTIFIER 0x000C03
 #define AUDIO_BLOCK	0x01
 #define VENDOR_BLOCK    0x03
+#define SPEAKER_BLOCK	0x04
 #define EDID_BASIC_AUDIO	(1 << 6)
 
 /**
@@ -1305,6 +1306,176 @@ u8 *drm_find_cea_extension(struct edid *
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
+		a = min(2 * (a - 1), 500);
+	if (v)
+		v = min(2 * (v - 1), 500);
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
--- linux-drm.orig/drivers/gpu/drm/i915/intel_hdmi.c	2011-08-01 16:23:58.303999986 +0800
+++ linux-drm/drivers/gpu/drm/i915/intel_hdmi.c	2011-08-01 16:39:01.107999987 +0800
@@ -193,6 +193,8 @@ static void intel_hdmi_mode_set(struct d
 		intel_ironlake_hdmi_set_avi_infoframe(encoder);
 	else
 		intel_hdmi_set_avi_infoframe(encoder);
+
+	intel_write_eld(encoder, crtc, adjusted_mode);
 }
 
 static void intel_hdmi_dpms(struct drm_encoder *encoder, int mode)
@@ -269,6 +271,7 @@ intel_hdmi_detect(struct drm_connector *
 			status = connector_status_connected;
 			intel_hdmi->has_hdmi_sink = drm_detect_hdmi_monitor(edid);
 			intel_hdmi->has_audio = drm_detect_monitor_audio(edid);
+			drm_edid_to_eld(connector, edid);
 		}
 		connector->display_info.raw_edid = NULL;
 		kfree(edid);
--- linux-drm.orig/include/drm/drm_edid.h	2011-08-01 16:23:58.264000029 +0800
+++ linux-drm/include/drm/drm_edid.h	2011-08-01 16:25:07.155999999 +0800
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
--- linux-drm.orig/drivers/gpu/drm/i915/intel_display.c	2011-08-01 16:23:58.315999989 +0800
+++ linux-drm/drivers/gpu/drm/i915/intel_display.c	2011-08-01 16:25:07.160000000 +0800
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
+#include <drm/drm_edid.h>
 #include "drmP.h"
 #include "intel_drv.h"
 #include "i915_drm.h"
@@ -5583,6 +5584,120 @@ static int intel_crtc_mode_set(struct dr
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
+	DRM_DEBUG_DRIVER("ELD size %d\n", len);
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
+	len = min_t(uint8_t, eld[2], 21);	/* 84 bytes of hw ELD buffer */
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
@@ -8101,6 +8216,7 @@ static void intel_init_display(struct dr
 			}
 			dev_priv->display.fdi_link_train = ironlake_fdi_link_train;
 			dev_priv->display.init_clock_gating = ironlake_init_clock_gating;
+			dev_priv->display.write_eld = ironlake_write_eld;
 		} else if (IS_GEN6(dev)) {
 			if (SNB_READ_WM0_LATENCY()) {
 				dev_priv->display.update_wm = sandybridge_update_wm;
@@ -8111,6 +8227,7 @@ static void intel_init_display(struct dr
 			}
 			dev_priv->display.fdi_link_train = gen6_fdi_link_train;
 			dev_priv->display.init_clock_gating = gen6_init_clock_gating;
+			dev_priv->display.write_eld = ironlake_write_eld;
 		} else if (IS_IVYBRIDGE(dev)) {
 			/* FIXME: detect B0+ stepping and use auto training */
 			dev_priv->display.fdi_link_train = ivb_manual_fdi_link_train;
@@ -8142,6 +8259,7 @@ static void intel_init_display(struct dr
 			dev_priv->display.update_wm = pineview_update_wm;
 		dev_priv->display.init_clock_gating = gen3_init_clock_gating;
 	} else if (IS_G4X(dev)) {
+		dev_priv->display.write_eld = g4x_write_eld;
 		dev_priv->display.update_wm = g4x_update_wm;
 		dev_priv->display.init_clock_gating = g4x_init_clock_gating;
 	} else if (IS_GEN4(dev)) {
--- linux-drm.orig/drivers/gpu/drm/i915/i915_reg.h	2011-08-01 16:23:58.343999996 +0800
+++ linux-drm/drivers/gpu/drm/i915/i915_reg.h	2011-08-01 16:25:07.196000009 +0800
@@ -3462,4 +3462,24 @@
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
--- linux-drm.orig/drivers/gpu/drm/i915/intel_drv.h	2011-08-01 16:23:58.295999984 +0800
+++ linux-drm/drivers/gpu/drm/i915/intel_drv.h	2011-08-01 16:25:07.200000010 +0800
@@ -356,4 +356,7 @@ extern void intel_fb_output_poll_changed
 extern void intel_fb_restore_mode(struct drm_device *dev);
 
 extern void intel_init_clock_gating(struct drm_device *dev);
+extern void intel_write_eld(struct drm_encoder *encoder,
+			    struct drm_crtc *crtc,
+			    struct drm_display_mode *mode);
 #endif /* __INTEL_DRV_H__ */
--- linux-drm.orig/drivers/gpu/drm/i915/intel_modes.c	2011-08-01 16:23:58.323999991 +0800
+++ linux-drm/drivers/gpu/drm/i915/intel_modes.c	2011-08-01 16:25:07.212000013 +0800
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
--- linux-drm.orig/include/drm/drm_crtc.h	2011-08-01 16:23:58.275999979 +0800
+++ linux-drm/include/drm/drm_crtc.h	2011-08-01 16:25:25.351999998 +0800
@@ -464,6 +464,8 @@ enum drm_connector_force {
 /* DACs should rarely do this without a lot of testing */
 #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
 
+#define MAX_ELD_BYTES	128
+
 /**
  * drm_connector - central DRM connector control structure
  * @crtc: CRTC this connector is currently connected to, NULL if none
@@ -521,6 +523,13 @@ struct drm_connector {
 	uint32_t force_encoder_id;
 	struct drm_encoder *encoder; /* currently active encoder */
 
+	/* EDID bits */
+	uint8_t eld[MAX_ELD_BYTES];
+	bool dvi_dual;
+	int max_tmds_clock;	/* in MHz */
+	bool latency_present[2];
+	int video_latency[2];	/* [0]: progressive, [1]: interlaced */
+	int audio_latency[2];
 	int null_edid_counter; /* needed to workaround some HW bugs where we get all 0s */
 };
 
--- linux-drm.orig/drivers/gpu/drm/i915/intel_dp.c	2011-08-01 16:23:58.331999993 +0800
+++ linux-drm/drivers/gpu/drm/i915/intel_dp.c	2011-08-01 16:25:07.212000013 +0800
@@ -794,6 +794,8 @@ intel_dp_mode_set(struct drm_encoder *en
 		else
 			intel_dp->DP |= DP_PLL_FREQ_270MHZ;
 	}
+
+	intel_write_eld(encoder, crtc, adjusted_mode);
 }
 
 static void ironlake_edp_panel_vdd_on(struct intel_dp *intel_dp)
--- linux-drm.orig/drivers/gpu/drm/i915/i915_drv.h	2011-08-01 16:23:58.287999982 +0800
+++ linux-drm/drivers/gpu/drm/i915/i915_drv.h	2011-08-01 16:25:07.216000014 +0800
@@ -208,6 +208,8 @@ struct drm_i915_display_funcs {
 			     struct drm_display_mode *adjusted_mode,
 			     int x, int y,
 			     struct drm_framebuffer *old_fb);
+	void (*write_eld)(struct drm_connector *connector,
+			  struct drm_crtc *crtc);
 	void (*fdi_link_train)(struct drm_crtc *crtc);
 	void (*init_clock_gating)(struct drm_device *dev);
 	void (*init_pch_clock_gating)(struct drm_device *dev);

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hdmi-hotplug-noeld

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.0-drm+ (wfg@bee) (gcc version 4.5.0 (GCC) ) #14 SMP Mon Aug 1 16:39:14 CST 2011
[    0.000000] Command line: BOOT_IMAGE=x86_64/vmlinuz log_buf_len=8M debug sched_debug apic=debug dynamic_printk drm.debug=6 panic=10 unknown_nmi_panic=1 nmi_watchdog=panic,lapic load_ramdisk=2 prompt_ramdisk=0 console=ttyS0,115200 console=tty0 netconsole=@:/eth0,6666@10.239.97.14/00:30:48:fe:19:94 ip=10.239.47.20:10.239.97.14:10.239.47.241:255.255.255.0:wu-kexec:eth0:none nfsroot=10.239.97.14:/nfsroot/wfg,tcp,v3,nocto,nolock,rsize=524288,wsize=524288 rw kexec_jump_back_entry=0x6f637465
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   Centaur CentaurHauls
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000100 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000aac8f000 (usable)
[    0.000000]  BIOS-e820: 00000000aac8f000 - 00000000aadd4000 (reserved)
[    0.000000]  BIOS-e820: 00000000aadd4000 - 00000000aade2000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000aade2000 - 00000000aae65000 (reserved)
[    0.000000]  BIOS-e820: 00000000aae65000 - 00000000aae68000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000aae68000 - 00000000aaf17000 (reserved)
[    0.000000]  BIOS-e820: 00000000aaf17000 - 00000000aaf1b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000aaf1b000 - 00000000aaf1f000 (reserved)
[    0.000000]  BIOS-e820: 00000000aaf1f000 - 00000000aaf9f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000aaf9f000 - 00000000aafff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000aafff000 - 00000000ab000000 (usable)
[    0.000000]  BIOS-e820: 00000000ab000000 - 00000000ab800000 (reserved)
[    0.000000]  BIOS-e820: 00000000abe00000 - 00000000b0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffd80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000014f800000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: LENOVO 20086,4396/Emerald Lake, BIOS 43CN18WW 12/07/2010
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] last_pfn = 0x14f800 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0B0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0AC000000 mask FFC000000 uncachable
[    0.000000]   5 base 0AB000000 mask FFF000000 uncachable
[    0.000000]   6 base 100000000 mask FC0000000 write-back
[    0.000000]   7 base 140000000 mask FE0000000 write-back
[    0.000000]   8 base 150000000 mask FF0000000 uncachable
[    0.000000]   9 base 14F800000 mask FFF800000 uncachable
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xab000 max_arch_pfn = 0x400000000
[    0.000000] Scan SMP from ffff880000000000 for 1024 bytes.
[    0.000000] Scan SMP from ffff88000009fc00 for 1024 bytes.
[    0.000000] Scan SMP from ffff8800000f0000 for 65536 bytes.
[    0.000000] Scan SMP from ffff88000009d800 for 1024 bytes.
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000ab000000
[    0.000000]  0000000000 - 00ab000000 page 4k
[    0.000000] kernel direct mapping tables up to ab000000 @ aa733000-aac8f000
[    0.000000] init_memory_mapping: 0000000100000000-000000014f800000
[    0.000000]  0100000000 - 014f800000 page 4k
[    0.000000] kernel direct mapping tables up to 14f800000 @ 14ed7d000-14f800000
[    0.000000] log_buf_len: 8388608
[    0.000000] early log buf free: 257165(98%)
[    0.000000] ACPI: RSDP 00000000000f0110 00024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 00000000aaffe120 00084 (v01 LENOVO CB-01    00000001 LENO 00000001)
[    0.000000] ACPI: FACP 00000000aafee000 000F4 (v03 LENOVO CB-01    00000001 PTL  00000001)
[    0.000000] ACPI: DSDT 00000000aaff1000 0989C (v02 LENOVO  SNB-CPT 00000000 INTL 20061109)
[    0.000000] ACPI: FACS 00000000aaf40000 00040
[    0.000000] ACPI: SLIC 00000000aaffd000 00176 (v01 LENOVO CB-01    00000001 LENO 00000001)
[    0.000000] ACPI: SSDT 00000000aaffb000 01068 (v01 LENOVO PtidDevc 00001000 INTL 20061109)
[    0.000000] ACPI: ASF! 00000000aaff0000 000A5 (v32 LENOVO CB-01    00000001 PTL  00000001)
[    0.000000] ACPI: HPET 00000000aafed000 00038 (v01 LENOVO CB-01    00000001 PTL  00000001)
[    0.000000] ACPI: APIC 00000000aafec000 00098 (v01 LENOVO CB-01    00000001 PTL  00000001)
[    0.000000] ACPI: MCFG 00000000aafeb000 0003C (v01 LENOVO CB-01    00000001 PTL  00000001)
[    0.000000] ACPI: SSDT 00000000aafea000 0090C (v01  PmRef  Cpu0Ist 00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000aafe9000 00996 (v01  PmRef    CpuPm 00003000 INTL 20061109)
[    0.000000] ACPI: UEFI 00000000aafe8000 0003E (v01 LENOVO CB-01    00000001 PTL  00000001)
[    0.000000] ACPI: UEFI 00000000aafe7000 00042 (v01 PTL      COMBUF 00000001 PTL  00000001)
[    0.000000] ACPI: UEFI 00000000aafe6000 00242 (v01 LENOVO CB-01    00000001 PTL  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000014f800000
[    0.000000] Initmem setup node 0 0000000000000000-000000014f800000
[    0.000000]   NODE_DATA [000000014effb000 - 000000014effffff]
[    0.000000]  [ffffea0000000000-ffffea00049fffff] PMD -> [ffff88014a400000-ffff88014ddfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0014f800
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000aac8f
[    0.000000]     0: 0x000aafff -> 0x000ab000
[    0.000000]     0: 0x00100000 -> 0x0014f800
[    0.000000] On node 0 totalpages: 1025053
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 681160 pages, LIFO batch:31
[    0.000000]   Normal zone: 4452 pages used for memmap
[    0.000000]   Normal zone: 321180 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000aac8f000 - 00000000aadd4000
[    0.000000] PM: Registered nosave memory: 00000000aadd4000 - 00000000aade2000
[    0.000000] PM: Registered nosave memory: 00000000aade2000 - 00000000aae65000
[    0.000000] PM: Registered nosave memory: 00000000aae65000 - 00000000aae68000
[    0.000000] PM: Registered nosave memory: 00000000aae68000 - 00000000aaf17000
[    0.000000] PM: Registered nosave memory: 00000000aaf17000 - 00000000aaf1b000
[    0.000000] PM: Registered nosave memory: 00000000aaf1b000 - 00000000aaf1f000
[    0.000000] PM: Registered nosave memory: 00000000aaf1f000 - 00000000aaf9f000
[    0.000000] PM: Registered nosave memory: 00000000aaf9f000 - 00000000aafff000
[    0.000000] PM: Registered nosave memory: 00000000ab000000 - 00000000ab800000
[    0.000000] PM: Registered nosave memory: 00000000ab800000 - 00000000abe00000
[    0.000000] PM: Registered nosave memory: 00000000abe00000 - 00000000b0000000
[    0.000000] PM: Registered nosave memory: 00000000b0000000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffd80000
[    0.000000] PM: Registered nosave memory: 00000000ffd80000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at b0000000 (gap: b0000000:48000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 474 pages/cpu @ffff880149400000 s1910784 r8192 d22528 u2097152
[    0.000000] pcpu-alloc: s1910784 r8192 d22528 u2097152 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1006260
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=x86_64/vmlinuz log_buf_len=8M debug sched_debug apic=debug dynamic_printk drm.debug=6 panic=10 unknown_nmi_panic=1 nmi_watchdog=panic,lapic load_ramdisk=2 prompt_ramdisk=0 console=ttyS0,115200 console=tty0 netconsole=@:/eth0,6666@10.239.97.14/00:30:48:fe:19:94 ip=10.239.47.20:10.239.97.14:10.239.47.241:255.255.255.0:wu-kexec:eth0:none nfsroot=10.239.97.14:/nfsroot/wfg,tcp,v3,nocto,nolock,rsize=524288,wsize=524288 rw kexec_jump_back_entry=0x6f637465
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Memory: 3916068k/5496832k available (9400k kernel code, 1396620k absent, 184144k reserved, 5543k data, 2736k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU debugfs-based tracing is enabled.
[    0.000000] NR_IRQS:4352 nr_irqs:744 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 6335 kB
[    0.000000]  per task-struct memory footprint: 2688 bytes
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 1995.540 MHz processor.
[    0.000004] Calibrating delay loop (skipped), value calculated using timer frequency.. 3991.08 BogoMIPS (lpj=1995540)
[    0.000923] pid_max: default: 32768 minimum: 301
[    0.002811] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.004972] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.006012] Mount-cache hash table entries: 256
[    0.006870] Initializing cgroup subsys debug
[    0.007283] Initializing cgroup subsys cpuacct
[    0.007693] Initializing cgroup subsys memory
[    0.008141] Initializing cgroup subsys devices
[    0.008544] Initializing cgroup subsys freezer
[    0.008946] Initializing cgroup subsys blkio
[    0.009427] Disabled fast string operations
[    0.009813] CPU: Physical Processor ID: 0
[    0.010206] CPU: Processor Core ID: 0
[    0.010561] mce: CPU supports 9 MCE banks
[    0.010947] CPU0: Thermal monitoring enabled (TM1)
[    0.011402] using mwait in idle threads.
[    0.013395] ACPI: Core revision 20110413
[    0.038429] ftrace: allocating 35893 entries in 141 pages
[    0.052119] Getting VERSION: 1060015
[    0.052466] Getting VERSION: 1060015
[    0.052811] Getting ID: 0
[    0.053112] Getting ID: 0
[    0.053396] enabled ExtINT on CPU#0
[    0.054000] ENABLING IO-APIC IRQs
[    0.054328] init IO_APIC IRQs
[    0.054633]  apic 2 pin 0 not connected
[    0.055017] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0 Active:0)
[    0.055662] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Active:0)
[    0.056324] IOAPIC[0]: Set routing entry (2-3 -> 0x33 -> IRQ 3 Mode:0 Active:0)
[    0.056974] IOAPIC[0]: Set routing entry (2-4 -> 0x34 -> IRQ 4 Mode:0 Active:0)
[    0.057618] IOAPIC[0]: Set routing entry (2-5 -> 0x35 -> IRQ 5 Mode:0 Active:0)
[    0.058267] IOAPIC[0]: Set routing entry (2-6 -> 0x36 -> IRQ 6 Mode:0 Active:0)
[    0.058912] IOAPIC[0]: Set routing entry (2-7 -> 0x37 -> IRQ 7 Mode:0 Active:0)
[    0.059560] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0 Active:0)
[    0.060210] IOAPIC[0]: Set routing entry (2-9 -> 0x39 -> IRQ 9 Mode:1 Active:0)
[    0.060856] IOAPIC[0]: Set routing entry (2-10 -> 0x3a -> IRQ 10 Mode:0 Active:0)
[    0.061514] IOAPIC[0]: Set routing entry (2-11 -> 0x3b -> IRQ 11 Mode:0 Active:0)
[    0.062174] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12 Mode:0 Active:0)
[    0.062830] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13 Mode:0 Active:0)
[    0.063490] IOAPIC[0]: Set routing entry (2-14 -> 0x3e -> IRQ 14 Mode:0 Active:0)
[    0.064151] IOAPIC[0]: Set routing entry (2-15 -> 0x3f -> IRQ 15 Mode:0 Active:0)
[    0.064806]  apic 2 pin 16 not connected
[    0.065177]  apic 2 pin 17 not connected
[    0.065545]  apic 2 pin 18 not connected
[    0.065911]  apic 2 pin 19 not connected
[    0.066282]  apic 2 pin 20 not connected
[    0.066649]  apic 2 pin 21 not connected
[    0.067019]  apic 2 pin 22 not connected
[    0.067386]  apic 2 pin 23 not connected
[    0.067901] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.078408] CPU0: Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz stepping 07
[    0.079077] Using local APIC timer interrupts.
[    0.079078] calibrating APIC timer ...
[    0.180923] ... lapic delta = 623578
[    0.181266] ... PM-Timer delta = 357951
[    0.181626] ... PM-Timer result ok
[    0.181959] ..... delta 623578
[    0.182269] ..... mult: 26786542
[    0.182590] ..... calibration result: 99772
[    0.182975] ..... CPU clock speed is 1995.0450 MHz.
[    0.183405] ..... host bus clock speed is 99.0772 MHz.
[    0.183862] Performance Events: PEBS fmt1+, SandyBridge events, Intel PMU driver.
[    0.184700] ... version:                3
[    0.185077] ... bit width:              48
[    0.185455] ... generic registers:      4
[    0.185828] ... value mask:             0000ffffffffffff
[    0.186287] ... max period:             000000007fffffff
[    0.186743] ... fixed-purpose events:   3
[    0.187119] ... event mask:             000000070000000f
[    0.188009] lockdep: fixing up alternatives.
[    0.188484] Booting Node   0, Processors  #1
[    0.188879] smpboot cpu 1: start_ip = 98000
[    0.200612] masked ExtINT on CPU#1
[    0.259837] Disabled fast string operations
[    0.280420] lockdep: fixing up alternatives.
[    0.280851]  #2
[    0.281015] smpboot cpu 2: start_ip = 98000
[    0.292632] masked ExtINT on CPU#2
[    0.352794] Disabled fast string operations
[    0.373311] lockdep: fixing up alternatives.
[    0.373738]  #3
[    0.373907] smpboot cpu 3: start_ip = 98000
[    0.385522] masked ExtINT on CPU#3
[    0.444752] Disabled fast string operations
[    0.465296] lockdep: fixing up alternatives.
[    0.465726]  #4
[    0.465895] smpboot cpu 4: start_ip = 98000
[    0.477511] masked ExtINT on CPU#4
[    0.537710] Disabled fast string operations
[    0.558294] lockdep: fixing up alternatives.
[    0.558724]  #5
[    0.558888] smpboot cpu 5: start_ip = 98000
[    0.570505] masked ExtINT on CPU#5
[    0.630668] Disabled fast string operations
[    0.651191] lockdep: fixing up alternatives.
[    0.651621]  #6
[    0.651790] smpboot cpu 6: start_ip = 98000
[    0.663406] masked ExtINT on CPU#6
[    0.722627] Disabled fast string operations
[    0.743187] lockdep: fixing up alternatives.
[    0.743618]  #7 Ok.
[    0.743867] smpboot cpu 7: start_ip = 98000
[    0.755359] masked ExtINT on CPU#7
[    0.814585] Disabled fast string operations
[    0.834994] Brought up 8 CPUs
[    0.835301] Total of 8 processors activated (31924.09 BogoMIPS).
[    0.841536] CPU0 attaching sched-domain:
[    0.841913]  domain 0: span 0-1 level SIBLING
[    0.843782]   groups: 0 (cpu_power = 589) 1 (cpu_power = 589)
[    0.844580]   domain 1: span 0-7 level MC
[    0.845014]    groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178) 4-5 (cpu_power = 1178) 6-7 (cpu_power = 1178)
[    0.846411] CPU1 attaching sched-domain:
[    0.846781]  domain 0: span 0-1 level SIBLING
[    0.847238]   groups: 1 (cpu_power = 589) 0 (cpu_power = 589)
[    0.848034]   domain 1: span 0-7 level MC
[    0.848468]    groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178) 4-5 (cpu_power = 1178) 6-7 (cpu_power = 1178)
[    0.849867] CPU2 attaching sched-domain:
[    0.850236]  domain 0: span 2-3 level SIBLING
[    0.850696]   groups: 2 (cpu_power = 589) 3 (cpu_power = 589)
[    0.851488]   domain 1: span 0-7 level MC
[    0.851926]    groups: 2-3 (cpu_power = 1178) 4-5 (cpu_power = 1178) 6-7 (cpu_power = 1178) 0-1 (cpu_power = 1178)
[    0.853322] CPU3 attaching sched-domain:
[    0.853693]  domain 0: span 2-3 level SIBLING
[    0.854150]   groups: 3 (cpu_power = 589) 2 (cpu_power = 589)
[    0.854946]   domain 1: span 0-7 level MC
[    0.855380]    groups: 2-3 (cpu_power = 1178) 4-5 (cpu_power = 1178) 6-7 (cpu_power = 1178) 0-1 (cpu_power = 1178)
[    0.856778] CPU4 attaching sched-domain:
[    0.857147]  domain 0: span 4-5 level SIBLING
[    0.857607]   groups: 4 (cpu_power = 589) 5 (cpu_power = 589)
[    0.858399]   domain 1: span 0-7 level MC
[    0.858838]    groups: 4-5 (cpu_power = 1178) 6-7 (cpu_power = 1178) 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
[    0.860234] CPU5 attaching sched-domain:
[    0.860605]  domain 0: span 4-5 level SIBLING
[    0.861062]   groups: 5 (cpu_power = 589) 4 (cpu_power = 589)
[    0.861857]   domain 1: span 0-7 level MC
[    0.862291]    groups: 4-5 (cpu_power = 1178) 6-7 (cpu_power = 1178) 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
[    0.863689] CPU6 attaching sched-domain:
[    0.864055]  domain 0: span 6-7 level SIBLING
[    0.864511]   groups: 6 (cpu_power = 589) 7 (cpu_power = 589)
[    0.865306]   domain 1: span 0-7 level MC
[    0.865742]    groups: 6-7 (cpu_power = 1178) 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178) 4-5 (cpu_power = 1178)
[    0.867141] CPU7 attaching sched-domain:
[    0.867507]  domain 0: span 6-7 level SIBLING
[    0.867967]   groups: 7 (cpu_power = 589) 6 (cpu_power = 589)
[    0.868764]   domain 1: span 0-7 level MC
[    0.869198]    groups: 6-7 (cpu_power = 1178) 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178) 4-5 (cpu_power = 1178)
[    0.871285] kworker/u:0 used greatest stack depth: 5304 bytes left
[    0.875012] PM: Registering ACPI NVS region at aadd4000 (57344 bytes)
[    0.875545] PM: Registering ACPI NVS region at aae65000 (12288 bytes)
[    0.876085] PM: Registering ACPI NVS region at aaf17000 (16384 bytes)
[    0.876619] PM: Registering ACPI NVS region at aaf1f000 (524288 bytes)
[    0.878138] xor: automatically using best checksumming function: generic_sse
[    0.883551]    generic_sse:  8864.000 MB/sec
[    0.883941] xor: using function: generic_sse (8864.000 MB/sec)
[    0.884578] Time:  8:36:56  Date: 08/01/11
[    0.885075] NET: Registered protocol family 16
[    0.886506] ACPI: bus type pci registered
[    0.887174] dca service started, version 1.12.1
[    0.887701] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.888471] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.905704] PCI: Using configuration type 1 for base access
[    0.941257] bio: create slab <bio-0> at 0
[    0.958518] raid6: int64x1   2089 MB/s
[    0.975527] raid6: int64x2   2195 MB/s
[    0.992524] raid6: int64x4   1941 MB/s
[    1.009522] raid6: int64x8   1503 MB/s
[    1.026490] raid6: sse2x1    5355 MB/s
[    1.043481] raid6: sse2x2    6656 MB/s
[    1.060473] raid6: sse2x4    7585 MB/s
[    1.060829] raid6: using algorithm sse2x4 (7585 MB/s)
[    1.072195] ACPI: EC: Look up EC in DSDT
[    1.083568] ACPI: Executed 1 blocks of module-level executable AML code
[    1.102782] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    1.104507] ACPI: SSDT 00000000aaf0f698 0060F (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
[    1.108177] ACPI: Dynamic OEM Table Load:
[    1.108678] ACPI: SSDT           (null) 0060F (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
[    1.115390] ACPI: SSDT 00000000aaf10a98 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
[    1.119245] ACPI: Dynamic OEM Table Load:
[    1.119748] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
[    1.125820] ACPI: SSDT 00000000aae6bd98 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
[    1.129535] ACPI: Dynamic OEM Table Load:
[    1.130030] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
[    1.145224] ACPI: Interpreter enabled
[    1.145581] ACPI: (supports S0 S1 S3 S4 S5)
[    1.146336] ACPI: Using IOAPIC for interrupt routing
[    1.176153] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    1.177600] ACPI: No dock devices found.
[    1.177971] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.180000] \_SB_.PCI0:_OSC invalid UUID
[    1.180368] _OSC request data:1 8 1f 
[    1.180973] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.183770] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.184315] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.184863] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.185504] pci_root PNP0A08:00: host bridge window [mem 0xb0000000-0xfeafffff]
[    1.186143] pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
[    1.186818] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    1.187401] pci 0000:00:02.0: [8086:0116] type 0 class 0x000300
[    1.187928] pci 0000:00:02.0: reg 10: [mem 0xc0000000-0xc03fffff 64bit]
[    1.188487] pci 0000:00:02.0: reg 18: [mem 0xb0000000-0xbfffffff 64bit pref]
[    1.189067] pci 0000:00:02.0: reg 20: [io  0x3000-0x303f]
[    1.189660] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    1.190204] pci 0000:00:16.0: reg 10: [mem 0xc0605000-0xc060500f 64bit]
[    1.190879] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.191392] pci 0000:00:16.0: PME# disabled
[    1.191853] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    1.192392] pci 0000:00:1a.0: reg 10: [mem 0xc060a000-0xc060a3ff]
[    1.193063] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.193579] pci 0000:00:1a.0: PME# disabled
[    1.194012] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    1.194547] pci 0000:00:1b.0: reg 10: [mem 0xc0600000-0xc0603fff 64bit]
[    1.195225] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.195742] pci 0000:00:1b.0: PME# disabled
[    1.196166] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    1.196807] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.197321] pci 0000:00:1c.0: PME# disabled
[    1.197759] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    1.198397] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.198915] pci 0000:00:1c.1: PME# disabled
[    1.199346] pci 0000:00:1c.3: [8086:1c16] type 1 class 0x000604
[    1.199985] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.200501] pci 0000:00:1c.3: PME# disabled
[    1.200950] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    1.201490] pci 0000:00:1d.0: reg 10: [mem 0xc0609000-0xc06093ff]
[    1.202154] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.202670] pci 0000:00:1d.0: PME# disabled
[    1.203100] pci 0000:00:1f.0: [8086:1c49] type 0 class 0x000601
[    1.203856] pci 0000:00:1f.2: [8086:1c03] type 0 class 0x000106
[    1.204398] pci 0000:00:1f.2: reg 10: [io  0x3088-0x308f]
[    1.204881] pci 0000:00:1f.2: reg 14: [io  0x3094-0x3097]
[    1.205361] pci 0000:00:1f.2: reg 18: [io  0x3080-0x3087]
[    1.205844] pci 0000:00:1f.2: reg 1c: [io  0x3090-0x3093]
[    1.206323] pci 0000:00:1f.2: reg 20: [io  0x3060-0x307f]
[    1.206806] pci 0000:00:1f.2: reg 24: [mem 0xc0608000-0xc06087ff]
[    1.207403] pci 0000:00:1f.2: PME# supported from D3hot
[    1.207860] pci 0000:00:1f.2: PME# disabled
[    1.208281] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    1.208816] pci 0000:00:1f.3: reg 10: [mem 0xc0604000-0xc06040ff 64bit]
[    1.209411] pci 0000:00:1f.3: reg 20: [io  0xefa0-0xefbf]
[    1.210033] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.210494] pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.211070] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.211748] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.212825] pci 0000:02:00.0: [8086:0084] type 0 class 0x000280
[    1.213684] pci 0000:02:00.0: reg 10: [mem 0xc0500000-0xc0501fff 64bit]
[    1.215660] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.216221] pci 0000:02:00.0: PME# disabled
[    1.216864] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    1.217321] pci 0000:00:1c.1:   bridge window [io  0xf000-0x0000] (disabled)
[    1.217901] pci 0000:00:1c.1:   bridge window [mem 0xc0500000-0xc05fffff]
[    1.218468] pci 0000:00:1c.1:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.219347] pci 0000:03:00.0: [10ec:8168] type 0 class 0x000200
[    1.219922] pci 0000:03:00.0: reg 10: [io  0x2000-0x20ff]
[    1.220529] pci 0000:03:00.0: reg 18: [mem 0xc0404000-0xc0404fff 64bit pref]
[    1.221185] pci 0000:03:00.0: reg 20: [mem 0xc0400000-0xc0403fff 64bit pref]
[    1.222012] pci 0000:03:00.0: supports D1 D2
[    1.222404] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.222963] pci 0000:03:00.0: PME# disabled
[    1.223459] pci 0000:00:1c.3: PCI bridge to [bus 03-03]
[    1.223916] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    1.224433] pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.225110] pci 0000:00:1c.3:   bridge window [mem 0xc0400000-0xc04fffff 64bit pref]
[    1.225815] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.226714] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.228762] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    1.229415] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    1.230280] \_SB_.PCI0:_OSC invalid UUID
[    1.230653] _OSC request data:1 19 1f 
[    1.231256]  pci0000:00: Unable to request _OSC control (_OSC support mask: 0x19)
[    1.244465] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    1.245937] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    1.247406] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12 14 15) *7, disabled.
[    1.249123] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    1.250591] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.252296] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.254010] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12 14 15), disabled.
[    1.255650] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    1.257369] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    1.258088] vgaarb: loaded
[    1.258380] vgaarb: bridge control possible 0000:00:02.0
[    1.259155] SCSI subsystem initialized
[    1.259782] libata version 3.00 loaded.
[    1.260553] usbcore: registered new interface driver usbfs
[    1.261120] usbcore: registered new interface driver hub
[    1.261695] usbcore: registered new device driver usb
[    1.263379] wmi: Mapper loaded
[    1.263797] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    1.264323] PCI: Using ACPI for IRQ routing
[    1.268602] PCI: pci_cache_line_size set to 64 bytes
[    1.269232] reserve RAM buffer: 000000000009d800 - 000000000009ffff 
[    1.269700] reserve RAM buffer: 00000000aac8f000 - 00000000abffffff 
[    1.270289] reserve RAM buffer: 00000000ab000000 - 00000000abffffff 
[    1.270881] reserve RAM buffer: 000000014f800000 - 000000014fffffff 
[    1.271939] 
[    1.271939] printing PIC contents
[    1.272612] ... PIC  IMR: ffff
[    1.272926] ... PIC  IRR: 0c00
[    1.273250] ... PIC  ISR: 0000
[    1.273569] ... PIC ELCR: 0e00
[    1.273881] printing local APIC contents on CPU#0/0:
[    1.274315] ... APIC ID:      00000000 (0)
[    1.274693] ... APIC VERSION: 01060015
[    1.275048] ... APIC TASKPRI: 00000000 (00)
[    1.275431] ... APIC PROCPRI: 00000000
[    1.275787] ... APIC LDR: 01000000
[    1.276119] ... APIC DFR: ffffffff
[    1.276452] ... APIC SPIV: 000001ff
[    1.276791] ... APIC ISR field:
[    1.277106] 0000000000000000000000000000000000000000000000000000000000000000
[    1.278166] ... APIC TMR field:
[    1.278482] 0000000002000000000000000000000000000000000000000000000000000000
[    1.279541] ... APIC IRR field:
[    1.279857] 0000000000000000000000000000000000000000000000000000000000008000
[    1.280916] ... APIC ESR: 00000000
[    1.281249] ... APIC ICR: 000008fd
[    1.281581] ... APIC ICR2: 02000000
[    1.281921] ... APIC LVTT: 000200ef
[    1.282258] ... APIC LVTPC: 00000400
[    1.282601] ... APIC LVT0: 00010700
[    1.282941] ... APIC LVT1: 00000400
[    1.283278] ... APIC LVTERR: 000000fe
[    1.283627] ... APIC TMICT: 0000185b
[    1.283971] ... APIC TMCCT: 00000983
[    1.284316] ... APIC TDCR: 00000003
[    1.284653] 
[    1.284866] number of MP IRQ sources: 15.
[    1.285240] number of IO-APIC #2 registers: 24.
[    1.285649] testing the IO APIC.......................
[    1.286103] 
[    1.286312] IO APIC #2......
[    1.286617] .... register #00: 02000000
[    1.286979] .......    : physical APIC id: 02
[    1.287376] .......    : Delivery Type: 0
[    1.287749] .......    : LTS          : 0
[    1.288123] .... register #01: 00170020
[    1.288488] .......     : max redirection entries: 0017
[    1.288940] .......     : PRQ implemented: 0
[    1.289329] .......     : IO APIC version: 0020
[    1.289739] .... IRQ redirection table:
[    1.290101]  NR Dst Mask Trig IRR Pol Stat Dmod Deli Vect:
[    1.290581]  00 000 1    0    0   0   0    0    0    00
[    1.291101]  01 0FF 0    0    0   0   0    1    1    31
[    1.291623]  02 0FF 0    0    0   0   0    1    1    30
[    1.292142]  03 0FF 0    0    0   0   0    1    1    33
[    1.292664]  04 0FF 0    0    0   0   0    1    1    34
[    1.293182]  05 0FF 0    0    0   0   0    1    1    35
[    1.293704]  06 0FF 0    0    0   0   0    1    1    36
[    1.294221]  07 0FF 0    0    0   0   0    1    1    37
[    1.294745]  08 0FF 0    0    0   0   0    1    1    38
[    1.295265]  09 0FF 0    1    0   0   0    1    1    39
[    1.295787]  0a 0FF 0    0    0   0   0    1    1    3A
[    1.296305]  0b 0FF 0    0    0   0   0    1    1    3B
[    1.296827]  0c 0FF 0    0    0   0   0    1    1    3C
[    1.297344]  0d 0FF 0    0    0   0   0    1    1    3D
[    1.297866]  0e 0FF 0    0    0   0   0    1    1    3E
[    1.298390]  0f 0FF 0    0    0   0   0    1    1    3F
[    1.298910]  10 000 1    0    0   0   0    0    0    00
[    1.299429]  11 000 1    0    0   0   0    0    0    00
[    1.299947]  12 000 1    0    0   0   0    0    0    00
[    1.300469]  13 000 1    0    0   0   0    0    0    00
[    1.300987]  14 000 1    0    0   0   0    0    0    00
[    1.301508]  15 000 1    0    0   0   0    0    0    00
[    1.302028]  16 000 1    0    0   0   0    0    0    00
[    1.302553]  17 000 1    0    0   0   0    0    0    00
[    1.303066] IRQ to pin mappings:
[    1.303392] IRQ0 -> 0:2
[    1.303786] IRQ1 -> 0:1
[    1.304177] IRQ3 -> 0:3
[    1.304575] IRQ4 -> 0:4
[    1.304969] IRQ5 -> 0:5
[    1.305365] IRQ6 -> 0:6
[    1.305758] IRQ7 -> 0:7
[    1.306151] IRQ8 -> 0:8
[    1.306550] IRQ9 -> 0:9
[    1.306943] IRQ10 -> 0:10
[    1.307347] IRQ11 -> 0:11
[    1.307755] IRQ12 -> 0:12
[    1.308161] IRQ13 -> 0:13
[    1.308568] IRQ14 -> 0:14
[    1.308972] IRQ15 -> 0:15
[    1.309380] .................................... done.
[    1.309839] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.310915] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.313429] Switching to clocksource hpet
[    1.314362] Switched to NOHz mode on CPU #0
[    1.314725] Switched to NOHz mode on CPU #2
[    1.314731] Switched to NOHz mode on CPU #5
[    1.314752] Switched to NOHz mode on CPU #3
[    1.314784] Switched to NOHz mode on CPU #1
[    1.314787] Switched to NOHz mode on CPU #7
[    1.314789] Switched to NOHz mode on CPU #6
[    1.314794] Switched to NOHz mode on CPU #4
[    1.355293] pnp: PnP ACPI init
[    1.355631] ACPI: bus type pnp registered
[    1.357151] pnp 00:00: [bus 00-3e]
[    1.357487] pnp 00:00: [io  0x0000-0x0cf7 window]
[    1.357906] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.358302] pnp 00:00: [io  0x0d00-0xffff window]
[    1.358722] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.359195] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    1.359659] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    1.360132] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    1.360596] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    1.361067] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    1.361530] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    1.362003] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    1.362466] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    1.362929] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    1.363408] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    1.363870] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    1.364345] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    1.364807] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    1.365280] pnp 00:00: [mem 0xb0000000-0xfeafffff window]
[    1.365746] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    1.366516] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.367205] pnp 00:01: [io  0x0000-0x001f]
[    1.367585] pnp 00:01: [io  0x0081-0x0091]
[    1.367963] pnp 00:01: [io  0x0093-0x009f]
[    1.368355] pnp 00:01: [io  0x00c0-0x00df]
[    1.368734] pnp 00:01: [dma 4]
[    1.369192] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.369750] pnp 00:02: [mem 0xff000000-0xffffffff]
[    1.370325] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    1.371080] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    1.371651] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.372232] pnp 00:04: [io  0x00f0]
[    1.372577] IOAPIC[0]: Set routing entry (2-13 -> 0x3d -> IRQ 13 Mode:0 Active:0)
[    1.373244] pnp 00:04: [irq 13]
[    1.373715] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.374294] pnp 00:05: [io  0x002e-0x002f]
[    1.374674] pnp 00:05: [io  0x004e-0x004f]
[    1.375063] pnp 00:05: [io  0x0061]
[    1.375401] pnp 00:05: [io  0x0063]
[    1.375739] pnp 00:05: [io  0x0065]
[    1.376087] pnp 00:05: [io  0x0067]
[    1.376426] pnp 00:05: [io  0x0070]
[    1.378191] pnp 00:05: [io  0x0080]
[    1.378530] pnp 00:05: [io  0x0092]
[    1.378870] pnp 00:05: [io  0x00b2-0x00b3]
[    1.379259] pnp 00:05: [io  0x1000-0x100f]
[    1.379638] pnp 00:05: [io  0xffff]
[    1.379986] pnp 00:05: [io  0xffff]
[    1.380325] pnp 00:05: [io  0x0400-0x0453]
[    1.380703] pnp 00:05: [io  0x0458-0x047f]
[    1.381091] pnp 00:05: [io  0x0500-0x057f]
[    1.381469] pnp 00:05: [io  0x0068-0x006f]
[    1.381848] pnp 00:05: [mem 0xfe800000-0xfe80ffff]
[    1.382474] system 00:05: [io  0x1000-0x100f] has been reserved
[    1.382990] system 00:05: [io  0xffff] has been reserved
[    1.383447] system 00:05: [io  0xffff] has been reserved
[    1.383907] system 00:05: [io  0x0400-0x0453] has been reserved
[    1.384421] system 00:05: [io  0x0458-0x047f] has been reserved
[    1.384919] system 00:05: [io  0x0500-0x057f] has been reserved
[    1.385434] system 00:05: [mem 0xfe800000-0xfe80ffff] has been reserved
[    1.385988] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.386563] pnp 00:06: [io  0x0070-0x0077]
[    1.386944] IOAPIC[0]: Set routing entry (2-8 -> 0x38 -> IRQ 8 Mode:0 Active:0)
[    1.387603] pnp 00:06: [irq 8]
[    1.388073] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.388700] pnp 00:07: [io  0x0454-0x0457]
[    1.389276] system 00:07: [io  0x0454-0x0457] has been reserved
[    1.389778] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.390616] pnp 00:08: [io  0x0060]
[    1.390956] pnp 00:08: [io  0x0064]
[    1.391312] IOAPIC[0]: Set routing entry (2-1 -> 0x31 -> IRQ 1 Mode:0 Active:0)
[    1.391956] pnp 00:08: [irq 1]
[    1.392437] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.393017] IOAPIC[0]: Set routing entry (2-12 -> 0x3c -> IRQ 12 Mode:0 Active:0)
[    1.393674] pnp 00:09: [irq 12]
[    1.394155] pnp 00:09: Plug and Play ACPI device, IDs ETD0605 ETD0001 ETD0002 PNP0f13 (active)
[    1.395248] pnp 00:0a: [mem 0xfed1c000-0xfed1ffff]
[    1.395673] pnp 00:0a: [mem 0xfed10000-0xfed17fff]
[    1.396107] pnp 00:0a: [mem 0xfed18000-0xfed18fff]
[    1.396531] pnp 00:0a: [mem 0xfed19000-0xfed19fff]
[    1.396976] pnp 00:0a: [mem 0xf8000000-0xfbffffff]
[    1.397400] pnp 00:0a: [mem 0xfed20000-0xfed3ffff]
[    1.397823] pnp 00:0a: [mem 0xfed90000-0xfed93fff]
[    1.398257] pnp 00:0a: [mem 0xfed45000-0xfed8ffff]
[    1.398680] pnp 00:0a: [mem 0xff000000-0xffffffff]
[    1.399114] pnp 00:0a: [mem 0xfee00000-0xfeefffff]
[    1.399537] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    1.400262] system 00:0a: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.400807] system 00:0a: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.401365] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.401908] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.402466] system 00:0a: [mem 0xf8000000-0xfbffffff] has been reserved
[    1.403018] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.403562] system 00:0a: [mem 0xfed90000-0xfed93fff] has been reserved
[    1.404113] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.404657] system 00:0a: [mem 0xff000000-0xffffffff] could not be reserved
[    1.405231] system 00:0a: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.405798] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.407242] pnp 00:0b: [mem 0x20000000-0x201fffff]
[    1.407665] pnp 00:0b: [mem 0x40000000-0x401fffff]
[    1.408392] system 00:0b: [mem 0x20000000-0x201fffff] could not be reserved
[    1.408976] system 00:0b: [mem 0x40000000-0x401fffff] could not be reserved
[    1.409544] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.410172] pnp: PnP ACPI: found 12 devices
[    1.410556] ACPI: ACPI bus type pnp unregistered
[    1.424669] PCI: max bus depth: 1 pci_try_num: 2
[    1.425147] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.425598] pci 0000:00:1c.0:   bridge window [io  disabled]
[    1.426095] pci 0000:00:1c.0:   bridge window [mem disabled]
[    1.426579] pci 0000:00:1c.0:   bridge window [mem pref disabled]
[    1.427107] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    1.427559] pci 0000:00:1c.1:   bridge window [io  disabled]
[    1.428058] pci 0000:00:1c.1:   bridge window [mem 0xc0500000-0xc05fffff]
[    1.428616] pci 0000:00:1c.1:   bridge window [mem pref disabled]
[    1.429144] pci 0000:00:1c.3: PCI bridge to [bus 03-03]
[    1.429597] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    1.430122] pci 0000:00:1c.3:   bridge window [mem disabled]
[    1.430607] pci 0000:00:1c.3:   bridge window [mem 0xc0400000-0xc04fffff 64bit pref]
[    1.431313] IOAPIC[0]: Set routing entry (2-16 -> 0x29 -> IRQ 16 Mode:1 Active:1)
[    1.431976] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.432528] pci 0000:00:1c.0: setting latency timer to 64
[    1.433017] IOAPIC[0]: Set routing entry (2-17 -> 0x41 -> IRQ 17 Mode:1 Active:1)
[    1.433670] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.434233] pci 0000:00:1c.1: setting latency timer to 64
[    1.434716] IOAPIC[0]: Set routing entry (2-19 -> 0x49 -> IRQ 19 Mode:1 Active:1)
[    1.435378] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    1.435929] pci 0000:00:1c.3: setting latency timer to 64
[    1.436410] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.436884] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.437375] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.437894] pci_bus 0000:00: resource 7 [mem 0xb0000000-0xfeafffff]
[    1.438430] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    1.438961] pci_bus 0000:02: resource 1 [mem 0xc0500000-0xc05fffff]
[    1.439483] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    1.439968] pci_bus 0000:03: resource 2 [mem 0xc0400000-0xc04fffff 64bit pref]
[    1.440687] NET: Registered protocol family 2
[    1.441645] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.446169] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.449893] TCP bind hash table entries: 65536 (order: 10, 5242880 bytes)
[    1.453688] TCP: Hash tables configured (established 524288 bind 65536)
[    1.454260] TCP reno registered
[    1.454708] UDP hash table entries: 2048 (order: 6, 393216 bytes)
[    1.455563] UDP-Lite hash table entries: 2048 (order: 6, 393216 bytes)
[    1.456643] NET: Registered protocol family 1
[    1.457334] RPC: Registered named UNIX socket transport module.
[    1.457832] RPC: Registered udp transport module.
[    1.458265] RPC: Registered tcp transport module.
[    1.458683] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.459236] pci 0000:00:02.0: Boot video device
[    1.459841] PCI: CLS 64 bytes, default 64
[    1.460330] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.460862] Placing 64MB software IO TLB between ffff8800a6733000 - ffff8800aa733000
[    1.461539] software IO TLB at phys 0xa6733000 - 0xaa733000
[    1.462112] kvm: disabled by bios
[    1.467328] Machine check injector initialized
[    1.469901] microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x6
[    1.470431] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x6
[    1.470953] microcode: CPU2 sig=0x206a7, pf=0x10, revision=0x6
[    1.471457] microcode: CPU3 sig=0x206a7, pf=0x10, revision=0x6
[    1.471964] microcode: CPU4 sig=0x206a7, pf=0x10, revision=0x6
[    1.472470] microcode: CPU5 sig=0x206a7, pf=0x10, revision=0x6
[    1.472974] microcode: CPU6 sig=0x206a7, pf=0x10, revision=0x6
[    1.473479] microcode: CPU7 sig=0x206a7, pf=0x10, revision=0x6
[    1.474088] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.475467] audit: initializing netlink socket (disabled)
[    1.475988] type=2000 audit(1312187816.212:1): initialized
[    1.514326] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.531755] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    1.532935] fuse init (API version 7.16)
[    1.534141] JFS: nTxBlock = 8192, nTxLock = 65536
[    1.538872] SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
[    1.542443] NILFS version 2 loaded
[    1.544063] Btrfs loaded
[    1.544348] msgmni has been set to 7648
[    1.546498] async_tx: api initialized (async)
[    1.547214] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.547949] io scheduler noop registered
[    1.548318] io scheduler deadline registered
[    1.548932] io scheduler cfq registered (default)
[    1.550203] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.561134] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    1.562171] ACPI: AC Adapter [ADP1] (on-line)
[    1.563176] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
[    1.563962] ACPI: Lid Switch [LID0]
[    1.564464] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
[    1.565191] ACPI: Sleep Button [SLPB]
[    1.565706] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.566371] ACPI: Power Button [PWRF]
[    1.567543] ACPI: acpi_idle registered with cpuidle
[    1.581452] thermal LNXTHERM:00: registered as thermal_zone0
[    1.581953] ACPI: Thermal Zone [TZS0] (49 C)
[    1.582863] thermal LNXTHERM:01: registered as thermal_zone1
[    1.583370] ACPI: Thermal Zone [TZS1] (39 C)
[    1.584412] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    1.586947] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    1.587887] ACPI: Battery Slot [BAT0] (battery present)
[    1.652070] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.715398] Initializing Nozomi driver 2.1d
[    1.716829] Non-volatile memory driver v1.3
[    1.717549] Linux agpgart interface v0.103
[    1.718229] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.720347] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    1.722791] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.723612] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xb0000000
[    1.724300] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    1.725060] Hangcheck: Using getrawmonotonic().
[    1.725598] [drm] Initialized drm 1.1.0 20060810
[    1.726057] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.726613] i915 0000:00:02.0: setting latency timer to 64
[    1.803277] mtrr: type mismatch for b0000000,10000000 old: write-back new: write-combining
[    1.803991] [drm] MTRR allocation failed.  Graphics performance may suffer.
[    1.806176] [drm:intel_opregion_setup], graphic opregion physical addr: 0xaae65018
[    1.806928] [drm:intel_opregion_setup], Public ACPI methods supported
[    1.807520] [drm:intel_opregion_setup], SWSCI supported
[    1.808045] [drm:intel_opregion_setup], ASLE supported
[    1.808593] i915 0000:00:02.0: irq 40 for MSI/MSI-X
[    1.809038] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    1.809579] [drm] Driver supports precise vblank timestamp query.
[    1.810104] [drm:intel_detect_pch], Found CougarPoint PCH
[    1.810629] [drm:intel_parse_bios], Using VBT from OpRegion: $VBT SANDYBRIDGE-M  d
[    1.811356] [drm:parse_general_definitions], crt_ddc_bus_pin: 2
[    1.811925] [drm:parse_lfp_panel_data], Found panel mode in BIOS VBT tables:
[    1.812557] [drm:drm_mode_debug_printmodeline], Modeline 0:"1366x768" 0 71000 1366 1414 1446 1502 768 771 776 788 0x8 0xa
[    1.813506] [drm:parse_sdvo_panel_data], Found SDVO panel mode in BIOS VBT tables:
[    1.814235] [drm:drm_mode_debug_printmodeline], Modeline 0:"1600x1200" 0 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x8 0xa
[    1.815219] [drm:parse_sdvo_device_mapping], No SDVO device info is found in VBT
[    1.815944] [drm:intel_dsm_pci_probe], no _DSM method for intel device
[    1.816594] [drm:intel_modeset_init], 2 display pipes available.
[    1.817181] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.891870] [drm:intel_crt_init], pch crt adpa set to 0xf40000
[    1.895198] [drm:intel_sdvo_read_byte], i2c transfer returned -6
[    1.895763] [drm:intel_sdvo_init], No SDVO device found on SDVOB
[    1.896972] [drm:intel_dp_i2c_init], i2c_init DPDDC-B
[    1.897990] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[    1.898588] [drm:intel_dp_i2c_aux_ch], aux_ch failed -110
[    1.899636] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[    1.900244] [drm:intel_dp_i2c_aux_ch], aux_ch failed -110
[    1.900903] [drm:intel_panel_get_backlight], get backlight PWM = 976
[    1.901490] [drm:intel_panel_get_backlight], get backlight PWM = 976
[    1.902092] [drm:intel_panel_set_backlight], set backlight PWM = 0
[    1.902689] [drm:ironlake_crtc_dpms], crtc 0/0 dpms off
[    1.903248] [drm:i915_get_vblank_timestamp], crtc 0 is disabled
[    1.924246] [drm:intel_update_fbc], 
[    1.924652] [drm:intel_update_fbc], no output, disabling
[    1.925377] [drm:ironlake_crtc_dpms], crtc 1/1 dpms off
[    1.925901] [drm:gm45_get_vblank_counter], trying to get vblank count for disabled pipe B
[    1.926656] [drm:i915_get_vblank_timestamp], crtc 1 is disabled
[    1.927215] [drm:gm45_get_vblank_counter], trying to get vblank count for disabled pipe B
[    1.928644] [drm:intel_update_fbc], 
[    1.929059] [drm:intel_update_fbc], no output, disabling
[    1.989253] [drm:init_status_page], render ring hws offset: 0x00000000
[    1.990102] [drm:init_status_page], gen6 bsd ring hws offset: 0x00021000
[    1.990931] [drm:init_status_page], blt ring hws offset: 0x00042000
[    1.991708] [drm:i915_setup_compression], FBC base 0xfc000000, ll base 0x00000000, size 32M
[    1.992537] [drm:intel_panel_set_backlight], set backlight PWM = 0
[    1.993147] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:5:LVDS-1]
[    1.993864] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:5:LVDS-1] probed modes :
[    1.994649] [drm:drm_mode_debug_printmodeline], Modeline 19:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[    1.995615] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:11:VGA-1]
[    1.996326] [drm:intel_ironlake_crt_detect_hotplug], trigger hotplug detect cycle: adpa=0xf40000
[    2.006802] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[    2.007618] [drm:intel_crt_detect], CRT not detected via hotplug
[    2.008191] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:11:VGA-1] disconnected
[    2.008974] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:14:HDMI-A-1]
[    2.153392] [drm:drm_detect_monitor_audio], Monitor has basic audio support
[    2.154029] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[    2.154555] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[    2.155367] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[    2.299697] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[    2.300221] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[    2.301034] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[    2.301570] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:14:HDMI-A-1] probed modes :
[    2.302381] [drm:drm_mode_debug_printmodeline], Modeline 20:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[    2.303381] [drm:drm_mode_debug_printmodeline], Modeline 21:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    2.304378] [drm:drm_mode_debug_printmodeline], Modeline 23:"1600x1200" 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
[    2.305377] [drm:drm_mode_debug_printmodeline], Modeline 25:"1680x1050" 60 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6
[    2.306374] [drm:drm_mode_debug_printmodeline], Modeline 30:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
[    2.307373] [drm:drm_mode_debug_printmodeline], Modeline 22:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[    2.308371] [drm:drm_mode_debug_printmodeline], Modeline 24:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[    2.309341] [drm:drm_mode_debug_printmodeline], Modeline 31:"1024x768" 75 78800 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[    2.310305] [drm:drm_mode_debug_printmodeline], Modeline 32:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[    2.311270] [drm:drm_mode_debug_printmodeline], Modeline 33:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[    2.312210] [drm:drm_mode_debug_printmodeline], Modeline 26:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[    2.313151] [drm:drm_mode_debug_printmodeline], Modeline 27:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[    2.314087] [drm:drm_mode_debug_printmodeline], Modeline 28:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[    2.315024] [drm:drm_mode_debug_printmodeline], Modeline 29:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[    2.315961] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:17:DP-1]
[    2.317170] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[    2.320220] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[    2.323219] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[    2.325696] [drm:intel_dp_detect], DPCD: 0000000000000000
[    2.326250] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:17:DP-1] disconnected
[    2.327028] [drm:drm_setup_crtcs], 
[    2.327429] [drm:drm_enable_connectors], connector 5 enabled? yes
[    2.328009] [drm:drm_enable_connectors], connector 11 enabled? no
[    2.328578] [drm:drm_enable_connectors], connector 14 enabled? yes
[    2.329163] [drm:drm_enable_connectors], connector 17 enabled? no
[    2.329742] [drm:drm_target_preferred], looking for cmdline mode on connector 5
[    2.330442] [drm:drm_target_preferred], looking for preferred mode on connector 5
[    2.331163] [drm:drm_target_preferred], found mode 1366x768
[    2.331707] [drm:drm_target_preferred], looking for cmdline mode on connector 14
[    2.332413] [drm:drm_target_preferred], looking for preferred mode on connector 14
[    2.333139] [drm:drm_target_preferred], found mode 1920x1200
[    2.333688] [drm:drm_setup_crtcs], picking CRTCs for 8192x8192 config
[    2.334283] [drm:drm_setup_crtcs], desired mode 1366x768 set on crtc 3
[    2.334892] [drm:drm_setup_crtcs], desired mode 1920x1200 set on crtc 4
[    2.351761] [drm:intelfb_create], allocated 1920x1200 fb: 0x00063000, bo ffff880144c7e000
[    2.352827] fbcon: inteldrmfb (fb0) is primary device
[    2.354430] [drm:drm_crtc_helper_set_config], 
[    2.354432] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[    2.354448] [drm:drm_crtc_helper_set_config], crtc has no fb, full mode set
[    2.354451] [drm:drm_crtc_helper_set_config], modes are different, full mode set
[    2.354453] [drm:drm_mode_debug_printmodeline], Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    2.354457] [drm:drm_mode_debug_printmodeline], Modeline 34:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[    2.354461] [drm:drm_crtc_helper_set_config], encoder changed, full mode switch
[    2.354463] [drm:drm_crtc_helper_set_config], crtc changed, full mode switch
[    2.354466] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.354469] [drm:drm_crtc_helper_set_config], attempting to set mode from userspace
[    2.354471] [drm:drm_mode_debug_printmodeline], Modeline 34:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[    2.354477] [drm:drm_crtc_helper_set_mode], [CRTC:3]
[    2.354500] [drm:ironlake_crtc_mode_set], using SSC reference clock of 120 MHz
[    2.354527] [drm:intel_choose_pipe_bpp_dither], clamping display bpc (was -1) to LVDS (6)
[    2.354530] [drm:intel_choose_pipe_bpp_dither], setting pipe bpc to 6 (max display bpc 6)
[    2.354738] [drm:ironlake_crtc_mode_set], Mode for pipe A:
[    2.354741] [drm:drm_mode_debug_printmodeline], Modeline 34:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[    2.406670] [drm:intel_wait_for_vblank], vblank wait timed out
[    2.406679] [drm:ironlake_update_plane], Writing base 00063000 00000000 0 0 7680
[    2.406687] [drm:intel_update_fbc], 
[    2.406692] [drm:intel_update_fbc], framebuffer not tiled or fenced, disabling compression
[    2.406700] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[    2.406707] [drm:ironlake_check_srwm], watermark 1: display plane 9, fbc lines 3, cursor 6
[    2.406715] [drm:ironlake_check_srwm], watermark 2: display plane 11, fbc lines 3, cursor 6
[    2.406723] [drm:ironlake_check_srwm], watermark 3: display plane 51, fbc lines 3, cursor 6
[    2.406732] [drm:drm_crtc_helper_set_mode], [ENCODER:6:LVDS-6] set [MODE:34:1366x768]
[    2.406740] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[    2.406747] [drm:ironlake_check_srwm], watermark 1: display plane 9, fbc lines 3, cursor 6
[    2.406755] [drm:ironlake_check_srwm], watermark 2: display plane 11, fbc lines 3, cursor 6
[    2.406762] [drm:ironlake_check_srwm], watermark 3: display plane 51, fbc lines 3, cursor 6
[    2.458653] [drm:intel_wait_for_vblank], vblank wait timed out
[    2.462810] Refined TSC clocksource calibration: 1995.467 MHz.
[    2.462816] Switching to clocksource tsc
[    2.510631] [drm:intel_wait_for_vblank], vblank wait timed out
[    2.511451] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x700
[    2.511455] [drm:gen6_fdi_link_train], FDI train 1 done.
[    2.512112] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x600
[    2.512116] [drm:gen6_fdi_link_train], FDI train 2 done.
[    2.512117] [drm:gen6_fdi_link_train], FDI train done.
[    2.513349] [drm:intel_update_fbc], 
[    2.513351] [drm:intel_update_fbc], framebuffer not tiled or fenced, disabling compression
[    2.513364] [drm:intel_panel_set_backlight], set backlight PWM = 976
[    2.513368] [drm:drm_crtc_helper_set_config], Setting connector DPMS state to on
[    2.513371] [drm:drm_crtc_helper_set_config], 	[CONNECTOR:5:LVDS-1] set DPMS on
[    2.513389] [drm:drm_crtc_helper_set_config], 
[    2.513391] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[    2.513401] [drm:drm_crtc_helper_set_config], crtc has no fb, full mode set
[    2.513403] [drm:drm_crtc_helper_set_config], modes are different, full mode set
[    2.513405] [drm:drm_mode_debug_printmodeline], Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    2.513409] [drm:drm_mode_debug_printmodeline], Modeline 35:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[    2.513413] [drm:drm_crtc_helper_set_config], encoder changed, full mode switch
[    2.513415] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.513418] [drm:drm_crtc_helper_set_config], crtc changed, full mode switch
[    2.513420] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[    2.513423] [drm:drm_crtc_helper_set_config], attempting to set mode from userspace
[    2.513425] [drm:drm_mode_debug_printmodeline], Modeline 35:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[    2.513431] [drm:drm_crtc_helper_set_mode], [CRTC:4]
[    2.513474] [drm:intel_choose_pipe_bpp_dither], clamping display bpc (was -1) to EDID reported max of 0
[    2.513477] [drm:intel_choose_pipe_bpp_dither], forcing bpc to 8 for HDMI
[    2.513479] [drm:intel_choose_pipe_bpp_dither], setting pipe bpc to 8 (max display bpc 8)
[    2.513686] [drm:ironlake_crtc_mode_set], Mode for pipe B:
[    2.513688] [drm:drm_mode_debug_printmodeline], Modeline 35:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[    2.530116] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[    2.565611] [drm:intel_wait_for_vblank], vblank wait timed out
[    2.565619] [drm:ironlake_update_plane], Writing base 00063000 00000000 0 0 7680
[    2.565627] [drm:intel_update_fbc], 
[    2.565631] [drm:intel_update_fbc], more than one pipe active, disabling compression
[    2.565638] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[    2.565645] [drm:sandybridge_update_wm], FIFO watermarks For pipe B - plane 9, cursor: 6
[    2.565653] [drm:drm_crtc_helper_set_mode], [ENCODER:13:TMDS-13] set [MODE:35:1920x1200]
[    2.617594] [drm:intel_wait_for_vblank], vblank wait timed out
[    2.617614] [drm:intel_write_eld], ELD on [CONNECTOR:14:HDMI-A-1], [ENCODER:13:TMDS-13]
[    2.617621] [drm:ironlake_write_eld], ELD on pipe B
[    2.617627] [drm:ironlake_write_eld], Audio directed to unknown port
[    2.617638] [drm:ironlake_write_eld], ELD size 9
[    2.617657] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[    2.617664] [drm:sandybridge_update_wm], FIFO watermarks For pipe B - plane 9, cursor: 6
[    2.669581] [drm:intel_wait_for_vblank], vblank wait timed out
[    2.721564] [drm:intel_wait_for_vblank], vblank wait timed out
[    2.722384] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x100
[    2.722387] [drm:gen6_fdi_link_train], FDI train 1 done.
[    2.723045] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x600
[    2.723048] [drm:gen6_fdi_link_train], FDI train 2 done.
[    2.723050] [drm:gen6_fdi_link_train], FDI train done.
[    2.723306] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[    2.724282] [drm:intel_update_fbc], 
[    2.724283] [drm:intel_update_fbc], more than one pipe active, disabling compression
[    2.724297] [drm:drm_crtc_helper_set_config], Setting connector DPMS state to on
[    2.724300] [drm:drm_crtc_helper_set_config], 	[CONNECTOR:14:HDMI-A-1] set DPMS on
[    2.724329] [drm:drm_crtc_helper_set_config], 
[    2.724331] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[    2.724341] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.724344] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[    2.724347] [drm:drm_crtc_helper_set_config], 
[    2.724349] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[    2.724358] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.724361] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[    2.727607] [drm:drm_crtc_helper_set_config], 
[    2.727609] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[    2.727619] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.727622] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[    2.727625] [drm:drm_crtc_helper_set_config], 
[    2.727626] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[    2.727636] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.727638] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[    2.730679] Console: switching to colour frame buffer device 170x48
[    2.730684] [drm:drm_crtc_helper_set_config], 
[    2.730685] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[    2.730696] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.730698] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[    2.730701] [drm:drm_crtc_helper_set_config], 
[    2.730703] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[    2.730712] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[    2.730715] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[    2.892356] fb0: inteldrmfb frame buffer device
[    2.892357] drm: registered panic notifier
[    2.911615] ACPI Error: Current brightness invalid (20110413/video-376)
[    2.913765] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input3
[    2.915313] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.916834] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    5.933697] floppy0: no floppy controllers found
[    6.068182] brd: module loaded
[    6.071670] loop: module loaded
[    6.073687] Loading iSCSI transport class v2.0-870.
[    6.076163] Loading Adaptec I2O RAID: Version 2.4 Build 5go
[    6.077480] Detecting Adaptec I2O RAID controllers...
[    6.079001] Adaptec aacraid driver 1.1-7[28000]-ms
[    6.080666] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
[    6.082376] QLogic Fibre Channel HBA Driver: 8.03.07.03-k
[    6.083972] iscsi: registered transport (qla4xxx)
[    6.085392] QLogic iSCSI HBA Driver
[    6.086750] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
[    6.088377] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
[    6.089967] megasas: 00.00.05.38-rc1 Wed. May. 11 17:00:00 PDT 2011
[    6.091568] mpt2sas version 08.100.00.02 loaded
[    6.093454] ahci 0000:00:1f.2: version 3.0
[    6.094762] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    6.096319] ahci 0000:00:1f.2: irq 41 for MSI/MSI-X
[    6.097725] ahci: SSS flag set, parallel bus scan disabled
[    6.109550] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x39 impl SATA mode
[    6.111173] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led clo pio slum part ems sxs apst 
[    6.112841] ahci 0000:00:1f.2: setting latency timer to 64
[    6.121830] scsi0 : ahci
[    6.123394] scsi1 : ahci
[    6.124885] scsi2 : ahci
[    6.126363] scsi3 : ahci
[    6.127826] scsi4 : ahci
[    6.129271] scsi5 : ahci
[    6.130690] ata1: SATA max UDMA/133 abar m2048@0xc0608000 port 0xc0608100 irq 41
[    6.132203] ata2: DUMMY
[    6.133394] ata3: DUMMY
[    6.134567] ata4: SATA max UDMA/133 abar m2048@0xc0608000 port 0xc0608280 irq 41
[    6.136089] ata5: SATA max UDMA/133 abar m2048@0xc0608000 port 0xc0608300 irq 41
[    6.137594] ata6: SATA max UDMA/133 abar m2048@0xc0608000 port 0xc0608380 irq 41
[    6.142563] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    6.144039] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    6.145528] e1000e: Intel(R) PRO/1000 Network Driver - 1.3.10-k2
[    6.146939] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    6.148440] Intel(R) Gigabit Ethernet Network Driver - version 3.0.6-k2
[    6.149902] Copyright (c) 2007-2011 Intel Corporation.
[    6.151363] Intel(R) Virtual Function Network Driver - version 1.0.8-k0
[    6.152837] Copyright (c) 2009 - 2010 Intel Corporation.
[    6.154318] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 3.3.8-k2
[    6.155879] ixgbe: Copyright (c) 1999-2011 Intel Corporation.
[    6.157404] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
[    6.158918] ixgb: Copyright (c) 1999-2008 Intel Corporation.
[    6.160799] jme: JMicron JMC2XX ethernet driver version 1.0.8
[    6.162589] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
[    6.164341] cnic: Broadcom NetXtreme II CNIC Driver cnic v2.2.14 (Mar 30, 2011)
[    6.166016] sky2: driver version 1.28
[    6.168751] tun: Universal TUN/TAP device driver, 1.6
[    6.170139] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    6.171834] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    6.173297] r8169 0000:03:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    6.174943] r8169 0000:03:00.0: setting latency timer to 64
[    6.176631] r8169 0000:03:00.0: irq 42 for MSI/MSI-X
[    6.178975] r8169 0000:03:00.0: eth0: RTL8168e/8111e at 0xffffc90000662000, f0:de:f1:2d:5c:de, XID 0c200000 IRQ 42
[    6.180931] usbcore: registered new interface driver catc
[    6.182378] catc: v2.8:CATC EL1210A NetMate USB Ethernet driver
[    6.183936] usbcore: registered new interface driver kaweth
[    6.185386] pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
[    6.187046] usbcore: registered new interface driver pegasus
[    6.188510] rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet driver
[    6.190142] usbcore: registered new interface driver rtl8150
[    6.191694] usbcore: registered new interface driver asix
[    6.193221] usbcore: registered new interface driver cdc_ether
[    6.194764] usbcore: registered new interface driver cdc_eem
[    6.196270] usbcore: registered new interface driver dm9601
[    6.197753] usbcore: registered new interface driver smsc75xx
[    6.199223] usbcore: registered new interface driver smsc95xx
[    6.200674] usbcore: registered new interface driver gl620a
[    6.202116] usbcore: registered new interface driver net1080
[    6.203568] usbcore: registered new interface driver plusb
[    6.205008] usbcore: registered new interface driver rndis_host
[    6.206482] usbcore: registered new interface driver cdc_subset
[    6.207973] usbcore: registered new interface driver zaurus
[    6.209408] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
[    6.210948] usbcore: registered new interface driver int51x1
[    6.212292] cdc_ncm: 01-June-2011
[    6.213542] usbcore: registered new interface driver cdc_ncm
[    6.214888] netconsole: local port 6665
[    6.216118] netconsole: local IP 10.0.0.0
[    6.217339] netconsole: interface 'eth0'
[    6.218540] netconsole: remote port 6666
[    6.219732] netconsole: remote IP 10.239.97.14
[    6.220948] netconsole: remote ethernet address 00:30:48:fe:19:94
[    6.222271] netconsole: device eth0 not up yet, forcing it
[    6.443413] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.716392] ata1.00: ATA-8: ST9500420AS, 0003LVM1, max UDMA/100
[    6.717763] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    6.721036] ata1.00: configured for UDMA/100
[    6.722537] scsi 0:0:0:0: Direct-Access     ATA      ST9500420AS      0003 PQ: 0 ANSI: 5
[    6.724473] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    6.726093] sd 0:0:0:0: [sda] Write Protect is off
[    6.727333] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.728613] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.807786]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 > sda4
[    6.810567] sd 0:0:0:0: [sda] Attached SCSI disk
[    7.029221] ata4: SATA link down (SStatus 0 SControl 300)
[    7.335127] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    7.338302] ata5.00: ATAPI: Optiarc DVD RW AD-7710H, A833, max UDMA/100
[    7.341778] ata5.00: configured for UDMA/100
[    7.345128] scsi 4:0:0:0: CD-ROM            Optiarc  DVD RW AD-7710H  A833 PQ: 0 ANSI: 5
[    7.652023] ata6: SATA link down (SStatus 0 SControl 300)
[   12.899395] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[   12.900923] [drm:intel_crt_detect], CRT not detected via hotplug
[   12.902250] [drm:output_poll_execute], [CONNECTOR:11:VGA-1] status updated from 2 to 2
[   13.046818] [drm:drm_detect_monitor_audio], Monitor has basic audio support
[   13.048224] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[   13.049526] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[   13.051126] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[   13.052466] [drm:output_poll_execute], [CONNECTOR:14:HDMI-A-1] status updated from 1 to 1
[   13.054521] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[   13.057794] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[   13.060790] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[   13.063275] [drm:intel_dp_detect], DPCD: 0000000000000000
[   13.064701] [drm:output_poll_execute], [CONNECTOR:17:DP-1] status updated from 2 to 2
[   67.026397] r8169 0000:03:00.0: eth0: unable to load firmware patch rtl_nic/rtl8168e-2.fw (-2)
[   67.047182] r8169 0000:03:00.0: eth0: link down
[   67.048576] r8169 0000:03:00.0: eth0: link down
[   68.565993] r8169 0000:03:00.0: eth0: link up
[   68.581378] console [netcon0] enabled
[   68.582787] netconsole: network logging started
[   68.584303] Fusion MPT base driver 3.04.19
[   68.585687] Copyright (c) 1999-2008 LSI Corporation
[   68.587137] Fusion MPT SPI Host driver 3.04.19
[   68.588664] Fusion MPT FC Host driver 3.04.19
[   68.590167] Fusion MPT SAS Host driver 3.04.19
[   68.591678] Fusion MPT misc device (ioctl) driver 3.04.19
[   68.593271] mptctl: Registered with Fusion MPT base driver
[   68.594748] mptctl: /dev/mptctl @ (major,minor=10,220)
[   68.596384] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   68.597962] ehci_hcd: block sizes: qh 104 qtd 96 itd 192 sitd 96
[   68.599540] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   68.601199] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[   68.602730] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[   68.604294] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file 'devices'
[   68.605935] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '001'
[   68.607537] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   68.609166] ehci_hcd 0000:00:1a.0: reset hcs_params 0x200002 dbg=2 cc=0 pcc=0 ordered !ppc ports=2
[   68.610194] r8169 0000:03:00.0: eth0: link down
[   68.612321] ehci_hcd 0000:00:1a.0: reset hcc_params 36881 caching frame 1024 64 bit addr
[   68.614060] ehci_hcd 0000:00:1a.0: support lpm
[   68.615522] ehci_hcd 0000:00:1a.0: debug port 2
[   68.616954] ehci_hcd 0000:00:1a.0: reset command 0010012 (park)=0 ithresh=1 Periodic period=1024 Reset HALT
[   68.622616] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[   68.624199] ehci_hcd 0000:00:1a.0: supports USB remote wakeup
[   68.625747] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xc060a000
[   68.627252] ehci_hcd 0000:00:1a.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
[   68.632860] ehci_hcd 0000:00:1a.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
[   68.639619] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   68.641282] usb usb1: default language 0x0409
[   68.642689] usb usb1: udev 1, busnum 1, minor = 0
[   68.644086] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   68.645620] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   68.647157] usb usb1: Product: EHCI Host Controller
[   68.648555] usb usb1: Manufacturer: Linux 3.0.0-drm+ ehci_hcd
[   68.649987] usb usb1: SerialNumber: 0000:00:1a.0
[   68.651498] usb usb1: usb_probe_device
[   68.652764] usb usb1: configuration #1 chosen from 1 choice
[   68.654154] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[   68.655690] hub 1-0:1.0: usb_probe_interface
[   68.656998] hub 1-0:1.0: usb_probe_interface - got id
[   68.658344] hub 1-0:1.0: USB hub found
[   68.659590] hub 1-0:1.0: 2 ports detected
[   68.660820] hub 1-0:1.0: standalone hub
[   68.662035] hub 1-0:1.0: no power switching (usb 1.0)
[   68.663335] hub 1-0:1.0: individual port over-current protection
[   68.664705] hub 1-0:1.0: power on to power good time: 20ms
[   68.666076] hub 1-0:1.0: local power source is good
[   68.667377] hub 1-0:1.0: trying to enable port power on non-switchable hub
[   68.668870] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '001'
[   68.670425] IOAPIC[0]: Set routing entry (2-23 -> 0x69 -> IRQ 23 Mode:1 Active:1)
[   68.671944] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[   68.673457] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[   68.674874] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[   68.676248] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '002'
[   68.677749] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   68.679284] ehci_hcd 0000:00:1d.0: reset hcs_params 0x200002 dbg=2 cc=0 pcc=0 ordered !ppc ports=2
[   68.680933] ehci_hcd 0000:00:1d.0: reset hcc_params 36881 caching frame 1024 64 bit addr
[   68.682532] ehci_hcd 0000:00:1d.0: support lpm
[   68.683896] ehci_hcd 0000:00:1d.0: debug port 2
[   68.685236] ehci_hcd 0000:00:1d.0: reset command 0010012 (park)=0 ithresh=1 Periodic period=1024 Reset HALT
[   68.690830] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[   68.692323] ehci_hcd 0000:00:1d.0: supports USB remote wakeup
[   68.693805] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xc0609000
[   68.695240] ehci_hcd 0000:00:1d.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
[   68.700740] ehci_hcd 0000:00:1d.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
[   68.707595] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   68.709123] usb usb2: default language 0x0409
[   68.710458] usb usb2: udev 1, busnum 2, minor = 128
[   68.711806] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[   68.713280] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   68.714767] usb usb2: Product: EHCI Host Controller
[   68.716110] usb usb2: Manufacturer: Linux 3.0.0-drm+ ehci_hcd
[   68.717506] usb usb2: SerialNumber: 0000:00:1d.0
[   68.719014] usb usb2: usb_probe_device
[   68.720259] usb usb2: configuration #1 chosen from 1 choice
[   68.721637] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[   68.723124] hub 2-0:1.0: usb_probe_interface
[   68.724403] hub 2-0:1.0: usb_probe_interface - got id
[   68.725710] hub 2-0:1.0: USB hub found
[   68.726944] hub 2-0:1.0: 2 ports detected
[   68.728174] hub 2-0:1.0: standalone hub
[   68.729368] hub 2-0:1.0: no power switching (usb 1.0)
[   68.730643] hub 2-0:1.0: individual port over-current protection
[   68.731994] hub 2-0:1.0: power on to power good time: 20ms
[   68.733321] hub 2-0:1.0: local power source is good
[   68.734589] hub 2-0:1.0: trying to enable port power on non-switchable hub
[   68.736044] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '001'
[   68.737637] uhci_hcd: USB Universal Host Controller Interface driver
[   68.739195] Initializing USB Mass Storage driver...
[   68.740621] usbcore: registered new interface driver usb-storage
[   68.742036] USB Mass Storage support registered.
[   68.743491] usbcore: registered new interface driver libusual
[   68.744990] usbcore: registered new interface driver ums-alauda
[   68.746500] usbcore: registered new interface driver ums-cypress
[   68.748001] usbcore: registered new interface driver ums-datafab
[   68.749477] usbcore: registered new interface driver ums-freecom
[   68.750947] usbcore: registered new interface driver ums-isd200
[   68.752381] usbcore: registered new interface driver ums-jumpshot
[   68.753816] usbcore: registered new interface driver ums-karma
[   68.755205] usbcore: registered new interface driver ums-onetouch
[   68.756616] usbcore: registered new interface driver ums-sddr09
[   68.757984] usbcore: registered new interface driver ums-sddr55
[   68.759339] usbcore: registered new interface driver ums-usbat
[   68.760755] usbcore: registered new interface driver usbserial
[   68.762073] USB Serial support registered for generic
[   68.763329] usbcore: registered new interface driver usbserial_generic
[   68.764605] usbserial: USB Serial Driver core
[   68.765803] USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
[   68.767295] usbcore: registered new interface driver belkin
[   68.768515] belkin_sa: v1.3:USB Belkin Serial converter driver
[   68.769805] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
[   68.771258] hub 1-0:1.0: port 1: status 0501 change 0001
[   68.771378] USB Serial support registered for MCT U232
[   68.771505] usbcore: registered new interface driver mct_u232
[   68.771508] mct_u232: z2.1:Magic Control Technology USB-RS232 converter driver
[   68.771805] i8042: PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   68.774390] serio: i8042 KBD port at 0x60,0x64 irq 1
[   68.774424] serio: i8042 AUX port at 0x60,0x64 irq 12
[   68.774967] mousedev: PS/2 mouse device common for all mice
[   68.776120] rtc_cmos 00:06: RTC can wake from S4
[   68.776441] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   68.776508] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[   68.776605] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[   68.776854] iTCO_wdt: Found a Cougar Point TCO device (Version=2, TCOBASE=0x0460)
[   68.777023] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   68.777028] iTCO_vendor_support: vendor-support=0
[   68.777031] SoftDog: cannot register miscdev on minor=130 (err=-16)
[   68.777043] md: linear personality registered for level -1
[   68.777046] md: raid0 personality registered for level 0
[   68.777048] md: raid1 personality registered for level 1
[   68.777050] md: raid10 personality registered for level 10
[   68.777052] md: raid6 personality registered for level 6
[   68.777054] md: raid5 personality registered for level 5
[   68.777056] md: raid4 personality registered for level 4
[   68.777058] md: multipath personality registered for level -4
[   68.777060] md: faulty personality registered for level -5
[   68.777483] device-mapper: uevent: version 1.0.3
[   68.777823] device-mapper: ioctl: 4.20.0-ioctl (2011-02-02) initialised: dm-devel@redhat.com
[   68.778043] device-mapper: multipath: version 1.3.0 loaded
[   68.778058] device-mapper: multipath round-robin: version 1.0.0 loaded
[   68.778060] device-mapper: multipath queue-length: version 0.1.0 loaded
[   68.778062] device-mapper: multipath service-time: version 0.2.0 loaded
[   68.778317] device-mapper: dm-log-userspace: version 1.1.0 loaded
[   68.780859] cpuidle: using governor ladder
[   68.819573] cpuidle: using governor menu
[   68.821105] usbcore: registered new interface driver usbhid
[   68.822432] usbhid: USB HID core driver
[   68.824225] dell_wmi: No known WMI GUID found
[   68.825505] acer_wmi: Acer Laptop ACPI-WMI Extras
[   68.827288] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[   68.835581] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
[   68.837253] hub 2-0:1.0: port 1: status 0501 change 0001
[   68.860030] IOAPIC[0]: Set routing entry (2-22 -> 0x71 -> IRQ 22 Mode:1 Active:1)
[   68.861600] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   68.863263] HDA Intel 0000:00:1b.0: irq 43 for MSI/MSI-X
[   68.864714] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   68.866159] ALSA hda_intel.c:2586 chipset global capabilities = 0x4401
[   68.867640] ALSA hda_intel.c:1089 Clearing TCSEL
[   68.868999] ALSA hda_intel.c:1127 HDA snoop disabled, enabling ... OK
[   68.877584] ALSA hda_intel.c:943 codec_mask = 0x9
[   68.879216] ALSA hda_intel.c:1390 codec #0 probed OK
[   68.880607] ALSA hda_intel.c:1390 codec #3 probed OK
[   68.913621] hub 1-0:1.0: state 7 ports 2 chg 0002 evt 0000
[   68.914994] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[   68.966779] ehci_hcd 0000:00:1a.0: port 1 high speed
[   68.968103] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   69.020587] usb 1-1: new high speed USB device number 2 using ehci_hcd
[   69.072746] ehci_hcd 0000:00:1a.0: port 1 high speed
[   69.074066] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   69.138709] ehci_hcd 0000:00:1a.0: set dev address 2 for port 1
[   69.140346] ehci_hcd 0000:00:1a.0: LPM: no device attached
[   69.142014] usb 1-1: udev 2, busnum 1, minor = 1
[   69.143337] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[   69.145147] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   69.146866] usb 1-1: usb_probe_device
[   69.148101] usb 1-1: configuration #1 chosen from 1 choice
[   69.149942] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
[   69.151620] hub 1-1:1.0: usb_probe_interface
[   69.152881] hub 1-1:1.0: usb_probe_interface - got id
[   69.154386] hub 1-1:1.0: USB hub found
[   69.155885] hub 1-1:1.0: 6 ports detected
[   69.157204] hub 1-1:1.0: standalone hub
[   69.158755] hub 1-1:1.0: individual port power switching
[   69.160095] hub 1-1:1.0: individual port over-current protection
[   69.161721] hub 1-1:1.0: Single TT
[   69.162928] hub 1-1:1.0: TT requires at most 8 FS bit times (666 ns)
[   69.164539] hub 1-1:1.0: power on to power good time: 100ms
[   69.166125] hub 1-1:1.0: local power source is good
[   69.167769] hub 1-1:1.0: enabling power on all ports
[   69.169879] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '002'
[   69.171363] hub 2-0:1.0: state 7 ports 2 chg 0002 evt 0000
[   69.173105] hub 2-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[   69.225694] ehci_hcd 0000:00:1d.0: port 1 high speed
[   69.227151] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   69.270227] hub 1-1:1.0: port 5: status 0101 change 0001
[   69.279488] usb 2-1: new high speed USB device number 2 using ehci_hcd
[   69.332659] ehci_hcd 0000:00:1d.0: port 1 high speed
[   69.334161] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   69.371432] usb 1-1: link qh256-0001/ffff88014363e500 start 1 [1/0 us]
[   69.389450] ALSA patch_realtek.c:1748 SKU: Nid=0x1d sku_cfg=0x40179a2d
[   69.390996] ALSA patch_realtek.c:1750 SKU: port_connectivity=0x1
[   69.392410] ALSA patch_realtek.c:1751 SKU: enable_pcbeep=0x1
[   69.393781] ALSA patch_realtek.c:1752 SKU: check_sum=0x00000007
[   69.395176] ALSA patch_realtek.c:1753 SKU: customization=0x0000009a
[   69.396578] ALSA patch_realtek.c:1754 SKU: external_amp=0x5
[   69.397921] ALSA patch_realtek.c:1755 SKU: platform_type=0x1
[   69.398545] ehci_hcd 0000:00:1d.0: set dev address 2 for port 1
[   69.398551] ehci_hcd 0000:00:1d.0: LPM: no device attached
[   69.398790] usb 2-1: udev 2, busnum 2, minor = 129
[   69.398794] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[   69.398797] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   69.399136] usb 2-1: usb_probe_device
[   69.399139] usb 2-1: configuration #1 chosen from 1 choice
[   69.399314] usb 2-1: adding 2-1:1.0 (config #1, interface 0)
[   69.399574] hub 2-1:1.0: usb_probe_interface
[   69.399577] hub 2-1:1.0: usb_probe_interface - got id
[   69.399579] hub 2-1:1.0: USB hub found
[   69.399661] hub 2-1:1.0: 6 ports detected
[   69.399664] hub 2-1:1.0: standalone hub
[   69.399666] hub 2-1:1.0: individual port power switching
[   69.399669] hub 2-1:1.0: individual port over-current protection
[   69.399672] hub 2-1:1.0: Single TT
[   69.399674] hub 2-1:1.0: TT requires at most 8 FS bit times (666 ns)
[   69.399678] hub 2-1:1.0: power on to power good time: 100ms
[   69.399908] hub 2-1:1.0: local power source is good
[   69.399912] hub 2-1:1.0: enabling power on all ports
[   69.400708] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '002'
[   69.400762] hub 1-1:1.0: state 7 ports 6 chg 0020 evt 0000
[   69.400918] hub 1-1:1.0: port 5, status 0101, change 0000, 12 Mb/s
[   69.411542] hub 1-1:1.0: port 5 not reset yet, waiting 10ms
[   69.429825] ALSA patch_realtek.c:1756 SKU: swap=0x0
[   69.431110] ALSA patch_realtek.c:1757 SKU: override=0x1
[   69.432577] hda_codec: ALC272: BIOS auto-probing.
[   69.433827] ALSA hda_codec.c:4707 autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   69.435336] ALSA hda_codec.c:4711    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   69.436737] ALSA hda_codec.c:4715    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[   69.438115] ALSA hda_codec.c:4716    mono: mono_out=0x0
[   69.439405] ALSA hda_codec.c:4720    inputs:
[   69.439690] ALSA hda_codec.c:4724  Internal Mic=0x12
[   69.440961] ALSA hda_codec.c:4724  Mic=0x18
[   69.442159] ALSA hda_codec.c:4726 
[   69.445272] ALSA patch_realtek.c:1805 realtek: No valid SSID, checking pincfg 0x40179a2d for NID 0x1d
[   69.446793] ALSA patch_realtek.c:1821 realtek: Enabling init ASM_ID=0x9a2d CODEC_ID=10ec0272
[   69.448284] ALSA patch_realtek.c:1598 realtek: Enable HP auto-muting on NID 0x21
[   69.449669] ALSA patch_realtek.c:1678 realtek: Enable auto-mic switch on NID 0x18/0x12/0x0
[   69.451313] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input5
[   69.453468] HDMI status: Pin=5 Presence_Detect=1 ELD_Valid=1
[   69.459200] ALSA hda_eld.c:267 HDMI: Unknown ELD version 0
[   69.460969] ALSA patch_hdmi.c:945 HDMI: Skipping node 3 (no connection)
[   69.462282] ALSA patch_hdmi.c:945 HDMI: Skipping node 4 (no connection)
[   69.465656] ALSA hda_codec.c:2234 Cannot find slave Front Playback Volume, skipped
[   69.467050] ALSA hda_codec.c:2234 Cannot find slave Surround Playback Volume, skipped
[   69.468472] ALSA hda_codec.c:2234 Cannot find slave Center Playback Volume, skipped
[   69.469862] ALSA hda_codec.c:2234 Cannot find slave LFE Playback Volume, skipped
[   69.471254] ALSA hda_codec.c:2234 Cannot find slave Side Playback Volume, skipped
[   69.471259] ALSA hda_codec.c:2234 Cannot find slave Mono Playback Volume, skipped
[   69.471262] ALSA hda_codec.c:2234 Cannot find slave Line-Out Playback Volume, skipped
[   69.471268] ALSA hda_codec.c:2234 Cannot find slave Front Playback Switch, skipped
[   69.471271] ALSA hda_codec.c:2234 Cannot find slave Surround Playback Switch, skipped
[   69.471274] ALSA hda_codec.c:2234 Cannot find slave Center Playback Switch, skipped
[   69.471276] ALSA hda_codec.c:2234 Cannot find slave LFE Playback Switch, skipped
[   69.471279] ALSA hda_codec.c:2234 Cannot find slave Side Playback Switch, skipped
[   69.471288] ALSA hda_codec.c:2234 Cannot find slave Mono Playback Switch, skipped
[   69.471291] ALSA hda_codec.c:2234 Cannot find slave IEC958 Playback Switch, skipped
[   69.471295] ALSA hda_codec.c:2234 Cannot find slave Line-Out Playback Switch, skipped
[   69.471491] HDMI hot plug event: Pin=5 Presence_Detect=1 ELD_Valid=1
[   69.471540] HDMI status: Pin=5 Presence_Detect=1 ELD_Valid=1
[   69.472304] input: HDA Intel PCH HDMI/DP as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   69.472715] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   69.473067] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   69.473527] usb 1-1.5: new high speed USB device number 3 using ehci_hcd
[   69.474041] ALSA device list:
[   69.474044]   #0: HDA Intel PCH at 0xc0600000 irq 43
[   69.474048] oprofile: using NMI interrupt.
[   69.474186] netem: version 1.3
[   69.474189] Netfilter messages via NETLINK v0.30.
[   69.474279] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   69.475129] ALSA hda_eld.c:267 HDMI: Unknown ELD version 0
[   69.475194] HDMI hot plug event: Pin=5 Presence_Detect=1 ELD_Valid=1
[   69.475253] HDMI status: Pin=5 Presence_Detect=1 ELD_Valid=1
[   69.475798] ctnetlink v0.93: registering with nfnetlink.
[   69.475865] NF_TPROXY: Transparent proxy support initialized, version 4.1.0
[   69.475868] NF_TPROXY: Copyright (c) 2006-2007 BalaBit IT Ltd.
[   69.476494] xt_time: kernel timezone is -0000
[   69.478791] ALSA hda_eld.c:267 HDMI: Unknown ELD version 0
[   69.479422] ip_tables: (C) 2000-2006 Netfilter Core Team
[   69.479511] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[   69.479540] arp_tables: (C) 2002 David S. Miller
[   69.479580] TCP bic registered
[   69.479582] TCP cubic registered
[   69.479584] TCP westwood registered
[   69.479585] TCP highspeed registered
[   69.479587] TCP hybla registered
[   69.479588] TCP htcp registered
[   69.479590] TCP vegas registered
[   69.479592] TCP veno registered
[   69.479593] TCP scalable registered
[   69.479595] TCP lp registered
[   69.479596] TCP yeah registered
[   69.479598] TCP illinois registered
[   69.479600] Initializing XFRM netlink socket
[   69.479618] NET: Registered protocol family 17
[   69.479632] NET: Registered protocol family 15
[   69.479789] Bridge firewalling registered
[   69.479805] Ebtables v2.0 registered
[   69.480363] PM: Hibernation image not present or could not be loaded.
[   69.480396] registered taskstats version 1
[   69.481160]   Magic number: 7:513:623
[   69.485518] hub 1-1:1.0: port 5 not reset yet, waiting 10ms
[   69.500633] hub 2-1:1.0: port 2: status 0101 change 0001
[   69.500875] hub 2-1:1.0: port 3: status 0101 change 0001
[   69.501125] hub 2-1:1.0: port 4: status 0101 change 0001
[   69.501500] hub 2-1:1.0: port 6: status 0101 change 0001
[   69.502926] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input9
[   69.538499] rtc_cmos 00:06: setting system clock to 2011-08-01 08:38:04 UTC (1312187884)
[   69.601406] usb 2-1: link qh256-0001/ffff88014361d700 start 1 [1/0 us]
[   69.690053] usb 1-1.5: skipped 1 descriptor after configuration
[   69.692649] usb 1-1.5: skipped 5 descriptors after interface
[   69.695187] usb 1-1.5: skipped 1 descriptor after endpoint
[   69.697664] usb 1-1.5: skipped 19 descriptors after interface
[   69.700351] usb 1-1.5: default language 0x0409
[   69.726525] usb 1-1.5: udev 3, busnum 1, minor = 2
[   69.728941] usb 1-1.5: New USB device found, idVendor=0bda, idProduct=58ea
[   69.731524] usb 1-1.5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[   69.734107] usb 1-1.5: Product: Lenovo easy camera
[   69.736550] usb 1-1.5: Manufacturer: Generic
[   69.738868] usb 1-1.5: SerialNumber: 200901010001
[   69.741811] usb 1-1.5: usb_probe_device
[   69.744052] usb 1-1.5: configuration #1 chosen from 1 choice
[   69.747354] usb 1-1.5: adding 1-1.5:1.0 (config #1, interface 0)
[   69.750639] usbserial_generic 1-1.5:1.0: usb_probe_interface
[   69.752973] usbserial_generic 1-1.5:1.0: usb_probe_interface - got id
[   69.755537] usb 1-1.5: adding 1-1.5:1.1 (config #1, interface 1)
[   69.758354] usbserial_generic 1-1.5:1.1: usb_probe_interface
[   69.760665] usbserial_generic 1-1.5:1.1: usb_probe_interface - got id
[   69.762999] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '003'
[   69.765509] hub 2-1:1.0: state 7 ports 6 chg 005c evt 0000
[   69.766598] hub 2-1:1.0: port 2, status 0101, change 0000, 12 Mb/s
[   69.778481] hub 2-1:1.0: port 2 not reset yet, waiting 10ms
[   69.842458] usb 2-1.2: new high speed USB device number 3 using ehci_hcd
[   69.856449] hub 2-1:1.0: port 2 not reset yet, waiting 10ms
[   69.933454] usb 2-1.2: default language 0x0409
[   69.937582] usb 2-1.2: udev 3, busnum 2, minor = 130
[   69.940070] usb 2-1.2: New USB device found, idVendor=03f0, idProduct=5607
[   69.942715] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   69.945437] usb 2-1.2: Product: v210w
[   69.947942] usb 2-1.2: Manufacturer: HP
[   69.950415] usb 2-1.2: SerialNumber: 0000000000000031
[   69.953622] usb 2-1.2: usb_probe_device
[   69.956110] usb 2-1.2: configuration #1 chosen from 1 choice
[   69.959026] usb 2-1.2: adding 2-1.2:1.0 (config #1, interface 0)
[   69.962149] usb-storage 2-1.2:1.0: usb_probe_interface
[   69.964817] usb-storage 2-1.2:1.0: usb_probe_interface - got id
[   69.967971] scsi6 : usb-storage 2-1.2:1.0
[   69.971509] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '003'
[   69.974505] hub 2-1:1.0: port 3, status 0101, change 0000, 12 Mb/s
[   70.039555] usb 2-1.3: new full speed USB device number 4 using ehci_hcd
[   70.053417] hub 2-1:1.0: port 3 not reset yet, waiting 10ms
[   70.131885] usb 2-1.3: default language 0x0409
[   70.135391] usb 2-1.3: udev 4, busnum 2, minor = 131
[   70.138203] usb 2-1.3: New USB device found, idVendor=1c7a, idProduct=0603
[   70.141062] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   70.144001] usb 2-1.3: Product: EgisTec_ES603
[   70.146643] usb 2-1.3: Manufacturer: EgisTec
[   70.149831] usb 2-1.3: usb_probe_device
[   70.152379] usb 2-1.3: configuration #1 chosen from 1 choice
[   70.155369] usb 2-1.3: adding 2-1.3:1.0 (config #1, interface 0)
[   70.158657] usbserial_generic 2-1.3:1.0: usb_probe_interface
[   70.161407] usbserial_generic 2-1.3:1.0: usb_probe_interface - got id
[   70.164359] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '004'
[   70.167406] hub 2-1:1.0: port 4, status 0101, change 0000, 12 Mb/s
[   70.169828] r8169 0000:03:00.0: eth0: link up
[   70.179323] hub 2-1:1.0: port 4 not reset yet, waiting 10ms
[   70.182752] IP-Config: Complete:
[   70.185352]      device=eth0, addr=10.239.47.20, mask=255.255.255.0, gw=10.239.47.241,
[   70.186086]      host=wu-kexec, domain=, nis-domain=(none),
[   70.188977]      bootserver=10.239.97.14, rootserver=10.239.97.14, rootpath=
[   70.195164] md: Waiting for all devices to be available before autodetect
[   70.196358] md: If you don't use raid, use raid=noautodetect
[   70.198410] md: Autodetecting RAID arrays.
[   70.199463] md: Scanned 0 and added 0 devices.
[   70.200474] md: autorun ...
[   70.201394] md: ... autorun DONE.
[   70.244351] usb 2-1.4: new full speed USB device number 5 using ehci_hcd
[   70.258294] hub 2-1:1.0: port 4 not reset yet, waiting 10ms
[   70.338092] usb 2-1.4: skipped 1 descriptor after interface
[   70.341322] usb 2-1.4: default language 0x0409
[   70.345324] usb 2-1.4: udev 5, busnum 2, minor = 132
[   70.348130] usb 2-1.4: New USB device found, idVendor=0489, idProduct=e00d
[   70.351067] usb 2-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   70.354038] usb 2-1.4: Product: Broadcom Bluetooth 2.1 Device
[   70.356885] usb 2-1.4: Manufacturer: Broadcom Corp
[   70.359663] usb 2-1.4: SerialNumber: 18F46AE6E7A9
[   70.362982] usb 2-1.4: usb_probe_device
[   70.365713] usb 2-1.4: configuration #1 chosen from 1 choice
[   70.368788] usb 2-1.4: adding 2-1.4:1.0 (config #1, interface 0)
[   70.370210] usbserial_generic 2-1.4:1.0: usb_probe_interface
[   70.371356] usbserial_generic 2-1.4:1.0: usb_probe_interface - got id
[   70.372492] usb 2-1.4: adding 2-1.4:1.1 (config #1, interface 1)
[   70.373895] usbserial_generic 2-1.4:1.1: usb_probe_interface
[   70.375089] usbserial_generic 2-1.4:1.1: usb_probe_interface - got id
[   70.376237] usb 2-1.4: adding 2-1.4:1.2 (config #1, interface 2)
[   70.377661] usbserial_generic 2-1.4:1.2: usb_probe_interface
[   70.378819] usbserial_generic 2-1.4:1.2: usb_probe_interface - got id
[   70.379940] usb 2-1.4: adding 2-1.4:1.3 (config #1, interface 3)
[   70.381475] usbserial_generic 2-1.4:1.3: usb_probe_interface
[   70.382552] usbserial_generic 2-1.4:1.3: usb_probe_interface - got id
[   70.383626] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '005'
[   70.384870] hub 2-1:1.0: port 6, status 0101, change 0000, 12 Mb/s
[   70.397254] hub 2-1:1.0: port 6 not reset yet, waiting 10ms
[   70.461237] usb 2-1.6: new high speed USB device number 6 using ehci_hcd
[   70.475234] hub 2-1:1.0: port 6 not reset yet, waiting 10ms
[   70.552809] usb 2-1.6: default language 0x0409
[   70.555930] usb 2-1.6: udev 6, busnum 2, minor = 133
[   70.558668] usb 2-1.6: New USB device found, idVendor=0bda, idProduct=0139
[   70.561564] usb 2-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   70.564518] usb 2-1.6: Product: USB2.0-CRW
[   70.567227] usb 2-1.6: Manufacturer: Generic
[   70.569906] usb 2-1.6: SerialNumber: 20100201396000000
[   70.573221] usb 2-1.6: usb_probe_device
[   70.574258] usb 2-1.6: configuration #1 chosen from 1 choice
[   70.575676] usb 2-1.6: adding 2-1.6:1.0 (config #1, interface 0)
[   70.577320] usbserial_generic 2-1.6:1.0: usb_probe_interface
[   70.578367] usbserial_generic 2-1.6:1.0: usb_probe_interface - got id
[   70.579470] /c/wfg/linux-drm/drivers/usb/core/inode.c: creating file '006'
[   70.580554] hub 2-1:1.0: state 7 ports 6 chg 0000 evt 0040
[   70.972630] scsi 6:0:0:0: Direct-Access     hp       v210w            0.00 PQ: 0 ANSI: 2
[   71.086225] scsi_scan_6 used greatest stack depth: 4792 bytes left
[   71.089183] sd 6:0:0:0: [sdb] 31711232 512-byte logical blocks: (16.2 GB/15.1 GiB)
[   71.092678] sd 6:0:0:0: [sdb] Write Protect is off
[   71.095419] sd 6:0:0:0: [sdb] Mode Sense: 00 00 00 00
[   71.098797] sd 6:0:0:0: [sdb] Asking for cache data failed
[   71.101521] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[   71.107940] sd 6:0:0:0: [sdb] Asking for cache data failed
[   71.110664] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[   71.114416]  sdb: sdb1
[   71.120540] sd 6:0:0:0: [sdb] Asking for cache data failed
[   71.123337] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[   71.126108] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[   71.225054] VFS: Mounted root (nfs filesystem) on device 0:15.
[   71.227906] debug: unmapping init memory ffffffff81e99000..ffffffff82145000
[   71.767520] stty used greatest stack depth: 4384 bytes left
[   71.861633] uname used greatest stack depth: 3728 bytes left
[   71.970015] sh used greatest stack depth: 3680 bytes left
[   72.833624] alsa-utils used greatest stack depth: 3664 bytes left
[   72.908760] blkid used greatest stack depth: 3552 bytes left
[   73.292806] alsactl used greatest stack depth: 3536 bytes left
[   74.327135] fstab_import used greatest stack depth: 3360 bytes left
[   85.767257] rc used greatest stack depth: 3344 bytes left
[  113.236378] [drm:pch_irq_handler], PCH transcoder audio interrupt
[  113.239286] [drm:i915_hotplug_work_func], running encoder hotplug functions
[  113.242681] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[  113.245851] [drm:intel_crt_detect], CRT not detected via hotplug
[  113.248908] [drm:output_poll_execute], [CONNECTOR:11:VGA-1] status updated from 2 to 2
[  113.265365] [drm:output_poll_execute], [CONNECTOR:14:HDMI-A-1] status updated from 1 to 2
[  113.269091] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  113.273934] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  113.276937] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  113.279432] [drm:intel_dp_detect], DPCD: 0000000000000000
[  113.280507] [drm:output_poll_execute], [CONNECTOR:17:DP-1] status updated from 2 to 2
[  113.281775] [drm:drm_fb_helper_hotplug_event], 
[  113.282832] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:5:LVDS-1]
[  113.284033] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:5:LVDS-1] probed modes :
[  113.285350] [drm:drm_mode_debug_printmodeline], Modeline 19:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[  113.286844] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:11:VGA-1]
[  113.287992] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[  113.289248] [drm:intel_crt_detect], CRT not detected via hotplug
[  113.290350] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:11:VGA-1] disconnected
[  113.291609] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:14:HDMI-A-1]
[  113.305914] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:14:HDMI-A-1] disconnected
[  113.307124] [drm:drm_mode_debug_printmodeline], Modeline 20:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[  113.308569] [drm:drm_mode_prune_invalid], Not using 1920x1200 mode -3
[  113.309711] [drm:drm_mode_debug_printmodeline], Modeline 21:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[  113.311181] [drm:drm_mode_prune_invalid], Not using 1920x1080 mode -3
[  113.312336] [drm:drm_mode_debug_printmodeline], Modeline 23:"1600x1200" 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
[  113.313840] [drm:drm_mode_prune_invalid], Not using 1600x1200 mode -3
[  113.314979] [drm:drm_mode_debug_printmodeline], Modeline 25:"1680x1050" 60 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6
[  113.316467] [drm:drm_mode_prune_invalid], Not using 1680x1050 mode -3
[  113.317670] [drm:drm_mode_debug_printmodeline], Modeline 30:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
[  113.319171] [drm:drm_mode_prune_invalid], Not using 1280x1024 mode -3
[  113.320404] [drm:drm_mode_debug_printmodeline], Modeline 22:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[  113.321952] [drm:drm_mode_prune_invalid], Not using 1280x1024 mode -3
[  113.323219] [drm:drm_mode_debug_printmodeline], Modeline 24:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[  113.324812] [drm:drm_mode_prune_invalid], Not using 1152x864 mode -3
[  113.326117] [drm:drm_mode_debug_printmodeline], Modeline 31:"1024x768" 75 78800 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[  113.327725] [drm:drm_mode_prune_invalid], Not using 1024x768 mode -3
[  113.329070] [drm:drm_mode_debug_printmodeline], Modeline 32:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[  113.330751] [drm:drm_mode_prune_invalid], Not using 1024x768 mode -3
[  113.332090] [drm:drm_mode_debug_printmodeline], Modeline 33:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[  113.333740] [drm:drm_mode_prune_invalid], Not using 800x600 mode -3
[  113.335142] [drm:drm_mode_debug_printmodeline], Modeline 26:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[  113.336838] [drm:drm_mode_prune_invalid], Not using 800x600 mode -3
[  113.338278] [drm:drm_mode_debug_printmodeline], Modeline 27:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[  113.340029] [drm:drm_mode_prune_invalid], Not using 640x480 mode -3
[  113.341512] [drm:drm_mode_debug_printmodeline], Modeline 28:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[  113.343270] [drm:drm_mode_prune_invalid], Not using 640x480 mode -3
[  113.344826] [drm:drm_mode_debug_printmodeline], Modeline 29:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[  113.346599] [drm:drm_mode_prune_invalid], Not using 720x400 mode -3
[  113.348127] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:17:DP-1]
[  113.350231] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  113.353922] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  113.357911] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  113.361411] [drm:intel_dp_detect], DPCD: 0000000000000000
[  113.362886] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:17:DP-1] disconnected
[  113.364520] [drm:drm_setup_crtcs], 
[  113.365870] [drm:drm_enable_connectors], connector 5 enabled? yes
[  113.367389] [drm:drm_enable_connectors], connector 11 enabled? no
[  113.368887] [drm:drm_enable_connectors], connector 14 enabled? no
[  113.370374] [drm:drm_enable_connectors], connector 17 enabled? no
[  113.371839] [drm:drm_target_preferred], looking for cmdline mode on connector 5
[  113.373386] [drm:drm_target_preferred], looking for preferred mode on connector 5
[  113.374932] [drm:drm_target_preferred], found mode 1366x768
[  113.376339] [drm:drm_setup_crtcs], picking CRTCs for 8192x8192 config
[  113.377839] [drm:drm_setup_crtcs], desired mode 1366x768 set on crtc 3
[  113.379308] [drm:drm_crtc_helper_set_config], 
[  113.380702] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  113.382303] [drm:drm_crtc_helper_set_config], crtc changed, full mode switch
[  113.383896] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  113.385439] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [NOCRTC]
[  113.386976] [drm:drm_crtc_helper_set_config], attempting to set mode from userspace
[  113.388493] [drm:drm_mode_debug_printmodeline], Modeline 8:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[  113.390217] [drm:drm_crtc_helper_set_mode], [CRTC:3]
[  113.396396] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  113.443405] [drm:intel_wait_for_vblank], vblank wait timed out
[  113.480815] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  113.484785] [drm:sandybridge_update_wm], FIFO watermarks For pipe B - plane 9, cursor: 6
[  113.488802] [drm:intel_update_fbc], 
[  113.492322] [drm:intel_update_fbc], more than one pipe active, disabling compression
[  113.496190] [drm:ironlake_crtc_mode_set], using SSC reference clock of 120 MHz
[  113.500171] [drm:intel_choose_pipe_bpp_dither], clamping display bpc (was -1) to LVDS (6)
[  113.504096] [drm:intel_choose_pipe_bpp_dither], setting pipe bpc to 6 (max display bpc 6)
[  113.508173] [drm:ironlake_crtc_mode_set], Mode for pipe A:
[  113.511791] [drm:drm_mode_debug_printmodeline], Modeline 8:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[  113.567366] [drm:intel_wait_for_vblank], vblank wait timed out
[  113.570884] [drm:ironlake_update_plane], Writing base 00063000 00000000 0 0 7680
[  113.574604] [drm:intel_update_fbc], 
[  113.577905] [drm:intel_update_fbc], more than one pipe active, disabling compression
[  113.633352] [drm:intel_wait_for_vblank], vblank wait timed out
[  113.636747] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  113.640395] [drm:sandybridge_update_wm], FIFO watermarks For pipe B - plane 9, cursor: 6
[  113.643938] [drm:drm_crtc_helper_set_mode], [ENCODER:6:LVDS-6] set [MODE:8:1366x768]
[  113.647558] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  113.650960] [drm:sandybridge_update_wm], FIFO watermarks For pipe B - plane 9, cursor: 6
[  113.706321] [drm:intel_wait_for_vblank], vblank wait timed out
[  113.761328] [drm:intel_wait_for_vblank], vblank wait timed out
[  113.765235] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x100
[  113.768408] [drm:gen6_fdi_link_train], FDI train 1 done.
[  113.772027] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x600
[  113.775111] [drm:gen6_fdi_link_train], FDI train 2 done.
[  113.778207] [drm:gen6_fdi_link_train], FDI train done.
[  113.782497] [drm:intel_update_fbc], 
[  113.785266] [drm:intel_update_fbc], more than one pipe active, disabling compression
[  113.788455] [drm:intel_panel_set_backlight], set backlight PWM = 976
[  113.791514] [drm:drm_crtc_helper_set_config], Setting connector DPMS state to on
[  113.794705] [drm:drm_crtc_helper_set_config], 	[CONNECTOR:5:LVDS-1] set DPMS on
[  113.797913] [drm:ironlake_crtc_dpms], crtc 1/1 dpms off
[  113.801097] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  113.804261] [drm:i915_get_vblank_timestamp], crtc 1 is disabled
[  113.820018] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  113.859274] [drm:intel_wait_for_vblank], vblank wait timed out
[  113.888685] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  113.892087] [drm:ironlake_check_srwm], watermark 1: display plane 9, fbc lines 3, cursor 6
[  113.895618] [drm:ironlake_check_srwm], watermark 2: display plane 11, fbc lines 3, cursor 6
[  113.899059] [drm:ironlake_check_srwm], watermark 3: display plane 51, fbc lines 3, cursor 6
[  113.902469] [drm:intel_update_fbc], 
[  113.905488] [drm:intel_update_fbc], framebuffer not tiled or fenced, disabling compression
[  113.908939] [drm:drm_crtc_helper_set_config], 
[  113.912114] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=0 (x y) (0 0)
[  113.915585] [drm:drm_crtc_helper_set_config], crtc has no fb, full mode set
[  113.918859] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  123.296345] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[  123.299742] [drm:intel_crt_detect], CRT not detected via hotplug
[  123.303328] [drm:output_poll_execute], [CONNECTOR:11:VGA-1] status updated from 2 to 2
[  123.451860] [drm:drm_detect_monitor_audio], Monitor has basic audio support
[  123.455327] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[  123.458568] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[  123.458578] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[  123.458589] [drm:output_poll_execute], [CONNECTOR:14:HDMI-A-1] status updated from 2 to 1
[  123.459118] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  123.460707] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  123.462738] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  123.464220] [drm:intel_dp_detect], DPCD: 0000000000000000
[  123.464232] [drm:output_poll_execute], [CONNECTOR:17:DP-1] status updated from 2 to 2
[  123.464299] [drm:drm_fb_helper_hotplug_event], 
[  123.464309] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:5:LVDS-1]
[  123.464353] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:5:LVDS-1] probed modes :
[  123.464364] [drm:drm_mode_debug_printmodeline], Modeline 19:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[  123.464380] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:11:VGA-1]
[  123.464391] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[  123.464401] [drm:intel_crt_detect], CRT not detected via hotplug
[  123.464409] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:11:VGA-1] disconnected
[  123.464420] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:14:HDMI-A-1]
[  123.610041] [drm:drm_detect_monitor_audio], Monitor has basic audio support
[  123.611393] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[  123.612630] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[  123.614128] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[  123.758084] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[  123.759313] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[  123.760850] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[  123.762167] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:14:HDMI-A-1] probed modes :
[  123.763674] [drm:drm_mode_debug_printmodeline], Modeline 21:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[  123.765361] [drm:drm_mode_debug_printmodeline], Modeline 22:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[  123.767045] [drm:drm_mode_debug_printmodeline], Modeline 24:"1600x1200" 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
[  123.768777] [drm:drm_mode_debug_printmodeline], Modeline 26:"1680x1050" 60 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6
[  123.770466] [drm:drm_mode_debug_printmodeline], Modeline 31:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
[  123.772155] [drm:drm_mode_debug_printmodeline], Modeline 23:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[  123.773838] [drm:drm_mode_debug_printmodeline], Modeline 25:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[  123.775552] [drm:drm_mode_debug_printmodeline], Modeline 32:"1024x768" 75 78800 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[  123.777181] [drm:drm_mode_debug_printmodeline], Modeline 33:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[  123.778842] [drm:drm_mode_debug_printmodeline], Modeline 34:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[  123.780550] [drm:drm_mode_debug_printmodeline], Modeline 27:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[  123.782176] [drm:drm_mode_debug_printmodeline], Modeline 28:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[  123.783817] [drm:drm_mode_debug_printmodeline], Modeline 29:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[  123.785511] [drm:drm_mode_debug_printmodeline], Modeline 30:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[  123.787136] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:17:DP-1]
[  123.789114] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  123.792595] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  123.795602] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  123.798103] [drm:intel_dp_detect], DPCD: 0000000000000000
[  123.799427] [drm:drm_helper_probe_single_connector_modes], [CONNECTOR:17:DP-1] disconnected
[  123.800916] [drm:drm_setup_crtcs], 
[  123.802157] [drm:drm_enable_connectors], connector 5 enabled? yes
[  123.803517] [drm:drm_enable_connectors], connector 11 enabled? no
[  123.804844] [drm:drm_enable_connectors], connector 14 enabled? yes
[  123.806225] [drm:drm_enable_connectors], connector 17 enabled? no
[  123.807513] [drm:drm_target_preferred], looking for cmdline mode on connector 5
[  123.808870] [drm:drm_target_preferred], looking for preferred mode on connector 5
[  123.810299] [drm:drm_target_preferred], found mode 1366x768
[  123.811545] [drm:drm_target_preferred], looking for cmdline mode on connector 14
[  123.812929] [drm:drm_target_preferred], looking for preferred mode on connector 14
[  123.814387] [drm:drm_target_preferred], found mode 1920x1200
[  123.815638] [drm:drm_setup_crtcs], picking CRTCs for 8192x8192 config
[  123.816944] [drm:drm_setup_crtcs], desired mode 1366x768 set on crtc 3
[  123.818346] [drm:drm_setup_crtcs], desired mode 1920x1200 set on crtc 4
[  123.819643] [drm:drm_crtc_helper_set_config], 
[  123.820777] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  123.822237] [drm:drm_crtc_helper_set_config], crtc changed, full mode switch
[  123.823543] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  123.824844] [drm:drm_crtc_helper_set_config], attempting to set mode from userspace
[  123.826244] [drm:drm_mode_debug_printmodeline], Modeline 8:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[  123.827781] [drm:drm_crtc_helper_set_mode], [CRTC:3]
[  123.838482] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  123.879104] [drm:intel_wait_for_vblank], vblank wait timed out
[  123.906500] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  123.909938] [drm:ironlake_check_srwm], watermark 1: display plane 9, fbc lines 3, cursor 6
[  123.913490] [drm:ironlake_check_srwm], watermark 2: display plane 11, fbc lines 3, cursor 6
[  123.916814] [drm:ironlake_check_srwm], watermark 3: display plane 51, fbc lines 3, cursor 6
[  123.920342] [drm:intel_update_fbc], 
[  123.923202] [drm:intel_update_fbc], framebuffer not tiled or fenced, disabling compression
[  123.926518] [drm:ironlake_crtc_mode_set], using SSC reference clock of 120 MHz
[  123.929849] [drm:intel_choose_pipe_bpp_dither], clamping display bpc (was -1) to LVDS (6)
[  123.933207] [drm:intel_choose_pipe_bpp_dither], setting pipe bpc to 6 (max display bpc 6)
[  123.936715] [drm:ironlake_crtc_mode_set], Mode for pipe A:
[  123.939976] [drm:drm_mode_debug_printmodeline], Modeline 8:"1366x768" 60 71000 1366 1414 1446 1502 768 771 776 788 0x48 0xa
[  123.996051] [drm:intel_wait_for_vblank], vblank wait timed out
[  123.999230] [drm:ironlake_update_plane], Writing base 00063000 00000000 0 0 7680
[  124.002608] [drm:intel_update_fbc], 
[  124.005667] [drm:intel_update_fbc], framebuffer not tiled or fenced, disabling compression
[  124.061030] [drm:intel_wait_for_vblank], vblank wait timed out
[  124.064240] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  124.067714] [drm:ironlake_check_srwm], watermark 1: display plane 9, fbc lines 3, cursor 6
[  124.071238] [drm:ironlake_check_srwm], watermark 2: display plane 11, fbc lines 3, cursor 6
[  124.074636] [drm:ironlake_check_srwm], watermark 3: display plane 51, fbc lines 3, cursor 6
[  124.078032] [drm:drm_crtc_helper_set_mode], [ENCODER:6:LVDS-6] set [MODE:8:1366x768]
[  124.081305] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  124.084992] [drm:ironlake_check_srwm], watermark 1: display plane 9, fbc lines 3, cursor 6
[  124.088431] [drm:ironlake_check_srwm], watermark 2: display plane 11, fbc lines 3, cursor 6
[  124.091902] [drm:ironlake_check_srwm], watermark 3: display plane 51, fbc lines 3, cursor 6
[  124.147002] [drm:intel_wait_for_vblank], vblank wait timed out
[  124.201991] [drm:intel_wait_for_vblank], vblank wait timed out
[  124.205982] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x100
[  124.209131] [drm:gen6_fdi_link_train], FDI train 1 done.
[  124.213000] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x600
[  124.216102] [drm:gen6_fdi_link_train], FDI train 2 done.
[  124.219265] [drm:gen6_fdi_link_train], FDI train done.
[  124.223601] [drm:intel_update_fbc], 
[  124.226629] [drm:intel_update_fbc], framebuffer not tiled or fenced, disabling compression
[  124.230398] [drm:intel_panel_set_backlight], set backlight PWM = 976
[  124.233727] [drm:drm_crtc_helper_set_config], Setting connector DPMS state to on
[  124.237124] [drm:drm_crtc_helper_set_config], 	[CONNECTOR:5:LVDS-1] set DPMS on
[  124.240479] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  124.243881] [drm:drm_crtc_helper_set_config], 
[  124.247096] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  124.250483] [drm:drm_crtc_helper_set_config], crtc has no fb, full mode set
[  124.253817] [drm:drm_crtc_helper_set_config], encoder changed, full mode switch
[  124.257200] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  124.257208] [drm:drm_crtc_helper_set_config], crtc changed, full mode switch
[  124.257214] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  124.257221] [drm:drm_crtc_helper_set_config], attempting to set mode from userspace
[  124.257228] [drm:drm_mode_debug_printmodeline], Modeline 35:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[  124.257251] [drm:drm_crtc_helper_set_mode], [CRTC:4]
[  124.257336] [drm:intel_choose_pipe_bpp_dither], clamping display bpc (was -1) to EDID reported max of 0
[  124.257345] [drm:intel_choose_pipe_bpp_dither], forcing bpc to 8 for HDMI
[  124.257352] [drm:intel_choose_pipe_bpp_dither], setting pipe bpc to 8 (max display bpc 8)
[  124.257564] [drm:ironlake_crtc_mode_set], Mode for pipe B:
[  124.257569] [drm:drm_mode_debug_printmodeline], Modeline 35:"1920x1200" 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x48 0x9
[  124.309957] [drm:intel_wait_for_vblank], vblank wait timed out
[  124.313283] [drm:ironlake_update_plane], Writing base 00063000 00000000 0 0 7680
[  124.316805] [drm:intel_update_fbc], 
[  124.319996] [drm:intel_update_fbc], more than one pipe active, disabling compression
[  124.323442] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  124.326929] [drm:sandybridge_update_wm], FIFO watermarks For pipe B - plane 9, cursor: 6
[  124.330322] [drm:drm_crtc_helper_set_mode], [ENCODER:13:TMDS-13] set [MODE:35:1920x1200]
[  124.384927] [drm:intel_wait_for_vblank], vblank wait timed out
[  124.388145] [drm:intel_write_eld], ELD on [CONNECTOR:14:HDMI-A-1], [ENCODER:13:TMDS-13]
[  124.391596] [drm:ironlake_write_eld], ELD on pipe B
[  124.394889] [drm:ironlake_write_eld], Audio directed to unknown port
[  124.398090] [drm:ironlake_write_eld], ELD size 9
[  124.401188] [drm:sandybridge_update_wm], FIFO watermarks For pipe A - plane 6, cursor: 6
[  124.404555] [drm:sandybridge_update_wm], FIFO watermarks For pipe B - plane 9, cursor: 6
[  124.459909] [drm:intel_wait_for_vblank], vblank wait timed out
[  124.514886] [drm:intel_wait_for_vblank], vblank wait timed out
[  124.518844] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x100
[  124.521880] [drm:gen6_fdi_link_train], FDI train 1 done.
[  124.525628] [drm:gen6_fdi_link_train], FDI_RX_IIR 0x600
[  124.528756] [drm:gen6_fdi_link_train], FDI train 2 done.
[  124.531743] [drm:gen6_fdi_link_train], FDI train done.
[  124.536023] [drm:intel_update_fbc], 
[  124.538843] [drm:intel_update_fbc], more than one pipe active, disabling compression
[  124.542118] [drm:drm_crtc_helper_set_config], Setting connector DPMS state to on
[  124.545366] [drm:drm_crtc_helper_set_config], 	[CONNECTOR:14:HDMI-A-1] set DPMS on
[  124.552699] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  133.469191] [drm:intel_ironlake_crt_detect_hotplug], ironlake hotplug adpa=0xf40000, result 0
[  133.472174] [drm:intel_crt_detect], CRT not detected via hotplug
[  133.475184] [drm:output_poll_execute], [CONNECTOR:11:VGA-1] status updated from 2 to 2
[  133.623423] [drm:drm_detect_monitor_audio], Monitor has basic audio support
[  133.626291] [drm:drm_edid_to_eld], ELD monitor DELL 2709W
[  133.629083] HDMI: DVI dual 0, max TMDS clock 190, latency present 1 0, video latency 11 0, audio latency 0 2
[  133.632207] [drm:drm_edid_to_eld], ELD size 9, SAD count 1
[  133.634940] [drm:output_poll_execute], [CONNECTOR:14:HDMI-A-1] status updated from 1 to 1
[  133.638471] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  133.643464] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  133.646486] [drm:intel_dp_aux_ch], dp_aux_ch timeout status 0x5143003e
[  133.648956] [drm:intel_dp_detect], DPCD: 0000000000000000
[  133.650611] [drm:output_poll_execute], [CONNECTOR:17:DP-1] status updated from 2 to 2
[  152.206362] [drm:drm_crtc_helper_set_config], 
[  152.206365] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  152.206381] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  152.206384] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  152.206387] [drm:drm_crtc_helper_set_config], 
[  152.206389] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  152.206402] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  152.206404] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  152.634552] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  152.642375] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  152.668010] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  152.718204] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  153.644863] xkbcomp used greatest stack depth: 3280 bytes left
[  163.009145] scim-helper-man used greatest stack depth: 3232 bytes left
[  183.092322] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  183.092749] [drm:intel_prepare_page_flip], preparing flip with no unpin work?
[  183.156863] mtrr: no MTRR for b0000000,3ff0000 found
[  183.161744] [drm:drm_crtc_helper_set_config], 
[  183.161747] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  183.161757] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.161759] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  183.161762] [drm:drm_crtc_helper_set_config], 
[  183.161763] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  183.161770] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.161772] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  183.161774] [drm:drm_crtc_helper_set_config], 
[  183.161775] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  183.161782] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.161784] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  183.161786] [drm:drm_crtc_helper_set_config], 
[  183.161787] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  183.161793] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.161795] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  183.161805] [drm:drm_crtc_helper_set_config], 
[  183.161806] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  183.161813] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.161815] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  183.161817] [drm:drm_crtc_helper_set_config], 
[  183.161818] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  183.161824] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.161826] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  183.174248] [drm:drm_crtc_helper_set_config], 
[  183.174249] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  183.174257] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.174259] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  183.174261] [drm:drm_crtc_helper_set_config], 
[  183.174262] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  183.174269] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  183.174270] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  194.832240] [drm:drm_crtc_helper_set_config], 
[  194.832247] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  194.832280] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  194.832288] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  194.832296] [drm:drm_crtc_helper_set_config], 
[  194.832300] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  194.832325] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  194.832332] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  196.113864] [drm:drm_crtc_helper_set_config], 
[  196.113871] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  196.113902] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  196.113909] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  196.113917] [drm:drm_crtc_helper_set_config], 
[  196.113922] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  196.113947] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  196.113953] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  197.699508] [drm:drm_crtc_helper_set_config], 
[  197.699516] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  197.699547] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  197.699592] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  197.699600] [drm:drm_crtc_helper_set_config], 
[  197.699604] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  197.699631] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  197.699637] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  198.603538] [drm:drm_crtc_helper_set_config], 
[  198.603546] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  198.603577] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  198.603584] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  198.603592] [drm:drm_crtc_helper_set_config], 
[  198.603596] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  198.603621] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  198.603627] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  199.503617] [drm:drm_crtc_helper_set_config], 
[  199.503624] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  199.503655] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  199.503662] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  199.503670] [drm:drm_crtc_helper_set_config], 
[  199.503675] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  199.503700] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  199.503706] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  200.047235] [drm:drm_crtc_helper_set_config], 
[  200.047244] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  200.047275] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  200.047282] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  200.047290] [drm:drm_crtc_helper_set_config], 
[  200.047294] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  200.047318] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  200.047325] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  200.784212] [drm:drm_crtc_helper_set_config], 
[  200.784220] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  200.784251] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  200.784258] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  200.784266] [drm:drm_crtc_helper_set_config], 
[  200.784270] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  200.784295] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  200.784302] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  201.050971] [drm:drm_crtc_helper_set_config], 
[  201.050978] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  201.051010] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  201.051017] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  201.051025] [drm:drm_crtc_helper_set_config], 
[  201.051028] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  201.051053] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  201.051060] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  202.047692] [drm:drm_crtc_helper_set_config], 
[  202.047700] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  202.047731] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  202.047738] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  202.047747] [drm:drm_crtc_helper_set_config], 
[  202.047751] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  202.047776] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  202.047782] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  202.306429] [drm:drm_crtc_helper_set_config], 
[  202.306436] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  202.306467] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  202.306475] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  202.306483] [drm:drm_crtc_helper_set_config], 
[  202.306487] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  202.306512] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  202.306518] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  205.619663] [drm:drm_crtc_helper_set_config], 
[  205.619671] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  205.619701] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  205.619709] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  205.619717] [drm:drm_crtc_helper_set_config], 
[  205.619721] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  205.619746] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  205.619753] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  206.094854] [drm:drm_crtc_helper_set_config], 
[  206.094861] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  206.094934] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  206.094941] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  206.094950] [drm:drm_crtc_helper_set_config], 
[  206.094953] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  206.094979] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  206.094985] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  206.675754] [drm:drm_crtc_helper_set_config], 
[  206.675762] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  206.675793] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  206.675801] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  206.675809] [drm:drm_crtc_helper_set_config], 
[  206.675813] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  206.675837] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  206.675844] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  226.736390] [drm:drm_crtc_helper_set_config], 
[  226.736397] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  226.736428] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  226.736436] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  226.736444] [drm:drm_crtc_helper_set_config], 
[  226.736448] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  226.736473] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  226.736479] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.013270] [drm:drm_crtc_helper_set_config], 
[  227.013277] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  227.013308] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.013316] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.013324] [drm:drm_crtc_helper_set_config], 
[  227.013328] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  227.013353] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.013359] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.273994] [drm:drm_crtc_helper_set_config], 
[  227.274001] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  227.274032] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.274039] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.274048] [drm:drm_crtc_helper_set_config], 
[  227.274051] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  227.274076] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.274083] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.671660] [drm:drm_crtc_helper_set_config], 
[  227.671667] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  227.671698] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.671706] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.671714] [drm:drm_crtc_helper_set_config], 
[  227.671718] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  227.671743] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.671749] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.934396] [drm:drm_crtc_helper_set_config], 
[  227.934404] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  227.934435] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.934442] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  227.934451] [drm:drm_crtc_helper_set_config], 
[  227.934455] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  227.934480] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  227.934487] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  228.282735] [drm:drm_crtc_helper_set_config], 
[  228.282743] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  228.282773] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  228.282781] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  228.282789] [drm:drm_crtc_helper_set_config], 
[  228.282793] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  228.282818] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  228.282824] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  228.530427] [drm:drm_crtc_helper_set_config], 
[  228.530435] [drm:drm_crtc_helper_set_config], [CRTC:3] [FB:36] #connectors=1 (x y) (0 0)
[  228.530466] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  228.530473] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]
[  228.530481] [drm:drm_crtc_helper_set_config], 
[  228.530485] [drm:drm_crtc_helper_set_config], [CRTC:4] [FB:36] #connectors=1 (x y) (0 0)
[  228.530510] [drm:drm_crtc_helper_set_config], [CONNECTOR:5:LVDS-1] to [CRTC:3]
[  228.530517] [drm:drm_crtc_helper_set_config], [CONNECTOR:14:HDMI-A-1] to [CRTC:4]

--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--huq684BweRXVnRxX--
