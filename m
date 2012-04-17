From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: da7210: Minor update for PLL and SRM
Date: Tue, 17 Apr 2012 20:30:58 +0530
Message-ID: <1334674858.13279.9.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe010.messaging.microsoft.com [216.32.180.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BDCA2455E
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 16:49:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch converts multiple if conditions in to single if with "&&"s.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index cf4063b..d3ca28b 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -992,19 +992,15 @@ static int da7210_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 
 	/* Search pll div array for correct divisors */
 	for (cnt = 0; cnt < ARRAY_SIZE(da7210_pll_div); cnt++) {
-		/* check fref */
-		if (fref == da7210_pll_div[cnt].fref) {
-			/* check mode */
-			 if (da7210->master ==  da7210_pll_div[cnt].mode) {
-				/* check fout */
-				if (fout == da7210_pll_div[cnt].fout) {
-					/* all match, pick up divisors */
-					pll_div1 = da7210_pll_div[cnt].div1;
-					pll_div2 = da7210_pll_div[cnt].div2;
-					pll_div3 = da7210_pll_div[cnt].div3;
-					break;
-				}
-			}
+		/* check fref, mode  and fout */
+		if ((fref == da7210_pll_div[cnt].fref) &&
+			(da7210->master ==  da7210_pll_div[cnt].mode) &&
+			(fout == da7210_pll_div[cnt].fout)) {
+				/* all match, pick up divisors */
+				pll_div1 = da7210_pll_div[cnt].div1;
+				pll_div2 = da7210_pll_div[cnt].div2;
+				pll_div3 = da7210_pll_div[cnt].div3;
+				break;
 		}
 	}
 	if (cnt >= ARRAY_SIZE(da7210_pll_div))

-- 
1.7.1
