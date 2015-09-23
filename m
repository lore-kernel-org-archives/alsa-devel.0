From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 6/8] ASoC: Intel: Skylake: Initialize and
	load DSP controls
Date: Wed, 23 Sep 2015 20:33:22 +0530
Message-ID: <1443020604-22282-7-git-send-email-vinod.koul@intel.com>
References: <1443020604-22282-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FB9D264FF6
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 17:01:35 +0200 (CEST)
In-Reply-To: <1443020604-22282-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Initialize and creates DSP controls if processing pipe capability
is supported by HW. Updates the dma_id, hw_params to module param
to be used when DSP module has to be configured.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 143 ++++++++++++++++++++++++++++++--------
 1 file changed, 114 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index bea26730873c..7f352cc2eb9d 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -24,6 +24,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "skl.h"
+#include "skl-topology.h"
 
 #define HDA_MONO 1
 #define HDA_STEREO 2
@@ -214,6 +215,8 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct skl_pipe_params p_params = {0};
+	struct skl_module_cfg *m_cfg;
 	int ret, dma_id;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
@@ -228,6 +231,16 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 	dma_id = hdac_stream(stream)->stream_tag - 1;
 	dev_dbg(dai->dev, "dma_id=%d\n", dma_id);
 
+	p_params.s_fmt = snd_pcm_format_width(params_format(params));
+	p_params.ch = params_channels(params);
+	p_params.s_freq = params_rate(params);
+	p_params.host_dma_id = dma_id;
+	p_params.stream = substream->stream;
+
+	m_cfg = skl_tplg_fe_get_cpr_module(dai, p_params.stream);
+	if (m_cfg)
+		skl_tplg_update_pipe_params(dai->dev, m_cfg, &p_params);
+
 	return 0;
 }
 
@@ -268,6 +281,46 @@ static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
 	return skl_substream_free_pages(ebus_to_hbus(ebus), substream);
 }
 
+static int skl_be_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct skl_pipe_params p_params = {0};
+
+	p_params.s_fmt = snd_pcm_format_width(params_format(params));
+	p_params.ch = params_channels(params);
+	p_params.s_freq = params_rate(params);
+	p_params.stream = substream->stream;
+	skl_tplg_be_update_params(dai, &p_params);
+
+	return 0;
+}
+
+static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
+		struct snd_soc_dai *dai)
+{
+	struct skl *skl = get_skl_ctx(dai->dev);
+	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_module_cfg *mconfig;
+
+	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
+	if (!mconfig)
+		return -EIO;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		return skl_run_pipe(ctx, mconfig->pipe);
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		return skl_stop_pipe(ctx, mconfig->pipe);
+
+	default:
+		return 0;
+	}
+}
+
 static int skl_link_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -277,9 +330,8 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct skl_dma_params *dma_params;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int dma_id;
+	struct skl_pipe_params p_params = {0};
 
-	pr_debug("%s\n", __func__);
 	link_dev = snd_hdac_ext_stream_assign(ebus, substream,
 					HDAC_EXT_STREAM_TYPE_LINK);
 	if (!link_dev)
@@ -293,7 +345,14 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	if (dma_params)
 		dma_params->stream_tag =  hdac_stream(link_dev)->stream_tag;
 	snd_soc_dai_set_dma_data(codec_dai, substream, (void *)dma_params);
-	dma_id = hdac_stream(link_dev)->stream_tag - 1;
+
+	p_params.s_fmt = snd_pcm_format_width(params_format(params));
+	p_params.ch = params_channels(params);
+	p_params.s_freq = params_rate(params);
+	p_params.stream = substream->stream;
+	p_params.link_dma_id = hdac_stream(link_dev)->stream_tag - 1;
+
+	skl_tplg_be_update_params(dai, &p_params);
 
 	return 0;
 }
@@ -308,27 +367,12 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 	unsigned int format_val = 0;
 	struct skl_dma_params *dma_params;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_pcm_hw_params *params;
-	struct snd_interval *channels, *rate;
 	struct hdac_ext_link *link;
 
-	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 	if (link_dev->link_prepared) {
-		dev_dbg(dai->dev, "already stream is prepared - returning\n");
+		dev_info(dai->dev, "already stream is prepared - returning\n");
 		return 0;
 	}
-	params  = devm_kzalloc(dai->dev, sizeof(*params), GFP_KERNEL);
-	if (params == NULL)
-		return -ENOMEM;
-
-	channels = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	channels->min = channels->max = substream->runtime->channels;
-	rate = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	rate->min = rate->max = substream->runtime->rate;
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-					SNDRV_PCM_HW_PARAM_FIRST_MASK],
-					substream->runtime->format);
-
 
 	dma_params  = (struct skl_dma_params *)
 			snd_soc_dai_get_dma_data(codec_dai, substream);
@@ -399,13 +443,13 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_hda_be_startup(struct snd_pcm_substream *substream,
+static int skl_be_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	return pm_runtime_get_sync(dai->dev);
 }
 
-static void skl_hda_be_shutdown(struct snd_pcm_substream *substream,
+static void skl_be_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	pm_runtime_mark_last_busy(dai->dev);
@@ -418,20 +462,28 @@ static struct snd_soc_dai_ops skl_pcm_dai_ops = {
 	.prepare = skl_pcm_prepare,
 	.hw_params = skl_pcm_hw_params,
 	.hw_free = skl_pcm_hw_free,
+	.trigger = skl_pcm_trigger,
 };
 
 static struct snd_soc_dai_ops skl_dmic_dai_ops = {
-	.startup = skl_hda_be_startup,
-	.shutdown = skl_hda_be_shutdown,
+	.startup = skl_be_startup,
+	.hw_params = skl_be_hw_params,
+	.shutdown = skl_be_shutdown,
+};
+
+static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
+	.startup = skl_be_startup,
+	.hw_params = skl_be_hw_params,
+	.shutdown = skl_be_shutdown,
 };
 
 static struct snd_soc_dai_ops skl_link_dai_ops = {
-	.startup = skl_hda_be_startup,
+	.startup = skl_be_startup,
 	.prepare = skl_link_pcm_prepare,
 	.hw_params = skl_link_hw_params,
 	.hw_free = skl_link_hw_free,
 	.trigger = skl_link_pcm_trigger,
-	.shutdown = skl_hda_be_shutdown,
+	.shutdown = skl_be_shutdown,
 };
 
 static struct snd_soc_dai_driver skl_platform_dai[] = {
@@ -488,6 +540,24 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 },
 /* BE CPU  Dais */
 {
+	.name = "SSP0 Pin",
+	.ops = &skl_be_ssp_dai_ops,
+	.playback = {
+		.stream_name = "ssp0 Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "ssp0 Rx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
 	.name = "iDisp Pin",
 	.ops = &skl_link_dai_ops,
 	.playback = {
@@ -544,7 +614,7 @@ static int skl_platform_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int skl_pcm_trigger(struct snd_pcm_substream *substream,
+static int skl_coupled_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
@@ -618,7 +688,7 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_dsp_trigger(struct snd_pcm_substream *substream,
+static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
 		int cmd)
 {
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
@@ -675,9 +745,9 @@ static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
 
 	if (ebus->ppcap)
-		return skl_dsp_trigger(substream, cmd);
+		return skl_decoupled_trigger(substream, cmd);
 	else
-		return skl_pcm_trigger(substream, cmd);
+		return skl_coupled_trigger(substream, cmd);
 }
 
 /* calculate runtime delay from LPIB */
@@ -844,7 +914,17 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return retval;
 }
 
+static int skl_platform_soc_probe(struct snd_soc_platform *platform)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(platform->dev);
+
+	if (ebus->ppcap)
+		return skl_tplg_init(platform, ebus);
+
+	return 0;
+}
 static struct snd_soc_platform_driver skl_platform_drv  = {
+	.probe		= skl_platform_soc_probe,
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
 	.pcm_free	= skl_pcm_free,
@@ -857,6 +937,11 @@ static const struct snd_soc_component_driver skl_component = {
 int skl_platform_register(struct device *dev)
 {
 	int ret;
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct skl *skl = ebus_to_skl(ebus);
+
+	INIT_LIST_HEAD(&skl->ppl_list);
+	INIT_LIST_HEAD(&skl->dapm_path_list);
 
 	ret = snd_soc_register_platform(dev, &skl_platform_drv);
 	if (ret) {
-- 
1.9.1
