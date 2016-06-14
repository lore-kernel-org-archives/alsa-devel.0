From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: mark pm functions __maybe_unused" to the asoc tree
Date: Tue, 14 Jun 2016 16:09:19 +0100
Message-ID: <E1bCpxv-0001Xq-4X@finisterre>
References: <24871235.njqcnbLnL2@wuerfel>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24871235.njqcnbLnL2@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: mark pm functions __maybe_unused

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

>From 4983d32526ab6db2f8bd2288def8abf2da5f37b2 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jun 2016 12:19:31 +0200
Subject: [PATCH] ASoC: nau8825: mark pm functions __maybe_unused

The newly added nau8825_dai_is_active() function is only called from
the PM logic that is build-time conditional in this driver, so we get
a warning when CONFIG_PM is disabled:

sound/soc/codecs/nau8825.c:229:13: error: 'nau8825_dai_is_active' defined but not used [-Werror=unused-function]
 static bool nau8825_dai_is_active(struct nau8825 *nau8825)

By replacing the #ifdef around the functions with a __maybe_unused
annotation, the code becomes more robust to this kind of problem
and we no longer get the warning while also slightly improving
readability.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b50455fab459 ("ASoC: nau8825: cross talk suppression measurement function")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 4b0a1b8d9405..3f30e6ed210c 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2216,8 +2216,7 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int nau8825_suspend(struct snd_soc_codec *codec)
+static int __maybe_unused nau8825_suspend(struct snd_soc_codec *codec)
 {
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 
@@ -2229,7 +2228,7 @@ static int nau8825_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int nau8825_resume(struct snd_soc_codec *codec)
+static int __maybe_unused nau8825_resume(struct snd_soc_codec *codec)
 {
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 
@@ -2253,10 +2252,6 @@ static int nau8825_resume(struct snd_soc_codec *codec)
 
 	return 0;
 }
-#else
-#define nau8825_suspend NULL
-#define nau8825_resume NULL
-#endif
 
 static struct snd_soc_codec_driver nau8825_codec_driver = {
 	.probe = nau8825_codec_probe,
-- 
2.8.1
