From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 7/7] ASoC: hda: Apply dai params_fixup for DSP
	widgets
Date: Sun, 19 Apr 2015 02:27:33 +0530
Message-ID: <1429390653-8194-8-git-send-email-vinod.koul@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CDE0226530C
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:58 +0200 (CEST)
In-Reply-To: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

DSP widgets configuration needs to be changed based on hw_params or
hw_params_fixup. Add support where dai configuration is store in private
data and apply to widget based on fixup.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/Makefile             |    2 +-
 sound/soc/hda/hda_dsp_controls.c   |  213 +++++++++++++++++++++++++++++++++++-
 sound/soc/hda/hda_dsp_ssp_config.c |   15 ++-
 sound/soc/hda/hda_skl.h            |   75 +++++++++++++
 4 files changed, 298 insertions(+), 7 deletions(-)

diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
index 668c831b196e..c8be01816157 100644
--- a/sound/soc/hda/Makefile
+++ b/sound/soc/hda/Makefile
@@ -1,5 +1,5 @@
 snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o hda_soc_dsp.o \
-hda_dsp_controls.o
+hda_dsp_controls.o hda_dsp_ssp_config.o
 
 obj-$(CONFIG_SND_SOC_HDA_SKL) += snd-soc-hda-skl.o
 
diff --git a/sound/soc/hda/hda_dsp_controls.c b/sound/soc/hda/hda_dsp_controls.c
index ee53227fa751..3c23fdc3e14b 100644
--- a/sound/soc/hda/hda_dsp_controls.c
+++ b/sound/soc/hda/hda_dsp_controls.c
@@ -25,8 +25,27 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-hda-sst-dsp.h>
 #include "hda_dsp_controls.h"
+#include "hda_dsp_ssp_config.h"
 #include "hda_skl.h"
 
+#define CH_FIXUP		(1 << 0)
+#define RATE_FIXUP		(1 << 1)
+#define FMT_FIXUP		(1 << 2)
+
+#define CH_FIXUP_MASK		(1 << 0)
+#define RATE_FIXUP_MASK		(1 << 1)
+#define FMT_FIXUP_MASK		(1 << 2)
+
+#define CH_CONVERTER		(1 << 0)
+#define RATE_CONVERTER		(1 << 1)
+#define FMT_CONVERTER		(1 << 2)
+
+#define CH_CONVERTER_MASK	(1 << 0)
+#define RATE_CONVERTER_MASK	(1 << 1)
+#define FMT_CONVERTER_MASK	(1 << 2)
+
+#define REGS_OFFSET_CPR_BLOB	8
+
 static int is_hda_widget_type(struct snd_soc_dapm_widget *w)
 {
 	return ((w->id == snd_soc_dapm_dai_link) ||
@@ -161,6 +180,117 @@ static bool hda_sst_is_pipe_mcps_available(struct hda_platform_info *pinfo,
 	return true;
 }
 
+static struct snd_soc_dai *hda_find_dai_in(struct list_head *sinks)
+{
+	struct snd_soc_dapm_path *p;
+	struct snd_soc_dai *dai = NULL;
+	list_for_each_entry(p, sinks, list_source) {
+		if (p->connect) {
+			if (p->sink->id == snd_soc_dapm_dai_in ||
+					p->sink->id == snd_soc_dapm_dai_out) {
+				dai = p->sink->priv;
+				return dai;
+			}
+			dai = hda_find_dai_in(&p->sink->sinks);
+			if (dai)
+				return dai;
+		}
+	}
+	return dai;
+}
+
+static struct snd_soc_dai *hda_find_dai_out(struct list_head *sources)
+{
+	struct snd_soc_dapm_path *p;
+	struct snd_soc_dai *dai = NULL;
+	list_for_each_entry(p, sources, list_sink) {
+		if (p->connect) {
+			if (p->source->id == snd_soc_dapm_dai_in ||
+					p->source->id == snd_soc_dapm_dai_out) {
+				dai = p->source->priv;
+				break;
+			}
+			dai = hda_find_dai_out(&p->source->sources);
+			if (dai)
+				return dai;
+		}
+	}
+	return dai;
+}
+
+static struct hda_dai_config *hda_sst_get_dai_config(struct snd_soc_dapm_widget *w,
+		struct ssth_module_config *mconfig, struct ssth_lib *ctx)
+{
+	struct snd_soc_dai *dai = NULL;
+	struct hda_soc_bus *hda = NULL;
+
+	if (mconfig->hw_conn_type == SSTH_CONN_SOURCE) {
+		if (mconfig->pipe->conn_type == SSTH_PIPE_CONN_TYPE_BE)
+			dai = hda_find_dai_in(&w->sinks);
+		else if (mconfig->pipe->conn_type == SSTH_PIPE_CONN_TYPE_FE)
+			dai = hda_find_dai_out(&w->sources);
+	} else if (mconfig->hw_conn_type == SSTH_CONN_SINK) {
+		if (mconfig->pipe->conn_type == SSTH_PIPE_CONN_TYPE_BE)
+			dai = hda_find_dai_out(&w->sources);
+		else if (mconfig->pipe->conn_type == SSTH_PIPE_CONN_TYPE_FE)
+			dai = hda_find_dai_in(&w->sinks);
+	}
+	if (!dai) {
+		dev_dbg(ctx->dev, "Dai not found for widget %s\n", w->name);
+		return NULL;
+	}
+	dev_dbg(ctx->dev, "Dai found %s for widget %s\n",
+			dai->name, w->name);
+	hda = dev_get_drvdata(dai->dev);
+	return &hda->pinfo->dai_config[dai->id - 1];
+
+}
+
+static void hda_dump_mconfig(struct ssth_lib *ctx,
+					struct ssth_module_config *mcfg)
+{
+	dev_dbg(ctx->dev, "Dumping Mconfig\n");
+	dev_dbg(ctx->dev, "Input Format:\n");
+	dev_dbg(ctx->dev, "channels = %d\n", mcfg->in_fmt.channels);
+	dev_dbg(ctx->dev, "sampling_freq = %d\n", mcfg->in_fmt.sampling_freq);
+	dev_dbg(ctx->dev, "channel_config = %d\n", mcfg->in_fmt.channel_config);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->in_fmt.valid_bit_depth);
+	dev_dbg(ctx->dev, "Output Format:\n");
+	dev_dbg(ctx->dev, "channels = %d\n", mcfg->out_fmt.channels);
+	dev_dbg(ctx->dev, "sampling_freq = %d\n", mcfg->out_fmt.sampling_freq);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->out_fmt.valid_bit_depth);
+	dev_dbg(ctx->dev, "channel_config = %d\n", mcfg->out_fmt.channel_config);
+}
+static void hda_dump_dai_config(struct ssth_lib *ctx,
+					struct hda_dai_config *cfg)
+{
+	struct hda_ssp_dai_config *ssp_cfg = &cfg->ssp_dai_config;
+	dev_dbg(ctx->dev, "Dumping DAI config\n");
+	dev_dbg(ctx->dev, "slot_width = %d\n", ssp_cfg->slot_width);
+	dev_dbg(ctx->dev, "Slot = %d\n", ssp_cfg->slots);
+	dev_dbg(ctx->dev, "ssp_mode = %d\n", ssp_cfg->ssp_mode);
+	dev_dbg(ctx->dev, "sampling rate = %d\n", cfg->sampling_rate);
+	dev_dbg(ctx->dev, "s_fmt = %d\n", cfg->s_fmt);
+	dev_dbg(ctx->dev, "bclk_invert = %d\n", ssp_cfg->bclk_invert);
+	dev_dbg(ctx->dev, "fs_invert = %d\n", ssp_cfg->fs_invert);
+	dev_dbg(ctx->dev, "num_channels = %d\n", cfg->num_channels);
+	dev_dbg(ctx->dev, "fs_slave = %d\n", ssp_cfg->fs_slave);
+	dev_dbg(ctx->dev, "bclk_slave = %d\n", ssp_cfg->bclk_slave);
+}
+
+static void hda_update_mconfig(struct ssth_module_format *fmt,
+						struct hda_dai_config *ssp_cfg,
+						int params_fixup)
+{
+	if (params_fixup & RATE_FIXUP_MASK)
+		fmt->sampling_freq = ssp_cfg->sampling_rate;
+	if (params_fixup & CH_FIXUP_MASK)
+		fmt->channels = ssp_cfg->num_channels;
+	if (params_fixup & FMT_FIXUP_MASK)
+		fmt->valid_bit_depth = ssp_cfg->s_fmt;
+
+}
+
 static void hda_update_slot_map(struct ssth_lib *ctx,
 					struct ssth_module_config *m_cfg)
 {
@@ -213,6 +343,87 @@ static void hda_update_ch_config(struct ssth_module_config *m_cfg)
 
 }
 
+static void hda_update_buffer_size(struct ssth_lib *ctx,
+				struct ssth_module_config *mcfg)
+{
+	int multiplier = 1;
+
+	if (mcfg->id.module_id == SSTH_SRCINT_MODULE)
+		multiplier = 5;
+	mcfg->ibs = (mcfg->in_fmt.sampling_freq / 1000) *
+				(mcfg->in_fmt.channels) *
+				(mcfg->in_fmt.bit_depth >> 3) *
+				multiplier;
+
+	mcfg->obs = (mcfg->out_fmt.sampling_freq / 1000) *
+				(mcfg->out_fmt.channels) *
+				(mcfg->out_fmt.bit_depth >> 3) *
+				multiplier;
+}
+
+static void hda_sst_configure_widget(struct snd_soc_dapm_widget *w,
+	struct ssth_lib *ctx, struct hda_platform_info *pinfo)
+{
+	struct ssth_module_config *m_cfg = w->priv;
+	struct hda_dai_config *dai_config;
+	union ssth_ssp_dma_node dma_id;
+	unsigned int *regs = NULL;
+
+	dai_config = hda_sst_get_dai_config(w, m_cfg, ctx);
+	if (!dai_config)
+		return;
+
+	if (m_cfg->id.module_id == SSTH_COPIER_MODULE &&
+		m_cfg->pipe->conn_type == SSTH_PIPE_CONN_TYPE_BE &&
+		dai_config->dai_type == HDA_DAI_TYPE_SSP) {
+		dma_id.val = 0;
+		dma_id.dma_node.i2s_instance =
+				dai_config->ssp_dai_config.i2s_instance;
+		m_cfg->dma_id = dma_id.val;
+		regs = m_cfg->formats_config.caps;
+	}
+	if (!m_cfg->params_fixup)
+		return;
+
+	hda_dump_dai_config(ctx, dai_config);
+	dev_dbg(ctx->dev, "Mconfig for widget  %s BEFORE updation\n", w->name);
+	hda_dump_mconfig(ctx, m_cfg);
+
+	/* Based on whether the widget is in FE pipe or BE PIPE and playback direction
+	 * or capture direction, fixups applied will be changed
+	 */
+	if  ((m_cfg->pipe->conn_type == SSTH_PIPE_CONN_TYPE_FE &&
+		(m_cfg->hw_conn_type  == SSTH_CONN_SINK)) ||
+		(m_cfg->pipe->conn_type == SSTH_PIPE_CONN_TYPE_BE &&
+		m_cfg->hw_conn_type  == SSTH_CONN_SOURCE)) {
+		hda_update_mconfig(&m_cfg->out_fmt, dai_config,
+						m_cfg->params_fixup);
+		hda_update_mconfig(&m_cfg->in_fmt, dai_config,
+				(~m_cfg->converter) & m_cfg->params_fixup);
+	}
+	if  ((m_cfg->pipe->conn_type == SSTH_PIPE_CONN_TYPE_BE &&
+		(m_cfg->hw_conn_type  == SSTH_CONN_SINK)) ||
+		(m_cfg->pipe->conn_type == SSTH_PIPE_CONN_TYPE_FE &&
+		m_cfg->hw_conn_type  == SSTH_CONN_SOURCE)) {
+		hda_update_mconfig(&m_cfg->in_fmt, dai_config,
+						m_cfg->params_fixup);
+		hda_update_mconfig(&m_cfg->out_fmt, dai_config,
+				(~m_cfg->converter) & m_cfg->params_fixup);
+	}
+
+	hda_update_ch_config(m_cfg);
+	hda_update_buffer_size(ctx, m_cfg);
+	if (regs) {
+		/* Slot map only needs to be updated for copier */
+		hda_update_slot_map(ctx, m_cfg);
+		hda_calculate_ssp_regs(ctx, dai_config,
+				&regs[REGS_OFFSET_CPR_BLOB]);
+	}
+
+	dev_dbg(ctx->dev, "Mconfig for widget  %s AFTER updation\n", w->name);
+	hda_dump_mconfig(ctx, m_cfg);
+}
+
 static int hda_sst_get_pipe_widget(struct device *dev,
 	struct snd_soc_dapm_widget *w, struct ssth_pipe *pipe)
 {
@@ -261,6 +472,7 @@ static int hda_init_pipe_modules(struct ssth_lib *ctx,
 		mconfig = w->priv;
 		/*TODO if loadable module, mconfig->is_loadable, load module */
 
+		hda_sst_configure_widget(w, ctx, pinfo);
 		ret = ssth_init_module(ctx, mconfig, NULL);
 		if (ret < 0)
 			return ret;
@@ -619,7 +831,6 @@ void hda_sst_set_copier_dma_id(struct snd_soc_dai *dai, int dma_id, int stream,
 	mconfig = hda_sst_get_module(dai, stream, is_fe, "cpr");
 	if (mconfig != NULL)
 		mconfig->dma_id = dma_id;
-	return;
 }
 
 /*set BE copier I2s,DMIC, SLIMBUS config*/
diff --git a/sound/soc/hda/hda_dsp_ssp_config.c b/sound/soc/hda/hda_dsp_ssp_config.c
index 8b79777fb8be..aa9d5542dc59 100644
--- a/sound/soc/hda/hda_dsp_ssp_config.c
+++ b/sound/soc/hda/hda_dsp_ssp_config.c
@@ -18,9 +18,14 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
+
+#include <sound/pcm_params.h>
+#include <sound/soc-hda-sst-dsp.h>
+#include "hda_dsp_controls.h"
 #include "hda_dsp_ssp_config.h"
 #include "hda_skl.h"
 
+
 #define HDA_SSP_MAX_FREQ_192 19200000
 
 struct hda_ssp_regs {
@@ -128,8 +133,8 @@ static void azx_set_default_ssp_regs_v1(struct hda_ssp_regs *regs)
 
 }
 
-static void azx_print_ssp_regs(struct sst_dsp_ctx *ctx,
-						struct hda_ssp_regs *regs)
+static void azx_print_ssp_regs(struct ssth_lib *ctx,
+				struct hda_ssp_regs *regs)
 {
 	dev_dbg(ctx->dev, "ssc0\t\t %x\n", regs->hda_ssc0);
 	dev_dbg(ctx->dev, "ssc1\t\t %x\n", regs->hda_ssc1);
@@ -143,7 +148,7 @@ static void azx_print_ssp_regs(struct sst_dsp_ctx *ctx,
 	dev_dbg(ctx->dev, "ssioc\t\t %x\n", regs->hda_ssioc);
 }
 
-static int azx_find_ssp_clk_divisor(struct sst_dsp_ctx *ctx, int fs,
+static int azx_find_ssp_clk_divisor(struct ssth_lib *ctx, int fs,
 			int slots, int s_fmt, int *div, int *dummy_bits)
 {
 	int divisor, mod;
@@ -190,7 +195,7 @@ static int azx_find_ssp_clk_divisor(struct sst_dsp_ctx *ctx, int fs,
 
 	return -EINVAL;
 }
-int azx_calculate_ssp_regs(struct sst_dsp_ctx *ctx, struct azx_dai_config *cfg,
+int hda_calculate_ssp_regs(struct ssth_lib *ctx, struct hda_dai_config *cfg,
 						void *ssp_regs)
 {
 	struct hda_ssp_regs regs;
@@ -198,7 +203,7 @@ int azx_calculate_ssp_regs(struct sst_dsp_ctx *ctx, struct azx_dai_config *cfg,
 	int div, dummy;
 	int dss, edss;
 	int edmystop, dmystop;
-	struct azx_ssp_dai_config *ssp_cfg = &cfg->ssp_dai_config;
+	struct hda_ssp_dai_config *ssp_cfg = &cfg->ssp_dai_config;
 
 	azx_set_default_ssp_regs_v1(&regs);
 	dev_dbg(ctx->dev, "Default value of registers set to:\n");
diff --git a/sound/soc/hda/hda_skl.h b/sound/soc/hda/hda_skl.h
index f6d9c629a8e3..fd09bb855af6 100644
--- a/sound/soc/hda/hda_skl.h
+++ b/sound/soc/hda/hda_skl.h
@@ -8,6 +8,12 @@
 
 #define HDA_SKL_SUSPEND_DELAY 2000
 
+#define HDA_SSP_MODE_I2S	0
+#define HDA_SSP_MODE_DSP_A	1
+#define HDA_SSP_MODE_DSP_B	2
+#define HDA_SSP_MAX_SLOTS	8
+#define HDA_DAI_TYPE_SSP	1
+
 struct hda_soc_bus {
 	struct hdac_bus chip;
 	struct device *dev;
@@ -39,6 +45,73 @@ struct hda_platform_info {
 	struct ssth_dsp_resource resource;
 	struct list_head ppl_list;
 	struct list_head ppl_start_list;
+	/* Structure to save dai_configuration, private data  for each DAIs
+	 * Memory will be allcated where platform driver is registered, based
+	 * on number of DAIs getting registered.
+	 */
+	struct hda_dai_config *dai_config;
+};
+
+/***
+ * struct soc_hda_ssp_dai_config - DAI configuration structure. SSP type of DAI
+ * configuration. Configuration specific to SSP DAIs will go here.
+ *
+ * @slot_width : * Number of slots per frame for tdm/pcm mode,
+ *		for I2S mode this is dont care. Currently slot_width
+ *		supported is same as active bits in slots. All dummy
+ *		bits will be programmed after the last slot in TDM mode
+ * @slots : Number of slots per frame for tdm/pcm mode,
+ *		for I2S mode this is dont care. Currently slot_width
+ *		supported is same as active bits in slots. All dummy
+ *		bits will be programmed after the last slot in TDM mode
+ *
+ * @ssp_mode : SP mode like DSP_A, I2S etc
+ * @tx_slot_mask: Indicates which tx slot active
+ * @rx_slot_mask: Indicates which rx slot active
+ * @bclk_invert : Clock invert,
+ *		clock_invert = 1,  data driven on rising edge of clock,
+ *		sample on falling edge of clock.
+ *		clock_invert =  0, data driver on falling edge of clock,
+ *		sample on rising edge of clock.
+ *
+ * @fs_invert : Invert the frame sync,
+ *		fs_invert = 0, frame sync active low
+ *		fs_invert = 1, frame sync active high
+ *
+ * @fs_slave : Frame sync is slave or master 1 = slave, 0 = master
+ * @bclk_slave : BCLK is master of slave 1 = slave, 0 = master
+ * @i2s_instance: It its SSP dai, hardware I2S instance for this DAI
+ */
+struct hda_ssp_dai_config {
+	u8 slot_width;
+	u8 slots;
+	u8 ssp_mode;
+	u8 tx_slot_mask;
+	u8 rx_slot_mask;
+	bool bclk_invert;
+	bool fs_invert;
+	bool fs_slave;
+	bool bclk_slave;
+	u32 i2s_instance;
+};
+
+/***
+ * struct soc_hda_dai_config - DAI configuration structure. DSP widgets and
+ * SSP registers will be configured based on this structure. This
+ * structure will be filled in part based on number of call to DAI methods
+ * like hw_params, set_tdm_slot and set_fmt.
+ * @s_fmt: Sampling format likt 24bit per ch, 16 bits per ch
+ * @num_channels :  number of active channels. This must be 2 for I2S mode
+ * @sampling_rate : Sampling frequency in hertz 48000 for 48K sampling freq
+ * @dai_type : if its a SSP Dai, need to configure somethings extra for SSP dai
+ * @ssp_dai_config: Configuration specific to SSP dai
+ */
+struct hda_dai_config {
+	u8 s_fmt;
+	u8 num_channels;
+	u32 sampling_rate;
+	u32 dai_type;
+	struct hda_ssp_dai_config ssp_dai_config;
 };
 
 int azx_get_delay_from_lpib(struct hdac_bus *chip,
@@ -48,4 +121,6 @@ void  azx_position_check(struct hdac_bus *chip,	struct hdac_stream *azx_dev);
 
 int soc_hda_platform_unregister(struct device *dev);
 int soc_hda_platform_register(struct device *dev);
+int hda_calculate_ssp_regs(struct ssth_lib *ctx,
+				struct hda_dai_config *cfg, void *ssp_regs);
 #endif /* __SOUND_SOC_HDA_SKL_H */
-- 
1.7.9.5
