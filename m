From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: don't fail if sysclk
	setting is not supported" to the asoc tree
Date: Wed, 27 Jan 2016 20:27:23 +0000
Message-ID: <E1aOWgV-0001xN-UD@debutante>
References: <1453588600-14831-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1062D260504
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 21:27:33 +0100 (CET)
In-Reply-To: <1453588600-14831-3-git-send-email-aaro.koskinen@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: don't fail if sysclk setting is not supported

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

>From ee43a1a0cd2a8f33cddfa1323a60b5cfcf865ba0 Mon Sep 17 00:00:00 2001
From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 24 Jan 2016 00:36:40 +0200
Subject: [PATCH] ASoC: simple-card: don't fail if sysclk setting is not
 supported

Commit e22579713ae1 ("ASoC: simple card: set cpu-dai sysclk
with mclk-fs") added sysclk / SND_SOC_CLOCK_OUT setting, that makes
asoc_simple_card_hw_params fail if the operation is not supported,
although the intention clearly was to ignore ENOTSUPP. Fix it.

The patch fixes audio playback on Kirkwood / OpenRD client,
where the following errors are seen:

	asoc-simple-card sound: ASoC: machine hw_params failed: -524
	alsa-lib: /alsa-lib-1.0.28/src/pcm/pcm_hw.c:327:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed (-524): Unknown error 524

Fixes: e22579713ae1 ("ASoC: simple card: set cpu-dai sysclk with mclk-fs")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 1ded8811598e..2389ab47e25f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -99,7 +99,7 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 		if (ret && ret != -ENOTSUPP)
 			goto err;
 	}
-
+	return 0;
 err:
 	return ret;
 }
-- 
2.7.0.rc3
