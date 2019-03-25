From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai" to the asoc tree
Date: Mon, 25 Mar 2019 16:11:45 +0000 (GMT)
Message-ID: <20190325161145.0ABA511288F1@debutante.sirena.org.uk>
References: <1553271819-24576-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553271819-24576-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, pankaj.laxminarayan.bharadiya@intel.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai

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

>From 8633d44002ba5c98f44bacc1397190adba832fd6 Mon Sep 17 00:00:00 2001
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Date: Fri, 22 Mar 2019 21:53:39 +0530
Subject: [PATCH] ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai

In case of single config, private_value is left uninitialized.

The private_value does need to be initialized or in
snd_soc_dapm_new_control_unlocked() call failure case, it leads to a
bogus free in snd_soc_dapm_free_kcontrol()

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef6d161..74a6f5705f66 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4038,7 +4038,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
 	const char **w_param_text;
-	unsigned long private_value;
+	unsigned long private_value = 0;
 	char *link_name;
 	int ret;
 
-- 
2.20.1
