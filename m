From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: fix incompatible pointer type of
	set_sysclk
Date: Thu, 29 Jun 2017 09:47:55 +0800
Message-ID: <1498700875-13120-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DCC826720E
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 03:48:33 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The first parameter is codec not dai.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
Sorry for missing it in the "move set_sysclk to codec level" patch
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 7fa63ad..64756dc 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2442,7 +2442,7 @@ static int rt5670_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static int rt5670_set_codec_sysclk(struct snd_soc_dai *dai, int clk_id,
+static int rt5670_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
 				   int source, unsigned int freq, int dir)
 {
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
-- 
2.7.4
