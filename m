From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: fix issue that pop noise when start capture" to the asoc tree
Date: Tue, 19 Dec 2017 10:58:55 +0000
Message-ID: <E1eRFbr-0000mh-4i@debutante>
References: <1513019426-9623-1-git-send-email-abhijeet.kumar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513019426-9623-1-git-send-email-abhijeet.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhijeet Kumar <abhijeet.kumar@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Hsu <KCHSU0@nuvoton.com>, Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: fix issue that pop noise when start capture

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

>From d070f7c703ef26e3db613f24206823f916272fc6 Mon Sep 17 00:00:00 2001
From: Abhijeet Kumar <abhijeet.kumar@intel.com>
Date: Tue, 12 Dec 2017 00:40:25 +0530
Subject: [PATCH] ASoC: nau8825: fix issue that pop noise when start capture

In skylake platform, we hear a loud pop noise(0 dB) at start of
audio capture power up sequence. This patch removes the pop noise
from the recording by adding a delay before enabling ADC.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 714ce17da717..e853a6dfd33b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -905,6 +905,7 @@ static int nau8825_adc_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		msleep(125);
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
 			NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
 		break;
-- 
2.15.1
