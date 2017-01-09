From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH v2 2/2] ASoC: dwc: Enable 24 bit sample size in PIO mode
Date: Mon,  9 Jan 2017 13:43:28 +0000
Message-ID: <4208c77798e92cfeb7305add296b6eb414c96f27.1483969112.git.joabreu@synopsys.com>
References: <cover.1483969112.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483969112.git.joabreu@synopsys.com>
In-Reply-To: <cover.1483969112.git.joabreu@synopsys.com>
References: <cover.1483969112.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Sample size of 24 bits use in reality 32 bits for storage. We
can safelly enable this sample size and treat the data as
32 bits.

Tested in a x86_64 platform and in ARC AXS101 SDP platform.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/dwc/designware_pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/designware_pcm.c
index b063c86..459ec86 100644
--- a/sound/soc/dwc/designware_pcm.c
+++ b/sound/soc/dwc/designware_pcm.c
@@ -80,6 +80,7 @@
 	.rate_min = 32000,
 	.rate_max = 48000,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_S24_LE |
 		SNDRV_PCM_FMTBIT_S32_LE,
 	.channels_min = 2,
 	.channels_max = 2,
@@ -175,6 +176,7 @@ static int dw_pcm_hw_params(struct snd_pcm_substream *substream,
 		dev->tx_fn = dw_pcm_tx_16;
 		dev->rx_fn = dw_pcm_rx_16;
 		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dev->tx_fn = dw_pcm_tx_32;
 		dev->rx_fn = dw_pcm_rx_32;
-- 
1.9.1
