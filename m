From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Don't enable FLL on REFCLK
	configuration
Date: Fri, 22 Feb 2013 17:10:37 +0000
Message-ID: <1361553037-423-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36D452650A8
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 18:12:54 +0100 (CET)
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

Enabling the FLL when REFCLK is being configured is not what the user
would expect and can cause issues if SYNCCLK has no specified frequency.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 6837863..eb25ab9 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1148,17 +1148,17 @@ int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 	if (source < 0)
 		return -EINVAL;
 
-	if (fll->ref_src == source && fll->ref_freq == Fref &&
-	    fll->fout == Fout)
+	if (fll->ref_src == source && fll->ref_freq == Fref)
 		return 0;
 
-	if (Fout) {
-		ret = arizona_calc_fll(fll, &ref, Fref, Fout);
+	if (fll->fout) {
+		ret = arizona_calc_fll(fll, &ref, Fref, fll->fout);
 		if (ret != 0)
 			return ret;
 
 		if (fll->sync_src >= 0) {
-			ret = arizona_calc_fll(fll, &sync, fll->sync_freq, Fout);
+			ret = arizona_calc_fll(fll, &sync, fll->sync_freq,
+					       fll->fout);
 			if (ret != 0)
 				return ret;
 		}
@@ -1166,12 +1166,9 @@ int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 
 	fll->ref_src = source;
 	fll->ref_freq = Fref;
-	fll->fout = Fout;
 
-	if (Fout) {
+	if (fll->fout) {
 		arizona_enable_fll(fll, &ref, &sync);
-	} else {
-		arizona_disable_fll(fll);
 	}
 
 	return 0;
-- 
1.7.2.5
