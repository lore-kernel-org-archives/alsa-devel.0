From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 1/3] drm/i915/audio: Track temporary rpm
	wakerefs
Date: Mon, 14 Jan 2019 17:37:51 +0000
Message-ID: <20190114173753.472-1-chris@chris-wilson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 630A12667F5
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 18:38:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: intel-gfx@lists.freedesktop.org
Cc: alsa-devel@alsa-project.org, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

Track the temporary rpm wakerefs used within audio so that they may be
marked as complete and the tracking cancelled upon release.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
---
 drivers/gpu/drm/i915/intel_audio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index de26cd0a5497..92e27359c2e3 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -756,12 +756,13 @@ static void i915_audio_component_codec_wake_override(struct device *kdev,
 						     bool enable)
 {
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
+	intel_wakeref_t wakeref;
 	u32 tmp;
 
 	if (!IS_GEN(dev_priv, 9))
 		return;
 
-	i915_audio_component_get_power(kdev);
+	wakeref = intel_display_power_get(dev_priv, POWER_DOMAIN_AUDIO);
 
 	/*
 	 * Enable/disable generating the codec wake signal, overriding the
@@ -779,7 +780,7 @@ static void i915_audio_component_codec_wake_override(struct device *kdev,
 		usleep_range(1000, 1500);
 	}
 
-	i915_audio_component_put_power(kdev);
+	intel_display_power_put(dev_priv, POWER_DOMAIN_AUDIO, wakeref);
 }
 
 /* Get CDCLK in kHz  */
@@ -850,12 +851,13 @@ static int i915_audio_component_sync_audio_rate(struct device *kdev, int port,
 	struct i915_audio_component *acomp = dev_priv->audio_component;
 	struct intel_encoder *encoder;
 	struct intel_crtc *crtc;
+	intel_wakeref_t wakeref;
 	int err = 0;
 
 	if (!HAS_DDI(dev_priv))
 		return 0;
 
-	i915_audio_component_get_power(kdev);
+	wakeref = intel_display_power_get(dev_priv, POWER_DOMAIN_AUDIO);
 	mutex_lock(&dev_priv->av_mutex);
 
 	/* 1. get the pipe */
@@ -875,7 +877,7 @@ static int i915_audio_component_sync_audio_rate(struct device *kdev, int port,
 
  unlock:
 	mutex_unlock(&dev_priv->av_mutex);
-	i915_audio_component_put_power(kdev);
+	intel_display_power_put(dev_priv, POWER_DOMAIN_AUDIO, wakeref);
 	return err;
 }
 
-- 
2.20.1
