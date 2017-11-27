From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Delete an error message for a failed memory allocation in da7213_fw_to_pdata()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:53 +0000
Message-ID: <E1eJOXR-0007QY-LS@debutante>
References: <6dc71b14-4c14-82f6-9dad-92bfa9854de2@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6dc71b14-4c14-82f6-9dad-92bfa9854de2@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, support.opensource@diasemi.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Delete an error message for a failed memory allocation in da7213_fw_to_pdata()

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

>From 13d5ea5f10b7359cd0f846179fe0b2411e12cfeb Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 17:56:54 +0100
Subject: [PATCH] ASoC: da7213: Delete an error message for a failed memory
 allocation in da7213_fw_to_pdata()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 41d9b1da27c2..d1b77a0e3b74 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1654,10 +1654,8 @@ static struct da7213_platform_data
 	u32 fw_val32;
 
 	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_warn(codec->dev, "Failed to allocate memory for pdata\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	if (device_property_read_u32(dev, "dlg,micbias1-lvl", &fw_val32) >= 0)
 		pdata->micbias1_lvl = da7213_of_micbias_lvl(codec, fw_val32);
-- 
2.15.0
