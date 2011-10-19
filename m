From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: ak4641: Use SND_SOC_DAPM_DAC for Voice Playback
 stream widget
Date: Wed, 19 Oct 2011 23:24:54 +0800
Message-ID: <1319037894.7741.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Harald Welte <laforge@gnumonks.org>, Philipp Zabel <philipp.zabel@gmail.com>, Dmitry Artamonow <mad_soft@inbox.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4641.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index f5125ae..7783858 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -225,7 +225,7 @@ static const struct snd_soc_dapm_widget ak4641_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("Mono Out 2", AK4641_PM2, 3, 0, NULL, 0),
 
 	SND_SOC_DAPM_ADC("Voice ADC", "Voice Capture", AK4641_BTIF, 0, 0),
-	SND_SOC_DAPM_ADC("Voice DAC", "Voice Playback", AK4641_BTIF, 1, 0),
+	SND_SOC_DAPM_DAC("Voice DAC", "Voice Playback", AK4641_BTIF, 1, 0),
 
 	SND_SOC_DAPM_MICBIAS("Mic Int Bias", AK4641_MIC, 3, 0),
 	SND_SOC_DAPM_MICBIAS("Mic Ext Bias", AK4641_MIC, 4, 0),
-- 
1.7.5.4
