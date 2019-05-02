From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: fix DAI_CLK_EN register bit overwrite" to the asoc tree
Date: Thu,  2 May 2019 03:18:03 +0100 (BST)
Message-ID: <20190502021803.9926D441D56@finisterre.ee.mobilebroadband>
References: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Adam.Thomson.Opensource@diasemi.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, logesh.kolandavel@timesys.comMark Brown <broonie@kernel.org>, perex@perex.cz, support.opensource@diasemi.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: fix DAI_CLK_EN register bit overwrite

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From 414a7321d60bc0abced4a760e22b8187e2b4aecf Mon Sep 17 00:00:00 2001
From: Logesh <logesh.kolandavel@timesys.com>
Date: Wed, 1 May 2019 14:34:24 +0530
Subject: [PATCH] ASoC: da7213: fix DAI_CLK_EN register bit overwrite

If the da7213 codec is configured as Master with the DAPM power down
delay time set, 'snd_soc_component_write' function overwrites the
DAI_CLK_EN bit of DAI_CLK_MODE register which leads to audio play
only once until it re-initialize after codec power up.

Signed-off-by: Logesh <logesh.kolandavel@timesys.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 5 ++++-
 sound/soc/codecs/da7213.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 92d006a5283e..425c11d63e49 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1305,7 +1305,10 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* By default only 64 BCLK per WCLK is supported */
 	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_64;
 
-	snd_soc_component_write(component, DA7213_DAI_CLK_MODE, dai_clk_mode);
+	snd_soc_component_update_bits(component, DA7213_DAI_CLK_MODE,
+			    DA7213_DAI_BCLKS_PER_WCLK_MASK |
+			    DA7213_DAI_CLK_POL_MASK | DA7213_DAI_WCLK_POL_MASK,
+			    dai_clk_mode);
 	snd_soc_component_update_bits(component, DA7213_DAI_CTRL, DA7213_DAI_FORMAT_MASK,
 			    dai_ctrl);
 	snd_soc_component_write(component, DA7213_DAI_OFFSET, dai_offset);
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 5a78dba1dcb5..9d31efc3cfe5 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -181,7 +181,9 @@
 #define DA7213_DAI_BCLKS_PER_WCLK_256				(0x3 << 0)
 #define DA7213_DAI_BCLKS_PER_WCLK_MASK				(0x3 << 0)
 #define DA7213_DAI_CLK_POL_INV					(0x1 << 2)
+#define DA7213_DAI_CLK_POL_MASK					(0x1 << 2)
 #define DA7213_DAI_WCLK_POL_INV					(0x1 << 3)
+#define DA7213_DAI_WCLK_POL_MASK				(0x1 << 3)
 #define DA7213_DAI_CLK_EN_MASK					(0x1 << 7)
 
 /* DA7213_DAI_CTRL = 0x29 */
-- 
2.20.1
