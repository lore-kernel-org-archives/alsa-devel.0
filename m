From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/3] ALSA: pcm: Add
	snd_pcm_rate_range_to_bits()
Date: Fri, 15 Jan 2016 16:13:10 +0800
Message-ID: <f34caedda0fb6329d07130203ef24ff6fa8ee47e.1452844210.git.mengdong.lin@linux.intel.com>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F3F4926058E
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 09:13:11 +0100 (CET)
In-Reply-To: <cover.1452844210.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This helper function can convert a given sample rate range to
SNDRV_PCM_RATE_xxx bits.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b0be092..af1fb37 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1093,6 +1093,8 @@ unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate);
 unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit);
 unsigned int snd_pcm_rate_mask_intersect(unsigned int rates_a,
 					 unsigned int rates_b);
+unsigned int snd_pcm_rate_range_to_bits(unsigned int rate_min,
+					unsigned int rate_max);
 
 /**
  * snd_pcm_set_runtime_buffer - Set the PCM runtime buffer
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index ebe8444..53dc373 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -565,3 +565,33 @@ unsigned int snd_pcm_rate_mask_intersect(unsigned int rates_a,
 	return rates_a & rates_b;
 }
 EXPORT_SYMBOL_GPL(snd_pcm_rate_mask_intersect);
+
+/**
+ * snd_pcm_rate_range_to_bits - converts rate range to SNDRV_PCM_RATE_xxx bit
+ * @rate_min: the minimum sample rate
+ * @rate_max: the maximum sample rate
+ *
+ * This function has an implicit assumption: the rates in the given range have
+ * only the pre-defined rates like 44100 or 16000.
+ *
+ * Return: The SNDRV_PCM_RATE_xxx flag that corresponds to the given rate range,
+ * or SNDRV_PCM_RATE_KNOT for an unknown range.
+ */
+unsigned int snd_pcm_rate_range_to_bits(unsigned int rate_min,
+	unsigned int rate_max)
+{
+	unsigned int rates = 0;
+	int i;
+
+	for (i = 0; i < snd_pcm_known_rates.count; i++) {
+		if (snd_pcm_known_rates.list[i] >= rate_min
+			&& snd_pcm_known_rates.list[i] <= rate_max)
+			rates |= 1 << i;
+	}
+
+	if (!rates)
+		rates = SNDRV_PCM_RATE_KNOT;
+
+	return rates;
+}
+EXPORT_SYMBOL_GPL(snd_pcm_rate_range_to_bits);
-- 
2.5.0
