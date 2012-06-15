From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Add snd_pcm_rate_bit_to_rate()
Date: Fri, 15 Jun 2012 16:35:28 +0100
Message-ID: <1339774528-12358-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75DE424834
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 17:35:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is essentially the reverse of snd_pcm_rate_to_rate_bit().

This is generally useful as the Compress API uses the rate bit
directly and it helps to be able to map back to the actual sample
rate.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/pcm.h   |    1 +
 sound/core/pcm_misc.c |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1d58d79..18ad1f1 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -892,6 +892,7 @@ extern const struct snd_pcm_hw_constraint_list snd_pcm_known_rates;
 
 int snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime);
 unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate);
+unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit);
 
 static inline void snd_pcm_set_runtime_buffer(struct snd_pcm_substream *substream,
 					      struct snd_dma_buffer *bufp)
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 9c9eff9..d4fc1bf 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -488,3 +488,21 @@ unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate)
 	return SNDRV_PCM_RATE_KNOT;
 }
 EXPORT_SYMBOL(snd_pcm_rate_to_rate_bit);
+
+/**
+ * snd_pcm_rate_bit_to_rate - converts SNDRV_PCM_RATE_xxx bit to sample rate
+ * @rate_bit: the rate bit to convert
+ *
+ * Returns the sample rate that corresponds to the given SNDRV_PCM_RATE_xxx flag
+ * or 0 for an unknown rate bit
+ */
+unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit)
+{
+	unsigned int i;
+
+	for (i = 0; i < snd_pcm_known_rates.count; i++)
+		if ((1u << i) == rate_bit)
+			return snd_pcm_known_rates.list[i];
+	return 0;
+}
+EXPORT_SYMBOL(snd_pcm_rate_bit_to_rate);
-- 
1.7.10.4
