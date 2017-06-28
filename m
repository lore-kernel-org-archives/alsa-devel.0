From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5670: fix wrong audio route
Date: Wed, 28 Jun 2017 15:38:00 +0800
Message-ID: <1498635482-4970-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 88137267068
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 09:38:18 +0200 (CEST)
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

When we select "IF1_ADC4" for IF1 ADC Muxes, it is actually connected
to "TxDP_ADC" widget. This patch fixes the audio route and remove the
unexisting "IF1_ADC4" widget.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index e27c5a4..d95d2e6 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1717,7 +1717,6 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("IF1_ADC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1_ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1_ADC3", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1_ADC4", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* DSP */
 	SND_SOC_DAPM_PGA("TxDP_ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -2086,13 +2085,13 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "IF1 ADC1 IN1 Mux", "IF1_ADC3", "IF1_ADC3" },
 
 	{ "IF1 ADC1 IN2 Mux", "IF1_ADC1_IN1", "IF1 ADC1 IN1 Mux" },
-	{ "IF1 ADC1 IN2 Mux", "IF1_ADC4", "IF1_ADC4" },
+	{ "IF1 ADC1 IN2 Mux", "IF1_ADC4", "TxDP_ADC" },
 
 	{ "IF1 ADC2 IN Mux", "IF_ADC2", "IF_ADC2" },
 	{ "IF1 ADC2 IN Mux", "VAD_ADC", "VAD_ADC" },
 
 	{ "IF1 ADC2 IN1 Mux", "IF1_ADC2_IN", "IF1 ADC2 IN Mux" },
-	{ "IF1 ADC2 IN1 Mux", "IF1_ADC4", "IF1_ADC4" },
+	{ "IF1 ADC2 IN1 Mux", "IF1_ADC4", "TxDP_ADC" },
 
 	{ "IF1_ADC1" , NULL, "IF1 ADC1 IN2 Mux" },
 	{ "IF1_ADC2" , NULL, "IF1 ADC2 IN1 Mux" },
-- 
2.7.4
