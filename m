From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] ASoC: rt5663: use msleep() for uncritical delay
Date: Wed, 11 Jan 2017 16:03:51 +0100
Message-ID: <1484147031-25525-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

The delay here does not seem to be critical with respect to longer
delays than 10ms as this delay is to ensure that the write took
effect before the next soc_update_bits/write call only, thus a 
high resolution timer makes little sense here - msleep() should do.

Fixes: commit df7c52168ee1 ("ASoC: add rt5663 codec driver")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Problem was found by cocinelle script.

msleep() of 10ms can take up to 20ms on HZ=100 systems but even this
does not seem critical here as this is not a very frequent operation
(that is not called in a loop)

In any case the delta of only 5 us seems unnecessarily small given that
jitter on almost all systems would be expected to be larger than 5us and
the microsecond precision really is not needed here.

This does throw a checkpatch warning with:
WARNING: msleep < 20ms can sleep for up to 20ms;"
but that seems ok in this case, presumably there are very few systems 
running audio subsystem that have HZ=100 set.

Patch was compile tested with: x86_64_defconfig + CONFIG_COMPILE_TEST=y
SND_SOC=m + SND_SOC_ALL_CODECS=m (implies SND_SOC_RT5663=m)

Patch is aginast 4.10-rc3 (localversion-next is next-20170111)

 sound/soc/codecs/rt5663.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index ed94830..2ecc600 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -2764,7 +2764,7 @@ static int rt5663_set_bias_level(struct snd_soc_codec *codec,
 			RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK |
 			RT5663_PWR_MB_MASK, RT5663_PWR_VREF1 |
 			RT5663_PWR_VREF2 | RT5663_PWR_MB);
-		usleep_range(10000, 10005);
+		msleep(10);
 		if (rt5663->codec_ver == CODEC_VER_1) {
 			snd_soc_update_bits(codec, RT5663_SIG_CLK_DET,
 				RT5663_EN_ANA_CLK_DET_MASK |
-- 
2.1.4
