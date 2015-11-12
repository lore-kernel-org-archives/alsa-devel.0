From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 3/4] drm/i915: refactoring audio component
	functions
Date: Thu, 12 Nov 2015 17:20:13 +0100
Message-ID: <1447345214-7212-4-git-send-email-tiwai@suse.de>
References: <1447345214-7212-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B6DDF2659F5
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

We have a common loop of encoder to look for the given audio port in
two audio component functions.  Split out a local helper function to
do it for the code simplification.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/i915/intel_audio.c | 60 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index dc8141324fcd..8169693418af 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -630,17 +630,33 @@ static int i915_audio_component_get_cdclk_freq(struct device *dev)
 	return ret;
 }
 
+static struct intel_encoder *audio_port_to_encoder(struct drm_device *drm_dev,
+						   int port)
+{
+	struct intel_encoder *intel_encoder;
+	struct intel_digital_port *intel_dig_port;
+
+	for_each_intel_encoder(drm_dev, intel_encoder) {
+		if (intel_encoder->type != INTEL_OUTPUT_HDMI &&
+		    intel_encoder->type != INTEL_OUTPUT_DISPLAYPORT)
+			continue;
+		intel_dig_port = enc_to_dig_port(&intel_encoder->base);
+		if (port == intel_dig_port->port)
+			return intel_encoder;
+	}
+	return NULL;
+}
+
 static int i915_audio_component_sync_audio_rate(struct device *dev,
 						int port, int rate)
 {
 	struct drm_i915_private *dev_priv = dev_to_i915(dev);
 	struct drm_device *drm_dev = dev_priv->dev;
 	struct intel_encoder *intel_encoder;
-	struct intel_digital_port *intel_dig_port;
 	struct intel_crtc *crtc;
 	struct drm_display_mode *mode;
 	struct i915_audio_component *acomp = dev_priv->audio_component;
-	enum pipe pipe = -1;
+	enum pipe pipe;
 	u32 tmp;
 	int n;
 
@@ -652,22 +668,14 @@ static int i915_audio_component_sync_audio_rate(struct device *dev,
 
 	mutex_lock(&dev_priv->av_mutex);
 	/* 1. get the pipe */
-	for_each_intel_encoder(drm_dev, intel_encoder) {
-		if (intel_encoder->type != INTEL_OUTPUT_HDMI)
-			continue;
-		intel_dig_port = enc_to_dig_port(&intel_encoder->base);
-		if (port == intel_dig_port->port) {
-			crtc = to_intel_crtc(intel_encoder->base.crtc);
-			pipe = crtc->pipe;
-			break;
-		}
-	}
-
-	if (pipe == INVALID_PIPE) {
+	intel_encoder = audio_port_to_encoder(drm_dev, port);
+	if (!intel_encoder || intel_encoder->type != INTEL_OUTPUT_HDMI) {
 		DRM_DEBUG_KMS("no pipe for the port %c\n", port_name(port));
 		mutex_unlock(&dev_priv->av_mutex);
 		return -ENODEV;
 	}
+	crtc = to_intel_crtc(intel_encoder->base.crtc);
+	pipe = crtc->pipe;
 	DRM_DEBUG_KMS("pipe %c connects port %c\n",
 				  pipe_name(pipe), port_name(port));
 	mode = &crtc->config->base.adjusted_mode;
@@ -716,23 +724,17 @@ static int i915_audio_component_get_eld(struct device *dev, int port,
 	int ret = -EINVAL;
 
 	mutex_lock(&dev_priv->av_mutex);
-	for_each_intel_encoder(drm_dev, intel_encoder) {
-		if (intel_encoder->type != INTEL_OUTPUT_DISPLAYPORT &&
-		    intel_encoder->type != INTEL_OUTPUT_HDMI)
-			continue;
+	intel_encoder = audio_port_to_encoder(drm_dev, port);
+	if (intel_encoder) {
+		ret = 0;
 		intel_dig_port = enc_to_dig_port(&intel_encoder->base);
-		if (port == intel_dig_port->port) {
-			if (!intel_dig_port->audio_enabled) {
-				ret = 0;
-				break;
-			}
+		if (intel_dig_port->audio_enabled) {
 			connector = drm_select_eld(&intel_encoder->base);
-			if (!connector)
-				break;
-			eld = connector->eld;
-			ret = min(max_bytes, drm_eld_size(eld));
-			memcpy(buf, eld, ret);
-			break;
+			if (connector) {
+				eld = connector->eld;
+				ret = min(max_bytes, drm_eld_size(eld));
+				memcpy(buf, eld, ret);
+			}
 		}
 	}
 
-- 
2.6.3
