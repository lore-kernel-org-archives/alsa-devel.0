From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5659: fix wrong control register
	for ADC2 power
Date: Mon, 12 Mar 2018 19:50:08 +0800
Message-ID: <1520855409-28862-2-git-send-email-bardliao@realtek.com>
References: <1520855409-28862-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 43048267172
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 12:50:22 +0100 (CET)
In-Reply-To: <1520855409-28862-1-git-send-email-bardliao@realtek.com>
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

The control register for ADC L2 and R2 is RT5659_PWR_DIG_1
not RT5659_PWR_DIG_2.

Signed-off-by: Zhong An <zhongan@pinecone.net>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5659.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index b772194..a81e248 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -2555,9 +2555,9 @@ static const struct snd_soc_dapm_widget rt5659_dapm_widgets[] = {
 		RT5659_PWR_ADC_L1_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC1 R Power", RT5659_PWR_DIG_1,
 		RT5659_PWR_ADC_R1_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC2 L Power", RT5659_PWR_DIG_2,
+	SND_SOC_DAPM_SUPPLY("ADC2 L Power", RT5659_PWR_DIG_1,
 		RT5659_PWR_ADC_L2_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC2 R Power", RT5659_PWR_DIG_2,
+	SND_SOC_DAPM_SUPPLY("ADC2 R Power", RT5659_PWR_DIG_1,
 		RT5659_PWR_ADC_R2_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC1 clock", SND_SOC_NOPM, 0, 0, set_adc_clk,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-- 
2.7.4
