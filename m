From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 7/9] ASoC: arizona: Calculate FLL gain last
Date: Fri,  7 Mar 2014 16:34:23 +0000
Message-ID: <1394210065-23941-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1639B265A23
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:55 +0100 (CET)
In-Reply-To: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

No part of the FLL calculation depends on the value determined for the
gain but the gain does depend on other values. In preparation for future
updates this patch moves the gain to be the last thing calculated.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 175e230..24ea6ed 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1464,18 +1464,6 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(fll_gains); i++) {
-		if (fll_gains[i].min <= Fref && Fref <= fll_gains[i].max) {
-			cfg->gain = fll_gains[i].gain;
-			break;
-		}
-	}
-	if (i == ARRAY_SIZE(fll_gains)) {
-		arizona_fll_err(fll, "Unable to find gain for Fref=%uHz\n",
-				Fref);
-		return -EINVAL;
-	}
-
 	cfg->n = target / (ratio * Fref);
 
 	if (target % (ratio * Fref)) {
@@ -1499,6 +1487,18 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 		cfg->lambda >>= 1;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(fll_gains); i++) {
+		if (fll_gains[i].min <= Fref && Fref <= fll_gains[i].max) {
+			cfg->gain = fll_gains[i].gain;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(fll_gains)) {
+		arizona_fll_err(fll, "Unable to find gain for Fref=%uHz\n",
+				Fref);
+		return -EINVAL;
+	}
+
 	arizona_fll_dbg(fll, "N=%x THETA=%x LAMBDA=%x\n",
 			cfg->n, cfg->theta, cfg->lambda);
 	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",
-- 
1.7.2.5
