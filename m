From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Atmel: ClassD: supports mono audio" to
	the asoc tree
Date: Fri, 20 Nov 2015 18:20:21 +0000
Message-ID: <E1ZzqIH-0003sW-CQ@debutante>
References: <1447904732-10784-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D677A26667E
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:32 +0100 (CET)
In-Reply-To: <1447904732-10784-1-git-send-email-songjun.wu@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Songjun Wu <songjun.wu@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Atmel: ClassD: supports mono audio

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

>From 07c55d395041c5b4cbdffd39a1bba41a61f87fe9 Mon Sep 17 00:00:00 2001
From: Songjun Wu <songjun.wu@atmel.com>
Date: Thu, 19 Nov 2015 11:45:32 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: supports mono audio

Modify the code to support mono audio.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-classd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 8276675730ef..dca614177fef 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -106,7 +106,7 @@ static const struct snd_pcm_hardware atmel_classd_hw = {
 	.rates			= ATMEL_CLASSD_RATES,
 	.rate_min		= 8000,
 	.rate_max		= 96000,
-	.channels_min		= 2,
+	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= 64 * 1024,
 	.period_bytes_min	= 256,
@@ -145,7 +145,7 @@ static const struct snd_soc_dai_ops atmel_classd_cpu_dai_ops = {
 
 static struct snd_soc_dai_driver atmel_classd_cpu_dai = {
 	.playback = {
-		.channels_min	= 2,
+		.channels_min	= 1,
 		.channels_max	= 2,
 		.rates		= ATMEL_CLASSD_RATES,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,},
@@ -171,9 +171,13 @@ atmel_classd_platform_configure_dma(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	if (params_channels(params) == 1)
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	else
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
 	slave_config->direction		= DMA_MEM_TO_DEV;
 	slave_config->dst_addr		= dd->phy_base + CLASSD_THR;
-	slave_config->dst_addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES;
 	slave_config->dst_maxburst	= 1;
 	slave_config->src_maxburst	= 1;
 	slave_config->device_fc		= false;
@@ -486,7 +490,7 @@ static struct snd_soc_dai_driver atmel_classd_codec_dai = {
 	.name = ATMEL_CLASSD_CODEC_DAI_NAME,
 	.playback = {
 		.stream_name	= "Playback",
-		.channels_min	= 2,
+		.channels_min	= 1,
 		.channels_max	= 2,
 		.rates		= ATMEL_CLASSD_RATES,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
-- 
2.6.2
