From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] drm/i915: Pass pipe to LPE audio
	notification
Date: Tue, 31 Jan 2017 22:36:46 +0100
Message-ID: <20170131213649.13689-5-tiwai@suse.de>
References: <20170131213649.13689-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F14A2666EA
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:36:56 +0100 (CET)
In-Reply-To: <20170131213649.13689-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, rakesh.a.ughreja@intel.com, Jerome Anand <jerome.anand@intel.com>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The LPE audio configuration depends on the pipe, thus we need to pass
the currently used pipe.  It's now embedded in struct
intel_hdmi_lpe_audio_eld as well as port id.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/i915/i915_drv.h        | 2 +-
 drivers/gpu/drm/i915/intel_audio.c     | 6 +++---
 drivers/gpu/drm/i915/intel_lpe_audio.c | 3 ++-
 include/drm/intel_lpe_audio.h          | 1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 836d823d476b..27311a337e2b 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -3401,7 +3401,7 @@ int  intel_lpe_audio_init(struct drm_i915_private *dev_priv);
 void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv);
 void intel_lpe_audio_irq_handler(struct drm_i915_private *dev_priv);
 void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
-			    void *eld, int port, int tmds_clk_speed,
+			    void *eld, int port, int pipe, int tmds_clk_speed,
 			    bool dp_output, int link_rate);
 
 /* intel_i2c.c */
diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index d4e6d1136cfe..892169b7952b 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -634,12 +634,12 @@ void intel_audio_codec_enable(struct intel_encoder *intel_encoder,
 
 	switch (intel_encoder->type) {
 	case INTEL_OUTPUT_HDMI:
-		intel_lpe_audio_notify(dev_priv, connector->eld, port,
+		intel_lpe_audio_notify(dev_priv, connector->eld, port, pipe,
 				       crtc_state->port_clock,
 				       false, 0);
 		break;
 	case INTEL_OUTPUT_DP:
-		intel_lpe_audio_notify(dev_priv, connector->eld, port,
+		intel_lpe_audio_notify(dev_priv, connector->eld, port, pipe,
 				       adjusted_mode->crtc_clock,
 				       true, crtc_state->port_clock);
 		break;
@@ -680,7 +680,7 @@ void intel_audio_codec_disable(struct intel_encoder *intel_encoder)
 						 (int) port, (int) pipe);
 	}
 
-	intel_lpe_audio_notify(dev_priv, NULL, port, 0, false, 0);
+	intel_lpe_audio_notify(dev_priv, NULL, port, pipe, 0, false, 0);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/intel_lpe_audio.c b/drivers/gpu/drm/i915/intel_lpe_audio.c
index f95624a46f27..2ca3c775c6b1 100644
--- a/drivers/gpu/drm/i915/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/intel_lpe_audio.c
@@ -332,7 +332,7 @@ void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv)
  * Notify lpe audio driver of eld change.
  */
 void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
-			    void *eld, int port, int tmds_clk_speed,
+			    void *eld, int port, int pipe, int tmds_clk_speed,
 			    bool dp_output, int link_rate)
 {
 	unsigned long irq_flags;
@@ -360,6 +360,7 @@ void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
 		memcpy(pdata->eld.eld_data, eld,
 			HDMI_MAX_ELD_BYTES);
 		pdata->eld.port_id = port;
+		pdata->eld.pipe_id = pipe;
 		pdata->hdmi_connected = true;
 
 		pdata->dp_output = dp_output;
diff --git a/include/drm/intel_lpe_audio.h b/include/drm/intel_lpe_audio.h
index 857e0eafed79..410128e4cd70 100644
--- a/include/drm/intel_lpe_audio.h
+++ b/include/drm/intel_lpe_audio.h
@@ -31,6 +31,7 @@
 
 struct intel_hdmi_lpe_audio_eld {
 	int port_id;
+	int pipe_id;
 	unsigned char eld_data[HDMI_MAX_ELD_BYTES];
 };
 
-- 
2.11.0
