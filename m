From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/9] ALSA: pcm: Convert params_* mask helpers
	to static inline functions
Date: Mon, 29 Dec 2014 19:41:41 +0100
Message-ID: <1419878506-28684-4-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id B892C2605C4
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:51 +0100 (CET)
In-Reply-To: <1419878506-28684-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use static inline functions instead of macros for the remaining params_*()
helpers that have not been converted yet. This is slightly cleaner and
offers better type safety.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm_params.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 15760f5..bf51f22 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -325,12 +325,24 @@ static inline int snd_interval_eq(const struct snd_interval *i1, const struct sn
 		i1->max == i2->max && i1->openmax == i2->openmax;
 }
 
-#define params_access(p) ((__force snd_pcm_access_t)\
-		snd_mask_min(hw_param_mask_c((p), SNDRV_PCM_HW_PARAM_ACCESS)))
-#define params_format(p) ((__force snd_pcm_format_t)\
-		snd_mask_min(hw_param_mask_c((p), SNDRV_PCM_HW_PARAM_FORMAT)))
-#define params_subformat(p) \
-	snd_mask_min(hw_param_mask_c((p), SNDRV_PCM_HW_PARAM_SUBFORMAT))
+static inline snd_pcm_access_t params_access(const struct snd_pcm_hw_params *p)
+{
+	return (__force snd_pcm_access_t)snd_mask_min(hw_param_mask_c(p,
+		SNDRV_PCM_HW_PARAM_ACCESS));
+}
+
+static inline snd_pcm_format_t params_format(const struct snd_pcm_hw_params *p)
+{
+	return (__force snd_pcm_format_t)snd_mask_min(hw_param_mask_c(p,
+		SNDRV_PCM_HW_PARAM_FORMAT));
+}
+
+static inline snd_pcm_subformat_t
+params_subformat(const struct snd_pcm_hw_params *p)
+{
+	return (__force snd_pcm_subformat_t)snd_mask_min(hw_param_mask_c(p,
+		SNDRV_PCM_HW_PARAM_SUBFORMAT));
+}
 
 static inline unsigned int
 params_period_bytes(const struct snd_pcm_hw_params *p)
-- 
1.8.0
