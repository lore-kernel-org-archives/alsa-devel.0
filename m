From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: Fix BCLK calculation of WM8994
Date: Tue, 02 Feb 2010 18:53:19 +0900
Message-ID: <4B67F60F.4090803@samsung.com>
References: <4B67F35D.905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 30CD3243AE
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 10:53:23 +0100 (CET)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KX700F1IKSVZ8@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 02 Feb 2010 18:53:20 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KX700DCIKSVQZ@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 02 Feb 2010 18:53:19 +0900 (KST)
In-reply-to: <4B67F35D.905@samsung.com>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

On 2/2/2010 6:41 PM, Joonyoung Shim wrote:
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 7bit
> 
> This fixes BCLK calculation and removes unnecessary check code.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>


Sorry, dummy texts were added. Please use below patch.

>From a531baaf93e3514f92a290a2e0bdd5ea5d928a4b Mon Sep 17 00:00:00 2001
From: Joonyoung Shim <jy0922.shim@samsung.com>
Date: Tue, 2 Feb 2010 18:05:42 +0900
Subject: [PATCH] ASoC: Fix BCLK calculation of WM8994

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
