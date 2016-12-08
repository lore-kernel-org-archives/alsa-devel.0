From: jeeja.kp@intel.com
Subject: [PATCH v3 02/13] ASoC: Intel: Skylake: Add helper
	function to setup host/link dma
Date: Thu,  8 Dec 2016 13:41:13 +0530
Message-ID: <1481184684-9620-3-git-send-email-jeeja.kp@intel.com>
References: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EC58266993
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 09:01:18 +0100 (CET)
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

This patch adds helper function to configure the host/link DMA when
the DMA is in decoupled mode.
Next patch adds the usage of this helper routines for configuring
DMA in Mixer event handler.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      | 74 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  4 ++
 2 files changed, 78 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 105aab7..8a7b6f7 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -137,6 +137,80 @@ static void skl_set_suspend_active(struct snd_pcm_substream *substream,
 		skl->supend_active--;
 }
 
+int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	unsigned int format_val;
+	struct hdac_stream *hstream;
+	struct hdac_ext_stream *stream;
+	int err;
+
+	hstream = snd_hdac_get_stream(bus, params->stream,
+					params->host_dma_id + 1);
+	if (!hstream)
+		return -EINVAL;
+
+	stream = stream_to_hdac_ext_stream(hstream);
+	snd_hdac_ext_stream_decouple(ebus, stream, true);
+
+	format_val = snd_hdac_calc_stream_format(params->s_freq,
+				params->ch, params->format, 32, 0);
+
+	dev_dbg(dev, "format_val=%d, rate=%d, ch=%d, format=%d\n",
+		format_val, params->s_freq, params->ch, params->format);
+
+	snd_hdac_stream_reset(hdac_stream(stream));
+	err = snd_hdac_stream_set_params(hdac_stream(stream), format_val);
+	if (err < 0)
+		return err;
+
+	err = snd_hdac_stream_setup(hdac_stream(stream));
+	if (err < 0)
+		return err;
+
+	hdac_stream(stream)->prepared = 1;
+
+	return 0;
+}
+
+int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	unsigned int format_val;
+	struct hdac_stream *hstream;
+	struct hdac_ext_stream *stream;
+	struct hdac_ext_link *link;
+
+	hstream = snd_hdac_get_stream(bus, params->stream,
+					params->link_dma_id + 1);
+	if (!hstream)
+		return -EINVAL;
+
+	stream = stream_to_hdac_ext_stream(hstream);
+	snd_hdac_ext_stream_decouple(ebus, stream, true);
+	format_val = snd_hdac_calc_stream_format(params->s_freq,
+				params->ch, params->format, 24, 0);
+
+	dev_dbg(dev, "format_val=%d, rate=%d, ch=%d, format=%d\n",
+		format_val, params->s_freq, params->ch, params->format);
+
+	snd_hdac_ext_link_stream_reset(stream);
+
+	snd_hdac_ext_link_stream_setup(stream, format_val);
+
+	list_for_each_entry(link, &ebus->hlink_list, list) {
+		if (link->index == params->link_index)
+			snd_hdac_ext_link_set_stream_id(link,
+					hstream->stream_tag);
+	}
+
+	stream->link_prepared = 1;
+
+	return 0;
+}
+
 static int skl_pcm_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 405765f..a0d3158 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -385,4 +385,8 @@ int skl_get_module_params(struct skl_sst *ctx, u32 *params, int size,
 struct skl_module_cfg *skl_tplg_be_get_cpr_module(struct snd_soc_dai *dai,
 								int stream);
 enum skl_bitdepth skl_get_bit_depth(int params);
+int skl_pcm_host_dma_prepare(struct device *dev,
+			struct skl_pipe_params *params);
+int skl_pcm_link_dma_prepare(struct device *dev,
+			struct skl_pipe_params *params);
 #endif
-- 
2.5.0
