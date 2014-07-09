From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: arizona: Correct checking of FLL
	ratio limitations
Date: Wed,  9 Jul 2014 17:41:44 +0100
Message-ID: <1404924109-1750-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A1882650C0
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:30 +0200 (CEST)
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

The check to ensure the Fref frequency is within the bounds for the
current ratio, was placed in the wrong loop. The initial configuration
will always be valid and the loop lowering the ratio will only reinforce
this validity. The check should be on the loop increasing the ratio.
This could on occasion cause an invalid ratio/Fref combination to be
selected.

Reported-by: Ryo Tsutsui <ryo.tsutsui@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a0252a7..e9e0b6b 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1623,6 +1623,10 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 	while (div <= ARIZONA_FLL_MAX_REFDIV) {
 		for (ratio = init_ratio; ratio <= ARIZONA_FLL_MAX_FRATIO;
 		     ratio++) {
+			if (ARIZONA_FLL_VCO_CORNER / (fll->vco_mult * ratio) <
+			    Fref)
+				break;
+
 			if (target % (ratio * Fref)) {
 				cfg->refdiv = refdiv;
 				cfg->fratio = ratio - 1;
@@ -1631,10 +1635,6 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 		}
 
 		for (ratio = init_ratio - 1; ratio > 0; ratio--) {
-			if (ARIZONA_FLL_VCO_CORNER / (fll->vco_mult * ratio) <
-			    Fref)
-				break;
-
 			if (target % (ratio * Fref)) {
 				cfg->refdiv = refdiv;
 				cfg->fratio = ratio - 1;
-- 
1.7.2.5
