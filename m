From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: wm8960: Stop when a matching PLL freq is found" to the asoc tree
Date: Thu, 06 Apr 2017 19:55:20 +0100
Message-ID: <E1cwCYy-0001lq-GL@debutante>
References: <1491479514-24862-2-git-send-email-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491479514-24862-2-git-send-email-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.combroonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, ckeepax@opensource.wolfsonmicro.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec: wm8960: Stop when a matching PLL freq is found

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

>From 303e8954af8daa087e4f42788672d280337071ab Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Thu, 6 Apr 2017 14:51:53 +0300
Subject: [PATCH] ASoC: codec: wm8960: Stop when a matching PLL freq is found

When a matching PLL freq is found, searching continues even this is
not necessary. The problem was introduced with the following refactoring
commit 84fdc00d519ffd ("ASoC: codec: wm9860: Refactor PLL out freq search)

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 36c84549da23..ace69da97cb8 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -724,7 +724,11 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 					break;
 				}
 			}
+			if (k != ARRAY_SIZE(bclk_divs))
+				break;
 		}
+		if (j != ARRAY_SIZE(dac_divs))
+			break;
 	}
 
 	if (*bclk_idx != -1)
-- 
2.11.0
