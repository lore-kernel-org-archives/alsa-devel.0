From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Fix PGA clear when disabling DRE" to the asoc tree
Date: Wed, 06 Jan 2016 18:12:26 +0000
Message-ID: <E1aGsZO-0007DY-K5@debutante>
References: <1452093337-30396-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1452093337-30396-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: stable-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5110: Fix PGA clear when disabling DRE

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

>From 24338722cfa23fdf4e08c6189a11f7e3a902d86a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 6 Jan 2016 15:15:37 +0000
Subject: [PATCH] ASoC: wm5110: Fix PGA clear when disabling DRE

We don't want to use a bypassed write in wm5110_clear_pga_volume,
we might disable the DRE whilst the CODEC is powered down. A
normal regmap_write will always go to the hardware (when not on
cache_only) even if the written value matches the cache. As using
a normal write will still achieve the desired behaviour of bring
the cache and hardware in sync, this patch updates the function
to use a normal write, which avoids issues when the CODEC is
powered down.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm5110.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c04c0bc6f58a..52b9ccf6d389 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -360,15 +360,13 @@ static int wm5110_hp_ev(struct snd_soc_dapm_widget *w,
 
 static int wm5110_clear_pga_volume(struct arizona *arizona, int output)
 {
-	struct reg_sequence clear_pga = {
-		ARIZONA_OUTPUT_PATH_CONFIG_1L + output * 4, 0x80
-	};
+	unsigned int reg = ARIZONA_OUTPUT_PATH_CONFIG_1L + output * 4;
 	int ret;
 
-	ret = regmap_multi_reg_write_bypassed(arizona->regmap, &clear_pga, 1);
+	ret = regmap_write(arizona->regmap, reg, 0x80);
 	if (ret)
 		dev_err(arizona->dev, "Failed to clear PGA (0x%x): %d\n",
-			clear_pga.reg, ret);
+			reg, ret);
 
 	return ret;
 }
-- 
2.7.0.rc3
