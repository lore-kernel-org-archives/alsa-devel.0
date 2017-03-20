From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5665: fix wrong shift
	rt5665_if2_1_adc_in_enum
Date: Mon, 20 Mar 2017 10:20:53 +0800
Message-ID: <1489976454-7441-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id E3BC9266BFF
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 03:21:12 +0100 (CET)
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

The shift is RT5665_IF2_1_ADC_IN_SFT not RT5665_IF3_ADC_IN_SFT.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 5545d08..21b07ca 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2256,7 +2256,7 @@ static const char * const rt5665_if2_1_adc_in_src[] = {
 
 static const SOC_ENUM_SINGLE_DECL(
 	rt5665_if2_1_adc_in_enum, RT5665_DIG_INF2_DATA,
-	RT5665_IF3_ADC_IN_SFT, rt5665_if2_1_adc_in_src);
+	RT5665_IF2_1_ADC_IN_SFT, rt5665_if2_1_adc_in_src);
 
 static const struct snd_kcontrol_new rt5665_if2_1_adc_in_mux =
 	SOC_DAPM_ENUM("IF2_1 ADC IN Source", rt5665_if2_1_adc_in_enum);
-- 
2.7.4
