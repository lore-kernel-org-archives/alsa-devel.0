From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [RESEND][PATCH v4 3/3] ASoC: Intel: Skylake: Add
	support for spib mode
Date: Tue, 20 Mar 2018 21:31:08 +0530
Message-ID: <1521561668-28613-4-git-send-email-sriramx.periyasamy@intel.com>
References: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id AC1A426739D
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 17:09:41 +0100 (CET)
In-Reply-To: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

Skylake audio controller supports SPIB (Software Position in buffer)
capability, which can be used to inform position of application pointer
to host DMA controller.
When SPIB mode is enabled, driver could write the application pointer
position in SPIB register. Host DMA will make sure it won't
read/write beyond bytes specified in SPIB register.

SPIB mode will be useful in low power use cases, where DSP could
pre-fetch large buffers to avoid frequent wakes caused due to
interrupts.

Skylake driver makes use of no_rewind flag and appl_ptr_update
callback to enable and update SPIB register respectively.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 43 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 15cb8ac3e374..01780a50a322 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -43,7 +43,8 @@ static const struct snd_pcm_hardware azx_pcm_hw = {
 				 SNDRV_PCM_INFO_SYNC_START |
 				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
 				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
-				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
+				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP |
+				 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE |
 				SNDRV_PCM_FMTBIT_S32_LE |
 				SNDRV_PCM_FMTBIT_S24_LE,
@@ -145,6 +146,7 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	unsigned int format_val;
 	struct hdac_stream *hstream;
 	struct hdac_ext_stream *stream;
+	struct snd_pcm_runtime *runtime;
 	int err;
 
 	hstream = snd_hdac_get_stream(bus, params->stream,
@@ -170,6 +172,11 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	if (err < 0)
 		return err;
 
+	/* Enable SPIB if no_rewinds flag is set */
+	runtime = hdac_stream(stream)->substream->runtime;
+	if (runtime->no_rewinds)
+		snd_hdac_ext_stream_spbcap_enable(ebus, true, hstream->index);
+
 	hdac_stream(stream)->prepared = 1;
 
 	return 0;
@@ -366,9 +373,14 @@ static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct hdac_stream *hstream = hdac_stream(stream);
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
+	if (runtime->no_rewinds)
+		snd_hdac_ext_stream_spbcap_enable(ebus, false, hstream->index);
+
 	snd_hdac_stream_cleanup(hdac_stream(stream));
 	hdac_stream(stream)->prepared = 0;
 
@@ -444,6 +456,7 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct skl_module_cfg *mconfig;
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_dapm_widget *w;
 	int ret;
 
@@ -469,6 +482,10 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			snd_hdac_ext_stream_set_dpibr(ebus, stream,
 							stream->lpib);
 			snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
+
+			if (runtime->no_rewinds)
+				snd_hdac_ext_stream_set_spib(ebus,
+						stream, stream->spib);
 		}
 
 	case SNDRV_PCM_TRIGGER_START:
@@ -1095,6 +1112,29 @@ static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+/* Update SPIB register with application position */
+static int skl_platform_ack(struct snd_pcm_substream *substream)
+{
+	struct hdac_ext_stream *estream = get_hdac_ext_stream(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	ssize_t appl_pos, buf_size;
+	u32 spib;
+
+	/* Use spib mode only if no_rewind mode is set */
+	if (!runtime->no_rewinds)
+		return 0;
+
+	appl_pos = frames_to_bytes(runtime, runtime->control->appl_ptr);
+	buf_size = frames_to_bytes(runtime, runtime->buffer_size);
+
+	spib = appl_pos % buf_size;
+
+	/* Allowable value for SPIB is 1 byte to max buffer size */
+	spib = (spib == 0) ? buf_size : spib;
+	return snd_hdac_ext_stream_set_spib(ebus, estream, spib);
+}
+
 static snd_pcm_uframes_t skl_platform_pcm_pointer
 			(struct snd_pcm_substream *substream)
 {
@@ -1202,6 +1242,7 @@ static const struct snd_pcm_ops skl_platform_ops = {
 	.get_time_info =  skl_get_time_info,
 	.mmap = snd_pcm_lib_default_mmap,
 	.page = snd_pcm_sgbuf_ops_page,
+	.ack = skl_platform_ack,
 };
 
 static void skl_pcm_free(struct snd_pcm *pcm)
-- 
2.7.4
