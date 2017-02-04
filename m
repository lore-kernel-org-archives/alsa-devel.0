From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: es8328: Add support for slave mode" to the asoc tree
Date: Sat, 04 Feb 2017 13:18:21 +0100
Message-ID: <E1cZzIL-0005TI-2e@finisterre>
References: <20170124100835.9540-3-romain.perier@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170124100835.9540-3-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Add support for slave mode

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

>From b9b044e2967dd47f0ffe98b5a989fc99c684f6d2 Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Date: Fri, 3 Feb 2017 15:37:57 +0100
Subject: [PATCH] ASoC: es8328: Add support for slave mode

Currently, the function that changes the DAI format only supports master
mode. Trying to use a slave mode exits the function with -EINVAL and
leave the codec misconfigured. This commits adds support for enabling
the slave mode.

Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/es8328.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 37722194b107..3f84fbd071e2 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -589,9 +589,21 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	u8 dac_mode = 0;
 	u8 adc_mode = 0;
 
-	/* set master/slave audio interface */
-	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* Master serial port mode, with BCLK generated automatically */
+		snd_soc_update_bits(codec, ES8328_MASTERMODE,
+				    ES8328_MASTERMODE_MSC,
+				    ES8328_MASTERMODE_MSC);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Slave serial port mode */
+		snd_soc_update_bits(codec, ES8328_MASTERMODE,
+				    ES8328_MASTERMODE_MSC, 0);
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -620,10 +632,6 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	snd_soc_update_bits(codec, ES8328_ADCCONTROL4,
 			ES8328_ADCCONTROL4_ADCFORMAT_MASK, adc_mode);
 
-	/* Master serial port mode, with BCLK generated automatically */
-	snd_soc_update_bits(codec, ES8328_MASTERMODE,
-			ES8328_MASTERMODE_MSC, ES8328_MASTERMODE_MSC);
-
 	return 0;
 }
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
