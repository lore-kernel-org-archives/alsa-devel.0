From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/9] ALSA: pcm: Add kernel doc for params_*()
	functions
Date: Mon, 29 Dec 2014 19:41:42 +0100
Message-ID: <1419878506-28684-5-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 578F02605C6
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:52 +0100 (CET)
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

Add kernel doc for the remaining undocumented params_*() functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm_params.h | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index bf51f22..2e2169e 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -325,18 +325,30 @@ static inline int snd_interval_eq(const struct snd_interval *i1, const struct sn
 		i1->max == i2->max && i1->openmax == i2->openmax;
 }
 
+/**
+ * params_access - get the access type from the hw params
+ * @p: hw params
+ */
 static inline snd_pcm_access_t params_access(const struct snd_pcm_hw_params *p)
 {
 	return (__force snd_pcm_access_t)snd_mask_min(hw_param_mask_c(p,
 		SNDRV_PCM_HW_PARAM_ACCESS));
 }
 
+/**
+ * params_format - get the sample format from the hw params
+ * @p: hw params
+ */
 static inline snd_pcm_format_t params_format(const struct snd_pcm_hw_params *p)
 {
 	return (__force snd_pcm_format_t)snd_mask_min(hw_param_mask_c(p,
 		SNDRV_PCM_HW_PARAM_FORMAT));
 }
 
+/**
+ * params_subformat - get the sample subformat from the hw params
+ * @p: hw params
+ */
 static inline snd_pcm_subformat_t
 params_subformat(const struct snd_pcm_hw_params *p)
 {
@@ -344,6 +356,10 @@ params_subformat(const struct snd_pcm_hw_params *p)
 		SNDRV_PCM_HW_PARAM_SUBFORMAT));
 }
 
+/**
+ * params_period_bytes - get the period size (in bytes) from the hw params
+ * @p: hw params
+ */
 static inline unsigned int
 params_period_bytes(const struct snd_pcm_hw_params *p)
 {
@@ -352,14 +368,27 @@ params_period_bytes(const struct snd_pcm_hw_params *p)
 		params_channels(p)) / 8;
 }
 
-static inline int
-params_width(const struct snd_pcm_hw_params *p)
+/**
+ * params_width - get the number of bits of the sample format from the hw params
+ * @p: hw params
+ *
+ * This function returns the number of bits per sample that the selected sample
+ * format of the hw params has.
+ */
+static inline int params_width(const struct snd_pcm_hw_params *p)
 {
 	return snd_pcm_format_width(params_format(p));
 }
 
-static inline int
-params_physical_width(const struct snd_pcm_hw_params *p)
+/*
+ * params_physical_width - get the storage size of the sample format from the hw params
+ * @p: hw params
+ *
+ * This functions returns the number of bits per sample that the selected sample
+ * format of the hw params takes up in memory. This will be equal or larger than
+ * params_width().
+ */
+static inline int params_physical_width(const struct snd_pcm_hw_params *p)
 {
 	return snd_pcm_format_physical_width(params_format(p));
 }
-- 
1.8.0
