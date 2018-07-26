From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: pcm: Add snd_mask_set_format() helper
	for standard usages" to the asoc tree
Date: Thu, 26 Jul 2018 17:11:56 +0100 (BST)
Message-ID: <20180726161156.4B28144008C@finisterre.ee.mobilebroadband>
References: <20180725211722.18944-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 998A12673A0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:45 +0200 (CEST)
In-Reply-To: <20180725211722.18944-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: pcm: Add snd_mask_set_format() helper for standard usages

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0b62834e73e332fea76a340d62aaf50c732b17e0 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 25 Jul 2018 23:17:17 +0200
Subject: [PATCH] ALSA: pcm: Add snd_mask_set_format() helper for standard
 usages

Many drivers calling snd_mask_set() need to do ugly cast with __force
for shutting up the sparse warnings.  Actually almost all of them are
about setting the format, so it's far better to provide a common
helper snd_mask_set_format() to pass SNDRV_PCM_FORMAT_* directly
without the cast.

There are a few other calls of snd_mask_set(), but they are in the PCM
core code, so we leave them for now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
