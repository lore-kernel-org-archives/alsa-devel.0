From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH] ASoC: WM8580: Debug interface index
Date: Fri,  3 Dec 2010 10:34:25 +0900
Message-ID: <1291340065-16897-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 927E71037EE
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 02:48:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

We want the index of DAI's driver here.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/codecs/wm8580.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index e2a9276..cb7765f 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -507,13 +507,13 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Look up the SYSCLK ratio; accept only exact matches */
-	ratio = wm8580->sysclk[dai->id] / params_rate(params);
+	ratio = wm8580->sysclk[dai->driver->id] / params_rate(params);
 	for (i = 0; i < ARRAY_SIZE(wm8580_sysclk_ratios); i++)
 		if (ratio == wm8580_sysclk_ratios[i])
 			break;
 	if (i == ARRAY_SIZE(wm8580_sysclk_ratios)) {
 		dev_err(codec->dev, "Invalid clock ratio %d/%d\n",
-			wm8580->sysclk[dai->id], params_rate(params));
+			wm8580->sysclk[dai->driver->id], params_rate(params));
 		return -EINVAL;
 	}
 	paifa |= i;
@@ -716,7 +716,7 @@ static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	switch (clk_id) {
 	case WM8580_CLKSRC_ADCMCLK:
-		if (dai->id != WM8580_DAI_PAIFTX)
+		if (dai->driver->id != WM8580_DAI_PAIFTX)
 			return -EINVAL;
 		sel = 0 << sel_shift;
 		break;
@@ -735,7 +735,7 @@ static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	}
 
 	/* We really should validate PLL settings but not yet */
-	wm8580->sysclk[dai->id] = freq;
+	wm8580->sysclk[dai->driver->id] = freq;
 
 	return snd_soc_update_bits(codec, WM8580_CLKSEL, sel_mask, sel);
 }
-- 
1.6.2.5
