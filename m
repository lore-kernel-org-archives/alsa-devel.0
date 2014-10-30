From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/8] ALSA: pcm: Convert params_*() with static
	inline functions
Date: Thu, 30 Oct 2014 16:06:19 +0100
Message-ID: <1414681581-4619-7-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 21459260642
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:24 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 08025ADE0
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:24 +0000 (UTC)
In-Reply-To: <1414681581-4619-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

... and add proper kerneldoc comments.
There is no big reason to keep them as macros.  Static inline
functions are safer in general, and suitable for kerneldoc, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h | 65 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index f78a5722f5cc..29eb09ef2969 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -841,18 +841,59 @@ static inline const struct snd_interval *hw_param_interval_c(const struct snd_pc
 	return &params->intervals[var - SNDRV_PCM_HW_PARAM_FIRST_INTERVAL];
 }
 
-#define params_channels(p) \
-	(hw_param_interval_c((p), SNDRV_PCM_HW_PARAM_CHANNELS)->min)
-#define params_rate(p) \
-	(hw_param_interval_c((p), SNDRV_PCM_HW_PARAM_RATE)->min)
-#define params_period_size(p) \
-	(hw_param_interval_c((p), SNDRV_PCM_HW_PARAM_PERIOD_SIZE)->min)
-#define params_periods(p) \
-	(hw_param_interval_c((p), SNDRV_PCM_HW_PARAM_PERIODS)->min)
-#define params_buffer_size(p) \
-	(hw_param_interval_c((p), SNDRV_PCM_HW_PARAM_BUFFER_SIZE)->min)
-#define params_buffer_bytes(p) \
-	(hw_param_interval_c((p), SNDRV_PCM_HW_PARAM_BUFFER_BYTES)->min)
+/**
+ * params_channels - Get the number of channels from the hw params
+ * @p: hw params
+ */
+static inline unsigned int params_channels(const struct snd_pcm_hw_params *p)
+{
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_CHANNELS)->min;
+}
+
+/**
+ * params_channels - Get the sample rate from the hw params
+ * @p: hw params
+ */
+static inline unsigned int params_rate(const struct snd_pcm_hw_params *p)
+{
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_RATE)->min;
+}
+
+/**
+ * params_channels - Get the period size (in frames) from the hw params
+ * @p: hw params
+ */
+static inline unsigned int params_period_size(const struct snd_pcm_hw_params *p)
+{
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_PERIOD_SIZE)->min;
+}
+
+/**
+ * params_channels - Get the number of periods from the hw params
+ * @p: hw params
+ */
+static inline unsigned int params_periods(const struct snd_pcm_hw_params *p)
+{
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_PERIODS)->min;
+}
+
+/**
+ * params_channels - Get the buffer size (in frames) from the hw params
+ * @p: hw params
+ */
+static inline unsigned int params_buffer_size(const struct snd_pcm_hw_params *p)
+{
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_BUFFER_SIZE)->min;
+}
+
+/**
+ * params_channels - Get the buffer size (in bytes) from the hw params
+ * @p: hw params
+ */
+static inline unsigned int params_buffer_bytes(const struct snd_pcm_hw_params *p)
+{
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_BUFFER_BYTES)->min;
+}
 
 int snd_interval_refine(struct snd_interval *i, const struct snd_interval *v);
 void snd_interval_mul(const struct snd_interval *a, const struct snd_interval *b, struct snd_interval *c);
-- 
2.1.2
