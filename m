From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Add 96k sample rate" to
	the asoc tree
Date: Tue, 19 Apr 2016 18:15:43 +0100
Message-ID: <E1asZFX-0002Pe-0j@debutante>
References: <1461085144-28104-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB6D26262A
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 19:15:57 +0200 (CEST)
In-Reply-To: <1461085144-28104-1-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Add 96k sample rate

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

>From 041f9d336f28d3a45b31799bb8b5b2e1fa322321 Mon Sep 17 00:00:00 2001
From: Jeremy McDermond <nh6z@nh6z.net>
Date: Tue, 19 Apr 2016 09:59:04 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Add 96k sample rate

The TLV320AIC32x4 series supports 96ksps rates in hardware.  This patch
adds the necessary PLL divider values and clock settings to the table to
make 96ksps work.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index c6b6d551f4fe..2f8480c93b3c 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -159,7 +159,10 @@ static const struct aic32x4_rate_divs aic32x4_divs[] = {
 	/* 48k rate */
 	{AIC32X4_FREQ_12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4},
 	{AIC32X4_FREQ_24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4},
-	{AIC32X4_FREQ_25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4}
+	{AIC32X4_FREQ_25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4},
+
+	/* 96k rate */
+	{AIC32X4_FREQ_25000000, 96000, 2, 7, 8643, 64, 4, 4, 64, 4, 4, 1},
 };
 
 static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
@@ -564,7 +567,7 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_48000
+#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_96000
 #define AIC32X4_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
 			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-- 
2.8.0.rc3
