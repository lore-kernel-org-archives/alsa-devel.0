From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/8] ASoC: arizona: Move selection of FLL
	REFCLK into init
Date: Wed, 20 Feb 2013 16:09:32 +0000
Message-ID: <1361376579-29051-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 68909261705
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:12:13 +0100 (CET)
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

In preparation for additional features on the FLL this patch moves the
code selecting the REFCLK source based on the 32kHz clock into the FLL
initialisation function.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   28 ++++++++++++++++------------
 sound/soc/codecs/arizona.h |    3 +++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ac948a6..c14e755 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1079,7 +1079,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 {
 	struct arizona *arizona = fll->arizona;
 	struct arizona_fll_cfg cfg, sync;
-	unsigned int reg, val;
+	unsigned int reg;
 	int syncsrc;
 	bool ena;
 	int ret;
@@ -1096,16 +1096,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	ena = reg & ARIZONA_FLL1_ENA;
 
 	if (Fout) {
-		/* Do we have a 32kHz reference? */
-		regmap_read(arizona->regmap, ARIZONA_CLOCK_32K_1, &val);
-		switch (val & ARIZONA_CLK_32K_SRC_MASK) {
-		case ARIZONA_CLK_SRC_MCLK1:
-		case ARIZONA_CLK_SRC_MCLK2:
-			syncsrc = val & ARIZONA_CLK_32K_SRC_MASK;
-			break;
-		default:
-			syncsrc = -1;
-		}
+		syncsrc = fll->ref_src;
 
 		if (source == syncsrc)
 			syncsrc = -1;
@@ -1115,7 +1106,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 			if (ret != 0)
 				return ret;
 
-			ret = arizona_calc_fll(fll, &cfg, 32768, Fout);
+			ret = arizona_calc_fll(fll, &cfg, fll->ref_freq, Fout);
 			if (ret != 0)
 				return ret;
 		} else {
@@ -1178,6 +1169,7 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 		     int ok_irq, struct arizona_fll *fll)
 {
 	int ret;
+	unsigned int val;
 
 	init_completion(&fll->ok);
 
@@ -1185,6 +1177,18 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 	fll->base = base;
 	fll->arizona = arizona;
 
+	/* Configure default refclk to 32kHz if we have one */
+	regmap_read(arizona->regmap, ARIZONA_CLOCK_32K_1, &val);
+	switch (val & ARIZONA_CLK_32K_SRC_MASK) {
+	case ARIZONA_CLK_SRC_MCLK1:
+	case ARIZONA_CLK_SRC_MCLK2:
+		fll->ref_src = val & ARIZONA_CLK_32K_SRC_MASK;
+		break;
+	default:
+		fll->ref_src = -1;
+	}
+	fll->ref_freq = 32768;
+
 	snprintf(fll->lock_name, sizeof(fll->lock_name), "FLL%d lock", id);
 	snprintf(fll->clock_ok_name, sizeof(fll->clock_ok_name),
 		 "FLL%d clock OK", id);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 116372c..124f9f0 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -201,6 +201,9 @@ struct arizona_fll {
 	unsigned int fref;
 	unsigned int fout;
 
+	int ref_src;
+	unsigned int ref_freq;
+
 	char lock_name[ARIZONA_FLL_NAME_LEN];
 	char clock_ok_name[ARIZONA_FLL_NAME_LEN];
 };
-- 
1.7.2.5
