From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm186x: make pcm186x_dai_ops and pcm186x_adc_input_channel_sel_value static" to the asoc tree
Date: Thu, 07 Dec 2017 17:48:26 +0000
Message-ID: <E1eN0Ha-00043M-32@debutante>
References: <20171207141132.25928-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207141132.25928-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Michael Stecklein <m-stecklein@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm186x: make pcm186x_dai_ops and pcm186x_adc_input_channel_sel_value static

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

>From dce231a484f72983cd7d5832aed4da04870a4d47 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 7 Dec 2017 14:11:32 +0000
Subject: [PATCH] ASoC: pcm186x: make pcm186x_dai_ops and
 pcm186x_adc_input_channel_sel_value static

pcm186x_dai_ops and pcm186x_adc_input_channel_sel_value are local to the
source and do not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'pcm186x_dai_ops' was not declared. Should it be static?
symbol 'pcm186x_adc_input_channel_sel_value' was not declared. Should it
be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm186x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index f7aa56e20169..cdb51427facc 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -59,7 +59,7 @@ static const struct snd_kcontrol_new pcm1865_snd_controls[] = {
 			   pcm186x_pga_tlv),
 };
 
-const unsigned int pcm186x_adc_input_channel_sel_value[] = {
+static const unsigned int pcm186x_adc_input_channel_sel_value[] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x20, 0x30
@@ -475,7 +475,7 @@ static int pcm186x_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
-const struct snd_soc_dai_ops pcm186x_dai_ops = {
+static const struct snd_soc_dai_ops pcm186x_dai_ops = {
 	.set_sysclk = pcm186x_set_dai_sysclk,
 	.set_tdm_slot = pcm186x_set_tdm_slot,
 	.set_fmt = pcm186x_set_fmt,
-- 
2.15.1
