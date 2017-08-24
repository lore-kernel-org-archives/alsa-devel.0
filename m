From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-analog: always true condition" to the asoc tree
Date: Thu, 24 Aug 2017 11:50:10 +0100
Message-ID: <E1dkpiE-0000tb-Ii@debutante>
References: <20170824100741.s4v24owbvocshr5n@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170824100741.s4v24owbvocshr5n@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Damien Riegel <damien.riegel@savoirfairelinux.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Bhumika Goyal <bhumirks@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-analog: always true condition

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

>From 56026714bd45fccda710114982789c5145285560 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 24 Aug 2017 13:07:41 +0300
Subject: [PATCH] ASoC: codecs: msm8916-wcd-analog: always true condition

Static checkers complain that unsigned int val is always >= 0.  The
context is that snd_soc_read() returns -1U on error.  This is harmless
because we're checking that CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK is not
set, and it will always be set for -1U.  I could have just removed the
check against -1 but I preserved it because I thought it helped with
readability.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index f834a639b350..cd4d60ef4c77 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -949,7 +949,7 @@ static irqreturn_t mbhc_btn_release_irq_handler(int irq, void *arg)
 		u32 val = snd_soc_read(codec, CDC_A_MBHC_RESULT_1);
 
 		/* check if its BTN0 thats released */
-		if ((val >= 0) && !(val & CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK))
+		if ((val != -1) && !(val & CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK))
 			priv->mbhc_btn0_pressed = false;
 
 	} else {
-- 
2.14.1

