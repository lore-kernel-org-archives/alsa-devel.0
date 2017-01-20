From: Jerome Anand <jerome.anand@intel.com>
Subject: [PATCH v4 2/5] drm/i915: Add support for audio driver
	notifications
Date: Sat, 21 Jan 2017 03:52:29 +0530
Message-ID: <20170120222232.27791-3-jerome.anand@intel.com>
References: <20170120222232.27791-1-jerome.anand@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C242F2666EA
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 11:20:53 +0100 (CET)
In-Reply-To: <20170120222232.27791-1-jerome.anand@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, jerome.anand@intel.com, ville.syrjala@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Notifiations like mode change, hot plug and edid to
the audio driver are added. This is inturn used by the
audio driver for its functionality.

A new interface file capturing the notifications needed by the
audio driver is added

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Jerome Anand <jerome.anand@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h        |  2 ++
 drivers/gpu/drm/i915/intel_audio.c     |  8 ++++++
 drivers/gpu/drm/i915/intel_hdmi.c      |  1 +
 drivers/gpu/drm/i915/intel_lpe_audio.c | 49 ++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index cc7033a..601c8ad 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -3623,6 +3623,8 @@ int  intel_lpe_audio_setup(struct drm_i915_private *dev_priv);
 void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv);
 void intel_lpe_audio_irq_handler(struct drm_i915_private *dev_priv);
 bool intel_lpe_audio_detect(struct drm_i915_private *dev_priv);
+void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
+			void *eld, int port, int tmds_clk_speed);
 
 /* intel_i2c.c */
 extern int intel_setup_gmbus(struct drm_i915_private *dev_priv);
diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index 16c2027..00a485e 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/component.h>
 #include <drm/i915_component.h>
+#include <drm/intel_lpe_audio.h>
 #include "intel_drv.h"
 
 #include <drm/drmP.h>
@@ -630,6 +631,10 @@ void intel_audio_codec_enable(struct intel_encoder *intel_encoder,
 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
 		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
 						 (int) port, (int) pipe);
+
+	if (HAS_LPE_AUDIO(dev_priv))
+		intel_lpe_audio_notify(dev_priv, connector->eld, port,
+			crtc_state->port_clock);
 }
 
 /**
@@ -663,6 +668,9 @@ void intel_audio_codec_disable(struct intel_encoder *intel_encoder)
 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
 		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
 						 (int) port, (int) pipe);
+
+	if (HAS_LPE_AUDIO(dev_priv))
+		intel_lpe_audio_notify(dev_priv, NULL, port, 0);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index 0bcfead..377584e1 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -36,6 +36,7 @@
 #include <drm/drm_edid.h>
 #include "intel_drv.h"
 #include <drm/i915_drm.h>
+#include <drm/intel_lpe_audio.h>
 #include "i915_drv.h"
 
 static struct drm_device *intel_hdmi_to_dev(struct intel_hdmi *intel_hdmi)
diff --git a/drivers/gpu/drm/i915/intel_lpe_audio.c b/drivers/gpu/drm/i915/intel_lpe_audio.c
index 099732c..293084d 100644
--- a/drivers/gpu/drm/i915/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/intel_lpe_audio.c
@@ -337,3 +337,52 @@ void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv)
 
 	irq_free_desc(dev_priv->lpe_audio.irq);
 }
+
+
+/**
+ * intel_lpe_audio_notify() - notify lpe audio event
+ * audio driver and i915
+ * @dev_priv: the i915 drm device private data
+ * @eld : ELD data
+ * @port: port id
+ * @tmds_clk_speed: tmds clock frequency in Hz
+ *
+ * Notify lpe audio driver of eld change.
+ */
+void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
+			void *eld, int port, int tmds_clk_speed)
+{
+	unsigned long irq_flags;
+	struct intel_hdmi_lpe_audio_pdata *pdata = NULL;
+
+	if (!HAS_LPE_AUDIO(dev_priv))
+		return;
+
+	pdata = dev_get_platdata(
+		&(dev_priv->lpe_audio.platdev->dev));
+
+	spin_lock_irqsave(&pdata->lpe_audio_slock, irq_flags);
+
+	if (eld != NULL) {
+		memcpy(pdata->eld.eld_data, eld,
+			HDMI_MAX_ELD_BYTES);
+		pdata->eld.port_id = port;
+		pdata->hdmi_connected = true;
+
+		if (tmds_clk_speed)
+			pdata->tmds_clock_speed = tmds_clk_speed;
+	} else {
+		memset(pdata->eld.eld_data, 0,
+			HDMI_MAX_ELD_BYTES);
+		pdata->hdmi_connected = false;
+	}
+
+	if (pdata->notify_audio_lpe)
+		pdata->notify_audio_lpe(
+			(eld != NULL) ? &pdata->eld : NULL);
+	else
+		pdata->notify_pending = true;
+
+	spin_unlock_irqrestore(&pdata->lpe_audio_slock,
+			irq_flags);
+}
-- 
2.9.3
