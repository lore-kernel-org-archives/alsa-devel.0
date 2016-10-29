From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8580: Fix non static symbol warnings" to the asoc tree
Date: Sat, 29 Oct 2016 12:12:51 -0600
Message-ID: <E1c0Y7f-0007fI-Vh@finisterre>
References: <1477758443-5682-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477758443-5682-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matt Flax <flatmax@flatmax.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8580: Fix non static symbol warnings

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

>From 2f3d1b659344ad28bd559dcb2176e9ae84a2b044 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sat, 29 Oct 2016 16:27:23 +0000
Subject: [PATCH] ASoC: wm8580: Fix non static symbol warnings

Fixes the following sparse warnings:

sound/soc/codecs/wm8580.c:988:33: warning:
 symbol 'wm8580_data' was not declared. Should it be static?
sound/soc/codecs/wm8580.c:992:33: warning:
 symbol 'wm8581_data' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8580.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index aecd3c99e604..da93b703ed49 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -985,11 +985,11 @@ static const struct regmap_config wm8580_regmap = {
 	.volatile_reg = wm8580_volatile,
 };
 
-const struct wm8580_driver_data wm8580_data = {
+static const struct wm8580_driver_data wm8580_data = {
 	.num_dacs = 3,
 };
 
-const struct wm8580_driver_data wm8581_data = {
+static const struct wm8580_driver_data wm8581_data = {
 	.num_dacs = 4,
 };
 
-- 
2.10.1
