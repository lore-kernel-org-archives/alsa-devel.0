From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] ASoC: rt5677: Convert to use
	rl6231_calc_dmic_clk
Date: Tue, 03 Jun 2014 10:58:58 +0800
Message-ID: <1401764338.15216.3.camel@phoenix>
References: <1401764201.15216.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f176.google.com (mail-ve0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 291A8265594
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 04:59:04 +0200 (CEST)
Received: by mail-ve0-f176.google.com with SMTP id jz11so6173012veb.21
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 19:59:03 -0700 (PDT)
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
 sound/soc/codecs/rt5677.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 1ffc689..45f99a8 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -637,21 +637,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
-	int div[] = {2, 3, 4, 6, 8, 12}, idx = -EINVAL, i;
-	int rate, red, bound, temp;
-
-	rate = rt5677->sysclk;
-	red = 3000000 * 12;
-	for (i = 0; i < ARRAY_SIZE(div); i++) {
-		bound = div[i] * 3000000;
-		if (rate > bound)
-			continue;
-		temp = bound - rate;
-		if (temp < red) {
-			red = temp;
-			idx = i;
-		}
-	}
+	int idx = rl6231_calc_dmic_clk(rt5677->sysclk);
 
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
-- 
1.8.3.2
