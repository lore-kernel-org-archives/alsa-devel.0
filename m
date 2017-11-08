From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: msm8916-wcd-analog: mark expected
	switch fall-through" to the asoc tree
Date: Wed, 08 Nov 2017 21:31:52 +0000
Message-ID: <E1eCXwu-0005M0-Lm@debutante>
References: <2ab74b1aac4e26dcc083e09e9e066770a00dd8ca.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D4832267662
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:33:44 +0100 (CET)
In-Reply-To: <2ab74b1aac4e26dcc083e09e9e066770a00dd8ca.1510170034.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: msm8916-wcd-analog: mark expected switch fall-through

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

>From dc10622bb32f08383cf5a9942a91042d8f38bf3d Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Wed, 8 Nov 2017 14:04:09 -0600
Subject: [PATCH] ASoC: msm8916-wcd-analog: mark expected switch fall-through

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1397957
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 549c269acc7d..518fa2a4ac78 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -614,6 +614,7 @@ static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
 		case CDC_A_TX_2_EN:
 			snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
 					    MICB_1_CTL_CFILT_REF_SEL_MASK, 0);
+			/* fall through */
 		case CDC_A_TX_3_EN:
 			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
 					    CONN_TX2_SERIAL_TX2_MUX,
-- 
2.15.0
