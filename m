From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/2] ASoC: codec: wm8960: Refactor sysclk
	freq search
Date: Tue, 21 Mar 2017 12:09:35 +0200
Message-ID: <1490090976-25877-2-git-send-email-daniel.baluta@nxp.com>
References: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0053.outbound.protection.outlook.com [104.47.0.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 420D52670FB
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 11:09:51 +0100 (CET)
In-Reply-To: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc: shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add a separate function for finding (sysclk, lrclk, bclk)
when the clock is auto or mclk. This makes code easier to
read and reduces the indentation level in wm8960_configure_clocking.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
	* made wm8960_configure_sysclk static
	* renamed i, j, with sysclk_idx, dac_idx, bclk_idx
	* added brackets to if() branch
	* kept the update of (sysclk_idx, ...) inside "for" loop
	because next patch requires (sysclk_idx, ..) to be saved
	inside loop

 sound/soc/codecs/wm8960.c | 80 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 3bf081a..25a4a11 100644
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
2.7.4
