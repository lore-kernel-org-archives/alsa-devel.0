From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH RFC V2 2/5] drm: add helper functions to add
	audio capabilities for bridge
Date: Thu, 1 Oct 2015 18:50:18 +0200
Message-ID: <1443718221-5120-3-git-send-email-arnaud.pouliquen@st.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D43702667E4
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 18:51:01 +0200 (CEST)
In-Reply-To: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: moinejf@free.fr, linux@arm.linux.org.uk, bcousson@baylibre.com, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Extend bridge capabilities for audio to enable to connect an audio driver to a
DRM driver with audio capabilities

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/gpu/drm/drm_bridge.c | 137 ++++++++++++++++++++++++++++++++++++++++++-
 include/drm/drm_crtc.h       |  62 ++++++++++++++++++++
 include/drm/drm_modes.h      |  12 ++++
 3 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6b8f721..d1a437e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -194,7 +194,7 @@ EXPORT_SYMBOL(drm_bridge_mode_fixup);
  * chain, starting from the last bridge to the first. These are called before
  * calling the encoder's prepare op.
  *
- * Note: the bridge passed should be the one closest to the encoder
+ * Note: the bridge passed should be the othingsne closest to the encoder
  */
 void drm_bridge_disable(struct drm_bridge *bridge)
 {
@@ -328,6 +328,141 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+/**
+ * DOC: audio bridge callbacks
+ *
+ * The drm_audio_bridge_funcs ops are populated by the bridge driver that has
+ * audio capabilities (e.g. HDMI)
+ * The alsa driver (or asoc codec) uses the defined helpers.
+ * These helpers call a specific drm_audio_bridge_funcs ops defined by
+ * bridges with audio capabilities during encoder configuration.
+ *
+ * pre_enable: this contains actions needed to be done by the bridge before
+ * audio is enabled by its source.
+ *
+ * enable: this contains actions needed to be done by the audio bridge once its
+ * source is enabled. In other words, enable is called once the source is
+ * ready to start stream rendering.
+ *
+ * disable: this contains actions needed to be done by audio bridge when
+ * disable the audio part, assuming that its source is still enabled.
+ *
+ * post_disable: this contains actions needed to be done by the bridge once
+ * its source is disabled.
+ *
+ * mode_set: this sets up the mode by the audio bridge. It assumes that its
+ * audio source is aligned on this mode.
+ *
+ * mode_get: this get the supported modes based on ELD table. this can be use
+ * by audio source to fix audio constraints according to mode.
+ */
+
+/**
+ * drm_audio_bridge_pre_enable - calls 'pre_enable' drm_audio_bridge_funcs op
+ * for audio bridge in the encoder chain.
+ * @bridge: bridge control structure
+ */
+int drm_audio_bridge_pre_enable(struct drm_bridge *bridge,
+				 struct drm_audio_bridge_cfg *cfg)
+{
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->audio_funcs->pre_enable)
+		return bridge->audio_funcs->pre_enable(bridge, cfg);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_audio_bridge_pre_enable);
+
+/**
+ * drm_audio_bridge_disable - calls 'disable' drm_audio_bridge_funcs op
+ * for audio bridge in the encoder chain.
+ * @bridge: bridge control structure
+ */
+int drm_audio_bridge_disable(struct drm_bridge *bridge)
+{
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->audio_funcs->disable)
+		return bridge->audio_funcs->disable(bridge);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_audio_bridge_disable);
+
+/**
+ * drm_audio_bridge_enable - calls 'enable' drm_audio_bridge_funcs audio
+ * bridge in the encoder chain.
+ * @bridge: bridge control structure
+ */
+int drm_audio_bridge_enable(struct drm_bridge *bridge)
+{
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->audio_funcs->enable)
+		return bridge->audio_funcs->enable(bridge);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_audio_bridge_enable);
+
+/**
+ * drm_audio_bridge_post_disable - calls 'disable' drm_audio_bridge_funcs op
+ * for audio bridge in the encoder chain.
+ * @bridge: bridge control structure
+ */
+int drm_audio_bridge_post_disable(struct drm_bridge *bridge)
+{
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->audio_funcs->post_disable)
+		return bridge->audio_funcs->post_disable(bridge);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_audio_bridge_post_disable);
+
+/**
+ * drm_audio_bridge_mode_set - calls 'mode_set' drm_audio_bridge_funcs op
+ * for audio bridge in the encoder chain.
+ * @bridge: bridge control structure
+ * @mode: desired audio mode to be set for the audio bridge
+ */
+int drm_audio_bridge_mode_set(struct drm_bridge *bridge,
+			       struct hdmi_audio_mode *mode)
+{
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->audio_funcs->mode_set)
+		return bridge->audio_funcs->mode_set(bridge, mode);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_audio_bridge_mode_set);
+
+/**
+ * drm_audio_bridge_mode_get - calls 'enable'drm_audio_bridge_funcs op
+ * for audio bridge in the encoder chain.
+ * @bridge: bridge control structure
+ * Note: The returned pointer needs to be freed using kfree().
+ */
+uint8_t *drm_audio_bridge_mode_get(struct drm_bridge *bridge)
+{
+	if (!bridge)
+		return NULL;
+
+	if (bridge->audio_funcs->mode_get)
+		return bridge->audio_funcs->mode_get(bridge);
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_audio_bridge_mode_get);
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 3b4d8a4..f13626a 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -583,6 +583,7 @@ struct drm_encoder_funcs {
  * @possible_clones: bitmask of potential sibling encoders for cloning
  * @crtc: currently bound CRTC
  * @bridge: bridge associated to the encoder
+ * @abridge: optional audio bridge associated to the encoder (HDMI)
  * @funcs: control functions
  * @helper_private: mid-layer private data
  *
@@ -601,6 +602,7 @@ struct drm_encoder {
 
 	struct drm_crtc *crtc;
 	struct drm_bridge *bridge;
+	struct drm_bridge *abridge;
 	const struct drm_encoder_funcs *funcs;
 	const void *helper_private;
 };
@@ -905,6 +907,56 @@ struct drm_bridge_funcs {
 };
 
 /**
+ * struct drm_audio_bridge_cfg - audio interface configuration
+ * @fmt: bus format
+ * @sample_rate: sampling frequency
+ * @sample_width: sample size
+ * @channels: number of channels
+ * @frame_clk_master: frame synchro master
+ * @frame_clk_inv: frame clock inverted
+ * @bit_clk_master: bit clock master
+ * @bit_clk_inv: bit clock inverted
+ */
+struct drm_audio_bridge_cfg {
+	enum {
+		HDMI_I2S,
+		HDMI_RIGHT_J,
+		HDMI_LEFT_J,
+		HDMI_DSP_A,
+		HDMI_DSP_B,
+		HDMI_AC97,
+		HDMI_SPDIF,
+	} fmt;
+	int sample_rate;
+	int sample_width;
+	int channels;
+	int frame_clk_master:1;
+	int frame_clk_inv:1;
+	int bit_clk_master:1;
+	int bit_clk_inv:1;
+};
+
+/**
+ * struct drm_audio_bridge_funcs - audio drm_bridge control functions
+ * @disable: Called to disable the audio bridge
+ * @post_disable: Called for post disable actions
+ * @pre_enable: Called to configure the audio bridge
+ * @enable: Called to enable the audio bridge
+ * @mode_set: Set the audio bridge mode
+ * @mode_get: Get ELD buffer for audio mode supported.
+ */
+struct drm_audio_bridge_funcs {
+	int (*disable)(struct drm_bridge *bridge);
+	int (*post_disable)(struct drm_bridge *bridge);
+	int (*pre_enable)(struct drm_bridge *bridge,
+			   struct drm_audio_bridge_cfg *cfg);
+	int (*enable)(struct drm_bridge *bridge);
+	int  (*mode_set)(struct drm_bridge *bridge,
+			 struct hdmi_audio_mode *mode);
+	uint8_t *(*mode_get)(struct drm_bridge *bridge);
+};
+
+/**
  * struct drm_bridge - central DRM bridge control structure
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
@@ -925,6 +977,7 @@ struct drm_bridge {
 	struct list_head list;
 
 	const struct drm_bridge_funcs *funcs;
+	const struct drm_audio_bridge_funcs *audio_funcs;
 	void *driver_private;
 };
 
@@ -1266,6 +1319,15 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
 void drm_bridge_pre_enable(struct drm_bridge *bridge);
 void drm_bridge_enable(struct drm_bridge *bridge);
 
+int drm_audio_bridge_pre_enable(struct drm_bridge *bridge,
+				struct drm_audio_bridge_cfg *cfg);
+int drm_audio_bridge_enable(struct drm_bridge *bridge);
+int drm_audio_bridge_disable(struct drm_bridge *bridge);
+int drm_audio_bridge_post_disable(struct drm_bridge *bridge);
+int drm_audio_bridge_mode_set(struct drm_bridge *bridge,
+			       struct hdmi_audio_mode *mode);
+uint8_t *drm_audio_bridge_mode_get(struct drm_bridge *bridge);
+
 extern int drm_encoder_init(struct drm_device *dev,
 			    struct drm_encoder *encoder,
 			    const struct drm_encoder_funcs *funcs,
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index 08a8cac..e923e32 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -164,6 +164,18 @@ struct drm_cmdline_mode {
 	enum drm_connector_force force;
 };
 
+/*
+ * struct hdmi_audio_mode - hdmi audio structure for audio configuration
+ * @infoframe: audio info frame
+ * @iec_status: iec60958 channel status bytes
+ *
+ * This is used by audio driver to configure the HDMI audio part
+ */
+struct hdmi_audio_mode {
+	struct hdmi_audio_infoframe infoframe;
+	unsigned char iec_status[24];
+};
+
 /**
  * drm_mode_is_stereo - check for stereo mode flags
  * @mode: drm_display_mode to check
-- 
1.9.1
