From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98371: Add terminate entry for i2c_device_id tables" to the asoc tree
Date: Mon, 22 Aug 2016 18:59:24 +0100
Message-ID: <E1bbtVM-0000uW-Ru@debutante>
References: <1471793836-28055-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471793836-28055-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Axel Lin <axel.lin@ingics.com>, anish kumar <yesanishhere@gmail.com>, Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98371: Add terminate entry for i2c_device_id tables

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

>From 209c721ce27022656a9d792b89572c4fdd7d31a7 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sun, 21 Aug 2016 15:37:16 +0000
Subject: [PATCH] ASoC: max98371: Add terminate entry for i2c_device_id tables

Make sure i2c_device_id tables are NULL terminated.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98371.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index cf0a39bb631a..02352ed8961c 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -412,6 +412,7 @@ static int max98371_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id max98371_i2c_id[] = {
 	{ "max98371", 0 },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, max98371_i2c_id);
-- 
2.8.1
