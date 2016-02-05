From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: pcm: Add snd_pcm_rate_range_to_bits()"
	to the asoc tree
Date: Fri, 05 Feb 2016 18:53:38 +0000
Message-ID: <E1aRlVi-0003UD-I3@debutante>
References: <f34caedda0fb6329d07130203ef24ff6fa8ee47e.1452844210.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9D02260698
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 19:53:49 +0100 (CET)
In-Reply-To: <f34caedda0fb6329d07130203ef24ff6fa8ee47e.1452844210.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: pcm: Add snd_pcm_rate_range_to_bits()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3bdff244a2bcbde37ec33bf3cdde4638049c6c38 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Fri, 15 Jan 2016 16:13:10 +0800
Subject: [PATCH] ALSA: pcm: Add snd_pcm_rate_range_to_bits()

This helper function can convert a given sample rate range to
SNDRV_PCM_RATE_xxx bits.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/pcm.h   |  2 ++
 sound/core/pcm_misc.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b0be09279943..af1fb37c6b26 100644
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
index ebe8444de6c6..53dc37357bca 100644
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
2.7.0.rc3
