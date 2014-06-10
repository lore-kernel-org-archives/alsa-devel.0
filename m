From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 4/4] ASoC: rt5677: Add a PMD case to MICBIAS1
	event
Date: Tue, 10 Jun 2014 14:35:26 +0800
Message-ID: <1402382126-704-4-git-send-email-oder_chiou@realtek.com>
References: <1402382126-704-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A037265274
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 08:35:39 +0200 (CEST)
In-Reply-To: <1402382126-704-1-git-send-email-oder_chiou@realtek.com>
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds a PMD case to MICBIAS1 event.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 438f384..068bcd9 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1670,6 +1670,13 @@ static int rt5677_set_micbias1_event(struct snd_soc_dapm_widget *w,
 			RT5677_PWR_CLK_MB, RT5677_PWR_CLK_MB1 |
 			RT5677_PWR_PP_MB1 | RT5677_PWR_CLK_MB);
 		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
+			RT5677_PWR_CLK_MB1 | RT5677_PWR_PP_MB1 |
+			RT5677_PWR_CLK_MB, 0);
+		break;
+
 	default:
 		return 0;
 	}
@@ -1686,7 +1693,8 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	/* Input Side */
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5677_PWR_ANLG2, RT5677_PWR_MB1_BIT,
-		0, rt5677_set_micbias1_event, SND_SOC_DAPM_POST_PMU),
+		0, rt5677_set_micbias1_event, SND_SOC_DAPM_PRE_PMD |
+		SND_SOC_DAPM_POST_PMU),
 
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC L1"),
-- 
1.8.1.1.439.g50a6b54
