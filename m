From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: remove read-only status
	register from snd_kcontrol_new" to the asoc tree
Date: Tue,  6 Nov 2018 18:09:13 +0000 (GMT)
Message-ID: <20181106180913.48E00112266B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 16AE6267AA5
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 19:09:14 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: remove read-only status register from snd_kcontrol_new

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

>From 223bc10b84970fd772c105b550beeef3ac3502be Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 04:33:02 +0000
Subject: [PATCH] ASoC: pcm3168a: remove read-only status register from
 snd_kcontrol_new

"DACn Zero Flag" and "ADCn Overflow Flag" are read-only status
register. These information are needed for driver not for user.
Let's remove these from snd_kcontrol_new.

There is no detail explanation for these register on
datasheet, but, judging from its behavior, it seems these register
needs clock to read. Otherwise, I2C returns error.
Therefor, amixer command will be failed under non working timing.

Without this patch, user often fail amixer command.
This patch is tested on R-Car H3 ulcb-kf board, SSI3/4 TDM sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 5f4327f5b725..115f21658222 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -133,10 +133,6 @@ static const struct snd_kcontrol_new pcm3168a_snd_controls[] = {
 	SOC_DOUBLE("DAC2 Invert Switch", PCM3168A_DAC_INV, 2, 3, 1, 0),
 	SOC_DOUBLE("DAC3 Invert Switch", PCM3168A_DAC_INV, 4, 5, 1, 0),
 	SOC_DOUBLE("DAC4 Invert Switch", PCM3168A_DAC_INV, 6, 7, 1, 0),
-	SOC_DOUBLE_STS("DAC1 Zero Flag", PCM3168A_DAC_ZERO, 0, 1, 1, 0),
-	SOC_DOUBLE_STS("DAC2 Zero Flag", PCM3168A_DAC_ZERO, 2, 3, 1, 0),
-	SOC_DOUBLE_STS("DAC3 Zero Flag", PCM3168A_DAC_ZERO, 4, 5, 1, 0),
-	SOC_DOUBLE_STS("DAC4 Zero Flag", PCM3168A_DAC_ZERO, 6, 7, 1, 0),
 	SOC_ENUM("DAC Volume Control Type", pcm3168a_dac_volume_type),
 	SOC_ENUM("DAC Volume Rate Multiplier", pcm3168a_dac_att_mult),
 	SOC_ENUM("DAC De-Emphasis", pcm3168a_dac_demp),
@@ -176,9 +172,6 @@ static const struct snd_kcontrol_new pcm3168a_snd_controls[] = {
 	SOC_DOUBLE("ADC1 Mute Switch", PCM3168A_ADC_MUTE, 0, 1, 1, 0),
 	SOC_DOUBLE("ADC2 Mute Switch", PCM3168A_ADC_MUTE, 2, 3, 1, 0),
 	SOC_DOUBLE("ADC3 Mute Switch", PCM3168A_ADC_MUTE, 4, 5, 1, 0),
-	SOC_DOUBLE_STS("ADC1 Overflow Flag", PCM3168A_ADC_OV, 0, 1, 1, 0),
-	SOC_DOUBLE_STS("ADC2 Overflow Flag", PCM3168A_ADC_OV, 2, 3, 1, 0),
-	SOC_DOUBLE_STS("ADC3 Overflow Flag", PCM3168A_ADC_OV, 4, 5, 1, 0),
 	SOC_ENUM("ADC Volume Control Type", pcm3168a_adc_volume_type),
 	SOC_ENUM("ADC Volume Rate Multiplier", pcm3168a_adc_att_mult),
 	SOC_ENUM("ADC Overflow Flag Polarity", pcm3168a_adc_ov_pol),
-- 
2.19.0.rc2
