From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: pxa2xx-ac97: fix dma requestor lines" to the asoc tree
Date: Tue, 22 Sep 2015 14:13:29 -0700
Message-ID: <E1ZeUsT-00029U-HS@finisterre>
References: <1442949622-29675-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1442949622-29675-1-git-send-email-robert.jarzmik@free.fr>
Sender: stable-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: pxa2xx-ac97: fix dma requestor lines

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

>From 8811191fdf7ed02ee07cb8469428158572d355a2 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 22 Sep 2015 21:20:22 +0200
Subject: [PATCH] ASoC: pxa: pxa2xx-ac97: fix dma requestor lines

PCM receive and transmit DMA requestor lines were reverted, breaking the
PCM playback interface for PXA platforms using the sound/soc/ variant
instead of the sound/arm variant.

The commit below shows the inversion in the requestor lines.

Fixes: d65a14587a9b ("ASoC: pxa: use snd_dmaengine_dai_dma_data")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/pxa/pxa2xx-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 1f60546..9e4b04e 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -49,7 +49,7 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_cold_reset,
 };
 
-static unsigned long pxa2xx_ac97_pcm_stereo_in_req = 12;
+static unsigned long pxa2xx_ac97_pcm_stereo_in_req = 11;
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
@@ -57,7 +57,7 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
 	.filter_data	= &pxa2xx_ac97_pcm_stereo_in_req,
 };
 
-static unsigned long pxa2xx_ac97_pcm_stereo_out_req = 11;
+static unsigned long pxa2xx_ac97_pcm_stereo_out_req = 12;
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
-- 
2.5.0
