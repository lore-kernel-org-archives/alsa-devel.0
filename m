From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/5] ASoC: tpa6130a2: Use one event handler for
	PGA_E
Date: Tue, 30 Nov 2010 16:00:02 +0200
Message-ID: <1291125604-10396-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id BF8A5103983
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:00:12 +0100 (CET)
In-Reply-To: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Reduce the amount of duplicated code by using single
event handler for PGA_E to enable the needed channel.
Use the w->shift to pass the channel information to
the handler function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 42887ae..4c77a82 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -317,29 +317,15 @@ static void tpa6130a2_channel_enable(u8 channel, int enable)
 	}
 }
 
-static int tpa6130a2_left_event(struct snd_soc_dapm_widget *w,
+static int tpa6130a2_pga_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		tpa6130a2_channel_enable(TPA6130A2_HP_EN_L, 1);
+		tpa6130a2_channel_enable(w->shift, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		tpa6130a2_channel_enable(TPA6130A2_HP_EN_L, 0);
-		break;
-	}
-	return 0;
-}
-
-static int tpa6130a2_right_event(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *kcontrol, int event)
-{
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R, 1);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R, 0);
+		tpa6130a2_channel_enable(w->shift, 0);
 		break;
 	}
 	return 0;
@@ -363,10 +349,10 @@ static int tpa6130a2_supply_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_soc_dapm_widget tpa6130a2_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA_E("TPA6130A2 Left", SND_SOC_NOPM,
-			0, 0, NULL, 0, tpa6130a2_left_event,
+			TPA6130A2_HP_EN_L, 0, NULL, 0, tpa6130a2_pga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_PGA_E("TPA6130A2 Right", SND_SOC_NOPM,
-			0, 0, NULL, 0, tpa6130a2_right_event,
+			TPA6130A2_HP_EN_R, 0, NULL, 0, tpa6130a2_pga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("TPA6130A2 Enable", SND_SOC_NOPM,
 			0, 0, tpa6130a2_supply_event,
-- 
1.7.3.2
