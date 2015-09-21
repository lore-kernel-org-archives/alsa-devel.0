From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 2/5] drm: add helper functions to add bridge
	audio capabilities
Date: Mon, 21 Sep 2015 15:19:53 +0200
Message-ID: <1442841596-1323-3-git-send-email-arnaud.pouliquen@st.com>
References: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 2734F2612DF
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 15:21:18 +0200 (CEST)
In-Reply-To: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: moinejf@free.fr, linux@arm.linux.org.uk, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, airlied@linux.ie, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

Extend bridge capabilities for audio to enable to connect an audio driver to a
DRM driver with audio capabilities

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/gpu/drm/drm_bridge.c | 114 +++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc.h       |  31 ++++++++++++
 include/linux/hdmi.h         |  16 ++++++
 3 files changed, 161 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6b8f721..2284ac9 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -328,6 +328,120 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+/**
+ * DOC: audio bridge callbacks
+ *
+ * The drm_audio_bridge_funcs ops are populated by the bridge driver that have
+ * audio capabilities (a.e HDMI)
+ * The drm internals(atomic and crtc helpers) use the helpers defined in
+ * drm_bridge.c
+ * These helpers call a specific drm_audio_bridge_funcs ops for all the bridges
+ * during encoder configuration.
+ *
+ * When creating a bridge driver, one can implement drm_audio_bridge_funcs op
+ * with the help of these rough rules:
+ *
+ * pre_enable: this contains things needed to be done for the bridge before
+ * audio is enabled by its source.
+ *
+ * enable: this contains things needed to be done for the audio bridge once its
+ * source is enabled. In other words, enable is called once the source is
+ * ready to start stream rendering.
+ *
+ * disable: this contains things needed to be done for audio bridge when to
+ * disable the audio part for the bridge, assuming that its source is still
+ * enabled.
+ *
+ * post_disable: this contains things needed to be done for the bridge once
+ * its source is disabled.
+ *
+ * mode_set: this sets up the mode for the audio bridge. It assumes that its
+ * source (an encoder or a bridge) has set the mode too.
+ */
+
+/**
+ * drm_audio_bridge_pre_enable - calls 'pre_enable' drm_audio_bridge_funcs ops
+ *                               for audio bridges in the encoder chain.
+ * @bridge: bridge control structure
+ *
+ * Calls 'pre_enable' drm_audio_bridge_funcs op for  audio bridge in the
+ * encoder chain.
+ *
+ */
+
+void drm_audio_bridge_pre_enable(struct drm_bridge *bridge)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->audio_funcs->pre_enable)
+		bridge->audio_funcs->pre_enable(bridge);
+}
+EXPORT_SYMBOL(drm_audio_bridge_pre_enable);
+
+/**
+ * drm_audio_bridge_disable - calls 'disable' drm_audio_bridge_funcs op for
+ *                            audio bridge in the encoder chain.
+ * @bridge: bridge control structure
+ *
+ * Calls 'disable' drm_audio_bridge_funcs op for bridges with audio in the
+ * encoder chain.
+ *
+ */
+void drm_audio_bridge_disable(struct drm_bridge *bridge)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->audio_funcs->disable)
+		bridge->audio_funcs->disable(bridge);
+}
+EXPORT_SYMBOL(drm_audio_bridge_disable);
+
+/**
+ * drm_audio_bridge_mode_set - set audio mode for audio bridge in the
+ *			 encoder chain
+ * @bridge: bridge control structure
+ * @mode: desired audio mode to be set for the audio bridge
+ *
+ * Calls 'mode_set' drm_audio_bridge_funcs op for audio bridge in the
+ * encoder chain.
+ *
+ */
+void drm_audio_bridge_mode_set(struct drm_bridge *bridge,
+			       struct hdmi_audio_mode *mode)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->audio_funcs->mode_set)
+		bridge->audio_funcs->mode_set(bridge, mode);
+}
+EXPORT_SYMBOL(drm_audio_bridge_mode_set);
+
+/**
+ * drm_audio_bridge_enable - calls 'enable' drm_audio_bridge_funcs op for all bridges
+ *		       in the encoder chain.
+ * @bridge: bridge control structure
+ *
+ * Calls 'enable' drm_audio_bridge_funcs op for all the bridges in the encoder
+ * chain, starting from the first bridge to the last. These are called
+ * after completing the encoder's commit op.
+ *
+ * Note that the bridge passed should be the one closest to the encoder
+ */
+void drm_audio_bridge_enable(struct drm_bridge *bridge)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->audio_funcs->mode_set)
+		bridge->audio_funcs->enable(bridge);
+
+}
+EXPORT_SYMBOL(drm_audio_bridge_enable);
+
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 3b4d8a4..5074019 100644
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
@@ -905,6 +907,24 @@ struct drm_bridge_funcs {
 };
 
 /**
+ * struct drm_audio_bridge_funcs - audio drm_bridge control functions
+ * @attach: Called during drm_audio_bridge_attach
+ * @mode_fixup: Try to fixup (or reject entirely) proposed mode for this bridge
+ * @disable: Called right before encoder prepare, disables the bridge
+ * @post_disable: Called right after encoder prepare, for lockstepped disable
+ * @mode_set: Set this mode to the bridge
+ * @pre_enable: Called right before encoder commit, for lockstepped commit
+ * @enable: Called right after encoder commit, enables the bridge
+ */
+struct drm_audio_bridge_funcs {
+	void (*disable)(struct drm_bridge *bridge);
+	void (*pre_enable)(struct drm_bridge *bridge);
+	void (*enable)(struct drm_bridge *bridge);
+	int (*mode_set)(struct drm_bridge *bridge,
+			struct hdmi_audio_mode *mode);
+};
+
+/**
  * struct drm_bridge - central DRM bridge control structure
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
@@ -925,7 +945,9 @@ struct drm_bridge {
 	struct list_head list;
 
 	const struct drm_bridge_funcs *funcs;
+	const struct drm_audio_bridge_funcs *audio_funcs;
 	void *driver_private;
+	void *snd_private;
 };
 
 /**
@@ -1271,6 +1293,15 @@ extern int drm_encoder_init(struct drm_device *dev,
 			    const struct drm_encoder_funcs *funcs,
 			    int encoder_type);
 
+int drm_audio_bridge_attach(struct drm_device *dev,
+			     struct drm_bridge *bridge);
+void drm_audio_bridge_disable(struct drm_bridge *bridge);
+void drm_audio_bridge_mode_set(struct drm_bridge *bridge,
+			       struct hdmi_audio_mode *mode);
+void drm_audio_bridge_pre_enable(struct drm_bridge *bridge);
+void drm_audio_bridge_enable(struct drm_bridge *bridge);
+
+
 /**
  * drm_encoder_crtc_ok - can a given crtc drive a given encoder?
  * @encoder: encoder to test
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 32107a0..d3d1a80 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -333,11 +333,27 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer);
 void hdmi_infoframe_log(const char *level, struct device *dev,
 			union hdmi_infoframe *frame);
 
+/**
+ * struct hdmi_audio_n_cts - n and cts parameter for ACR packets
+ */
 struct hdmi_audio_n_cts {
 	unsigned int n;
 	unsigned int cts;
 };
 
+/**
+ * struct hdmi_audio_mode - hdmi audio structure for audio configuration
+ * @enabled audio state
+ * @infoframe: audio infoframe info frame
+ * @data: private data use by alsa driver to retrieve context
+ *
+ * This is used by audio driver to configure the HDMI audio part
+ */
+struct hdmi_audio_mode {
+	bool enabled;
+	struct hdmi_audio_infoframe infoframe;
+};
+
 int hdmi_audio_compute_n_cts(unsigned int audio_fs, unsigned long pixel_clk,
 			     struct hdmi_audio_n_cts *n_cts);
 
-- 
1.9.1
