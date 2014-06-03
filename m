From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] ASoC: rt5677: Convert to use
	rl6231_get_clk_info
Date: Tue, 03 Jun 2014 10:58:08 +0800
Message-ID: <1401764288.15216.2.camel@phoenix>
References: <1401764201.15216.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B361265582
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 04:58:13 +0200 (CEST)
Received: by mail-vc0-f175.google.com with SMTP id id10so6075045vcb.20
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 19:58:13 -0700 (PDT)
In-Reply-To: <1401764201.15216.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/Kconfig  |  2 ++
 sound/soc/codecs/rt5677.c | 18 ++----------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cbfa1e1..9d88845 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -445,9 +445,11 @@ config SND_SOC_RL6231
 	default y if SND_SOC_RT5640=y
 	default y if SND_SOC_RT5645=y
 	default y if SND_SOC_RT5651=y
+	default y if SND_SOC_RT5677=y
 	default m if SND_SOC_RT5640=m
 	default m if SND_SOC_RT5645=m
 	default m if SND_SOC_RT5651=m
+	default m if SND_SOC_RT5677=m
 
 config SND_SOC_RT5631
 	tristate
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 60fff7f..1ffc689 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -27,6 +27,7 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
+#include "rl6231.h"
 #include "rt5677.h"
 
 #define RT5677_DEVICE_ID 0x6327
@@ -2798,21 +2799,6 @@ static const struct snd_soc_dapm_route
rt5677_dapm_routes[] = {
 	{ "PDM2R", NULL, "PDM2 R Mux" },
 };
 
-static int get_clk_info(int sclk, int rate)
-{
-	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
-
-	if (sclk <= 0 || rate <= 0)
-		return -EINVAL;
-
-	rate = rate << 8;
-	for (i = 0; i < ARRAY_SIZE(pd); i++)
-		if (sclk == rate * pd[i])
-			return i;
-
-	return -EINVAL;
-}
-
 static int rt5677_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -2822,7 +2808,7 @@ static int rt5677_hw_params(struct
snd_pcm_substream *substream,
 	int pre_div, bclk_ms, frame_size;
 
 	rt5677->lrck[dai->id] = params_rate(params);
-	pre_div = get_clk_info(rt5677->sysclk, rt5677->lrck[dai->id]);
+	pre_div = rl6231_get_clk_info(rt5677->sysclk, rt5677->lrck[dai->id]);
 	if (pre_div < 0) {
 		dev_err(codec->dev, "Unsupported clock setting\n");
 		return -EINVAL;
-- 
1.8.3.2
