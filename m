From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: fix boolean assignment" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:09 +0000 (GMT)
Message-ID: <20190107185809.69B7D1127492@debutante.sirena.org.uk>
References: <20190105020249.8639-16-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-16-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, John Hsu <KCHSU0@nuvoton.com>, liam.r.girdwood@linux.intel.combroonie@kernel.org, Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: fix boolean assignment

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

>From 290da7a7e349566f0e1541b14f25b722f58f236b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:43 -0600
Subject: [PATCH] ASoC: nau8824: fix boolean assignment

Reported by Coccinelle:
nau8824.c:810:6-12: ERROR: Assignment of bool to non-0/1 constant

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 468d5143e2c4..87ed3dc496dc 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -807,7 +807,7 @@ static const struct snd_soc_dapm_route nau8824_dapm_routes[] = {
 static bool nau8824_is_jack_inserted(struct nau8824 *nau8824)
 {
 	struct snd_soc_jack *jack = nau8824->jack;
-	bool insert = FALSE;
+	bool insert = false;
 
 	if (nau8824->irq && jack)
 		insert = jack->status & SND_JACK_HEADPHONE;
-- 
2.20.1
