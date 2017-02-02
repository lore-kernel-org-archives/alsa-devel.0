From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] drm/i915: Enable VLV audio chicken bit for LPE
	audio
Date: Thu,  2 Feb 2017 18:02:15 +0100
Message-ID: <20170202170307.24484-3-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 850E9266871
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:15 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

The audio chicken bit (register offset 0x62f38) seems required to make
DP audio working on some machines.  At least, on Dell Wyse 3040, I
failed to get the audio unless this bit is set once.

Strangely, the bit seems necessary only once, and it persists after
that, even some power-off cycles.  The register is supposedly
write-only, so it's no evidence whether the bit keeps effect
persistently.  But, judging from the experiment, it looks enough to
set it up once at the device initialization.

The patch is basically a cut from the original patch by Pierre-Louis
Bossart.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/i915/i915_reg.h        | 3 +++
 drivers/gpu/drm/i915/intel_lpe_audio.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 4e24ba0cdbe8..4f15a3dc6d98 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -2062,6 +2062,9 @@ enum skl_disp_power_wells {
 #define I915_HDMI_LPE_AUDIO_SIZE	0x1000
 
 /* DisplayPort Audio w/ LPE */
+#define VLV_AUD_CHICKEN_BIT_REG		_MMIO(VLV_DISPLAY_BASE + 0x62F38)
+#define VLV_CHICKEN_BIT_DBG_ENABLE	(1 << 0)
+
 #define _VLV_AUD_PORT_EN_B_DBG		(VLV_DISPLAY_BASE + 0x62F20)
 #define _VLV_AUD_PORT_EN_C_DBG		(VLV_DISPLAY_BASE + 0x62F30)
 #define _VLV_AUD_PORT_EN_D_DBG		(VLV_DISPLAY_BASE + 0x62F34)
diff --git a/drivers/gpu/drm/i915/intel_lpe_audio.c b/drivers/gpu/drm/i915/intel_lpe_audio.c
index d3ffe0012692..3ba2799e93bd 100644
--- a/drivers/gpu/drm/i915/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/intel_lpe_audio.c
@@ -248,6 +248,13 @@ static int lpe_audio_setup(struct drm_i915_private *dev_priv)
 		goto err_free_irq;
 	}
 
+	/* enable chicken bit; at least this is required for Dell Wyse 3040
+	 * with DP outputs (but only sometimes by some reason!)
+	 */
+	I915_WRITE(VLV_AUD_CHICKEN_BIT_REG,
+		   I915_READ(VLV_AUD_CHICKEN_BIT_REG) |
+		   VLV_CHICKEN_BIT_DBG_ENABLE);
+
 	return 0;
 err_free_irq:
 	irq_free_desc(dev_priv->lpe_audio.irq);
-- 
2.11.0
