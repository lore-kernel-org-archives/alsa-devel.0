From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH] ASoC: codecs/wm8978: Only reconfigure GPIO1
	when used for PLL output
Date: Fri,  9 Nov 2012 12:33:38 -0500
Message-ID: <1352482418-64950-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BBA92625ED
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 18:33:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

When GPIO1 is used for other purposes than PLL output (GPIO, Amute, etc) the
driver incorrectly reconfigures the pin to input when the PLL is recalculated.
Only reconfigure the pin for input when reconfiguring the PLL and GPIO1 is
used for PLL output.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 sound/soc/codecs/wm8978.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index a706262..0659b41 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -509,7 +509,11 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
 
 		dev_dbg(codec->dev, "%s: OPCLKDIV=%d\n", __func__, opclk_div);
 
-		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 0x30,
+		/*
+		 * GPIO1 is used for OPCLK, reconfigure into default
+		 * mode as input - before configuring OPCLKDIV and PLL
+		 */
+		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 0x37,
 				    (opclk_div - 1) << 4);
 
 		wm8978->f_pllout = f_opclk * opclk_div;
@@ -529,9 +533,6 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
 			return idx;
 
 		wm8978->mclk_idx = idx;
-
-		/* GPIO1 into default mode as input - before configuring PLL */
-		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 7, 0);
 	} else {
 		return -EINVAL;
 	}
@@ -638,8 +639,12 @@ static int wm8978_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
 		/* Clock CODEC directly from MCLK */
 		snd_soc_update_bits(codec, WM8978_CLOCKING, 0x100, 0);
 
-		/* GPIO1 into default mode as input - before configuring PLL */
-		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 7, 0);
+		/*
+		 * If GPIO1 is used for OPCLK, reconfigure GPIO1 into default
+		 * mode as input - before configuring PLL
+		 */
+		if (f_opclk)
+			snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 7, 0);
 
 		/* Turn off PLL */
 		snd_soc_update_bits(codec, WM8978_POWER_MANAGEMENT_1, 0x20, 0);
-- 
1.7.2.5
