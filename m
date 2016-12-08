From: jeeja.kp@intel.com
Subject: [PATCH v3 01/13] ASoC: Intel: Skylake: Update
	link_index and format in pipe params
Date: Thu,  8 Dec 2016 13:41:12 +0530
Message-ID: <1481184684-9620-2-git-send-email-jeeja.kp@intel.com>
References: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 576122667B2
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 09:01:15 +0100 (CET)
In-Reply-To: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
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

To configure Host/Link DMA, additionally link index and format
are required based on the hw params. So added these parameters in
the pipe params and in hw_params the pipe params are updated.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      | 8 ++++++++
 sound/soc/intel/skylake/skl-topology.c | 2 ++
 sound/soc/intel/skylake/skl-topology.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 84b5101..105aab7 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -292,6 +292,7 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 	p_params.s_freq = params_rate(params);
 	p_params.host_dma_id = dma_id;
 	p_params.stream = substream->stream;
+	p_params.format = params_format(params);
 
 	m_cfg = skl_tplg_fe_get_cpr_module(dai, p_params.stream);
 	if (m_cfg)
@@ -506,6 +507,7 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_ext_dma_params *dma_params;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct skl_pipe_params p_params = {0};
+	struct hdac_ext_link *link;
 
 	link_dev = snd_hdac_ext_stream_assign(ebus, substream,
 					HDAC_EXT_STREAM_TYPE_LINK);
@@ -514,6 +516,10 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_dai_set_dma_data(dai, substream, (void *)link_dev);
 
+	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
+	if (!link)
+		return -EINVAL;
+
 	/* set the stream tag in the codec dai dma params  */
 	dma_params = snd_soc_dai_get_dma_data(codec_dai, substream);
 	if (dma_params)
@@ -524,6 +530,8 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	p_params.s_freq = params_rate(params);
 	p_params.stream = substream->stream;
 	p_params.link_dma_id = hdac_stream(link_dev)->stream_tag - 1;
+	p_params.link_index = link->index;
+	p_params.format = params_format(params);
 
 	return skl_tplg_be_update_params(dai, &p_params);
 }
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index bd313c9..484d451 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1207,6 +1207,7 @@ static void skl_tplg_fill_dma_id(struct skl_module_cfg *mcfg,
 		switch (mcfg->dev_type) {
 		case SKL_DEVICE_HDALINK:
 			pipe->p_params->link_dma_id = params->link_dma_id;
+			pipe->p_params->link_index = params->link_index;
 			break;
 
 		case SKL_DEVICE_HDAHOST:
@@ -1220,6 +1221,7 @@ static void skl_tplg_fill_dma_id(struct skl_module_cfg *mcfg,
 		pipe->p_params->ch = params->ch;
 		pipe->p_params->s_freq = params->s_freq;
 		pipe->p_params->stream = params->stream;
+		pipe->p_params->format = params->format;
 
 	} else {
 		memcpy(pipe->p_params, params, sizeof(*params));
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 08d3928..405765f 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -254,6 +254,8 @@ struct skl_pipe_params {
 	u32 s_freq;
 	u32 s_fmt;
 	u8 linktype;
+	snd_pcm_format_t format;
+	int link_index;
 	int stream;
 };
 
-- 
2.5.0
