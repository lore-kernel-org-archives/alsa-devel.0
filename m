From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 1/4] drm/i915: Add get_eld audio component
Date: Thu, 12 Nov 2015 17:20:11 +0100
Message-ID: <1447345214-7212-2-git-send-email-tiwai@suse.de>
References: <1447345214-7212-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B7F64265A13
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 17:20:25 +0100 (CET)
In-Reply-To: <1447345214-7212-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Implement a new i915_audio_component_ops, get_eld().  It's called by
the audio driver to fetch the current ELD of the given HDMI/DP port.
The return value zero indicates that the audio is off, otherwise a
positive value as the ELD byte size or a negative error code.

For achieving this, a new field audio_enabled is added to struct
intel_digital_port.  This is set/reset at each audio enable/disable
call in intel_audio.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/i915/intel_audio.c | 39 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_drv.h   |  1 +
 include/drm/i915_component.h       |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index 4dccd9b003a1..ec81f8481d25 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -521,6 +521,7 @@ void intel_audio_codec_enable(struct intel_encoder *intel_encoder)
 
 	connector->eld[6] = drm_av_sync_delay(connector, adjusted_mode) / 2;
 
+	intel_dig_port->audio_enabled = true;
 	if (dev_priv->display.audio_codec_enable)
 		dev_priv->display.audio_codec_enable(connector, intel_encoder,
 						     adjusted_mode);
@@ -545,6 +546,7 @@ void intel_audio_codec_disable(struct intel_encoder *intel_encoder)
 	struct intel_digital_port *intel_dig_port = enc_to_dig_port(encoder);
 	enum port port = intel_dig_port->port;
 
+	intel_dig_port->audio_enabled = false;
 	if (dev_priv->display.audio_codec_disable)
 		dev_priv->display.audio_codec_disable(intel_encoder);
 
@@ -706,6 +708,42 @@ static int i915_audio_component_sync_audio_rate(struct device *dev,
 	return 0;
 }
 
+static int i915_audio_component_get_eld(struct device *dev, int port,
+					unsigned char *buf, int max_bytes)
+{
+	struct drm_i915_private *dev_priv = dev_to_i915(dev);
+	struct drm_device *drm_dev = dev_priv->dev;
+	struct intel_encoder *intel_encoder;
+	struct intel_digital_port *intel_dig_port;
+	struct drm_connector *connector;
+	unsigned char *eld;
+	int ret = -EINVAL;
+
+	mutex_lock(&dev_priv->av_mutex);
+	for_each_intel_encoder(drm_dev, intel_encoder) {
+		if (intel_encoder->type != INTEL_OUTPUT_DISPLAYPORT &&
+		    intel_encoder->type != INTEL_OUTPUT_HDMI)
+			continue;
+		intel_dig_port = enc_to_dig_port(&intel_encoder->base);
+		if (port == intel_dig_port->port) {
+			if (!intel_dig_port->audio_enabled) {
+				ret = 0;
+				break;
+			}
+			connector = drm_select_eld(&intel_encoder->base);
+			if (!connector)
+				break;
+			eld = connector->eld;
+			ret = min(max_bytes, drm_eld_size(eld));
+			memcpy(buf, eld, ret);
+			break;
+		}
+	}
+
+	mutex_unlock(&dev_priv->av_mutex);
+	return ret;
+}
+
 static const struct i915_audio_component_ops i915_audio_component_ops = {
 	.owner		= THIS_MODULE,
 	.get_power	= i915_audio_component_get_power,
@@ -713,6 +751,7 @@ static const struct i915_audio_component_ops i915_audio_component_ops = {
 	.codec_wake_override = i915_audio_component_codec_wake_override,
 	.get_cdclk_freq	= i915_audio_component_get_cdclk_freq,
 	.sync_audio_rate = i915_audio_component_sync_audio_rate,
+	.get_eld	= i915_audio_component_get_eld,
 };
 
 static int i915_audio_component_bind(struct device *i915_dev,
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 0598932ce623..4afc7560be04 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -798,6 +798,7 @@ struct intel_digital_port {
 	u32 saved_port_bits;
 	struct intel_dp dp;
 	struct intel_hdmi hdmi;
+	bool audio_enabled;
 	enum irqreturn (*hpd_pulse)(struct intel_digital_port *, bool);
 	bool release_cl2_override;
 };
diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index 30d89e0da2c6..0165eab87dbe 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -38,6 +38,8 @@
  * @codec_wake_override: Enable/Disable generating the codec wake signal
  * @get_cdclk_freq: get the Core Display Clock in KHz
  * @sync_audio_rate: set n/cts based on the sample rate
+ * @get_eld: fill ELD bytes for the given port, return the size of ELD bytes,
+ *           zero if unconnected, or a negative error code.
  */
 struct i915_audio_component_ops {
 	struct module *owner;
@@ -46,6 +48,8 @@ struct i915_audio_component_ops {
 	void (*codec_wake_override)(struct device *, bool enable);
 	int (*get_cdclk_freq)(struct device *);
 	int (*sync_audio_rate)(struct device *, int port, int rate);
+	int (*get_eld)(struct device *, int port, unsigned char *buf,
+		       int max_bytes);
 };
 
 struct i915_audio_component_audio_ops {
-- 
2.6.3
