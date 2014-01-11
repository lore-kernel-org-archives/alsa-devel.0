From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 4/5] ALSA: Add helper function for
	intersecting two rate masks
Date: Sat, 11 Jan 2014 10:24:43 +0100
Message-ID: <1389432284-6792-4-git-send-email-lars@metafoo.de>
References: <1389432284-6792-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D5682616E9
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 10:24:27 +0100 (CET)
In-Reply-To: <1389432284-6792-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

A bit of special care is necessary when creating the intersection of two rate
masks. This comes from the special meaning of the SNDRV_PCM_RATE_CONTINUOUS and
SNDRV_PCM_RATE_KNOT bits, which needs special handling when intersecting two
rate masks. SNDRV_PCM_RATE_CONTINUOUS means the hardware supports all rates in a
specific interval. SNDRV_PCM_RATE_KNOT means the hardware supports a set of
discrete rates specified by a list constraint. For all other cases the supported
rates are specified directly in the rate mask.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
Changes since v1:
	* Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
---
 include/sound/pcm.h   |  2 ++
 sound/core/pcm_misc.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 84b10f9..d017091 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -901,6 +901,8 @@ extern const struct snd_pcm_hw_constraint_list snd_pcm_known_rates;
 int snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime);
 unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate);
 unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit);
+unsigned int snd_pcm_rate_mask_intersect(unsigned int rates_a,
+					 unsigned int rates_b);
 
 static inline void snd_pcm_set_runtime_buffer(struct snd_pcm_substream *substream,
 					      struct snd_dma_buffer *bufp)
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 43f24cc..4560ca0 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -514,3 +514,42 @@ unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit)
 	return 0;
 }
 EXPORT_SYMBOL(snd_pcm_rate_bit_to_rate);
+
+static unsigned int snd_pcm_rate_mask_sanitize(unsigned int rates)
+{
+	if (rates & SNDRV_PCM_RATE_CONTINUOUS)
+		return SNDRV_PCM_RATE_CONTINUOUS;
+	else if (rates & SNDRV_PCM_RATE_KNOT)
+		return SNDRV_PCM_RATE_KNOT;
+	return rates;
+}
+
+/**
+ * snd_pcm_rate_mask_intersect - computes the intersection between two rate masks
+ * @rates_a: The first rate mask
+ * @rates_b: The second rate mask
+ *
+ * This function computes the rates that are supported by both rate masks passed
+ * to the function. It will take care of the special handling of
+ * SNDRV_PCM_RATE_CONTINUOUS and SNDRV_PCM_RATE_KNOT.
+ *
+ * Return: A rate mask containing the rates that are supported by both rates_a
+ * and rates_b.
+ */
+unsigned int snd_pcm_rate_mask_intersect(unsigned int rates_a,
+	unsigned int rates_b)
+{
+	rates_a = snd_pcm_rate_mask_sanitize(rates_a);
+	rates_b = snd_pcm_rate_mask_sanitize(rates_b);
+
+	if (rates_a & SNDRV_PCM_RATE_CONTINUOUS)
+		return rates_b;
+	else if (rates_b & SNDRV_PCM_RATE_CONTINUOUS)
+		return rates_a;
+	else if (rates_a & SNDRV_PCM_RATE_KNOT)
+		return rates_b;
+	else if (rates_b & SNDRV_PCM_RATE_KNOT)
+		return rates_a;
+	return rates_a & rates_b;
+}
+EXPORT_SYMBOL_GPL(snd_pcm_rate_mask_intersect);
-- 
1.8.0
