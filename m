From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 06/15] ALSA: pcm: Add DRM helper to set
	constraint for format
Date: Tue,  1 Dec 2015 23:17:02 +0530
Message-ID: <1448992031-8271-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E13E2261AE4
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:38 +0100 (CET)
In-Reply-To: <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Setting the constraint format based on ELD was missing bit in
the sound/core pcm drm. Added with this patch.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/pcm_drm_eld.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_drm_eld.c b/sound/core/pcm_drm_eld.c
index e70379f..0c5653e 100644
--- a/sound/core/pcm_drm_eld.c
+++ b/sound/core/pcm_drm_eld.c
@@ -20,11 +20,49 @@ static const unsigned int eld_rates[] = {
 	192000,
 };
 
+static unsigned int sad_format(const u8 *sad)
+{
+	return ((sad[0] >> 0x3) & 0x1f);
+}
+
+static unsigned int sad_sample_bits_lpcm(const u8 *sad)
+{
+	return (sad[2] & 7);
+}
+
 static unsigned int sad_max_channels(const u8 *sad)
 {
 	return 1 + (sad[0] & 7);
 }
 
+static int eld_limit_formats(struct snd_pcm_runtime *runtime, void *eld)
+{
+	u64 formats = SNDRV_PCM_FMTBIT_S16_LE;
+	int i;
+	const u8 *sad, *eld_buf = eld;
+
+	sad = drm_eld_sad(eld_buf);
+	if (!sad)
+		goto format_constraint;
+
+	for (i = drm_eld_sad_count(eld_buf); i > 0; i--, sad += 3) {
+		if (sad_format(sad) == 1) { /* AUDIO_CODING_TYPE_LPCM */
+
+			/* 20 bit */
+			if (sad_sample_bits_lpcm(sad) & 0x2)
+				formats |= SNDRV_PCM_FMTBIT_S32_LE;
+
+			/* 24 bit */
+			if (sad_sample_bits_lpcm(sad) & 0x4)
+				formats |= SNDRV_PCM_FMTBIT_S24_LE;
+		}
+	}
+
+format_constraint:
+	return snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT,
+				formats);
+}
+
 static int eld_limit_rates(struct snd_pcm_hw_params *params,
 			   struct snd_pcm_hw_rule *rule)
 {
@@ -93,7 +131,9 @@ int snd_pcm_hw_constraint_eld(struct snd_pcm_runtime *runtime, void *eld)
 	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  eld_limit_channels, eld,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return eld_limit_formats(runtime, eld);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_hw_constraint_eld);
-- 
1.9.1
