From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RESENT PATCH] ASoC: hdmi-codec: Use different name for playback streams
Date: Sat, 12 Aug 2017 08:40:38 +0800
Message-ID: <1502498438-18245-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Vincent Abriou <vincent.abriou@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Colin Ian King <colin.king@canonical.com>
List-Id: alsa-devel@alsa-project.org

Currently the hdmi i2s playback stream and hdmi spdif playback stream
are using the same name. So when they are enabled at the same time,
kernel will print this warning:

[    2.201835] hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: Failed to
create Playback debugfs file

Assign different names to them to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 sound/soc/codecs/hdmi-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 509ab51..a2af440 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -696,7 +696,7 @@ static struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
 	.playback = {
-		.stream_name = "Playback",
+		.stream_name = "I2S Playback",
 		.channels_min = 2,
 		.channels_max = 8,
 		.rates = HDMI_RATES,
@@ -711,7 +711,7 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 	.name = "spdif-hifi",
 	.id = DAI_ID_SPDIF,
 	.playback = {
-		.stream_name = "Playback",
+		.stream_name = "SPDIF Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = HDMI_RATES,
-- 
2.1.4
