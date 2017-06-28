From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5670: remove duplicate route.
Date: Wed, 28 Jun 2017 15:38:01 +0800
Message-ID: <1498635482-4970-2-git-send-email-bardliao@realtek.com>
References: <1498635482-4970-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8978026706A
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 09:38:18 +0200 (CEST)
In-Reply-To: <1498635482-4970-1-git-send-email-bardliao@realtek.com>
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

{ "ADC Stereo1 Filter", NULL, "PLL1", is_sys_clk_from_pll }, and
{ "ADC Stereo2 Filter", NULL, "PLL1", is_sys_clk_from_pll }, are
defined twice in the driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index d95d2e6..1146a96 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2022,7 +2022,6 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 
 	{ "Stereo1 ADC MIXL", NULL, "Sto1 ADC MIXL" },
 	{ "Stereo1 ADC MIXL", NULL, "ADC Stereo1 Filter" },
-	{ "ADC Stereo1 Filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "Stereo1 ADC MIXR", NULL, "Sto1 ADC MIXR" },
 	{ "Stereo1 ADC MIXR", NULL, "ADC Stereo1 Filter" },
@@ -2061,7 +2060,6 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 
 	{ "Stereo2 ADC MIXL", NULL, "Stereo2 ADC LR Mux" },
 	{ "Stereo2 ADC MIXL", NULL, "ADC Stereo2 Filter" },
-	{ "ADC Stereo2 Filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "Stereo2 ADC MIXR", NULL, "Sto2 ADC MIXR" },
 	{ "Stereo2 ADC MIXR", NULL, "ADC Stereo2 Filter" },
-- 
2.7.4
