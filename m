From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt274: fix boolean tests" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:18 +0000 (GMT)
Message-ID: <20190107185818.983281127491@debutante.sirena.org.uk>
References: <20190105020249.8639-11-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-11-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, liam.r.girdwood@linux.intel.combroonie@kernel.org, Bard Liao <bardliao@realtek.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt274: fix boolean tests

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

>From b793a1e4ebad5c9066f404dee13fec875fb9b4e5 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:38 -0600
Subject: [PATCH] ASoC: rt274: fix boolean tests

Reported by Coccinelle:

sound/soc/codecs/rt274.c:958:6-8: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:961:6-9: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:384:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:387:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt274.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index e2855ab9a2c6..9e88f7b25d38 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -381,10 +381,10 @@ static void rt274_jack_detect_work(struct work_struct *work)
 	if (rt274_jack_detect(rt274, &hp, &mic) < 0)
 		return;
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt274->jack, status,
@@ -955,10 +955,10 @@ static irqreturn_t rt274_irq(int irq, void *data)
 	ret = rt274_jack_detect(rt274, &hp, &mic);
 
 	if (ret == 0) {
-		if (hp == true)
+		if (hp)
 			status |= SND_JACK_HEADPHONE;
 
-		if (mic == true)
+		if (mic)
 			status |= SND_JACK_MICROPHONE;
 
 		snd_soc_jack_report(rt274->jack, status,
-- 
2.20.1
