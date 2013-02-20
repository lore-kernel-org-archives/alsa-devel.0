From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: arizona: Add convience define for
	clearing SYNCCLK
Date: Wed, 20 Feb 2013 16:09:39 +0000
Message-ID: <1361376579-29051-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25AE6261705
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:12:23 +0100 (CET)
In-Reply-To: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    8 ++++----
 sound/soc/codecs/arizona.h |    1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index b12a489..6a00904 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1185,7 +1185,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	int ret;
 
 	if (fll->ref_src < 0 || fll->ref_src == source) {
-		if (fll->sync_src == -1 &&
+		if (fll->sync_src == ARIZONA_FLL_SRC_NONE &&
 		    fll->ref_src == source && fll->ref_freq == Fref &&
 		    fll->fout == Fout)
 			return 0;
@@ -1196,7 +1196,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 				return ret;
 		}
 
-		fll->sync_src = -1;
+		fll->sync_src = ARIZONA_FLL_SRC_NONE;
 		fll->ref_src = source;
 		fll->ref_freq = Fref;
 	} else if (fll->ref_src != source) {
@@ -1240,7 +1240,7 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 	fll->id = id;
 	fll->base = base;
 	fll->arizona = arizona;
-	fll->sync_src = -1;
+	fll->sync_src = ARIZONA_FLL_SRC_NONE;
 
 	/* Configure default refclk to 32kHz if we have one */
 	regmap_read(arizona->regmap, ARIZONA_CLOCK_32K_1, &val);
@@ -1250,7 +1250,7 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 		fll->ref_src = val & ARIZONA_CLK_32K_SRC_MASK;
 		break;
 	default:
-		fll->ref_src = -1;
+		fll->ref_src = ARIZONA_FLL_SRC_NONE;
 	}
 	fll->ref_freq = 32768;
 
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index f2ca41f..3f84943 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -32,6 +32,7 @@
 #define ARIZONA_CLK_SRC_AIF2BCLK 0x9
 #define ARIZONA_CLK_SRC_AIF3BCLK 0xa
 
+#define ARIZONA_FLL_SRC_NONE      -1
 #define ARIZONA_FLL_SRC_MCLK1      0
 #define ARIZONA_FLL_SRC_MCLK2      1
 #define ARIZONA_FLL_SRC_SLIMCLK    3
-- 
1.7.2.5
