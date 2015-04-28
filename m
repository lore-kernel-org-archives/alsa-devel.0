From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5677: fixed wrong DMIC ref clock
Date: Tue, 28 Apr 2015 11:27:39 +0800
Message-ID: <1430191660-2959-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E5667265451
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 05:27:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

DMIC clock source is not from codec system clock directly. it is
generated from the division of system clock. And it should be 256 *
sample rate of AIF1.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index fbe16ba..dca64ae 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -917,7 +917,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
-	int idx = rl6231_calc_dmic_clk(rt5677->sysclk);
+	int idx = rl6231_calc_dmic_clk(rt5677->lrck[RT5677_AIF1] << 8);
 
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
-- 
1.8.1.1.439.g50a6b54
