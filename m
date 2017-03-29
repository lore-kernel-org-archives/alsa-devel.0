From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use the sig_bits to
	define dai bps capability" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:35 +0100
Message-ID: <E1ctCBP-0001bc-Td@debutante>
References: <1490275926-2270-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA4A8266FE1
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:44 +0200 (CEST)
In-Reply-To: <1490275926-2270-3-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use the sig_bits to define dai bps capability

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

>From 7f975a385b9313a03c13fb0be0a129c626f9a54e Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 24 Mar 2017 23:10:25 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use the sig_bits to define dai bps
 capability

For calculating the HDA DMA format, use the max_bps supported by the
DAI caps instead of fixing it to 32/24. For host DMA the Max bps support
is 32, but in case of link DMA, this depends on the codec capability.
So use the sig_bits to define the bps supported by dai.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 25 ++++++++++++++++++++++---
 sound/soc/intel/skylake/skl-topology.c |  2 ++
 sound/soc/intel/skylake/skl-topology.h |  2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 2f90bc40be77..3c61dbab3d4f 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -155,7 +155,7 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	snd_hdac_ext_stream_decouple(ebus, stream, true);
 
 	format_val = snd_hdac_calc_stream_format(params->s_freq,
-				params->ch, params->format, 32, 0);
+			params->ch, params->format, params->host_bps, 0);
 
 	dev_dbg(dev, "format_val=%d, rate=%d, ch=%d, format=%d\n",
 		format_val, params->s_freq, params->ch, params->format);
@@ -190,8 +190,8 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 
 	stream = stream_to_hdac_ext_stream(hstream);
 	snd_hdac_ext_stream_decouple(ebus, stream, true);
-	format_val = snd_hdac_calc_stream_format(params->s_freq,
-				params->ch, params->format, 24, 0);
+	format_val = snd_hdac_calc_stream_format(params->s_freq, params->ch,
+					params->format, params->link_bps, 0);
 
 	dev_dbg(dev, "format_val=%d, rate=%d, ch=%d, format=%d\n",
 		format_val, params->s_freq, params->ch, params->format);
@@ -309,6 +309,11 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 	p_params.host_dma_id = dma_id;
 	p_params.stream = substream->stream;
 	p_params.format = params_format(params);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		p_params.host_bps = dai->driver->playback.sig_bits;
+	else
+		p_params.host_bps = dai->driver->capture.sig_bits;
+
 
 	m_cfg = skl_tplg_fe_get_cpr_module(dai, p_params.stream);
 	if (m_cfg)
@@ -547,6 +552,11 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	p_params.link_index = link->index;
 	p_params.format = params_format(params);
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		p_params.link_bps = codec_dai->driver->playback.sig_bits;
+	else
+		p_params.link_bps = codec_dai->driver->capture.sig_bits;
+
 	return skl_tplg_be_update_params(dai, &p_params);
 }
 
@@ -652,6 +662,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_8000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 32,
 	},
 	.capture = {
 		.stream_name = "System Capture",
@@ -659,6 +670,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+		.sig_bits = 32,
 	},
 },
 {
@@ -670,6 +682,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.channels_max = HDA_QUAD,
 		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+		.sig_bits = 32,
 	},
 },
 {
@@ -681,6 +694,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+		.sig_bits = 32,
 	},
 },
 {
@@ -692,6 +706,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+		.sig_bits = 32,
 	},
 },
 {
@@ -703,6 +718,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.channels_max = HDA_QUAD,
 		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+		.sig_bits = 32,
 	},
 },
 {
@@ -718,6 +734,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 			SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
 			SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 32,
 	},
 },
 {
@@ -733,6 +750,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 			SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
 			SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 32,
 	},
 },
 {
@@ -748,6 +766,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 			SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
 			SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 32,
 	},
 },
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c6bd4bb49ec0..43f9cb380a76 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1242,10 +1242,12 @@ static void skl_tplg_fill_dma_id(struct skl_module_cfg *mcfg,
 		case SKL_DEVICE_HDALINK:
 			pipe->p_params->link_dma_id = params->link_dma_id;
 			pipe->p_params->link_index = params->link_index;
+			pipe->p_params->link_bps = params->link_bps;
 			break;
 
 		case SKL_DEVICE_HDAHOST:
 			pipe->p_params->host_dma_id = params->host_dma_id;
+			pipe->p_params->host_bps = params->host_bps;
 			break;
 
 		default:
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index fefab0e99a3b..bf2c63b4ab83 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -257,6 +257,8 @@ struct skl_pipe_params {
 	snd_pcm_format_t format;
 	int link_index;
 	int stream;
+	unsigned int host_bps;
+	unsigned int link_bps;
 };
 
 struct skl_pipe {
-- 
2.11.0
