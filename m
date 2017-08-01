From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: fix wrong register for bclk
	ratio control
Date: Tue, 1 Aug 2017 10:30:53 +0800
Message-ID: <1501554653-29727-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C114266B02
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 04:31:06 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The register of setting back ratio should be RT5665_ADDA_CLK_2
instead of RT5665_ADDA_CLK_1.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index d0a9490..db2e5b9 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4411,12 +4411,12 @@ static int rt5665_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 		switch (dai->id) {
 		case RT5665_AIF2_1:
 		case RT5665_AIF2_2:
-			snd_soc_update_bits(codec, RT5665_ADDA_CLK_1,
+			snd_soc_update_bits(codec, RT5665_ADDA_CLK_2,
 				RT5665_I2S_BCLK_MS2_MASK,
 				RT5665_I2S_BCLK_MS2_64);
 			break;
 		case RT5665_AIF3:
-			snd_soc_update_bits(codec, RT5665_ADDA_CLK_1,
+			snd_soc_update_bits(codec, RT5665_ADDA_CLK_2,
 				RT5665_I2S_BCLK_MS3_MASK,
 				RT5665_I2S_BCLK_MS3_64);
 			break;
-- 
2.7.4
