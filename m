From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: wm8960: Refactor sysclk freq search" to the asoc tree
Date: Fri, 24 Mar 2017 19:16:05 +0000
Message-ID: <E1crUgv-00061m-3u@debutante>
References: <1490090976-25877-2-git-send-email-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490090976-25877-2-git-send-email-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, tiwai@suse.com, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.comckeepax@opensource.wolfsonmicro.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec: wm8960: Refactor sysclk freq search

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

>From 3ddc97211cbb61a5f59882c26f8e3158c86e34bb Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 21 Mar 2017 17:03:24 +0200
Subject: [PATCH] ASoC: codec: wm8960: Refactor sysclk freq search

Add a separate function for finding (sysclk, lrclk, bclk)
when the clock is auto or mclk. This makes code easier to
read and reduces the indentation level in wm8960_configure_clocking.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 80 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 3bf081a7e450..25a4a11929fe 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -604,12 +604,71 @@ static const int bclk_divs[] = {
 	120, 160, 220, 240, 320, 320, 320
 };
 
+/**
+ * wm8960_configure_sysclk - checks if there is a sysclk frequency available
+ *	The sysclk must be chosen such that:
+ *		- sysclk     = MCLK / sysclk_divs
+ *		- lrclk      = sysclk / dac_divs
+ *		- 10 * bclk  = sysclk / bclk_divs
+ *
+ * @wm8960_priv: wm8960 codec private data
+ * @mclk: MCLK used to derive sysclk
+ * @sysclk_idx: sysclk_divs index for found sysclk
+ * @dac_idx: dac_divs index for found lrclk
+ * @bclk_idx: bclk_divs index for found bclk
+ *
+ * Returns:
+ * -1, in case no sysclk frequency available found
+ *  0, in case an exact (@sysclk_idx, @dac_idx, @bclk_idx) match is found
+ */
+static
+int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
+			    int *sysclk_idx, int *dac_idx, int *bclk_idx)
+{
+	int sysclk, bclk, lrclk;
+	int i, j, k;
+	int diff;
+
+	bclk = wm8960->bclk;
+	lrclk = wm8960->lrclk;
+
+	/* check if the sysclk frequency is available. */
+	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+		if (sysclk_divs[i] == -1)
+			continue;
+		sysclk = mclk / sysclk_divs[i];
+		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
+			if (sysclk != dac_divs[j] * lrclk)
+				continue;
+			for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k) {
+				diff = sysclk - bclk * bclk_divs[k] / 10;
+				if (diff == 0) {
+					*sysclk_idx = i;
+					*dac_idx = j;
+					*bclk_idx = k;
+					break;
+				}
+			}
+			if (k != ARRAY_SIZE(bclk_divs))
+				break;
+		}
+		if (j != ARRAY_SIZE(dac_divs))
+			break;
+	}
+
+	if (i != ARRAY_SIZE(sysclk_divs))
+		return 0;
+
+	return -1;
+}
+
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int sysclk, bclk, lrclk, freq_out, freq_in;
 	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
 	int i, j, k;
+	int ret;
 
 	if (!(iface1 & (1<<6))) {
 		dev_dbg(codec->dev,
@@ -643,25 +702,8 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 	}
 
 	if (wm8960->clk_id != WM8960_SYSCLK_PLL) {
-		/* check if the sysclk frequency is available. */
-		for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
-			if (sysclk_divs[i] == -1)
-				continue;
-			sysclk = freq_out / sysclk_divs[i];
-			for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
-				if (sysclk != dac_divs[j] * lrclk)
-					continue;
-				for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k)
-					if (sysclk == bclk * bclk_divs[k] / 10)
-						break;
-				if (k != ARRAY_SIZE(bclk_divs))
-					break;
-			}
-			if (j != ARRAY_SIZE(dac_divs))
-				break;
-		}
-
-		if (i != ARRAY_SIZE(sysclk_divs)) {
+		ret = wm8960_configure_sysclk(wm8960, freq_out, &i, &j, &k);
+		if (ret == 0) {
 			goto configure_clock;
 		} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
 			dev_err(codec->dev, "failed to configure clock\n");
-- 
2.11.0
