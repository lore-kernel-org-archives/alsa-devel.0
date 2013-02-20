From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 4/8] ASoC: arizona: Factor out FLL disable
Date: Wed, 20 Feb 2013 17:28:37 +0000
Message-ID: <1361381321-437-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361381321-437-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CCF7126171D
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 18:31:05 +0100 (CET)
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
the code for disabling an FLL into a seperate function.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 4640bcc..a8821a8 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1090,6 +1090,20 @@ static bool arizona_is_enabled_fll(struct arizona_fll *fll)
 	return reg & ARIZONA_FLL1_ENA;
 }
 
+static void arizona_disable_fll(struct arizona_fll *fll)
+{
+	struct arizona *arizona = fll->arizona;
+	bool change;
+
+	regmap_update_bits_check(arizona->regmap, fll->base + 1,
+				 ARIZONA_FLL1_ENA, 0, &change);
+	regmap_update_bits(arizona->regmap, fll->base + 0x11,
+			   ARIZONA_FLL1_SYNC_ENA, 0);
+
+	if (change)
+		pm_runtime_put_autosuspend(arizona->dev);
+}
+
 int arizona_set_fll(struct arizona_fll *fll, int source,
 		    unsigned int Fref, unsigned int Fout)
 {
@@ -1156,13 +1170,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 		if (ret == 0)
 			arizona_fll_warn(fll, "Timed out waiting for lock\n");
 	} else {
-		regmap_update_bits(arizona->regmap, fll->base + 1,
-				   ARIZONA_FLL1_ENA, 0);
-		regmap_update_bits(arizona->regmap, fll->base + 0x11,
-				   ARIZONA_FLL1_SYNC_ENA, 0);
-
-		if (ena)
-			pm_runtime_put_autosuspend(arizona->dev);
+		arizona_disable_fll(fll);
 	}
 
 	fll->fref = Fref;
-- 
1.7.2.5
