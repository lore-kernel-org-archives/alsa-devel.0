From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol" to the asoc tree
Date: Mon, 25 Mar 2019 12:22:02 +0000 (GMT)
Message-ID: <20190325122202.8E77111288F1@debutante.sirena.org.uk>
References: <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, pankaj.laxminarayan.bharadiya@intel.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol

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

>From cacea3a90e211f0c111975535508d446a4a928d2 Mon Sep 17 00:00:00 2001
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Date: Fri, 22 Mar 2019 18:00:09 +0530
Subject: [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_free_kcontrol

w_text_param can be NULL and it is being dereferenced without checking.
Add the missing sanity check to prevent  NULL pointer dereference.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef6d161..67b032ca1601 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3957,6 +3957,10 @@ snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
 	int count;
 
 	devm_kfree(card->dev, (void *)*private_value);
+
+	if (!w_param_text)
+		return;
+
 	for (count = 0 ; count < num_params; count++)
 		devm_kfree(card->dev, (void *)w_param_text[count]);
 	devm_kfree(card->dev, w_param_text);
-- 
2.20.1
