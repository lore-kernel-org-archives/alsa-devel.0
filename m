From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Provide a more complete DMA driver stub
Date: Mon,  5 Dec 2011 20:56:24 +0000
Message-ID: <1323118585-18216-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55A5824157
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 21:56:30 +0100 (CET)
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

Allow userspace applications to do more parameter setting by providing a
more complete stub DMA driver specifying a wildcard set of formats and
channels and essentially random values for the DMA parameters. This is
required for useful runtime operation of the dummy DMA driver until we
are able to figure out how to power up links and do hw_params() from DAPM.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-utils.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 0c12b98..4220bb0 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -58,7 +58,36 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *params)
 }
 EXPORT_SYMBOL_GPL(snd_soc_params_to_bclk);
 
-static struct snd_soc_platform_driver dummy_platform;
+static const struct snd_pcm_hardware dummy_dma_hardware = {
+	.formats		= 0xffffffff,
+	.channels_min		= 1,
+	.channels_max		= UINT_MAX,
+
+	/* Random values to keep userspace happy when checking constraints */
+	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.buffer_bytes_max	= 128*1024,
+	.period_bytes_min	= PAGE_SIZE,
+	.period_bytes_max	= PAGE_SIZE*2,
+	.periods_min		= 2,
+	.periods_max		= 128,
+};
+
+static int dummy_dma_open(struct snd_pcm_substream *substream)
+{
+	snd_soc_set_runtime_hwparams(substream, &dummy_dma_hardware);
+
+	return 0;
+}
+
+static struct snd_pcm_ops dummy_dma_ops = {
+	.open		= dummy_dma_open,
+	.ioctl		= snd_pcm_lib_ioctl,
+};
+
+static struct snd_soc_platform_driver dummy_platform = {
+	.ops = &dummy_dma_ops,
+};
 
 static __devinit int snd_soc_dummy_probe(struct platform_device *pdev)
 {
-- 
1.7.7.3
