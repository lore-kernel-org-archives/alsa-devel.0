From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: arizona: Correct return value of
	arizona_is_enabled_fll
Date: Wed,  9 Jul 2014 17:41:47 +0100
Message-ID: <1404924109-1750-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFA8826507D
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:33 +0200 (CEST)
In-Reply-To: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

arizona_is_enabled_fll currently returns a bool, but can throw an error.
The error will be basically ignored and we will treat the FLL as already
on. This patch changes the return to be an int and adds error code to
propagate the error up to the callback.

Reported-by: Anil Kumar <anil.kumar@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 9a369bc..1daa5cc 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1761,7 +1761,7 @@ static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
 				 ARIZONA_FLL1_CTRL_UPD | cfg->n);
 }
 
-static bool arizona_is_enabled_fll(struct arizona_fll *fll)
+static int arizona_is_enabled_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
 	unsigned int reg;
@@ -1777,13 +1777,17 @@ static bool arizona_is_enabled_fll(struct arizona_fll *fll)
 	return reg & ARIZONA_FLL1_ENA;
 }
 
-static void arizona_enable_fll(struct arizona_fll *fll)
+static int arizona_enable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
 	int ret;
 	bool use_sync = false;
+	int already_enabled = arizona_is_enabled_fll(fll);
 	struct arizona_fll_cfg cfg;
 
+	if (already_enabled < 0)
+		return already_enabled;
+
 	/*
 	 * If we have both REFCLK and SYNCCLK then enable both,
 	 * otherwise apply the SYNCCLK settings to REFCLK.
@@ -1811,7 +1815,7 @@ static void arizona_enable_fll(struct arizona_fll *fll)
 					 ARIZONA_FLL1_SYNC_ENA, 0);
 	} else {
 		arizona_fll_err(fll, "No clocks provided\n");
-		return;
+		return -EINVAL;
 	}
 
 	/*
@@ -1826,7 +1830,7 @@ static void arizona_enable_fll(struct arizona_fll *fll)
 					 ARIZONA_FLL1_SYNC_BW,
 					 ARIZONA_FLL1_SYNC_BW);
 
-	if (!arizona_is_enabled_fll(fll))
+	if (!already_enabled)
 		pm_runtime_get(arizona->dev);
 
 	/* Clear any pending completions */
@@ -1845,6 +1849,8 @@ static void arizona_enable_fll(struct arizona_fll *fll)
 					  msecs_to_jiffies(250));
 	if (ret == 0)
 		arizona_fll_warn(fll, "Timed out waiting for lock\n");
+
+	return 0;
 }
 
 static void arizona_disable_fll(struct arizona_fll *fll)
@@ -1866,7 +1872,7 @@ static void arizona_disable_fll(struct arizona_fll *fll)
 int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 			   unsigned int Fref, unsigned int Fout)
 {
-	int ret;
+	int ret = 0;
 
 	if (fll->ref_src == source && fll->ref_freq == Fref)
 		return 0;
@@ -1881,17 +1887,17 @@ int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 	fll->ref_freq = Fref;
 
 	if (fll->fout && Fref > 0) {
-		arizona_enable_fll(fll);
+		ret = arizona_enable_fll(fll);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(arizona_set_fll_refclk);
 
 int arizona_set_fll(struct arizona_fll *fll, int source,
 		    unsigned int Fref, unsigned int Fout)
 {
-	int ret;
+	int ret = 0;
 
 	if (fll->sync_src == source &&
 	    fll->sync_freq == Fref && fll->fout == Fout)
@@ -1914,11 +1920,11 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	fll->fout = Fout;
 
 	if (Fout)
-		arizona_enable_fll(fll);
+		ret = arizona_enable_fll(fll);
 	else
 		arizona_disable_fll(fll);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(arizona_set_fll);
 
-- 
1.7.2.5
