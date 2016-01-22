From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: Fix WM8960_SYSCLK_PLL mode" to
	the asoc tree
Date: Fri, 22 Jan 2016 18:26:54 +0000
Message-ID: <E1aMgQA-0004DP-W6@debutante>
References: <1453208949-23946-2-git-send-email-stuarth@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA12C261B03
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:27:02 +0100 (CET)
In-Reply-To: <1453208949-23946-2-git-send-email-stuarth@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stuart Henderson <stuart.henderson@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: Fix WM8960_SYSCLK_PLL mode

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

>From 6bb7451429084cefcb3a18fff809f7992595d2af Mon Sep 17 00:00:00 2001
From: Stuart Henderson <stuart.henderson@cirrus.com>
Date: Tue, 19 Jan 2016 13:09:09 +0000
Subject: [PATCH] ASoC: wm8960: Fix WM8960_SYSCLK_PLL mode

With the introduction of WM8960_SYSCLK_AUTO mode, WM8960_SYSCLK_PLL mode was
made unusable.  Ensure we're not PLL mode before trying to use MCLK.

Fixes: 3176bf2d7ccd ("ASoC: wm8960: update pll and clock setting function")
Signed-off-by: Stuart Henderson <stuart.henderson@cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 66057f853fae..4b4401329591 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -631,29 +631,31 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	/* check if the sysclk frequency is available. */
-	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
-		if (sysclk_divs[i] == -1)
-			continue;
-		sysclk = freq_out / sysclk_divs[i];
-		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
-			if (sysclk == dac_divs[j] * lrclk) {
+	if (wm8960->clk_id != WM8960_SYSCLK_PLL) {
+		/* check if the sysclk frequency is available. */
+		for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+			if (sysclk_divs[i] == -1)
+				continue;
+			sysclk = freq_out / sysclk_divs[i];
+			for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
+				if (sysclk != dac_divs[j] * lrclk)
+					continue;
 				for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k)
 					if (sysclk == bclk * bclk_divs[k] / 10)
 						break;
 				if (k != ARRAY_SIZE(bclk_divs))
 					break;
 			}
+			if (j != ARRAY_SIZE(dac_divs))
+				break;
 		}
-		if (j != ARRAY_SIZE(dac_divs))
-			break;
-	}
 
-	if (i != ARRAY_SIZE(sysclk_divs)) {
-		goto configure_clock;
-	} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
-		dev_err(codec->dev, "failed to configure clock\n");
-		return -EINVAL;
+		if (i != ARRAY_SIZE(sysclk_divs)) {
+			goto configure_clock;
+		} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
+			dev_err(codec->dev, "failed to configure clock\n");
+			return -EINVAL;
+		}
 	}
 	/* get a available pll out frequency and set pll */
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
-- 
2.7.0.rc3
