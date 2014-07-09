From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: arizona: Correct relationship
	between VCO corner and Fref
Date: Wed,  9 Jul 2014 17:41:45 +0100
Message-ID: <1404924109-1750-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 636182650C2
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:31 +0200 (CEST)
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

When configuring the FLL we must ensure that the reference clock passed
to the FLL is under a certain limit. This limit was specified
incorrectly in the current code, this patch corrects this. Although the
error will only be encountered in some edge cases.

Reported-by: Ryo Tsutsui <ryo.tsutsui@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e9e0b6b..97cc80d 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1623,8 +1623,8 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 	while (div <= ARIZONA_FLL_MAX_REFDIV) {
 		for (ratio = init_ratio; ratio <= ARIZONA_FLL_MAX_FRATIO;
 		     ratio++) {
-			if (ARIZONA_FLL_VCO_CORNER / (fll->vco_mult * ratio) <
-			    Fref)
+			if ((ARIZONA_FLL_VCO_CORNER / 2) /
+			    (fll->vco_mult * ratio) < Fref)
 				break;
 
 			if (target % (ratio * Fref)) {
-- 
1.7.2.5
