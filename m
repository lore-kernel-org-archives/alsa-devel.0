From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: arizona: Do not test ratio zero as
	it is not a valid setting
Date: Wed,  9 Jul 2014 17:41:43 +0100
Message-ID: <1404924109-1750-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7ED222650AF
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:29 +0200 (CEST)
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

Zero is not a valid FRATIO for the FLL, as such we shouldn't test it
whilst refining the FRATIO. This patch does just that.

Reported-by: Ryo Tsutsui <ryo.tsutsui@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index c5b6be2..a0252a7 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1630,7 +1630,7 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 			}
 		}
 
-		for (ratio = init_ratio - 1; ratio >= 0; ratio--) {
+		for (ratio = init_ratio - 1; ratio > 0; ratio--) {
 			if (ARIZONA_FLL_VCO_CORNER / (fll->vco_mult * ratio) <
 			    Fref)
 				break;
-- 
1.7.2.5
