From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 3/4] drm/i915: Add display audio routing APIs
	for ALSA
Date: Fri, 14 Jun 2013 23:20:28 +0800
Message-ID: <1371223229-8236-4-git-send-email-xingchao.wang@linux.intel.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: tiwai@suse.de, daniel.vetter@ffwll.ch
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, intel-gfx@lists.freedesktop.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

ALSA audio driver need know current audio routing infomation.
i.e. Route map between codec pins(DDI ports) and Transcoders(Pipe).

Also the new API let audio driver disable unused audio pin's output.
This fixed the bug when three pins *ALL* have monitors connected, playing
audio on one pin would cause audio output to all minitors.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h      |  18 +++++
 drivers/gpu/drm/i915/intel_ddi.c     | 131 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/i915/intel_display.c |   7 +-
 drivers/gpu/drm/i915/intel_drv.h     |   1 +
 include/drm/i915_powerwell.h         |   5 ++
 5 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 10a56c9..8248048 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -87,6 +87,7 @@ enum port {
 	I915_MAX_PORTS
 };
 #define port_name(p) ((p) + 'A')
+#define pin2port(p) ((p) + PORT_B)
 
 enum intel_display_power_domain {
 	POWER_DOMAIN_PIPE_A,
@@ -785,6 +786,20 @@ struct i915_power_well {
 	int i915_request;
 };
 
+#define DEFAULT_PIPE	-1
+/* Dp1.2 mode, one DDI port can choose multiple pipes */
+struct dp12_port {
+	int pipes[I915_MAX_PIPES];
+	int count;
+};
+
+/* audio routing info for haswell */
+struct i915_audio {
+	/* route map between pipe and DDI port */
+	struct dp12_port active_pipes[I915_MAX_PORTS];
+	int pin_eld;
+};
+
 struct i915_dri1_state {
 	unsigned allow_batchbuffer : 1;
 	u32 __iomem *gfx_hws_cpu_addr;
@@ -1147,6 +1162,9 @@ typedef struct drm_i915_private {
 	/* Haswell power well */
 	struct i915_power_well power_well;
 
+	/* Haswell audio routing */
+	struct i915_audio audio_route;
+
 	enum no_fbc_reason no_fbc_reason;
 
 	struct drm_mm_node *compressed_fb;
diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
index 224ce25..82823b8 100644
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -286,8 +286,11 @@ static void intel_ddi_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *adjusted_mode)
 {
 	struct drm_crtc *crtc = encoder->crtc;
+	struct drm_i915_private *dev_priv = crtc->dev->dev_private;
 	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
 	struct intel_encoder *intel_encoder = to_intel_encoder(encoder);
+	struct i915_audio *hsw_audio = &dev_priv->audio_route;
+	struct dp12_port *hsw_port;
 	int port = intel_ddi_get_encoder_port(intel_encoder);
 	int pipe = intel_crtc->pipe;
 	int type = intel_encoder->type;
@@ -296,6 +299,12 @@ static void intel_ddi_mode_set(struct drm_encoder *encoder,
 		      port_name(port), pipe_name(pipe));
 
 	intel_crtc->eld_vld = false;
+
+	/* store pipe routing info */
+	hsw_port = &hsw_audio->active_pipes[port];
+	hsw_port->pipes[0] = pipe;
+	hsw_port->count = 1;
+
 	if (type == INTEL_OUTPUT_DISPLAYPORT || type == INTEL_OUTPUT_EDP) {
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 		struct intel_digital_port *intel_dig_port =
@@ -306,8 +315,8 @@ static void intel_ddi_mode_set(struct drm_encoder *encoder,
 		intel_dp->DP |= DDI_PORT_WIDTH(intel_dp->lane_count);
 
 		if (intel_dp->has_audio) {
-			DRM_DEBUG_DRIVER("DP audio on pipe %c on DDI\n",
-					 pipe_name(intel_crtc->pipe));
+			DRM_DEBUG_DRIVER("DP audio on pipe %c on DDI %c\n",
+					 pipe_name(intel_crtc->pipe), port_name(port));
 
 			/* write eld */
 			DRM_DEBUG_DRIVER("DP audio: write eld information\n");
@@ -324,8 +333,8 @@ static void intel_ddi_mode_set(struct drm_encoder *encoder,
 			 * and a new set of registers, so we leave it for future
 			 * patch bombing.
 			 */
-			DRM_DEBUG_DRIVER("HDMI audio on pipe %c on DDI\n",
-					 pipe_name(intel_crtc->pipe));
+			DRM_DEBUG_DRIVER("HDMI audio on pipe %c on DDI %c \n",
+					 pipe_name(intel_crtc->pipe), port_name(port));
 
 			/* write eld */
 			DRM_DEBUG_DRIVER("HDMI audio: write eld information\n");
@@ -1135,6 +1144,9 @@ static void intel_disable_ddi(struct intel_encoder *intel_encoder)
 	int type = intel_encoder->type;
 	struct drm_device *dev = encoder->dev;
 	struct drm_i915_private *dev_priv = dev->dev_private;
+	struct i915_audio *hsw_audio = &dev_priv->audio_route;
+	struct dp12_port *hsw_port;
+	enum port port = intel_ddi_get_encoder_port(intel_encoder);
 	uint32_t tmp;
 
 	if (intel_crtc->eld_vld && type != INTEL_OUTPUT_EDP) {
@@ -1149,6 +1161,11 @@ static void intel_disable_ddi(struct intel_encoder *intel_encoder)
 
 		ironlake_edp_backlight_off(intel_dp);
 	}
+
+	/* clear pipe routing info */
+	hsw_port = &hsw_audio->active_pipes[port];
+	hsw_port->pipes[0] = 0;
+	hsw_port->count = 0;
 }
 
 int intel_ddi_get_cdclk_freq(struct drm_i915_private *dev_priv)
@@ -1312,6 +1329,24 @@ static const struct drm_encoder_helper_funcs intel_ddi_helper_funcs = {
 	.mode_set = intel_ddi_mode_set,
 };
 
+static struct drm_i915_private *hdmi_dev_priv;
+void intel_ddi_audio_init(struct drm_device *dev)
+{
+	struct drm_i915_private *dev_priv = dev->dev_private;
+	struct i915_audio *hsw_audio = &dev_priv->audio_route;
+	struct dp12_port *hsw_port;
+	enum port port;
+
+	for (port = PORT_A; port < I915_MAX_PORTS; port++) {
+		hsw_port = &hsw_audio->active_pipes[port];
+		hsw_port->count = 0;
+		memset(hsw_port->pipes, DEFAULT_PIPE, sizeof(hsw_port->pipes));
+	}
+
+	hsw_audio->pin_eld = 0;
+	hdmi_dev_priv = dev_priv;
+}
+
 void intel_ddi_init(struct drm_device *dev, enum port port)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
@@ -1369,3 +1404,91 @@ void intel_ddi_init(struct drm_device *dev, enum port port)
 		intel_hdmi_init_connector(intel_dig_port, hdmi_connector);
 	}
 }
+
+int i915_using_pipe(int pin)
+{
+	enum port port;
+	int pipe;
+	struct i915_audio *hsw_audio;
+	struct dp12_port *hsw_port;
+
+	if (!hdmi_dev_priv)
+		return -EINVAL;
+
+	hsw_audio = &hdmi_dev_priv->audio_route;
+
+	port = pin2port(pin);
+	hsw_port = &hsw_audio->active_pipes[port];
+
+	/* only first element is valid for non Dp1.2 */
+	pipe = hsw_port->pipes[0];
+
+	if (hsw_port->count)
+		DRM_DEBUG_DRIVER("HDMI: i915 is using pipe %c for pin %d now\n", pipe_name(pipe), pin);
+
+	return pipe;
+}
+EXPORT_SYMBOL_GPL(i915_using_pipe);
+
+int i915_disable_pipe(int pipe, int *busy_pins)
+{
+	struct drm_i915_private *dev_priv = hdmi_dev_priv;
+	struct i915_audio *hsw_audio;
+	struct dp12_port *hsw_port;
+	int aud_cntrl_st2 = HSW_AUD_PIN_ELD_CP_VLD;
+	int port, active_pipe;
+	int tmp;
+	int pin;
+
+	if (!hdmi_dev_priv)
+		return -EINVAL;
+
+	hsw_audio = &dev_priv->audio_route;
+
+	if (pipe == DEFAULT_PIPE) {
+		DRM_DEBUG_DRIVER("HDMI: disable all active pipes\n");
+	}
+
+	tmp = I915_READ(aud_cntrl_st2);
+	DRM_DEBUG_DRIVER("HDMI: current pin eld 0x%x\n", tmp);
+	/* Clear all output enable bits */
+	tmp &= ~(AUDIO_OUTPUT_ENABLE_A |
+			AUDIO_OUTPUT_ENABLE_B |
+			AUDIO_OUTPUT_ENABLE_C);
+
+	if (pipe != DEFAULT_PIPE) {
+		for (pin = 0; pin < 3; pin++) {
+			port = pin2port(pin);
+			hsw_port = &hsw_audio->active_pipes[port];
+			active_pipe = hsw_port->pipes[0];
+
+			if (busy_pins[pin] && active_pipe != DEFAULT_PIPE) {
+				tmp |= (AUDIO_OUTPUT_ENABLE_A << (active_pipe * 4));
+				DRM_DEBUG_DRIVER("pin %d is busy now, keep its using pipe %c\n", pin, pipe_name(active_pipe));
+			}
+		}
+	}
+
+	I915_WRITE(aud_cntrl_st2, tmp);
+	DRM_DEBUG_DRIVER("HDMI: new pin eld 0x%x -- disable unuesd pin's audio output\n", tmp);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i915_disable_pipe);
+
+int i915_restore_pineld(void)
+{
+	struct drm_i915_private *dev_priv = hdmi_dev_priv;
+	struct i915_audio *hsw_audio;
+	int aud_cntrl_st2 = HSW_AUD_PIN_ELD_CP_VLD;
+
+	if (!hdmi_dev_priv)
+		return -EINVAL;
+
+	hsw_audio = &dev_priv->audio_route;
+
+	I915_WRITE(aud_cntrl_st2, hsw_audio->pin_eld);
+	DRM_DEBUG_DRIVER("HDMI: restore pin eld 0x%x\n", hsw_audio->pin_eld);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i915_restore_pineld);
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index b23937b..1080750 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -6121,6 +6121,7 @@ static void haswell_write_eld(struct drm_connector *connector,
 	uint8_t *eld = connector->eld;
 	struct drm_device *dev = crtc->dev;
 	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
+	struct i915_audio *hsw_audio = &dev_priv->audio_route;
 	uint32_t eldv;
 	uint32_t i;
 	int len;
@@ -6137,6 +6138,7 @@ static void haswell_write_eld(struct drm_connector *connector,
 
 	/* Audio output enable */
 	DRM_DEBUG_DRIVER("HDMI audio: enable codec\n");
+
 	tmp = I915_READ(aud_cntrl_st2);
 	tmp |= (AUDIO_OUTPUT_ENABLE_A << (pipe * 4));
 	I915_WRITE(aud_cntrl_st2, tmp);
@@ -6171,6 +6173,7 @@ static void haswell_write_eld(struct drm_connector *connector,
 	} else
 		I915_WRITE(aud_config, 0);
 
+	hsw_audio->pin_eld = I915_READ(aud_cntrl_st2);
 	if (intel_eld_uptodate(connector,
 			       aud_cntrl_st2, eldv,
 			       aud_cntl_st, IBX_ELD_ADDRESS,
@@ -6198,7 +6201,6 @@ static void haswell_write_eld(struct drm_connector *connector,
 	i = I915_READ(aud_cntrl_st2);
 	i |= eldv;
 	I915_WRITE(aud_cntrl_st2, i);
-
 }
 
 static void ironlake_write_eld(struct drm_connector *connector,
@@ -8969,6 +8971,9 @@ static void intel_setup_outputs(struct drm_device *dev)
 	if (HAS_DDI(dev)) {
 		int found;
 
+		/* Init Haswell audio route map */
+		intel_ddi_audio_init(dev);
+
 		/* Haswell uses DDI functions to detect digital outputs */
 		found = I915_READ(DDI_BUF_CTL_A) & DDI_INIT_DISPLAY_DETECTED;
 		/* DDI A only supports eDP */
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index ffe9d35..6f8e680 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -758,6 +758,7 @@ extern void intel_write_eld(struct drm_encoder *encoder,
 extern void intel_prepare_ddi(struct drm_device *dev);
 extern void hsw_fdi_link_train(struct drm_crtc *crtc);
 extern void intel_ddi_init(struct drm_device *dev, enum port port);
+extern void intel_ddi_audio_init(struct drm_device *dev);
 
 /* For use by IVB LP watermark workaround in intel_sprite.c */
 extern void intel_update_watermarks(struct drm_device *dev);
diff --git a/include/drm/i915_powerwell.h b/include/drm/i915_powerwell.h
index cfdc884..aef3ec0 100644
--- a/include/drm/i915_powerwell.h
+++ b/include/drm/i915_powerwell.h
@@ -33,4 +33,9 @@
 extern void i915_request_power_well(void);
 extern void i915_release_power_well(void);
 
+/* used by hdmi driver for audio routing */
+extern int i915_using_pipe(int pin);
+extern int i915_disable_pipe(int pipe, int *busy_pins);
+extern int i915_restore_pineld(void);
+
 #endif				/* _I915_POWERWELL_H_ */
-- 
1.8.1.2
