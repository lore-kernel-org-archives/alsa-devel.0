From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: Enable 24 bit sample size in PIO mode" to the asoc tree
Date: Mon, 09 Jan 2017 20:01:33 +0000
Message-ID: <E1cQg8L-0006uG-SC@debutante>
References: <4208c77798e92cfeb7305add296b6eb414c96f27.1482846853.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4208c77798e92cfeb7305add296b6eb414c96f27.1482846853.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Jose Abreu <joabreu@synopsys.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: Enable 24 bit sample size in PIO mode

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

>From e21ab17904ff5c56bd6d6d062824ca584a42d89f Mon Sep 17 00:00:00 2001
From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Tue, 27 Dec 2016 14:00:54 +0000
Subject: [PATCH] ASoC: dwc: Enable 24 bit sample size in PIO mode

Sample size of 24 bits use in reality 32 bits for storage. We
can safelly enable this sample size and treat the data as
32 bits.

Tested in a x86_64 platform and in ARC AXS101 SDP platform.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/dwc/designware_pcm.c b/sound/soc/dwc/designware_pcm.c
index b063c8601569..459ec861e6b6 100644
--- a/sound/soc/dwc/designware_pcm.c
+++ b/sound/soc/dwc/designware_pcm.c
@@ -80,6 +80,7 @@ static const struct snd_pcm_hardware dw_pcm_hardware = {
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
2.11.0
