From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Implement FLL bypass support
Date: Thu,  5 Apr 2012 15:11:38 +0100
Message-ID: <1333635098-3757-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54AAE247F4
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 16:11:47 +0200 (CEST)
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

Later WM8994 class devices can bypass the FLL from BCLK. Do this
automatically when the FLL input and output frequencies match up.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   19 +++++++++++++++++++
 sound/soc/codecs/wm8994.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e94a84d..1dee30d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2112,6 +2112,14 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_1 + reg_offset,
 			    WM8994_FLL1_ENA, 0);
 
+	if (wm8994->fll_byp && src == WM8994_FLL_SRC_BCLK &&
+	    freq_in == freq_out) {
+		dev_dbg(codec->dev, "Bypassing FLL%d\n", id + 1);
+		snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
+				    WM8958_FLL1_BYP, WM8958_FLL1_BYP);
+		goto out;
+	}
+
 	reg = (fll.outdiv << WM8994_FLL1_OUTDIV_SHIFT) |
 		(fll.fll_fratio << WM8994_FLL1_FRATIO_SHIFT);
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_2 + reg_offset,
@@ -2126,6 +2134,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 				    fll.n << WM8994_FLL1_N_SHIFT);
 
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
+			    WM8958_FLL1_BYP |
 			    WM8994_FLL1_REFCLK_DIV_MASK |
 			    WM8994_FLL1_REFCLK_SRC_MASK,
 			    (fll.clk_ref_div << WM8994_FLL1_REFCLK_DIV_SHIFT) |
@@ -2188,6 +2197,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		}
 	}
 
+out:
 	wm8994->fll[id].in = freq_in;
 	wm8994->fll[id].out = freq_out;
 	wm8994->fll[id].src = src;
@@ -3714,6 +3724,14 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	case WM8958:
 		wm8994->hubs.dcs_readback_mode = 1;
 		wm8994->hubs.hp_startup_mode = 1;
+
+		switch (wm8994->revision) {
+		case 0:
+			break;
+		default:
+			wm8994->fll_byp = true;
+			break;
+		}
 		break;
 
 	case WM1811:
@@ -3721,6 +3739,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		wm8994->hubs.no_series_update = 1;
 		wm8994->hubs.hp_startup_mode = 1;
 		wm8994->hubs.no_cache_class_w = true;
+		wm8994->fll_byp = true;
 
 		switch (wm8994->revision) {
 		case 0:
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index c724112..91650bb 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -79,6 +79,7 @@ struct wm8994_priv {
 	struct wm8994_fll_config fll[2], fll_suspend[2];
 	struct completion fll_locked[2];
 	bool fll_locked_irq;
+	bool fll_byp;
 
 	int vmid_refcount;
 	int active_refcount;
-- 
1.7.9.1
