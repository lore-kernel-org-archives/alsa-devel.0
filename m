From: libin.yang@intel.com
Subject: [PATCH] drm/i915: set proper N/CTS in modeset
Date: Fri, 11 Sep 2015 08:40:51 +0800
Message-ID: <1441932051-48719-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D5908265919
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 02:40:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, jani.nikula@linux.intel.com, ville.syrjala@linux.intel.com
Cc: Libin Yang <libin.yang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

When modeset occurs and the TMDS frequency is set to some
speical values, the N/CTS need to be set manually if audio
is playing.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 drivers/gpu/drm/i915/intel_audio.c | 56 ++++++++++++++++++++++++++++++++------
 include/drm/i915_component.h       | 10 +++++++
 2 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index e3c32ce..a12bf57 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -128,6 +128,20 @@ static int audio_config_get_n(const struct drm_display_mode *mode, int rate)
 	return 0;
 }
 
+static uint32_t audio_config_setup_n_reg(int n, uint32_t val)
+{
+	int n_low, n_up;
+	uint32_t tmp = val;
+
+	n_low = n & 0xfff;
+	n_up = (n >> 12) & 0xff;
+	tmp &= ~(AUD_CONFIG_UPPER_N_MASK | AUD_CONFIG_LOWER_N_MASK);
+	tmp |= ((n_up << AUD_CONFIG_UPPER_N_SHIFT) |
+			(n_low << AUD_CONFIG_LOWER_N_SHIFT) |
+			AUD_CONFIG_N_PROG_ENABLE);
+	return tmp;
+}
+
 /* check whether N/CTS/M need be set manually */
 static bool audio_rate_need_prog(struct intel_crtc *crtc,
 					struct drm_display_mode *mode)
@@ -262,9 +276,14 @@ static void hsw_audio_codec_enable(struct drm_connector *connector,
 	struct drm_i915_private *dev_priv = connector->dev->dev_private;
 	struct intel_crtc *intel_crtc = to_intel_crtc(encoder->base.crtc);
 	enum pipe pipe = intel_crtc->pipe;
+	struct i915_audio_component *acomp = dev_priv->audio_component;
 	const uint8_t *eld = connector->eld;
+	struct intel_digital_port *intel_dig_port =
+		enc_to_dig_port(&encoder->base);
+	enum port port = intel_dig_port->port;
 	uint32_t tmp;
 	int len, i;
+	int n, rate;
 
 	DRM_DEBUG_KMS("Enable audio codec on pipe %c, %u bytes ELD\n",
 		      pipe_name(pipe), drm_eld_size(eld));
@@ -302,12 +321,29 @@ static void hsw_audio_codec_enable(struct drm_connector *connector,
 	/* Enable timestamps */
 	tmp = I915_READ(HSW_AUD_CFG(pipe));
 	tmp &= ~AUD_CONFIG_N_VALUE_INDEX;
-	tmp &= ~AUD_CONFIG_N_PROG_ENABLE;
 	tmp &= ~AUD_CONFIG_PIXEL_CLOCK_HDMI_MASK;
 	if (intel_pipe_has_type(intel_crtc, INTEL_OUTPUT_DISPLAYPORT))
 		tmp |= AUD_CONFIG_N_VALUE_INDEX;
 	else
 		tmp |= audio_config_hdmi_pixel_clock(mode);
+
+	tmp &= ~AUD_CONFIG_N_PROG_ENABLE;
+	if (audio_rate_need_prog(intel_crtc, mode)) {
+		if (!acomp)
+			rate = 0;
+		else if (port >= PORT_A && port <= PORT_E)
+			rate = acomp->aud_sample_rate[port];
+		else {
+			DRM_ERROR("invalid port: %d\n", port);
+			rate = 0;
+		}
+		n = audio_config_get_n(mode, rate);
+		if (n != 0)
+			tmp = audio_config_setup_n_reg(n, tmp);
+		else
+			DRM_DEBUG_KMS("no suitable N value is found\n");
+	}
+
 	I915_WRITE(HSW_AUD_CFG(pipe), tmp);
 
 	mutex_unlock(&dev_priv->av_mutex);
@@ -594,9 +630,10 @@ static int i915_audio_component_sync_audio_rate(struct device *dev,
 	struct intel_digital_port *intel_dig_port;
 	struct intel_crtc *crtc;
 	struct drm_display_mode *mode;
+	struct i915_audio_component *acomp = dev_priv->audio_component;
 	enum pipe pipe = -1;
 	u32 tmp;
-	int n_low, n_up, n;
+	int n;
 
 	/* HSW, BDW SKL need this fix */
 	if (!IS_SKYLAKE(dev_priv) &&
@@ -630,6 +667,9 @@ static int i915_audio_component_sync_audio_rate(struct device *dev,
 				  pipe_name(pipe), port_name(port));
 	mode = &crtc->config->base.adjusted_mode;
 
+	/* port must be valid now, otherwise the pipe will be invalid */
+	acomp->aud_sample_rate[port] = rate;
+
 	/* 2. check whether to set the N/CTS/M manually or not */
 	if (!audio_rate_need_prog(crtc, mode)) {
 		tmp = I915_READ(HSW_AUD_CFG(pipe));
@@ -649,15 +689,10 @@ static int i915_audio_component_sync_audio_rate(struct device *dev,
 		mutex_unlock(&dev_priv->av_mutex);
 		return 0;
 	}
-	n_low = n & 0xfff;
-	n_up = (n >> 12) & 0xff;
 
-	/* 4. set the N/CTS/M */
+	/* 3. set the N/CTS/M */
 	tmp = I915_READ(HSW_AUD_CFG(pipe));
-	tmp &= ~(AUD_CONFIG_UPPER_N_MASK | AUD_CONFIG_LOWER_N_MASK);
-	tmp |= ((n_up << AUD_CONFIG_UPPER_N_SHIFT) |
-			(n_low << AUD_CONFIG_LOWER_N_SHIFT) |
-			AUD_CONFIG_N_PROG_ENABLE);
+	tmp = audio_config_setup_n_reg(n, tmp);
 	I915_WRITE(HSW_AUD_CFG(pipe), tmp);
 
 	mutex_unlock(&dev_priv->av_mutex);
@@ -678,6 +713,7 @@ static int i915_audio_component_bind(struct device *i915_dev,
 {
 	struct i915_audio_component *acomp = data;
 	struct drm_i915_private *dev_priv = dev_to_i915(i915_dev);
+	int i;
 
 	if (WARN_ON(acomp->ops || acomp->dev))
 		return -EEXIST;
@@ -685,6 +721,8 @@ static int i915_audio_component_bind(struct device *i915_dev,
 	drm_modeset_lock_all(dev_priv->dev);
 	acomp->ops = &i915_audio_component_ops;
 	acomp->dev = i915_dev;
+	for (i = 0; i < I915_MAX_PORTS; i++)
+		acomp->aud_sample_rate[i] = 0;
 	dev_priv->audio_component = acomp;
 	drm_modeset_unlock_all(dev_priv->dev);
 
diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index e6d35d7..89dc7d6 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -24,8 +24,18 @@
 #ifndef _I915_COMPONENT_H_
 #define _I915_COMPONENT_H_
 
+/* MAX_PORT is the number of port
+ * It must be sync with I915_MAX_PORTS defined i915_drv.h
+ * 5 should be enough as only HSW, BDW, SKL need such fix.
+ */
+#define MAX_PORTS 5
+
 struct i915_audio_component {
 	struct device *dev;
+	/**
+	 * @aud_sample_rate: the array of audio sample rate per port
+	 */
+	int aud_sample_rate[MAX_PORTS];
 
 	const struct i915_audio_component_ops {
 		struct module *owner;
-- 
1.9.1
