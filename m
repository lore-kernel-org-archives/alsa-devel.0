From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: force using PLL if MCLK is not
	suitable
Date: Fri, 14 Jul 2017 14:36:32 +0800
Message-ID: <1500014192-1411-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C026126648D
 for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2017 08:36:49 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Idealy PLL will be set in machine driver if MCLK doesn't meet the
requirement of codec. To let the codec driver be more general, we
can use a common PLL setting once sysclk/pll doesn't set properly
in machine driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 370ed54d..d3103ef 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4098,9 +4098,12 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 	rt5665->lrck[dai->id] = params_rate(params);
 	pre_div = rl6231_get_clk_info(rt5665->sysclk, rt5665->lrck[dai->id]);
 	if (pre_div < 0) {
-		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
-			rt5665->lrck[dai->id], dai->id);
-		return -EINVAL;
+		dev_warn(codec->dev, "Force using PLL");
+		snd_soc_codec_set_pll(codec, 0, RT5665_PLL1_S_MCLK,
+			rt5665->sysclk,	rt5665->lrck[dai->id] * 512);
+		snd_soc_codec_set_sysclk(codec, RT5665_SCLK_S_PLL1, 0,
+			rt5665->lrck[dai->id] * 512, 0);
+		pre_div = 1;
 	}
 	frame_size = snd_soc_params_to_frame_size(params);
 	if (frame_size < 0) {
-- 
2.7.4
