From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 4/4] ASoC: fsl_ssi: Add stream names for DPCM usage
Date: Wed, 30 Jul 2014 11:10:29 +0800
Message-ID: <891b9f4edbba81a03c2b8350abc5ccf923db9260.1406688049.git.nicoleotsuka@gmail.com>
References: <cover.1406688048.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1406688048.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org, b42378@freescale.com, b02247@freescale.com
List-Id: alsa-devel@alsa-project.org

DPCM needs extra dapm routes in the machine driver to route audio
between Front-End and Back-End. In order to differ the stream names
in the route map from CODECs, we here add specific stream names to
SSI driver so that we can implement ASRC via DPCM to it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3043d57..87eb577 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1032,12 +1032,14 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.probe = fsl_ssi_dai_probe,
 	.playback = {
+		.stream_name = "CPU-Playback",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
 	.capture = {
+		.stream_name = "CPU-Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
-- 
1.8.4
