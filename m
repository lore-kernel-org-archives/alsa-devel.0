From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: arizona: Update handling for input
	change on an active FLL
Date: Wed,  9 Jul 2014 17:41:49 +0100
Message-ID: <1404924109-1750-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D5422650D4
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:35 +0200 (CEST)
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

Currently, the driver places no restrictions on changes that can be
applied to an active FLL. However, it is only possible to change the
input for an active FLL, to change the output the FLL should be stopped
and then recofigured. This patch disallows changes in output frequency
and adds some additional handling to ensure the output remains
consistent across an input transition.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a044e29..ca41586 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1545,6 +1545,12 @@ static int arizona_validate_fll(struct arizona_fll *fll,
 {
 	unsigned int Fvco_min;
 
+	if (fll->fout && Fout != fll->fout) {
+		arizona_fll_err(fll,
+				"Can't change output on active FLL\n");
+		return -EINVAL;
+	}
+
 	if (Fref / ARIZONA_FLL_MAX_REFDIV > ARIZONA_FLL_MAX_FREF) {
 		arizona_fll_err(fll,
 				"Can't scale %dMHz in to <=13.5MHz\n",
@@ -1788,6 +1794,15 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 	if (already_enabled < 0)
 		return already_enabled;
 
+	if (already_enabled) {
+		/* Facilitate smooth refclk across the transition */
+		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x7,
+					 ARIZONA_FLL1_GAIN_MASK, 0);
+		regmap_update_bits_async(fll->arizona->regmap, fll->base + 1,
+					 ARIZONA_FLL1_FREERUN,
+					 ARIZONA_FLL1_FREERUN);
+	}
+
 	/*
 	 * If we have both REFCLK and SYNCCLK then enable both,
 	 * otherwise apply the SYNCCLK settings to REFCLK.
@@ -1843,6 +1858,10 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 					 ARIZONA_FLL1_SYNC_ENA,
 					 ARIZONA_FLL1_SYNC_ENA);
 
+	if (already_enabled)
+		regmap_update_bits_async(arizona->regmap, fll->base + 1,
+					 ARIZONA_FLL1_FREERUN, 0);
+
 	ret = wait_for_completion_timeout(&fll->ok,
 					  msecs_to_jiffies(250));
 	if (ret == 0)
-- 
1.7.2.5
