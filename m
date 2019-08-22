From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8988: fix typo in wm8988_right_line_controls" to the asoc tree
Date: Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Message-ID: <20190822183257.4E189D02CE7@fitzroy.sirena.org.uk>
References: <20190822143608.59824-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822143608.59824-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: allison@lohutok.net, alsa-devel@alsa-project.org, broonie@kernel.org, gregkh@linuxfoundation.org, Hulk Robot <hulkci@huawei.com>, info@metux.net, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, perex@perex.cz, tglx@linutronix.de, tiwai@suse.com, yuehaibing@huawei.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8988: fix typo in wm8988_right_line_controls

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From c101fb29737f4558bf589d0d66371d9e21040568 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 22 Aug 2019 22:36:08 +0800
Subject: [PATCH] ASoC: wm8988: fix typo in wm8988_right_line_controls

sound/soc/codecs/wm8988.c:270:30: warning:
 wm8988_rline_enum defined but not used [-Wunused-const-variable=]

wm8988_rline_enum should be used in wm8988_right_line_controls.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5409fb4e327a ("ASoC: Add WM8988 CODEC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190822143608.59824-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8988.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 25e74cf0666a..85bfd041d546 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -273,7 +273,7 @@ static const struct soc_enum wm8988_rline_enum =
 			      wm8988_line_texts,
 			      wm8988_line_values);
 static const struct snd_kcontrol_new wm8988_right_line_controls =
-	SOC_DAPM_ENUM("Route", wm8988_lline_enum);
+	SOC_DAPM_ENUM("Route", wm8988_rline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new wm8988_left_mixer_controls[] = {
-- 
2.20.1
