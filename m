From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/5] ASoC: tpa6130a2: Add stereo DAPM path
Date: Tue, 30 Nov 2010 16:00:03 +0200
Message-ID: <1291125604-10396-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id E48E9103986
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

New DAPM widgets, and paths to enable both channels at the
same time (for stereo output).
With this path the switch time difference can be avoided
between left and right channels.
The original DAPM paths can be still used, if only one of
TPA's output has been connected to a speaker, but for most of
the cases, switching to the stereo path is better.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 4c77a82..c97badf 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -354,20 +354,27 @@ static const struct snd_soc_dapm_widget tpa6130a2_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA_E("TPA6130A2 Right", SND_SOC_NOPM,
 			TPA6130A2_HP_EN_R, 0, NULL, 0, tpa6130a2_pga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("TPA6130A2 Stereo", SND_SOC_NOPM,
+			TPA6130A2_HP_EN_L | TPA6130A2_HP_EN_R, 0, NULL, 0,
+			tpa6130a2_pga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("TPA6130A2 Enable", SND_SOC_NOPM,
 			0, 0, tpa6130a2_supply_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	/* Outputs */
 	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Left"),
 	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Right"),
+	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Stereo"),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
 	{"TPA6130A2 Headphone Left", NULL, "TPA6130A2 Left"},
 	{"TPA6130A2 Headphone Right", NULL, "TPA6130A2 Right"},
+	{"TPA6130A2 Headphone Stereo", NULL, "TPA6130A2 Stereo"},
 
 	{"TPA6130A2 Headphone Left", NULL, "TPA6130A2 Enable"},
 	{"TPA6130A2 Headphone Right", NULL, "TPA6130A2 Enable"},
+	{"TPA6130A2 Headphone Stereo", NULL, "TPA6130A2 Enable"},
 };
 
 int tpa6130a2_add_controls(struct snd_soc_codec *codec)
-- 
1.7.3.2
