From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 7/8] ASoC: arizona: Add support for directly
	setting the FLL REFCLK
Date: Wed, 20 Feb 2013 17:28:40 +0000
Message-ID: <1361381321-437-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361381321-437-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 499AD265B86
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 18:31:10 +0100 (CET)
In-Reply-To: <1361381321-437-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This patch allows the REFCLK to be set directly allowing much greater
flexibility in how the FLLs are configured.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   39 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    2 ++
 sound/soc/codecs/wm5102.c  |    6 ++++++
 sound/soc/codecs/wm5102.h  |    6 ++++--
 sound/soc/codecs/wm5110.c  |    6 ++++++
 sound/soc/codecs/wm5110.h  |    6 ++++--
 6 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 149e44f..2bebfae 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1139,6 +1139,45 @@ static void arizona_disable_fll(struct arizona_fll *fll)
 		pm_runtime_put_autosuspend(arizona->dev);
 }
 
+int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
+			   unsigned int Fref, unsigned int Fout)
+{
+	struct arizona_fll_cfg ref, sync;
+	int ret;
+
+	if (source < 0)
+		return -EINVAL;
+
+	if (fll->ref_src == source && fll->ref_freq == Fref &&
+	    fll->fout == Fout)
+		return 0;
+
+	if (Fout) {
+		ret = arizona_calc_fll(fll, &ref, Fref, Fout);
+		if (ret != 0)
+			return ret;
+
+		if (fll->sync_src >= 0) {
+			ret = arizona_calc_fll(fll, &sync, fll->sync_freq, Fout);
+			if (ret != 0)
+				return ret;
+		}
+	}
+
+	fll->ref_src = source;
+	fll->ref_freq = Fref;
+	fll->fout = Fout;
+
+	if (Fout) {
+		arizona_enable_fll(fll, &ref, &sync);
+	} else {
+		arizona_disable_fll(fll);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_set_fll_refclk);
+
 int arizona_set_fll(struct arizona_fll *fll, int source,
 		    unsigned int Fref, unsigned int Fout)
 {
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index bedf12a..f2ca41f 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -211,6 +211,8 @@ struct arizona_fll {
 
 extern int arizona_init_fll(struct arizona *arizona, int id, int base,
 			    int lock_irq, int ok_irq, struct arizona_fll *fll);
+extern int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
+				  unsigned int Fref, unsigned int Fout);
 extern int arizona_set_fll(struct arizona_fll *fll, int source,
 			   unsigned int Fref, unsigned int Fout);
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index ab69c83..6071673 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1479,6 +1479,12 @@ static int wm5102_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		return arizona_set_fll(&wm5102->fll[0], source, Fref, Fout);
 	case WM5102_FLL2:
 		return arizona_set_fll(&wm5102->fll[1], source, Fref, Fout);
+	case WM5102_FLL1_REFCLK:
+		return arizona_set_fll_refclk(&wm5102->fll[0], source, Fref,
+					      Fout);
+	case WM5102_FLL2_REFCLK:
+		return arizona_set_fll_refclk(&wm5102->fll[1], source, Fref,
+					      Fout);
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/codecs/wm5102.h b/sound/soc/codecs/wm5102.h
index d30477f..adb3804 100644
--- a/sound/soc/codecs/wm5102.h
+++ b/sound/soc/codecs/wm5102.h
@@ -15,7 +15,9 @@
 
 #include "arizona.h"
 
-#define WM5102_FLL1 1
-#define WM5102_FLL2 2
+#define WM5102_FLL1        1
+#define WM5102_FLL2        2
+#define WM5102_FLL1_REFCLK 3
+#define WM5102_FLL2_REFCLK 4
 
 #endif
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index a163132..623e433 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -876,6 +876,12 @@ static int wm5110_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		return arizona_set_fll(&wm5110->fll[0], source, Fref, Fout);
 	case WM5110_FLL2:
 		return arizona_set_fll(&wm5110->fll[1], source, Fref, Fout);
+	case WM5110_FLL1_REFCLK:
+		return arizona_set_fll_refclk(&wm5110->fll[0], source, Fref,
+					      Fout);
+	case WM5110_FLL2_REFCLK:
+		return arizona_set_fll_refclk(&wm5110->fll[1], source, Fref,
+					      Fout);
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/codecs/wm5110.h b/sound/soc/codecs/wm5110.h
index 75e9351..e6c0cd4 100644
--- a/sound/soc/codecs/wm5110.h
+++ b/sound/soc/codecs/wm5110.h
@@ -15,7 +15,9 @@
 
 #include "arizona.h"
 
-#define WM5110_FLL1 1
-#define WM5110_FLL2 2
+#define WM5110_FLL1        1
+#define WM5110_FLL2        2
+#define WM5110_FLL1_REFCLK 3
+#define WM5110_FLL2_REFCLK 4
 
 #endif
-- 
1.7.2.5
