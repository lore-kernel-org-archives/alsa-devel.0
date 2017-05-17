From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: make local symbol rt5665_i2c_driver static" to the asoc tree
Date: Wed, 17 May 2017 10:51:51 +0100
Message-ID: <E1dAvcV-0006jb-5X@debutante>
References: <20170516162456.18284-1-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516162456.18284-1-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: make local symbol rt5665_i2c_driver static

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

>From 18fe7869764c0b86e8ce6539bbb6e528f1d9928f Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Tue, 16 May 2017 16:24:56 +0000
Subject: [PATCH] ASoC: rt5665: make local symbol rt5665_i2c_driver static

Fixes the following sparse warnings:

sound/soc/codecs/rt5665.c:4928:19: warning:
symbol 'rt5665_i2c_driver' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index c0f36d85ee4d..7420010fd8e9 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4929,7 +4929,7 @@ static struct acpi_device_id rt5665_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5665_acpi_match);
 #endif
 
-struct i2c_driver rt5665_i2c_driver = {
+static struct i2c_driver rt5665_i2c_driver = {
 	.driver = {
 		.name = "rt5665",
 		.of_match_table = of_match_ptr(rt5665_of_match),
-- 
2.11.0
