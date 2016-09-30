From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] drm: sti: allow audio playback on HDMI even if
	disabled.
Date: Fri, 30 Sep 2016 17:17:00 +0200
Message-ID: <1475248620-28996-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id B26942665DC
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 17:17:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dri-devel@lists.freedesktop.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Vincent ABRIOU <vincent.abriou@st.com>
List-Id: alsa-devel@alsa-project.org

This fix allows to play audio while HDMI is disconnected.
When HDMI is disable, audio configuration is stored and samples
are dropped (by HDMI IP).
When HDMI is enabled, audio HDMI configuration is applied and samples
are outputted on HDMI wire.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 205 ++++++++++++++++++++---------------------
 1 file changed, 101 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 376b076..9c0025e 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -788,6 +788,95 @@ static void sti_hdmi_disable(struct drm_bridge *bridge)
 	hdmi->enabled = false;
 }
 
+/**
+ * sti_hdmi_audio_get_non_coherent_n() - get N parameter for non-coherent
+ * clocks. None-coherent clocks means that audio and TMDS clocks have not the
+ * same source (drifts between clocks). In this case assumption is that CTS is
+ * automatically calculated by hardware.
+ *
+ * @audio_fs: audio frame clock frequency in Hz
+ *
+ * Values computed are based on table described in HDMI specification 1.4b
+ *
+ * Returns n value.
+ */
+static int sti_hdmi_audio_get_non_coherent_n(unsigned int audio_fs)
+{
+	unsigned int n;
+
+	switch (audio_fs) {
+	case 32000:
+		n = 4096;
+		break;
+	case 44100:
+		n = 6272;
+		break;
+	case 48000:
+		n = 6144;
+		break;
+	case 88200:
+		n = 6272 * 2;
+		break;
+	case 96000:
+		n = 6144 * 2;
+		break;
+	case 176400:
+		n = 6272 * 4;
+		break;
+	case 192000:
+		n = 6144 * 4;
+		break;
+	default:
+		/* Not pre-defined, recommended value: 128 * fs / 1000 */
+		n = (audio_fs * 128) / 1000;
+	}
+
+	return n;
+}
+
+static int hdmi_audio_configure(struct sti_hdmi *hdmi)
+{
+	int audio_cfg, n;
+	struct hdmi_audio_params *params = &hdmi->audio;
+	struct hdmi_audio_infoframe *info = &params->cea;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	if (!hdmi->enabled)
+		return 0;
+
+	/* update N parameter */
+	n = sti_hdmi_audio_get_non_coherent_n(params->sample_rate);
+
+	DRM_DEBUG_DRIVER("Audio rate = %d Hz, TMDS clock = %d Hz, n = %d\n",
+			 params->sample_rate, hdmi->mode.clock * 1000, n);
+	hdmi_write(hdmi, n, HDMI_AUDN);
+
+	/* update HDMI registers according to configuration */
+	audio_cfg = HDMI_AUD_CFG_SPDIF_DIV_2 | HDMI_AUD_CFG_DTS_INVALID |
+		    HDMI_AUD_CFG_ONE_BIT_INVALID;
+
+	switch (info->channels) {
+	case 8:
+		audio_cfg |= HDMI_AUD_CFG_CH78_VALID;
+	case 6:
+		audio_cfg |= HDMI_AUD_CFG_CH56_VALID;
+	case 4:
+		audio_cfg |= HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
+	case 2:
+		audio_cfg |= HDMI_AUD_CFG_CH12_VALID;
+		break;
+	default:
+		DRM_ERROR("ERROR: Unsupported number of channels (%d)!\n",
+			  info->channels);
+		return -EINVAL;
+	}
+
+	hdmi_write(hdmi, audio_cfg, HDMI_AUDIO_CFG);
+
+	return hdmi_audio_infoframe_config(hdmi);
+}
+
 static void sti_hdmi_pre_enable(struct drm_bridge *bridge)
 {
 	struct sti_hdmi *hdmi = bridge->driver_private;
@@ -826,9 +915,12 @@ static void sti_hdmi_pre_enable(struct drm_bridge *bridge)
 	if (hdmi_avi_infoframe_config(hdmi))
 		DRM_ERROR("Unable to configure AVI infoframe\n");
 
-	/* Program AUDIO infoframe */
-	if (hdmi_audio_infoframe_config(hdmi))
-		DRM_ERROR("Unable to configure AUDIO infoframe\n");
+	if (hdmi->audio.enabled) {
+		if (hdmi_audio_configure(hdmi))
+			DRM_ERROR("Unable to configure audio\n");
+	} else {
+		hdmi_audio_infoframe_config(hdmi);
+	}
 
 	/* Program VS infoframe */
 	if (hdmi_vendor_infoframe_config(hdmi))
@@ -1078,97 +1170,6 @@ static struct drm_encoder *sti_hdmi_find_encoder(struct drm_device *dev)
 	return NULL;
 }
 
-/**
- * sti_hdmi_audio_get_non_coherent_n() - get N parameter for non-coherent
- * clocks. None-coherent clocks means that audio and TMDS clocks have not the
- * same source (drifts between clocks). In this case assumption is that CTS is
- * automatically calculated by hardware.
- *
- * @audio_fs: audio frame clock frequency in Hz
- *
- * Values computed are based on table described in HDMI specification 1.4b
- *
- * Returns n value.
- */
-static int sti_hdmi_audio_get_non_coherent_n(unsigned int audio_fs)
-{
-	unsigned int n;
-
-	switch (audio_fs) {
-	case 32000:
-		n = 4096;
-		break;
-	case 44100:
-		n = 6272;
-		break;
-	case 48000:
-		n = 6144;
-		break;
-	case 88200:
-		n = 6272 * 2;
-		break;
-	case 96000:
-		n = 6144 * 2;
-		break;
-	case 176400:
-		n = 6272 * 4;
-		break;
-	case 192000:
-		n = 6144 * 4;
-		break;
-	default:
-		/* Not pre-defined, recommended value: 128 * fs / 1000 */
-		n = (audio_fs * 128) / 1000;
-	}
-
-	return n;
-}
-
-static int hdmi_audio_configure(struct sti_hdmi *hdmi,
-				struct hdmi_audio_params *params)
-{
-	int audio_cfg, n;
-	struct hdmi_audio_infoframe *info = &params->cea;
-
-	DRM_DEBUG_DRIVER("\n");
-
-	if (!hdmi->enabled)
-		return 0;
-
-	/* update N parameter */
-	n = sti_hdmi_audio_get_non_coherent_n(params->sample_rate);
-
-	DRM_DEBUG_DRIVER("Audio rate = %d Hz, TMDS clock = %d Hz, n = %d\n",
-			 params->sample_rate, hdmi->mode.clock * 1000, n);
-	hdmi_write(hdmi, n, HDMI_AUDN);
-
-	/* update HDMI registers according to configuration */
-	audio_cfg = HDMI_AUD_CFG_SPDIF_DIV_2 | HDMI_AUD_CFG_DTS_INVALID |
-		    HDMI_AUD_CFG_ONE_BIT_INVALID;
-
-	switch (info->channels) {
-	case 8:
-		audio_cfg |= HDMI_AUD_CFG_CH78_VALID;
-	case 6:
-		audio_cfg |= HDMI_AUD_CFG_CH56_VALID;
-	case 4:
-		audio_cfg |= HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
-	case 2:
-		audio_cfg |= HDMI_AUD_CFG_CH12_VALID;
-		break;
-	default:
-		DRM_ERROR("ERROR: Unsupported number of channels (%d)!\n",
-			  info->channels);
-		return -EINVAL;
-	}
-
-	hdmi_write(hdmi, audio_cfg, HDMI_AUDIO_CFG);
-
-	hdmi->audio = *params;
-
-	return hdmi_audio_infoframe_config(hdmi);
-}
-
 static void hdmi_audio_shutdown(struct device *dev, void *data)
 {
 	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
@@ -1192,17 +1193,9 @@ static int hdmi_audio_hw_params(struct device *dev,
 {
 	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
 	int ret;
-	struct hdmi_audio_params audio = {
-		.sample_width = params->sample_width,
-		.sample_rate = params->sample_rate,
-		.cea = params->cea,
-	};
 
 	DRM_DEBUG_DRIVER("\n");
 
-	if (!hdmi->enabled)
-		return 0;
-
 	if ((daifmt->fmt != HDMI_I2S) || daifmt->bit_clk_inv ||
 	    daifmt->frame_clk_inv || daifmt->bit_clk_master ||
 	    daifmt->frame_clk_master) {
@@ -1213,9 +1206,13 @@ static int hdmi_audio_hw_params(struct device *dev,
 		return -EINVAL;
 	}
 
-	audio.enabled = true;
+	hdmi->audio.sample_width = params->sample_width;
+	hdmi->audio.sample_rate = params->sample_rate;
+	hdmi->audio.cea = params->cea;
+
+	hdmi->audio.enabled = true;
 
-	ret = hdmi_audio_configure(hdmi, &audio);
+	ret = hdmi_audio_configure(hdmi);
 	if (ret < 0)
 		return ret;
 
-- 
1.9.1
