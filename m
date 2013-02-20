From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 3/8] ASoC: arizona: Factor out check for
	enabled FLL
Date: Wed, 20 Feb 2013 17:28:36 +0000
Message-ID: <1361381321-437-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361381321-437-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 467BF2616F1
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 18:31:04 +0100 (CET)
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

In preparation for additional features on the FLL this patch factors out
the code which checks if an FLL is currently enabled into a seperate
function.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 03076ef..4640bcc 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1074,12 +1074,27 @@ static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
 			   ARIZONA_FLL1_CTRL_UPD | cfg->n);
 }
 
+static bool arizona_is_enabled_fll(struct arizona_fll *fll)
+{
+	struct arizona *arizona = fll->arizona;
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(arizona->regmap, fll->base + 1, &reg);
+	if (ret != 0) {
+		arizona_fll_err(fll, "Failed to read current state: %d\n",
+				ret);
+		return ret;
+	}
+
+	return reg & ARIZONA_FLL1_ENA;
+}
+
 int arizona_set_fll(struct arizona_fll *fll, int source,
 		    unsigned int Fref, unsigned int Fout)
 {
 	struct arizona *arizona = fll->arizona;
 	struct arizona_fll_cfg ref, sync;
-	unsigned int reg;
 	bool ena;
 	int ret;
 
@@ -1111,13 +1126,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 		fll->sync_freq = Fref;
 	}
 
-	ret = regmap_read(arizona->regmap, fll->base + 1, &reg);
-	if (ret != 0) {
-		arizona_fll_err(fll, "Failed to read current state: %d\n",
-				ret);
-		return ret;
-	}
-	ena = reg & ARIZONA_FLL1_ENA;
+	ena = arizona_is_enabled_fll(fll);
 
 	if (Fout) {
 		regmap_update_bits(arizona->regmap, fll->base + 5,
-- 
1.7.2.5
