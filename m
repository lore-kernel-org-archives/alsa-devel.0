From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Implement support for
	self-oscillation mode in the FLL
Date: Tue, 24 Jul 2012 11:50:05 +0100
Message-ID: <1343127005-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DAE0265202
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 12:50:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The FLLs in the WM8994 series devices can be started without any reference
being supplied, mainly for use in analogue bypass cases. Implement support
for this mode.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   21 +++++++++++++++------
 sound/soc/codecs/wm8994.h |    9 +++++----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 235577a..30fdcf9 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2102,6 +2102,10 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	case WM8994_FLL_SRC_LRCLK:
 	case WM8994_FLL_SRC_BCLK:
 		break;
+	case WM8994_FLL_SRC_INTERNAL:
+		freq_in = 12000000;
+		freq_out = 12000000;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2164,9 +2168,11 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 				    fll.n << WM8994_FLL1_N_SHIFT);
 
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
-			    WM8958_FLL1_BYP |
+			    WM8994_FLL1_FRC_NCO | WM8958_FLL1_BYP |
 			    WM8994_FLL1_REFCLK_DIV_MASK |
 			    WM8994_FLL1_REFCLK_SRC_MASK,
+			    ((src == WM8994_FLL_SRC_INTERNAL)
+			     << WM8994_FLL1_FRC_NCO_SHIFT) |
 			    (fll.clk_ref_div << WM8994_FLL1_REFCLK_DIV_SHIFT) |
 			    (src - 1));
 
@@ -2192,13 +2198,16 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			}
 		}
 
+		reg = WM8994_FLL1_ENA;
+
 		if (fll.k)
-			reg = WM8994_FLL1_ENA | WM8994_FLL1_FRAC;
-		else
-			reg = WM8994_FLL1_ENA;
+			reg |= WM8994_FLL1_FRAC;
+		if (src == WM8994_FLL_SRC_INTERNAL)
+			reg |= WM8994_FLL1_OSC_ENA;
+
 		snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_1 + reg_offset,
-				    WM8994_FLL1_ENA | WM8994_FLL1_FRAC,
-				    reg);
+				    WM8994_FLL1_ENA | WM8994_FLL1_OSC_ENA |
+				    WM8994_FLL1_FRAC, reg);
 
 		if (wm8994->fll_locked_irq) {
 			timeout = wait_for_completion_timeout(&wm8994->fll_locked[id],
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index d77e06f..19068d8 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -28,10 +28,11 @@
 #define WM8994_FLL1 1
 #define WM8994_FLL2 2
 
-#define WM8994_FLL_SRC_MCLK1  1
-#define WM8994_FLL_SRC_MCLK2  2
-#define WM8994_FLL_SRC_LRCLK  3
-#define WM8994_FLL_SRC_BCLK   4
+#define WM8994_FLL_SRC_MCLK1    1
+#define WM8994_FLL_SRC_MCLK2    2
+#define WM8994_FLL_SRC_LRCLK    3
+#define WM8994_FLL_SRC_BCLK     4
+#define WM8994_FLL_SRC_INTERNAL 5
 
 enum wm8994_vmid_mode {
 	WM8994_VMID_NORMAL,
-- 
1.7.10.4
