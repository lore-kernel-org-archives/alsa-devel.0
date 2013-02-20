From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 6/8] ASoC: arizona: Improve suppression of
	noop FLL updates
Date: Wed, 20 Feb 2013 17:28:39 +0000
Message-ID: <1361381321-437-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361381321-437-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 737BC265B72
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 18:31:08 +0100 (CET)
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

Previously updates that only changes FLL source would be missed, this
patch corrects this. We also ensures that both REFCLK and SYNCCLK
frequency changes are considered, in preparation for future updates.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   16 ++++++++++------
 sound/soc/codecs/arizona.h |    3 +--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e770945..149e44f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1145,10 +1145,12 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	struct arizona_fll_cfg ref, sync;
 	int ret;
 
-	if (fll->fref == Fref && fll->fout == Fout)
-		return 0;
-
 	if (fll->ref_src < 0 || fll->ref_src == source) {
+		if (fll->sync_src == -1 &&
+		    fll->ref_src == source && fll->ref_freq == Fref &&
+		    fll->fout == Fout)
+			return 0;
+
 		if (Fout) {
 			ret = arizona_calc_fll(fll, &ref, Fref, Fout);
 			if (ret != 0)
@@ -1159,6 +1161,10 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 		fll->ref_src = source;
 		fll->ref_freq = Fref;
 	} else {
+		if (fll->sync_src == source &&
+		    fll->sync_freq == Fref && fll->fout == Fout)
+			return 0;
+
 		if (Fout) {
 			ret = arizona_calc_fll(fll, &ref, fll->ref_freq, Fout);
 			if (ret != 0)
@@ -1172,6 +1178,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 		fll->sync_src = source;
 		fll->sync_freq = Fref;
 	}
+	fll->fout = Fout;
 
 	if (Fout) {
 		arizona_enable_fll(fll, &ref, &sync);
@@ -1179,9 +1186,6 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 		arizona_disable_fll(fll);
 	}
 
-	fll->fref = Fref;
-	fll->fout = Fout;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arizona_set_fll);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 37766b5..bedf12a 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -198,9 +198,8 @@ struct arizona_fll {
 	unsigned int base;
 	unsigned int vco_mult;
 	struct completion ok;
-	unsigned int fref;
-	unsigned int fout;
 
+	unsigned int fout;
 	int sync_src;
 	unsigned int sync_freq;
 	int ref_src;
-- 
1.7.2.5
