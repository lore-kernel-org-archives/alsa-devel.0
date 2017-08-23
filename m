From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: Fix unused variable warning" to
	the asoc tree
Date: Wed, 23 Aug 2017 12:24:57 +0100
Message-ID: <E1dkTmL-0007Eb-QH@debutante>
References: <20170823060343.25275-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 34A3E26731F
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:25:01 +0200 (CEST)
In-Reply-To: <20170823060343.25275-1-tiwai@suse.de>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tegra: Fix unused variable warning

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

>From f3f7df7635bd5fb6dbc8de150613d327a3bd6171 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 23 Aug 2017 08:03:43 +0200
Subject: [PATCH] ASoC: tegra: Fix unused variable warning

Fixes: 2a8bd83af30e ("ASoC: tegra: Remove superfluous snd_soc_jack_free_gpios() call")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_wm8903.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index ce498cc0914b..05f95944669a 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -203,7 +203,6 @@ static int tegra_wm8903_remove(struct snd_soc_card *card)
 		snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
 
 	wm8903_mic_detect(codec, NULL, 0, 0);
 
-- 
2.14.1
