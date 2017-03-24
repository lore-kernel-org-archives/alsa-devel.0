From: jeeja.kp@intel.com
Subject: [PATCH v2 02/11] ASoC: Intel: Skylake: Use the
	sig_bits to define dai bps capability
Date: Fri, 24 Mar 2017 23:10:25 +0530
Message-ID: <1490377234-30257-3-git-send-email-jeeja.kp@intel.com>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 487D62674C5
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:22 +0100 (CET)
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

For calculating the HDA DMA format, use the max_bps supported by the
DAI caps instead of fixing it to 32/24. For host DMA the Max bps support
is 32, but in case of link DMA, this depends on the codec capability.
So use the sig_bits to define the bps supported by dai.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      | 25 ++++++++++++++++++++++---
 sound/soc/intel/skylake/skl-topology.c |  2 ++
 sound/soc/intel/skylake/skl-topology.h |  2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 2f90bc4..3c61dba 100644
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
index c6bd4bb..43f9cb3 100644
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
index fefab0e..bf2c63b 100644
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
2.5.0
