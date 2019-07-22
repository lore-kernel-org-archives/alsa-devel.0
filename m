From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wcd9335: Fix misuse of GENMASK macro" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:09 +0100 (BST)
Message-ID: <20190722122209.6CBB02740463@ypsilon.sirena.org.uk>
References: <92e31a9f321fe731d428ec3ec9d4654ea8a16d1b.1562734889.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <92e31a9f321fe731d428ec3ec9d4654ea8a16d1b.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wcd9335: Fix misuse of GENMASK macro

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

>From f7408a3d5b5fd10571a653d1a81ce9167c62727f Mon Sep 17 00:00:00 2001
From: Joe Perches <joe@perches.com>
Date: Tue, 9 Jul 2019 22:04:25 -0700
Subject: [PATCH] ASoC: wcd9335: Fix misuse of GENMASK macro

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/r/92e31a9f321fe731d428ec3ec9d4654ea8a16d1b.1562734889.git.joe@perches.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd-clsh-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index c397d713f01a..cc5a9c9b918b 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -65,7 +65,7 @@ struct wcd_clsh_ctrl {
 #define WCD9XXX_FLYBACK_EN_PWDN_WITH_DELAY			0
 #define WCD9XXX_RX_BIAS_FLYB_BUFF			WCD9335_REG(0x6, 0xC7)
 #define WCD9XXX_RX_BIAS_FLYB_VNEG_5_UA_MASK		GENMASK(7, 4)
-#define WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK		GENMASK(0, 3)
+#define WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK		GENMASK(3, 0)
 #define WCD9XXX_HPH_L_EN				WCD9335_REG(0x6, 0xD3)
 #define WCD9XXX_HPH_CONST_SEL_L_MASK			GENMASK(7, 3)
 #define WCD9XXX_HPH_CONST_SEL_BYPASS			0
-- 
2.20.1
