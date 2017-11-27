From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2000: Delete an error message for a failed memory allocation in wm2000_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:54:39 +0000
Message-ID: <E1eJOYB-0007Zw-Op@debutante>
References: <87078639-7ec0-c3cc-5399-5607f2329c63@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87078639-7ec0-c3cc-5399-5607f2329c63@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2000: Delete an error message for a failed memory allocation in wm2000_i2c_probe()

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

>From e866d87a7de38672f52c6e7567e88c3f82f937dc Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 22:28:00 +0100
Subject: [PATCH] ASoC: wm2000: Delete an error message for a failed memory
 allocation in wm2000_i2c_probe()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 23cde3a0dc11..ce936deed7e3 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -902,7 +902,6 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 					    wm2000->anc_download_size,
 					    GFP_KERNEL);
 	if (wm2000->anc_download == NULL) {
-		dev_err(&i2c->dev, "Out of memory\n");
 		ret = -ENOMEM;
 		goto err_supplies;
 	}
-- 
2.15.0
