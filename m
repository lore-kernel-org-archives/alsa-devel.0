From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: deprecate MICBIAS widget type" to the asoc tree
Date: Fri, 13 May 2016 08:59:12 +0100
Message-ID: <E1b1808-00051m-GF@debutante>
References: <20160512120131.30a91984.john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160512120131.30a91984.john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: deprecate MICBIAS widget type

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

>From 32902177f7f6ae70e1d5e71d935aa1bfcae7f01c Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Thu, 12 May 2016 13:55:53 +0100
Subject: [PATCH] ASoC: dapm: deprecate MICBIAS widget type

Commit 086d7f804e26 ("ASoC: Convert WM8962 MICBIAS to a supply widget",
2011-09-23) says:

	A supply widget is generally clearer than a MICBIAS widget and a
	mic bias is just a type of supply so use a supply widget for the
	MICBIAS. This also avoids confusion with the routing when
	connected to multiple inputs.

but this has never been documented as a policy.  Add some comments to
make it clear.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 97069466c38d..3101d53468aa 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -100,6 +100,7 @@ struct device;
 {       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
+/* DEPRECATED: use SND_SOC_DAPM_SUPPLY */
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_micbias, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
@@ -473,7 +474,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_out_drv,			/* output driver */
 	snd_soc_dapm_adc,			/* analog to digital converter */
 	snd_soc_dapm_dac,			/* digital to analog converter */
-	snd_soc_dapm_micbias,		/* microphone bias (power) */
+	snd_soc_dapm_micbias,		/* microphone bias (power) - DEPRECATED: use snd_soc_dapm_supply */
 	snd_soc_dapm_mic,			/* microphone */
 	snd_soc_dapm_hp,			/* headphones */
 	snd_soc_dapm_spk,			/* speaker */
-- 
2.8.1
