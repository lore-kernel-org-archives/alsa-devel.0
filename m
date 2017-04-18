From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: use j for internal loop counter" to the asoc tree
Date: Tue, 18 Apr 2017 19:00:01 +0100
Message-ID: <E1d0XQ1-0007AX-G3@debutante>
References: <20170415174954.90707-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170415174954.90707-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: use j for internal loop counter

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

>From d7766aa57ab0084498add21ddbf99547116f6b71 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 15 Apr 2017 18:49:54 +0100
Subject: [PATCH] ASoC: topology: use j for internal loop counter

Currently variable i is being for 2 nested for loops. Fix this by
using integer loop counter j for the inside for loop.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8e3df8ba9b68..3a5818829e6c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -495,12 +495,13 @@ static void remove_widget(struct snd_soc_component *comp,
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 			struct soc_enum *se =
 				(struct soc_enum *)kcontrol->private_value;
+			int j;
 
 			snd_ctl_remove(card, kcontrol);
 
 			kfree(se->dobj.control.dvalues);
-			for (i = 0; i < se->items; i++)
-				kfree(se->dobj.control.dtexts[i]);
+			for (j = 0; j < se->items; j++)
+				kfree(se->dobj.control.dtexts[j]);
 
 			kfree(se);
 		}
-- 
2.11.0
