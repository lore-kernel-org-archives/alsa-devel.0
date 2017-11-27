From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Delete two error messages for a failed memory allocation in da7218_of_to_pdata()" to the asoc tree
Date: Mon, 27 Nov 2017 18:54:01 +0000
Message-ID: <E1eJOXZ-0007T5-9U@debutante>
References: <d6ca1c55-1bb9-7ec2-de4a-63b994567d59@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6ca1c55-1bb9-7ec2-de4a-63b994567d59@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, support.opensource@diasemi.comAdam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Delete two error messages for a failed memory allocation in da7218_of_to_pdata()

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

>From 14a07f1d8c4c64af29566316df0415052e8bdfe4 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 20:42:20 +0100
Subject: [PATCH] ASoC: da7218: Delete two error messages for a failed memory
 allocation in da7218_of_to_pdata()

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 56564ce90cb6..25ab7443d803 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2455,10 +2455,8 @@ static struct da7218_pdata *da7218_of_to_pdata(struct snd_soc_codec *codec)
 	u32 of_val32;
 
 	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_warn(codec->dev, "Failed to allocate memory for pdata\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	if (of_property_read_u32(np, "dlg,micbias1-lvl-millivolt", &of_val32) >= 0)
 		pdata->micbias1_lvl = da7218_of_micbias_lvl(codec, of_val32);
@@ -2527,8 +2525,6 @@ static struct da7218_pdata *da7218_of_to_pdata(struct snd_soc_codec *codec)
 		hpldet_pdata = devm_kzalloc(codec->dev, sizeof(*hpldet_pdata),
 					    GFP_KERNEL);
 		if (!hpldet_pdata) {
-			dev_warn(codec->dev,
-				 "Failed to allocate memory for hpldet pdata\n");
 			of_node_put(hpldet_np);
 			return pdata;
 		}
-- 
2.15.0
