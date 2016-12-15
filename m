From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: kfree kcontrol->private_value before freeing kcontrol" to the asoc tree
Date: Thu, 15 Dec 2016 12:21:14 +0000
Message-ID: <E1cHV2A-0000kr-68@debutante>
References: <20161209141747.4776-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209141747.4776-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: kfree kcontrol->private_value before freeing kcontrol

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

>From c2b36129ce53a22b89dd2b88db33e7ffdefe0f41 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 9 Dec 2016 14:17:47 +0000
Subject: [PATCH] ASoC: topology: kfree kcontrol->private_value before freeing
 kcontrol

kcontrol->private_value is being kfree'd after kcontrol has been freed
(in previous call to snd_ctl_remove).  Instead, fix this by kfreeing
the private_value before kcontrol.

CoverityScan CID#1388311 "Read from pointer after free"

Fixes: eea3dd4f1247a ("ASoC: topology: Only free TLV for volume mixers of a widget")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 65670b2b408c..fbfb1fab88d5 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -514,13 +514,12 @@ static void remove_widget(struct snd_soc_component *comp,
 			    == SND_SOC_TPLG_TYPE_MIXER)
 				kfree(kcontrol->tlv.p);
 
-			snd_ctl_remove(card, kcontrol);
-
 			/* Private value is used as struct soc_mixer_control
 			 * for volume mixers or soc_bytes_ext for bytes
 			 * controls.
 			 */
 			kfree((void *)kcontrol->private_value);
+			snd_ctl_remove(card, kcontrol);
 		}
 		kfree(w->kcontrol_news);
 	}
-- 
2.11.0
