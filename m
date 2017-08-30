From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: Use different name for playback streams" to the asoc tree
Date: Wed, 30 Aug 2017 22:19:48 +0100
Message-ID: <E1dnAOq-00079i-L4@debutante>
References: <1502498438-18245-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502498438-18245-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, "Jon Medhurst (Tixy)" <tixy@linaro.org>, alsa-devel@alsa-project.org, briannorris@chromium.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, dianders@chromium.orgMark Brown <broonie@kernel.org>, Colin Ian King <colin.king@canonical.com>, Takashi Iwai <tiwai@suse.com>, Vincent Abriou <vincent.abriou@st.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: Use different name for playback streams

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 943fa0228252320de503b923dfe46334f755aaae Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Sat, 12 Aug 2017 08:40:38 +0800
Subject: [PATCH] ASoC: hdmi-codec: Use different name for playback streams

Currently the hdmi i2s playback stream and hdmi spdif playback stream
are using the same name. So when they are enabled at the same time,
kernel will print this warning:

[    2.201835] hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: Failed to
create Playback debugfs file

Assign different names to them to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f7520413c671..189af068f28d 100644
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
2.14.1
