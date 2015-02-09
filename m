From: yang.a.fang@intel.com
Subject: [PATCH v2 1/2] ALSA: Add params_set_format helper
Date: Sun,  8 Feb 2015 16:01:36 -0800
Message-ID: <1423440097-95191-1-git-send-email-yang.a.fang@intel.com>
References: <1423181956-108810-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C04E26048D
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 01:02:01 +0100 (CET)
In-Reply-To: <1423181956-108810-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, denny.iriawan@intel.com, harshapriya.n@intel.com, praveen.k.jain@intel.com, kevin.strasser@intel.com, vinod.koul@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, tiwai@suse.de, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

Add a helper to set pcm format directly from params

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 include/sound/pcm_params.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 6b1c78f..e6fe584 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -366,4 +366,11 @@ params_physical_width(const struct snd_pcm_hw_params *p)
 	return snd_pcm_format_physical_width(params_format(p));
 }
 
+static inline void
+params_set_format(struct snd_pcm_hw_params *p, snd_pcm_format_t fmt)
+{
+	snd_mask_set(&p->masks[SNDRV_PCM_HW_PARAM_FORMAT -
+		SNDRV_PCM_HW_PARAM_FIRST_MASK], (__force int)fmt);
+}
+
 #endif /* __SOUND_PCM_PARAMS_H */
-- 
1.7.9.5
