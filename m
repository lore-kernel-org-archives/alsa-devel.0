From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: do not declare support for mono DAI" to the asoc tree
Date: Tue, 27 Sep 2016 09:36:27 -0700
Message-ID: <E1bovMp-0005Es-6Q@finisterre>
References: <1474965015-29243-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474965015-29243-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bastien Nocera <hadess@hadess.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: do not declare support for mono DAI

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

>From 3520646dbb22832fa65dae6899d8cb068257d4aa Mon Sep 17 00:00:00 2001
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date: Tue, 27 Sep 2016 11:30:15 +0300
Subject: [PATCH] ASoC: tlv320aic31xx: do not declare support for mono DAI

This hardware supports only 2-channel DAI, even mono ADC digital output
has two channels with the same data.

Having min_channels=1 results in broken playback of mono files in setups
where CPU DAI supports mono.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 725173b12725..be1a64bfd320 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1213,7 +1213,7 @@ static struct snd_soc_dai_driver dac31xx_dai_driver[] = {
 		.name = "tlv32dac31xx-hifi",
 		.playback = {
 			.stream_name	 = "Playback",
-			.channels_min	 = 1,
+			.channels_min	 = 2,
 			.channels_max	 = 2,
 			.rates		 = AIC31XX_RATES,
 			.formats	 = AIC31XX_FORMATS,
@@ -1228,14 +1228,14 @@ static struct snd_soc_dai_driver aic31xx_dai_driver[] = {
 		.name = "tlv320aic31xx-hifi",
 		.playback = {
 			.stream_name	 = "Playback",
-			.channels_min	 = 1,
+			.channels_min	 = 2,
 			.channels_max	 = 2,
 			.rates		 = AIC31XX_RATES,
 			.formats	 = AIC31XX_FORMATS,
 		},
 		.capture = {
 			.stream_name	 = "Capture",
-			.channels_min	 = 1,
+			.channels_min	 = 2,
 			.channels_max	 = 2,
 			.rates		 = AIC31XX_RATES,
 			.formats	 = AIC31XX_FORMATS,
-- 
2.9.3
