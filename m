From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Provide a dummy wrapper of
	snd_soc_set_dmi_name()" to the asoc tree
Date: Mon, 24 Apr 2017 19:20:56 +0100
Message-ID: <E1d2ibY-0000jT-21@debutante>
References: <20170421155525.15012-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E36202674C9
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 20:21:05 +0200 (CEST)
In-Reply-To: <20170421155525.15012-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Provide a dummy wrapper of snd_soc_set_dmi_name()

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

>From 1f5a4535db41bd2bb8d1a15f098cb2921d6c1317 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 24 Apr 2017 08:54:41 +0200
Subject: [PATCH] ASoC: Provide a dummy wrapper of snd_soc_set_dmi_name()

For systems without DMI, it makes no sense to have the code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 8 ++++++++
 sound/soc/soc-core.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cdfb55f7aede..915c06cb2b32 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -497,7 +497,15 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
 int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	unsigned int dai_fmt);
 
+#ifdef CONFIG_DMI
 int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour);
+#else
+static inline int snd_soc_set_dmi_name(struct snd_soc_card *card,
+				       const char *flavour)
+{
+	return 0;
+}
+#endif
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6dca408faae3..52f6d9c28df9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1918,6 +1918,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
 
+#ifdef CONFIG_DMI
 /* Trim special characters, and replace '-' with '_' since '-' is used to
  * separate different DMI fields in the card long name. Only number and
  * alphabet characters and a few separator characters are kept.
@@ -2049,6 +2050,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
+#endif /* CONFIG_DMI */
 
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
-- 
2.11.0
