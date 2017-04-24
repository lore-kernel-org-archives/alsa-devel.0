From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Call snd_soc_set_dmi_name()
	unconditionally" to the asoc tree
Date: Mon, 24 Apr 2017 19:20:52 +0100
Message-ID: <E1d2ibU-0000iP-Tk@debutante>
References: <20170424065442.13490-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7D882674C6
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 20:21:03 +0200 (CEST)
In-Reply-To: <20170424065442.13490-3-tiwai@suse.de>
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

   ASoC: Call snd_soc_set_dmi_name() unconditionally

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

>From 861886d338f7dd802be972e770a695bba62f397a Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 24 Apr 2017 08:54:42 +0200
Subject: [PATCH] ASoC: Call snd_soc_set_dmi_name() unconditionally

Since recently UCM can pick up a configuration specific to the board
via card longname field, and we introduced a helper function
snd_soc_set_dmi_name() for that.  So far, it was used only in one
place (sound/soc/intel/boards/broadwell.c), but it should be more
widely applied.

This patch puts a big hammer for that: it lets snd_soc_register_card()
calling snd_soc_set_dmi_name() unconditionally, so that all x86
devices get the better longname string.  This would have no impact for
other systems without DMI support, as snd_soc_set_dmi_name() is no-op
on them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/broadwell.c | 3 ---
 sound/soc/soc-core.c               | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index faf865bb1765..6dcbbcefc25b 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -269,9 +269,6 @@ static struct snd_soc_card broadwell_rt286 = {
 static int broadwell_audio_probe(struct platform_device *pdev)
 {
 	broadwell_rt286.dev = &pdev->dev;
-
-	snd_soc_set_dmi_name(&broadwell_rt286, NULL);
-
 	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 52f6d9c28df9..05c4d9564b0b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2192,6 +2192,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
 					card->num_of_dapm_routes);
 
+	/* try to set some sane longname if DMI is available */
+	snd_soc_set_dmi_name(card, NULL);
+
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s", card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
-- 
2.11.0
