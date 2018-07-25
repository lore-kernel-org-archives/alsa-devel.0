From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: pcm: Add snd_mask_set_format()
	helper for standard usages
Date: Wed, 25 Jul 2018 23:17:17 +0200
Message-ID: <20180725211722.18944-2-tiwai@suse.de>
References: <20180725211722.18944-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 359CF267762
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:17:27 +0200 (CEST)
In-Reply-To: <20180725211722.18944-1-tiwai@suse.de>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Many drivers calling snd_mask_set() need to do ugly cast with __force
for shutting up the sparse warnings.  Actually almost all of them are
about setting the format, so it's far better to provide a common
helper snd_mask_set_format() to pass SNDRV_PCM_FORMAT_* directly
without the cast.

There are a few other calls of snd_mask_set(), but they are in the PCM
core code, so we leave them for now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm_params.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index c704357775fc..2dd37cada7c0 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -87,6 +87,13 @@ static inline void snd_mask_set(struct snd_mask *mask, unsigned int val)
 	mask->bits[MASK_OFS(val)] |= MASK_BIT(val);
 }
 
+/* Most of drivers need only this one */
+static inline void snd_mask_set_format(struct snd_mask *mask,
+				       snd_pcm_format_t format)
+{
+	snd_mask_set(mask, (__force unsigned int)format);
+}
+
 static inline void snd_mask_reset(struct snd_mask *mask, unsigned int val)
 {
 	mask->bits[MASK_OFS(val)] &= ~MASK_BIT(val);
@@ -369,8 +376,7 @@ static inline int params_physical_width(const struct snd_pcm_hw_params *p)
 static inline void
 params_set_format(struct snd_pcm_hw_params *p, snd_pcm_format_t fmt)
 {
-	snd_mask_set(hw_param_mask(p, SNDRV_PCM_HW_PARAM_FORMAT),
-		(__force int)fmt);
+	snd_mask_set_format(hw_param_mask(p, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
 }
 
 #endif /* __SOUND_PCM_PARAMS_H */
-- 
2.18.0
