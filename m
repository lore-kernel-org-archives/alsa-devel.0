From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Don't allow reconfiguration of
	FLL when it provides SYSCLK
Date: Thu, 29 Mar 2012 14:49:52 +0100
Message-ID: <1333028992-27191-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1ED13104440
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 15:49:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Rather than trying to work around machine drivers which try to reprogram
the FLL while it is providing SYSCLK just return an error if they try.
This will avoid audio glitches during FLL reconfiguration, or at least
move the introduction of the glitches to the machine driver.

Since disabling the source for an active SYSCLK is not supported in the
first place systems shouldn't be doing this in the first place.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index cc6023c..f43b2ec 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1903,24 +1903,20 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	struct wm8994 *control = wm8994->wm8994;
 	int reg_offset, ret;
 	struct fll_div fll;
-	u16 reg, aif1, aif2;
+	u16 reg, clk1, aif_reg, aif_src;
 	unsigned long timeout;
 	bool was_enabled;
 
-	aif1 = snd_soc_read(codec, WM8994_AIF1_CLOCKING_1)
-		& WM8994_AIF1CLK_ENA;
-
-	aif2 = snd_soc_read(codec, WM8994_AIF2_CLOCKING_1)
-		& WM8994_AIF2CLK_ENA;
-
 	switch (id) {
 	case WM8994_FLL1:
 		reg_offset = 0;
 		id = 0;
+		aif_src = 0x10;
 		break;
 	case WM8994_FLL2:
 		reg_offset = 0x20;
 		id = 1;
+		aif_src = 0x18;
 		break;
 	default:
 		return -EINVAL;
@@ -1962,11 +1958,20 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	if (ret < 0)
 		return ret;
 
-	/* Gate the AIF clocks while we reclock */
-	snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
-			    WM8994_AIF1CLK_ENA, 0);
-	snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
-			    WM8994_AIF2CLK_ENA, 0);
+	/* Make sure that we're not providing SYSCLK right now */
+	clk1 = snd_soc_read(codec, WM8994_CLOCKING_1);
+	if (clk1 & WM8994_SYSCLK_SRC)
+		aif_reg = WM8994_AIF2_CLOCKING_1;
+	else
+		aif_reg = WM8994_AIF1_CLOCKING_1;
+	reg = snd_soc_read(codec, aif_reg);
+
+	if ((reg & WM8994_AIF1CLK_ENA) &&
+	    (reg & WM8994_AIF1CLK_SRC_MASK) == aif_src) {
+		dev_err(codec->dev, "FLL%d is currently providing SYSCLK\n",
+			id + 1);
+		return -EBUSY;
+	}
 
 	/* We always need to disable the FLL while reconfiguring */
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_1 + reg_offset,
@@ -2052,12 +2057,6 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	wm8994->fll[id].out = freq_out;
 	wm8994->fll[id].src = src;
 
-	/* Enable any gated AIF clocks */
-	snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
-			    WM8994_AIF1CLK_ENA, aif1);
-	snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
-			    WM8994_AIF2CLK_ENA, aif2);
-
 	configure_clock(codec);
 
 	return 0;
-- 
1.7.9.1
