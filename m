From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: asihpi: clean up indentation, remove extraneous tab" to the asoc tree
Date: Sat, 17 Nov 2018 03:28:14 +0000 (GMT)
Message-ID: <20181117032814.CDBA4440079@finisterre.ee.mobilebroadband>
References: <20181116150636.5226-2-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116150636.5226-2-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: asihpi: clean up indentation, remove extraneous tab

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

>From 7806869c6e5ea3c48aee80a72c790c55e6c3c303 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 16 Nov 2018 15:06:33 +0000
Subject: [PATCH] ASoC: tlv320aic31xx: asihpi: clean up indentation, remove
 extraneous tab

The return statement is indented too much by one level, fix this by
removing an extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 608ad49ad978..c6048d95c6d3 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1095,7 +1095,7 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if (freq/i > 20000000) {
 		dev_err(aic31xx->dev, "%s: Too high mclk frequency %u\n",
 			__func__, freq);
-			return -EINVAL;
+		return -EINVAL;
 	}
 	aic31xx->p_div = i;
 
-- 
2.19.1
