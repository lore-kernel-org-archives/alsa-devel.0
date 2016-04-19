From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Disallow unsupported 32KHz clock setting in set_dai_sysclk()" to the asoc tree
Date: Tue, 19 Apr 2016 17:41:34 +0100
Message-ID: <E1asYiU-0001fU-GT@debutante>
References: <2f0a44c076880b6e39aa8440f9a021f9627f34a3.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2f0a44c076880b6e39aa8440f9a021f9627f34a3.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Disallow unsupported 32KHz clock setting in set_dai_sysclk()

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

>From fb137ba64a6415ddf231495f6d1a82de1cd69ed0 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 19 Apr 2016 15:19:03 +0100
Subject: [PATCH] ASoC: da7219: Disallow unsupported 32KHz clock setting in
 set_dai_sysclk()

The PLL function was updated to disallow 32KHz in
commit 501f72e9c520 ("ASoC: da7219: Remove support for 32KHz PLL mode"),
but set_dai_sysclk() was missed and still permits it. This patch resolves
that discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 3b1d65badbda..caea2ee19d9a 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1025,7 +1025,7 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq))
 		return 0;
 
-	if (((freq < 2000000) && (freq != 32768)) || (freq > 54000000)) {
+	if ((freq < 2000000) || (freq > 54000000)) {
 		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
-- 
2.8.0.rc3
