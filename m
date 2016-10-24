From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rk3399_gru_sound: Fix non static symbol warning" to the asoc tree
Date: Mon, 24 Oct 2016 19:03:36 +0100
Message-ID: <E1byjay-000129-Lg@debutante>
References: <1476717318-12684-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476717318-12684-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rk3399_gru_sound: Fix non static symbol warning

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

>From 818f76831992198121c8949789c71a1adb02e329 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 17 Oct 2016 15:15:18 +0000
Subject: [PATCH] ASoC: rk3399_gru_sound: Fix non static symbol warning

Fixes the following sparse warning:

sound/soc/rockchip/rk3399_gru_sound.c:41:14: warning:
 symbol 'rt5514_dmic_delay' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 9ed735a6cf49..0cbd23555ba4 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -38,7 +38,7 @@
 
 #define SOUND_FS	256
 
-unsigned int rt5514_dmic_delay;
+static unsigned int rt5514_dmic_delay;
 
 static struct snd_soc_jack rockchip_sound_jack;
 
-- 
2.8.1
