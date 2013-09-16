From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Improve handling of setting
	REFCLK to 0
Date: Mon, 16 Sep 2013 15:34:35 +0100
Message-ID: <1379342075-18323-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AA0E261A9A
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 16:50:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch suppresses calculation of REFCLK parameters when the REFCLK
source frequency is set to zero, additionally it will consider a source
frequency of zero as the REFCLK being disabled and switch to using the
SYNCCLK.

Reported-by: Kyung Kwee Ryu <Kyung-Kwee.Ryu@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

This patch missed getting upstreamed at the time it was written, sorry about that.

Thanks,
Charles

 sound/soc/codecs/arizona.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 657808b..6f05b17 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1477,21 +1477,25 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 {
 	struct arizona *arizona = fll->arizona;
 	int ret;
+	bool use_sync = false;
 
 	/*
 	 * If we have both REFCLK and SYNCCLK then enable both,
 	 * otherwise apply the SYNCCLK settings to REFCLK.
 	 */
-	if (fll->ref_src >= 0 && fll->ref_src != fll->sync_src) {
+	if (fll->ref_src >= 0 && fll->ref_freq &&
+	    fll->ref_src != fll->sync_src) {
 		regmap_update_bits(arizona->regmap, fll->base + 5,
 				   ARIZONA_FLL1_OUTDIV_MASK,
 				   ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
 
 		arizona_apply_fll(arizona, fll->base, ref, fll->ref_src,
 				  false);
-		if (fll->sync_src >= 0)
+		if (fll->sync_src >= 0) {
 			arizona_apply_fll(arizona, fll->base + 0x10, sync,
 					  fll->sync_src, true);
+			use_sync = true;
+		}
 	} else if (fll->sync_src >= 0) {
 		regmap_update_bits(arizona->regmap, fll->base + 5,
 				   ARIZONA_FLL1_OUTDIV_MASK,
@@ -1511,7 +1515,7 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	 * Increase the bandwidth if we're not using a low frequency
 	 * sync source.
 	 */
-	if (fll->sync_src >= 0 && fll->sync_freq > 100000)
+	if (use_sync && fll->sync_freq > 100000)
 		regmap_update_bits(arizona->regmap, fll->base + 0x17,
 				   ARIZONA_FLL1_SYNC_BW, 0);
 	else
@@ -1526,8 +1530,7 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 
 	regmap_update_bits(arizona->regmap, fll->base + 1,
 			   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
-	if (fll->ref_src >= 0 && fll->sync_src >= 0 &&
-	    fll->ref_src != fll->sync_src)
+	if (use_sync)
 		regmap_update_bits(arizona->regmap, fll->base + 0x11,
 				   ARIZONA_FLL1_SYNC_ENA,
 				   ARIZONA_FLL1_SYNC_ENA);
@@ -1561,10 +1564,12 @@ int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 	if (fll->ref_src == source && fll->ref_freq == Fref)
 		return 0;
 
-	if (fll->fout && Fref > 0) {
-		ret = arizona_calc_fll(fll, &ref, Fref, fll->fout);
-		if (ret != 0)
-			return ret;
+	if (fll->fout) {
+		if (Fref > 0) {
+			ret = arizona_calc_fll(fll, &ref, Fref, fll->fout);
+			if (ret != 0)
+				return ret;
+		}
 
 		if (fll->sync_src >= 0) {
 			ret = arizona_calc_fll(fll, &sync, fll->sync_freq,
-- 
1.7.2.5
