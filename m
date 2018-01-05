From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: mt8173: remove unnecessary micbias
	widget in route
Date: Fri, 5 Jan 2018 17:00:51 +0800
Message-ID: <1515142851-11445-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id D0807266CFE
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 10:01:01 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The micbias1/2 are connected to route as SUPPLY usage. It was not
take effect since they were MICBIAS type. To keep the same register
settings, we have to remove it once the micbias1/2 widget is converted
to SUPPLY type.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 2 --
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 2 --
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 2 --
 3 files changed, 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 99c1521..5a9a548 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -37,8 +37,6 @@ static const struct snd_soc_dapm_route mt8173_rt5650_rt5514_routes[] = {
 	{"Sub DMIC1R", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
-	{"Headset Mic", NULL, "micbias1"},
-	{"Headset Mic", NULL, "micbias2"},
 	{"IN1P", NULL, "Headset Mic"},
 	{"IN1N", NULL, "Headset Mic"},
 };
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 42de84c..b724808 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -40,8 +40,6 @@ static const struct snd_soc_dapm_route mt8173_rt5650_rt5676_routes[] = {
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Headphone", NULL, "Sub AIF2TX"}, /* IF2 ADC to 5650  */
-	{"Headset Mic", NULL, "micbias1"},
-	{"Headset Mic", NULL, "micbias2"},
 	{"IN1P", NULL, "Headset Mic"},
 	{"IN1N", NULL, "Headset Mic"},
 	{"Sub AIF2RX", NULL, "Headset Mic"}, /* IF2 DAC from 5650  */
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index e69c141..40ebefd 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -51,8 +51,6 @@ static const struct snd_soc_dapm_route mt8173_rt5650_routes[] = {
 	{"DMIC R1", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
-	{"Headset Mic", NULL, "micbias1"},
-	{"Headset Mic", NULL, "micbias2"},
 	{"IN1P", NULL, "Headset Mic"},
 	{"IN1N", NULL, "Headset Mic"},
 };
-- 
2.7.4
