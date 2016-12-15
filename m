From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add helper function to
	setup host/link dma" to the asoc tree
Date: Thu, 15 Dec 2016 12:20:44 +0000
Message-ID: <E1cHV1g-0000Vr-DI@debutante>
References: <1481118275-30715-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E3D32671EE
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:20:50 +0100 (CET)
In-Reply-To: <1481118275-30715-3-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add helper function to setup host/link dma

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

>From ad036bdee57ab2287535fe53864bb5154e101991 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 8 Dec 2016 13:41:13 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add helper function to setup host/link
 dma

This patch adds helper function to configure the host/link DMA when
the DMA is in decoupled mode.
Next patch adds the usage of this helper routines for configuring
DMA in Mixer event handler.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 74 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  4 ++
 2 files changed, 78 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index aebae234152c..1abff8e1a298 100644
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
index 405765f3a6b5..a0d3158196f0 100644
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
2.11.0
