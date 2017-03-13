From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: returning uninitialized in probe()" to the asoc tree
Date: Mon, 13 Mar 2017 16:57:49 +0000
Message-ID: <E1cnTI5-00050Z-FK@debutante>
References: <20170313123237.GA9287@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170313123237.GA9287@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: returning uninitialized in probe()

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

>From bfe41c678d49f440de3ae80b945f7f94d5dbd340 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 13 Mar 2017 15:32:37 +0300
Subject: [PATCH] ASoC: cs35l35: returning uninitialized in probe()

If cs35l35->pdata.stereo is false then "ret" isn't initialized.

Fixes: 6387f866a2cc ("ASoC: Add support for Cirrus Logic CS35L35 Amplifier")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 6a266516f543..05117fca7e3c 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -969,7 +969,7 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_cs35l35 = {
-- 
2.11.0

