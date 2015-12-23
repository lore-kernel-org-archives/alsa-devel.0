From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add code to locate and
	initialise compressed buffer" to the asoc tree
Date: Wed, 23 Dec 2015 00:23:20 +0000
Message-ID: <E1aBXD6-0000WL-0s@debutante>
References: <1450115609-14094-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A191926609E
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:23:27 +0100 (CET)
In-Reply-To: <1450115609-14094-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add code to locate and initialise compressed buffer

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

>From 2cd19bdbf83c4c70b2ee36d022c5ded2738d2e19 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 15 Dec 2015 11:29:46 +0000
Subject: [PATCH] ASoC: wm_adsp: Add code to locate and initialise compressed
 buffer

Add code that locates and initialises the buffer of compressed data on
the DSP if the firmware supported compressed data capture. The buffer
struct (wm_adsp_compr_buf) is kept separate from the stream struct
(wm_adsp_compr) this will allow much easier support of multiple
streams of data from the one DSP in the future, although support for
this will not be added in this patch chain.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 291 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |   2 +
 2 files changed, 293 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d81ed218918e..90994a5528a4 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -229,6 +229,58 @@ static const char *wm_adsp_fw_text[WM_ADSP_NUM_FW] = {
 	[WM_ADSP_FW_MISC] =     "Misc",
 };
 
+struct wm_adsp_system_config_xm_hdr {
+	__be32 sys_enable;
+	__be32 fw_id;
+	__be32 fw_rev;
+	__be32 boot_status;
+	__be32 watchdog;
+	__be32 dma_buffer_size;
+	__be32 rdma[6];
+	__be32 wdma[8];
+	__be32 build_job_name[3];
+	__be32 build_job_number;
+};
+
+struct wm_adsp_alg_xm_struct {
+	__be32 magic;
+	__be32 smoothing;
+	__be32 threshold;
+	__be32 host_buf_ptr;
+	__be32 start_seq;
+	__be32 high_water_mark;
+	__be32 low_water_mark;
+	__be64 smoothed_power;
+};
+
+struct wm_adsp_buffer {
+	__be32 X_buf_base;		/* XM base addr of first X area */
+	__be32 X_buf_size;		/* Size of 1st X area in words */
+	__be32 X_buf_base2;		/* XM base addr of 2nd X area */
+	__be32 X_buf_brk;		/* Total X size in words */
+	__be32 Y_buf_base;		/* YM base addr of Y area */
+	__be32 wrap;			/* Total size X and Y in words */
+	__be32 high_water_mark;		/* Point at which IRQ is asserted */
+	__be32 irq_count;		/* bits 1-31 count IRQ assertions */
+	__be32 irq_ack;			/* acked IRQ count, bit 0 enables IRQ */
+	__be32 next_write_index;	/* word index of next write */
+	__be32 next_read_index;		/* word index of next read */
+	__be32 error;			/* error if any */
+	__be32 oldest_block_index;	/* word index of oldest surviving */
+	__be32 requested_rewind;	/* how many blocks rewind was done */
+	__be32 reserved_space;		/* internal */
+	__be32 min_free;		/* min free space since stream start */
+	__be32 blocks_written[2];	/* total blocks written (64 bit) */
+	__be32 words_written[2];	/* total words written (64 bit) */
+};
+
+struct wm_adsp_compr_buf {
+	struct wm_adsp *dsp;
+
+	struct wm_adsp_buffer_region *regions;
+	u32 host_buf_ptr;
+};
+
 struct wm_adsp_compr {
 	struct wm_adsp *dsp;
 
@@ -243,9 +295,53 @@ struct wm_adsp_compr {
 #define WM_ADSP_MIN_FRAGMENT_SIZE      (64 * WM_ADSP_DATA_WORD_SIZE)
 #define WM_ADSP_MAX_FRAGMENT_SIZE      (4096 * WM_ADSP_DATA_WORD_SIZE)
 
+#define WM_ADSP_ALG_XM_STRUCT_MAGIC    0x49aec7
+
+#define HOST_BUFFER_FIELD(field) \
+	(offsetof(struct wm_adsp_buffer, field) / sizeof(__be32))
+
+#define ALG_XM_FIELD(field) \
+	(offsetof(struct wm_adsp_alg_xm_struct, field) / sizeof(__be32))
+
+static int wm_adsp_buffer_init(struct wm_adsp *dsp);
+static int wm_adsp_buffer_free(struct wm_adsp *dsp);
+
+struct wm_adsp_buffer_region {
+	unsigned int offset;
+	unsigned int cumulative_size;
+	unsigned int mem_type;
+	unsigned int base_addr;
+};
+
+struct wm_adsp_buffer_region_def {
+	unsigned int mem_type;
+	unsigned int base_offset;
+	unsigned int size_offset;
+};
+
+static struct wm_adsp_buffer_region_def ez2control_regions[] = {
+	{
+		.mem_type = WMFW_ADSP2_XM,
+		.base_offset = HOST_BUFFER_FIELD(X_buf_base),
+		.size_offset = HOST_BUFFER_FIELD(X_buf_size),
+	},
+	{
+		.mem_type = WMFW_ADSP2_XM,
+		.base_offset = HOST_BUFFER_FIELD(X_buf_base2),
+		.size_offset = HOST_BUFFER_FIELD(X_buf_brk),
+	},
+	{
+		.mem_type = WMFW_ADSP2_YM,
+		.base_offset = HOST_BUFFER_FIELD(Y_buf_base),
+		.size_offset = HOST_BUFFER_FIELD(wrap),
+	},
+};
+
 struct wm_adsp_fw_caps {
 	u32 id;
 	struct snd_codec_desc desc;
+	int num_regions;
+	struct wm_adsp_buffer_region_def *region_defs;
 };
 
 static const struct wm_adsp_fw_caps ez2control_caps[] = {
@@ -257,6 +353,8 @@ static const struct wm_adsp_fw_caps ez2control_caps[] = {
 			.num_sample_rates = 1,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
+		.num_regions = ARRAY_SIZE(ez2control_regions),
+		.region_defs = ez2control_regions,
 	},
 };
 
@@ -2123,6 +2221,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 					 ADSP2_CORE_ENA | ADSP2_START);
 		if (ret != 0)
 			goto err;
+
+		if (wm_adsp_fw[dsp->fw].num_caps != 0)
+			ret = wm_adsp_buffer_init(dsp);
+
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
@@ -2157,6 +2259,9 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 			kfree(alg_region);
 		}
 
+		if (wm_adsp_fw[dsp->fw].num_caps != 0)
+			wm_adsp_buffer_free(dsp);
+
 		mutex_unlock(&dsp->pwr_lock);
 
 		adsp_dbg(dsp, "Shutdown complete\n");
@@ -2366,4 +2471,190 @@ int wm_adsp_compr_get_caps(struct snd_compr_stream *stream,
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_get_caps);
 
+static int wm_adsp_read_data_block(struct wm_adsp *dsp, int mem_type,
+				   unsigned int mem_addr,
+				   unsigned int num_words, u32 *data)
+{
+	struct wm_adsp_region const *mem = wm_adsp_find_region(dsp, mem_type);
+	unsigned int i, reg;
+	int ret;
+
+	if (!mem)
+		return -EINVAL;
+
+	reg = wm_adsp_region_to_reg(mem, mem_addr);
+
+	ret = regmap_raw_read(dsp->regmap, reg, data,
+			      sizeof(*data) * num_words);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < num_words; ++i)
+		data[i] = be32_to_cpu(data[i]) & 0x00ffffffu;
+
+	return 0;
+}
+
+static inline int wm_adsp_read_data_word(struct wm_adsp *dsp, int mem_type,
+					 unsigned int mem_addr, u32 *data)
+{
+	return wm_adsp_read_data_block(dsp, mem_type, mem_addr, 1, data);
+}
+
+static int wm_adsp_write_data_word(struct wm_adsp *dsp, int mem_type,
+				   unsigned int mem_addr, u32 data)
+{
+	struct wm_adsp_region const *mem = wm_adsp_find_region(dsp, mem_type);
+	unsigned int reg;
+
+	if (!mem)
+		return -EINVAL;
+
+	reg = wm_adsp_region_to_reg(mem, mem_addr);
+
+	data = cpu_to_be32(data & 0x00ffffffu);
+
+	return regmap_raw_write(dsp->regmap, reg, &data, sizeof(data));
+}
+
+static inline int wm_adsp_buffer_read(struct wm_adsp_compr_buf *buf,
+				      unsigned int field_offset, u32 *data)
+{
+	return wm_adsp_read_data_word(buf->dsp, WMFW_ADSP2_XM,
+				      buf->host_buf_ptr + field_offset, data);
+}
+
+static inline int wm_adsp_buffer_write(struct wm_adsp_compr_buf *buf,
+				       unsigned int field_offset, u32 data)
+{
+	return wm_adsp_write_data_word(buf->dsp, WMFW_ADSP2_XM,
+				       buf->host_buf_ptr + field_offset, data);
+}
+
+static int wm_adsp_buffer_locate(struct wm_adsp_compr_buf *buf)
+{
+	struct wm_adsp_alg_region *alg_region;
+	struct wm_adsp *dsp = buf->dsp;
+	u32 xmalg, addr, magic;
+	int i, ret;
+
+	alg_region = wm_adsp_find_alg_region(dsp, WMFW_ADSP2_XM, dsp->fw_id);
+	xmalg = sizeof(struct wm_adsp_system_config_xm_hdr) / sizeof(__be32);
+
+	addr = alg_region->base + xmalg + ALG_XM_FIELD(magic);
+	ret = wm_adsp_read_data_word(dsp, WMFW_ADSP2_XM, addr, &magic);
+	if (ret < 0)
+		return ret;
+
+	if (magic != WM_ADSP_ALG_XM_STRUCT_MAGIC)
+		return -EINVAL;
+
+	addr = alg_region->base + xmalg + ALG_XM_FIELD(host_buf_ptr);
+	for (i = 0; i < 5; ++i) {
+		ret = wm_adsp_read_data_word(dsp, WMFW_ADSP2_XM, addr,
+					     &buf->host_buf_ptr);
+		if (ret < 0)
+			return ret;
+
+		if (buf->host_buf_ptr)
+			break;
+
+		usleep_range(1000, 2000);
+	}
+
+	if (!buf->host_buf_ptr)
+		return -EIO;
+
+	adsp_dbg(dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
+
+	return 0;
+}
+
+static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
+{
+	const struct wm_adsp_fw_caps *caps = wm_adsp_fw[buf->dsp->fw].caps;
+	struct wm_adsp_buffer_region *region;
+	u32 offset = 0;
+	int i, ret;
+
+	for (i = 0; i < caps->num_regions; ++i) {
+		region = &buf->regions[i];
+
+		region->offset = offset;
+		region->mem_type = caps->region_defs[i].mem_type;
+
+		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
+					  &region->base_addr);
+		if (ret < 0)
+			return ret;
+
+		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
+					  &offset);
+		if (ret < 0)
+			return ret;
+
+		region->cumulative_size = offset;
+
+		adsp_dbg(buf->dsp,
+			 "region=%d type=%d base=%04x off=%04x size=%04x\n",
+			 i, region->mem_type, region->base_addr,
+			 region->offset, region->cumulative_size);
+	}
+
+	return 0;
+}
+
+static int wm_adsp_buffer_init(struct wm_adsp *dsp)
+{
+	struct wm_adsp_compr_buf *buf;
+	int ret;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->dsp = dsp;
+
+	ret = wm_adsp_buffer_locate(buf);
+	if (ret < 0) {
+		adsp_err(dsp, "Failed to acquire host buffer: %d\n", ret);
+		goto err_buffer;
+	}
+
+	buf->regions = kcalloc(wm_adsp_fw[dsp->fw].caps->num_regions,
+			       sizeof(*buf->regions), GFP_KERNEL);
+	if (!buf->regions) {
+		ret = -ENOMEM;
+		goto err_buffer;
+	}
+
+	ret = wm_adsp_buffer_populate(buf);
+	if (ret < 0) {
+		adsp_err(dsp, "Failed to populate host buffer: %d\n", ret);
+		goto err_regions;
+	}
+
+	dsp->buffer = buf;
+
+	return 0;
+
+err_regions:
+	kfree(buf->regions);
+err_buffer:
+	kfree(buf);
+	return ret;
+}
+
+static int wm_adsp_buffer_free(struct wm_adsp *dsp)
+{
+	if (dsp->buffer) {
+		kfree(dsp->buffer->regions);
+		kfree(dsp->buffer);
+
+		dsp->buffer = NULL;
+	}
+
+	return 0;
+}
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 33c9b5283d26..0b2205a5c42f 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -32,6 +32,7 @@ struct wm_adsp_alg_region {
 };
 
 struct wm_adsp_compr;
+struct wm_adsp_compr_buf;
 
 struct wm_adsp {
 	const char *part;
@@ -63,6 +64,7 @@ struct wm_adsp {
 	struct work_struct boot_work;
 
 	struct wm_adsp_compr *compr;
+	struct wm_adsp_compr_buf *buffer;
 
 	struct mutex pwr_lock;
 
-- 
2.6.2
