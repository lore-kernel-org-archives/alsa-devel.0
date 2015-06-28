From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 2/6] ASoC: fsl_ssi: AC'97 DAI driver needs probe method too
Date: Sun, 28 Jun 2015 15:45:23 +0200
Message-ID: <558FFA73.9030103@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

AC'97 DAI driver struct need the same probe method as
I2S one to setup DMA params in fsl_ssi driver.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9c46c7d..2ce9e1d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1101,6 +1101,7 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.bus_control = true,
+	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
