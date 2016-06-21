From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Fix non static symbol warnings" to the asoc tree
Date: Tue, 21 Jun 2016 19:52:44 +0100
Message-ID: <E1bFQmy-0008Nz-Tn@debutante>
References: <1466184120-13062-1-git-send-email-weiyj_lk@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466184120-13062-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Fix non static symbol warnings

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

>From ee85be8c9b5277a50bf6491c30b2736a5562331b Mon Sep 17 00:00:00 2001
From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date: Fri, 17 Jun 2016 17:22:00 +0000
Subject: [PATCH] ASoC: cs53l30: Fix non static symbol warnings

Fixes the following sparse warnings:

sound/soc/codecs/cs53l30.c:182:20: warning:
 symbol 'input1_sel_values' was not declared. Should it be static?
sound/soc/codecs/cs53l30.c:202:20: warning:
 symbol 'input2_sel_values' was not declared. Should it be static?
sound/soc/codecs/cs53l30.c:734:20: warning:
 symbol 'cs53l30_src_rates' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 384a3f79f1c5..a5976f3b589a 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -180,7 +180,7 @@ static const char * const input1_sel_text[] = {
 	"DMIC1 Off ADC1 Off",
 };
 
-unsigned int const input1_sel_values[] = {
+static unsigned int const input1_sel_values[] = {
 	CS53L30_CH_TYPE,
 	CS53L30_ADCxB_PDN | CS53L30_CH_TYPE,
 	CS53L30_ADCxA_PDN | CS53L30_CH_TYPE,
@@ -200,7 +200,7 @@ static const char * const input2_sel_text[] = {
 	"DMIC2 Off ADC2 Off",
 };
 
-unsigned int const input2_sel_values[] = {
+static unsigned int const input2_sel_values[] = {
 	0x0,
 	CS53L30_ADCxB_PDN,
 	CS53L30_ADCxA_PDN,
@@ -738,7 +738,7 @@ static int cs53l30_set_tristate(struct snd_soc_dai *dai, int tristate)
 				  CS53L30_ASP_3ST_MASK, val);
 }
 
-unsigned int const cs53l30_src_rates[] = {
+static unsigned int const cs53l30_src_rates[] = {
 	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
 };
 
-- 
2.8.1
