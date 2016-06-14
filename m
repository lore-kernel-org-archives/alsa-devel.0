From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ASoC: nau8825: mark pm functions __maybe_unused
Date: Tue, 14 Jun 2016 12:19:31 +0200
Message-ID: <24871235.njqcnbLnL2@wuerfel>
References: <5926900.hCFXH4RQH6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5926900.hCFXH4RQH6@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, John Hsu <KCHSU0@nuvoton.com>, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org

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
---
Like the first patch, this is for a warning that just appeared on today's
linux-next.

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
