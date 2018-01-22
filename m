From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmic: Fix check of return value from read of 'num-channels'" to the asoc tree
Date: Mon, 22 Jan 2018 12:26:31 +0000
Message-ID: <E1edbBH-0004cm-1y@debutante>
References: <20180119233650.100472-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119233650.100472-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmic: Fix check of return value from read of 'num-channels'

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

>From 35b84bf0614a7da98bfbbac70ed3d01c3b5b6c58 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Fri, 19 Jan 2018 15:36:50 -0800
Subject: [PATCH] ASoC: dmic: Fix check of return value from read of
 'num-channels'

Commit 7fb59e940f62 ("ASoC: codecs: dmic: Make number of channels
 configurable") introduces an optional property to the device tree
to specify the number of DMIC channels. dmic_codec_probe() uses
of_property_read_u32() to read the DT value, and expects a return
value of -ENOENT when the property does not exist. This expectation
is incorrect, the actual value returned in this case is -EINVAL (see
of_find_property_value_of_size(), which is called under the hood).
Check for -EINVAL instead.

Fixes: 7fb59e940f62 ("ASoC: codecs: dmic: Make number of channels configurable")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index c88f974ebe3e..cf83c423394d 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -113,7 +113,7 @@ static int dmic_dev_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		err = of_property_read_u32(pdev->dev.of_node, "num-channels", &chans);
-		if (err && (err != -ENOENT))
+		if (err && (err != -EINVAL))
 			return err;
 
 		if (!err) {
-- 
2.15.1
