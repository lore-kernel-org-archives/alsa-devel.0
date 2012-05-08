From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm9081: Hook DAC up via DAPM rather than
	stream
Date: Tue,  8 May 2012 12:12:40 +0100
Message-ID: <1336475560-22230-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 210BB10425C
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 13:12:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

More current API usage.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 076c126..9328270 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -774,7 +774,7 @@ static const struct snd_soc_dapm_widget wm9081_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("IN1"),
 SND_SOC_DAPM_INPUT("IN2"),
 
-SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM9081_POWER_MANAGEMENT, 0, 0),
+SND_SOC_DAPM_DAC("DAC", NULL, WM9081_POWER_MANAGEMENT, 0, 0),
 
 SND_SOC_DAPM_MIXER_NAMED_CTL("Mixer", SND_SOC_NOPM, 0, 0,
 			     mixer, ARRAY_SIZE(mixer)),
@@ -799,6 +799,7 @@ SND_SOC_DAPM_SUPPLY("TSENSE", WM9081_POWER_MANAGEMENT, 7, 0, NULL, 0),
 static const struct snd_soc_dapm_route wm9081_audio_paths[] = {
 	{ "DAC", NULL, "CLK_SYS" },
 	{ "DAC", NULL, "CLK_DSP" },
+	{ "DAC", NULL, "AIF" },
 
 	{ "Mixer", "IN1 Switch", "IN1" },
 	{ "Mixer", "IN2 Switch", "IN2" },
@@ -1252,7 +1253,7 @@ static const struct snd_soc_dai_ops wm9081_dai_ops = {
 static struct snd_soc_dai_driver wm9081_dai = {
 	.name = "wm9081-hifi",
 	.playback = {
-		.stream_name = "HiFi Playback",
+		.stream_name = "AIF",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM9081_RATES,
-- 
1.7.10
