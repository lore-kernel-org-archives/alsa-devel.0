From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: h1940_uda1380: Don't modify
	runtime->hw
Date: Mon,  3 Feb 2014 17:24:21 +0100
Message-ID: <1391444662-11933-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-089.synserver.de
 [212.40.185.89])
 by alsa0.perex.cz (Postfix) with ESMTP id A077C2608C7
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 17:24:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Individual components are not supposed to modify the runtime->hw struct itself
as it is manged by the ASoC core. If a component wants to limit the list of
supported rates it should set a rate constraint. The h1940_uda1380 already does
this, so it is safe to just remove the code that modifies runtime->hw.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/h1940_uda1380.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index ec5cbdd..7a85ce8 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -66,10 +66,6 @@ static int h1940_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->hw.rate_min = hw_rates.list[0];
-	runtime->hw.rate_max = hw_rates.list[hw_rates.count - 1];
-	runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
-
 	return snd_pcm_hw_constraint_list(runtime, 0,
 					SNDRV_PCM_HW_PARAM_RATE,
 					&hw_rates);
-- 
1.8.0
