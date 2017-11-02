From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: stm32: sai: fix warning in stm32_sai_set_config()" to the asoc tree
Date: Thu, 02 Nov 2017 11:05:55 +0000
Message-ID: <E1eADJr-0002Cr-9J@debutante>
References: <1509618009-30804-1-git-send-email-olivier.moysan@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1509618009-30804-1-git-send-email-olivier.moysan-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Olivier Moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgolivier.moysan-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: fix warning in stm32_sai_set_config()

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

>From 7e751e375ae7218f8b49f0b47e855cf9bbbdbcf9 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Date: Thu, 2 Nov 2017 11:20:09 +0100
Subject: [PATCH] ASoC: stm32: sai: fix warning in stm32_sai_set_config()

Fix uninitialized warning introduced by
"Move static settings to DAI init" commit
in stm32_sai_set_config() function.

Signed-off-by: Olivier Moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/stm/stm32_sai_sub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 150ad546d8b9..08583b958430 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -482,13 +482,13 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 	cr1_mask = SAI_XCR1_DS_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_8);
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_16);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_16);
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_32);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_32);
 		break;
 	default:
 		dev_err(cpu_dai->dev, "Data format not supported");
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
