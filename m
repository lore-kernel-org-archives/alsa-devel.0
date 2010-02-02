From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: Fix BCLK calculation of WM8994
Date: Tue, 02 Feb 2010 18:41:49 +0900
Message-ID: <4B67F35D.905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C64D243AB
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 10:43:29 +0100 (CET)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KX7006ITKCDIZ@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 02 Feb 2010 18:43:26 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KX7002KTKCDD1@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 02 Feb 2010 18:43:25 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: cw00.choi@samsung.com, alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: jy0922.shim@samsung.com
X-OriginalArrivalTime: 02 Feb 2010 09:41:49.0527 (UTC) FILETIME=[F1591670:01CAA3EB]

This fixes BCLK calculation and removes unnecessary check code.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/wm8994.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5dd4b29..29f3771 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3267,15 +3267,12 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	 */
 	best = 0;
 	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
-		if (bclk_divs[i] < 0)
-			continue;
-		cur_val = (wm8994->aifclk[id] * 10 / bclk_divs[i])
-			- bclk_rate * 10;
+		cur_val = (wm8994->aifclk[id] * 10 / bclk_divs[i]) - bclk_rate;
 		if (cur_val < 0) /* BCLK table is sorted */
 			break;
 		best = i;
 	}
-	bclk_rate = wm8994->aifclk[id] / bclk_divs[best];
+	bclk_rate = wm8994->aifclk[id] * 10 / bclk_divs[best];
 	dev_dbg(dai->dev, "Using BCLK_DIV %d for actual BCLK %dHz\n",
 		bclk_divs[best], bclk_rate);
 	bclk |= best << WM8994_AIF1_BCLK_DIV_SHIFT;
-- 
1.6.3.3
