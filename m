From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 7/8] ALSA: Add comments and descriptions to
	functions
Date: Thu, 13 Sep 2012 18:15:57 -0700
Message-ID: <1347585358-2403-8-git-send-email-ian_minett@creativelabs.com>
References: <1347585358-2403-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347585358-2403-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ef66817..936e161 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -460,8 +460,12 @@ static int chipio_send(struct hda_codec *codec,
 static int chipio_write_address(struct hda_codec *codec,
 				unsigned int chip_addx)
 {
+	struct ca0132_spec *spec = codec->spec;
 	int res;
 
+	if (spec->curr_chip_addx == chip_addx)
+			return 0;
+
 	/* send low 16 bits of the address */
 	res = chipio_send(codec, VENDOR_CHIPIO_ADDRESS_LOW,
 			  chip_addx & 0xffff);
@@ -472,37 +476,14 @@ static int chipio_write_address(struct hda_codec *codec,
 				  chip_addx >> 16);
 	}
 
+	spec->curr_chip_addx = (res < 0) ? ~0UL : chip_addx;
+
 	return res;
 }
 
-static int chipio_write_addx(struct hda_codec *codec, u32 chip_addx)
-{
-	struct ca0132_spec *spec = codec->spec;
-	int status;
-
-	if (spec->curr_chip_addx == chip_addx)
-		return 0;
-
-	/* send low 16 bits of the address */
-	status = chipio_send(codec, VENDOR_CHIPIO_ADDRESS_LOW,
-			  chip_addx & 0xffff);
-
-	if (status < 0)
-		return status;
-
-	/* send high 16 bits of the address */
-	status = chipio_send(codec, VENDOR_CHIPIO_ADDRESS_HIGH,
-			  chip_addx >> 16);
-
-	spec->curr_chip_addx = (status < 0) ? ~0UL : chip_addx;
-
-	return status;
-}
-
 /*
  * Write data through the vendor widget -- NOT protected by the Mutex!
  */
-
 static int chipio_write_data(struct hda_codec *codec, unsigned int data)
 {
 	int res;
@@ -519,6 +500,9 @@ static int chipio_write_data(struct hda_codec *codec, unsigned int data)
 	return res;
 }
 
+/*
+ * Write multiple data through the vendor widget -- NOT protected by the Mutex!
+ */
 static int chipio_write_data_multiple(struct hda_codec *codec,
 				      const u32 *data,
 				      unsigned int count)
@@ -588,6 +572,10 @@ exit:
 	return err;
 }
 
+/*
+ * Write multiple values to the given address through the chip I/O widget.
+ * protected by the Mutex
+ */
 static int chipio_write_multiple(struct hda_codec *codec,
 				 u32 chip_addx,
 				 const u32 *data,
@@ -597,7 +585,7 @@ static int chipio_write_multiple(struct hda_codec *codec,
 	int status;
 
 	mutex_lock(&spec->chipio_mutex);
-	status = chipio_write_addx(codec, chip_addx);
+	status = chipio_write_address(codec, chip_addx);
 	if (status < 0)
 		goto error;
 
@@ -634,6 +622,9 @@ exit:
 	return err;
 }
 
+/*
+ * Set chip control flags through the chip I/O widget.
+ */
 static void chipio_set_control_flag(struct hda_codec *codec,
 				    enum control_flag_id flag_id,
 				    bool flag_state)
@@ -647,6 +638,9 @@ static void chipio_set_control_flag(struct hda_codec *codec,
 			    VENDOR_CHIPIO_FLAG_SET, val);
 }
 
+/*
+ * Set chip parameters through the chip I/O widget.
+ */
 static void chipio_set_control_param(struct hda_codec *codec,
 		enum control_param_id param_id, int param_val)
 {
@@ -671,6 +665,9 @@ static void chipio_set_control_param(struct hda_codec *codec,
 	}
 }
 
+/*
+ * Set sampling rate of the connection point.
+ */
 static void chipio_set_conn_rate(struct hda_codec *codec,
 				int connid, enum ca0132_sample_rate rate)
 {
@@ -679,6 +676,9 @@ static void chipio_set_conn_rate(struct hda_codec *codec,
 				 rate);
 }
 
+/*
+ * Enable clocks.
+ */
 static void chipio_enable_clocks(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -718,22 +718,27 @@ static int dspio_send(struct hda_codec *codec, unsigned int reg,
 	return -EIO;
 }
 
+/*
+ * Wait for DSP to be ready for commands
+ */
 static void dspio_write_wait(struct hda_codec *codec)
 {
-	int cur_val, prv_val;
-	int retry = 50;
+	int status;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
-	cur_val = 0;
 	do {
-		prv_val = cur_val;
-		msleep(20);
-		dspio_send(codec, VENDOR_DSPIO_SCP_POST_COUNT_QUERY, 1);
-		dspio_send(codec, VENDOR_DSPIO_STATUS, 0);
-		cur_val = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
-					   VENDOR_DSPIO_SCP_READ_COUNT, 0);
-	} while (cur_val && (cur_val == prv_val) && --retry);
+		status = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
+						VENDOR_DSPIO_STATUS, 0);
+		if ((status == VENDOR_STATUS_DSPIO_OK) ||
+		    (status == VENDOR_STATUS_DSPIO_SCP_RESPONSE_QUEUE_EMPTY))
+			break;
+		msleep(1);
+	} while (time_before(jiffies, timeout));
 }
 
+/*
+ * Write SCP data to DSP
+ */
 static int dspio_write(struct hda_codec *codec, unsigned int scp_data)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -762,6 +767,9 @@ error:
 			-EIO : 0;
 }
 
+/*
+ * Write multiple SCP data to DSP
+ */
 static int dspio_write_multiple(struct hda_codec *codec,
 				unsigned int *buffer, unsigned int size)
 {
@@ -782,6 +790,9 @@ static int dspio_write_multiple(struct hda_codec *codec,
 	return status;
 }
 
+/*
+ * Construct the SCP header using corresponding fields
+ */
 static inline unsigned int
 make_scp_header(unsigned int target_id, unsigned int source_id,
 		unsigned int get_flag, unsigned int req,
@@ -802,6 +813,9 @@ make_scp_header(unsigned int target_id, unsigned int source_id,
 	return header;
 }
 
+/*
+ * Extract corresponding fields from SCP header
+ */
 static inline void
 extract_scp_header(unsigned int header,
 		   unsigned int *target_id, unsigned int *source_id,
@@ -835,6 +849,9 @@ struct scp_msg {
 	unsigned int data[SCP_MAX_DATA_WORDS];
 };
 
+/*
+ * Send SCP message to DSP
+ */
 static int dspio_send_scp_message(struct hda_codec *codec,
 				  unsigned char *send_buf,
 				  unsigned int send_buf_size,
@@ -912,6 +929,19 @@ static int dspio_send_scp_message(struct hda_codec *codec,
 	return status;
 }
 
+/**
+ * Prepare and send the SCP message to DSP
+ * @codec: the HDA codec
+ * @mod_id: ID of the DSP module to send the command
+ * @req: ID of request to send to the DSP module
+ * @dir: SET or GET
+ * @data: pointer to the data to send with the request, request specific
+ * @len: length of the data, in bytes
+ * @reply: point to the buffer to hold data returned for a reply
+ * @reply_len: length of the reply buffer returned from GET
+ *
+ * Returns zero or a negative error code.
+ */
 static int dspio_scp(struct hda_codec *codec,
 		int mod_id, int req, int dir, void *data, unsigned int len,
 		void *reply, unsigned int *reply_len)
@@ -988,6 +1018,9 @@ static int dspio_scp(struct hda_codec *codec,
 	return status;
 }
 
+/*
+ * Allocate a DSP DMA channel via an SCP message
+ */
 static int dspio_alloc_dma_chan(struct hda_codec *codec, unsigned int *dma_chan)
 {
 	int status = 0;
@@ -1013,6 +1046,9 @@ static int dspio_alloc_dma_chan(struct hda_codec *codec, unsigned int *dma_chan)
 	return status;
 }
 
+/*
+ * Free a DSP DMA via an SCP message
+ */
 static int dspio_free_dma_chan(struct hda_codec *codec, unsigned int dma_chan)
 {
 	int status = 0;
@@ -1035,7 +1071,7 @@ static int dspio_free_dma_chan(struct hda_codec *codec, unsigned int dma_chan)
 }
 
 /*
- * CA0132 DSP access stuffs
+ * (Re)start the DSP
  */
 static int dsp_set_run_state(struct hda_codec *codec)
 {
@@ -1069,6 +1105,9 @@ static int dsp_set_run_state(struct hda_codec *codec)
 	return 0;
 }
 
+/*
+ * Reset the DSP
+ */
 static int dsp_reset(struct hda_codec *codec)
 {
 	unsigned int res;
@@ -1088,6 +1127,9 @@ static int dsp_reset(struct hda_codec *codec)
 	return 0;
 }
 
+/*
+ * Convert chip address to DSP address
+ */
 static unsigned int dsp_chip_to_dsp_addx(unsigned int chip_addx,
 					bool *code, bool *yram)
 {
@@ -1106,6 +1148,9 @@ static unsigned int dsp_chip_to_dsp_addx(unsigned int chip_addx,
 	return (unsigned int)INVALID_CHIP_ADDRESS;
 }
 
+/*
+ * Check if the DSP DMA is active
+ */
 static bool dsp_is_dma_active(struct hda_codec *codec, unsigned int dma_chan)
 {
 	unsigned int dma_chnlstart_reg;
@@ -1226,6 +1271,9 @@ static int dsp_dma_setup_common(struct hda_codec *codec,
 	return 0;
 }
 
+/*
+ * Setup the DSP DMA per-transfer-specific registers
+ */
 static int dsp_dma_setup(struct hda_codec *codec,
 			unsigned int chip_addx,
 			unsigned int count,
@@ -1314,6 +1362,9 @@ static int dsp_dma_setup(struct hda_codec *codec,
 	return 0;
 }
 
+/*
+ * Start the DSP DMA
+ */
 static int dsp_dma_start(struct hda_codec *codec,
 			 unsigned int dma_chan, bool ovly)
 {
@@ -1347,6 +1398,9 @@ static int dsp_dma_start(struct hda_codec *codec,
 	return status;
 }
 
+/*
+ * Stop the DSP DMA
+ */
 static int dsp_dma_stop(struct hda_codec *codec,
 			unsigned int dma_chan, bool ovly)
 {
@@ -1379,6 +1433,17 @@ static int dsp_dma_stop(struct hda_codec *codec,
 	return status;
 }
 
+/**
+ * Allocate router ports
+ *
+ * @codec: the HDA codec
+ * @num_chans: number of channels in the stream
+ * @ports_per_channel: number of ports per channel
+ * @start_device: start device
+ * @port_map: pointer to the port list to hold the allocated ports
+ *
+ * Returns zero or a negative error code.
+ */
 static int dsp_allocate_router_ports(struct hda_codec *codec,
 				     unsigned int num_chans,
 				     unsigned int ports_per_channel,
@@ -1417,6 +1482,9 @@ static int dsp_allocate_router_ports(struct hda_codec *codec,
 	return (res < 0) ? res : 0;
 }
 
+/*
+ * Free router ports
+ */
 static int dsp_free_router_ports(struct hda_codec *codec)
 {
 	int status = 0;
@@ -1434,6 +1502,9 @@ static int dsp_free_router_ports(struct hda_codec *codec)
 	return status;
 }
 
+/*
+ * Allocate DSP ports for the download stream
+ */
 static int dsp_allocate_ports(struct hda_codec *codec,
 			unsigned int num_chans,
 			unsigned int rate_multi, unsigned int *port_map)
@@ -1455,22 +1526,6 @@ static int dsp_allocate_ports(struct hda_codec *codec,
 	return status;
 }
 
-static int dsp_free_ports(struct hda_codec *codec)
-{
-	int status;
-
-	snd_printdd(KERN_INFO "     dsp_free_ports() -- begin");
-
-	status = dsp_free_router_ports(codec);
-	if (status < 0) {
-		snd_printdd(KERN_ERR "free router ports fail");
-		return status;
-	}
-	snd_printdd(KERN_INFO "     dsp_free_ports() -- complete");
-
-	return status;
-}
-
 static int dsp_allocate_ports_format(struct hda_codec *codec,
 			const unsigned short fmt,
 			unsigned int *port_map)
@@ -1495,6 +1550,25 @@ static int dsp_allocate_ports_format(struct hda_codec *codec,
 }
 
 /*
+ * free DSP ports
+ */
+static int dsp_free_ports(struct hda_codec *codec)
+{
+	int status;
+
+	snd_printdd(KERN_INFO "     dsp_free_ports() -- begin");
+
+	status = dsp_free_router_ports(codec);
+	if (status < 0) {
+		snd_printdd(KERN_ERR "free router ports fail");
+		return status;
+	}
+	snd_printdd(KERN_INFO "     dsp_free_ports() -- complete");
+
+	return status;
+}
+
+/*
  *  HDA DMA engine stuffs for DSP code download
  */
 struct dma_engine {
@@ -1528,6 +1602,9 @@ static int dma_convert_to_hda_format(
 	return 0;
 }
 
+/*
+ *  Reset DMA for DSP download
+ */
 static int dma_reset(struct dma_engine *dma)
 {
 	struct hda_codec *codec = dma->codec;
@@ -1642,6 +1719,11 @@ static const struct dsp_image_seg *get_next_seg_ptr(
  */
 #define INVALID_DMA_CHANNEL (~0UL)
 
+/*
+ * Program a list of address/data pairs via the ChipIO widget.
+ * The segment data is in the format of successive pairs of words.
+ * These are repeated as indicated by the segment's cound field.
+ */
 static int dspxfr_hci_write(struct hda_codec *codec,
 			const struct dsp_image_seg *fls)
 {
@@ -1668,6 +1750,21 @@ static int dspxfr_hci_write(struct hda_codec *codec,
 	return 0;
 }
 
+/**
+ * Write a block of data into DSP code or data RAM using pre-allocated
+ * DMA engine.
+ *
+ * @codec: the HDA codec
+ * @fls: pointer to a fast load image
+ * @reloc: Relocation address for loading single-segment overlays, or 0 for
+ *	   no relocation
+ * @dma_engine: pointer to DMA engine to be used for DSP download
+ * @dma_chan: The number of DMA channels used for DSP download
+ * @port_map_mask: port mapping
+ * @ovly: TRUE if overlay format is required
+ *
+ * Returns zero or a negative error code.
+ */
 static int dspxfr_one_seg(struct hda_codec *codec,
 			const struct dsp_image_seg *fls,
 			unsigned int reloc,
@@ -1836,6 +1933,18 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 	return status;
 }
 
+/**
+ * Write the entire DSP image of a DSP code/data overlay to DSP memories
+ *
+ * @codec: the HDA codec
+ * @fls_data: pointer to a fast load image
+ * @reloc: Relocation address for loading single-segment overlays, or 0 for
+ *	   no relocation
+ * @format: format of the stream used for DSP download
+ * @ovly: TRUE if overlay format is required
+ *
+ * Returns zero or a negative error code.
+ */
 static int dspxfr_image(struct hda_codec *codec,
 			const struct dsp_image_seg *fls_data,
 			unsigned int reloc, struct hda_stream_format *format,
@@ -1970,6 +2079,23 @@ static void dspload_post_setup(struct hda_codec *codec)
 	chipio_write(codec, XRAM_XRAM_INST_OFFSET(0x29), 0x00000002);
 }
 
+/**
+ * Download DSP from a DSP Image Fast Load structure. This structure is a
+ * linear, non-constant sized element array of structures, each of which
+ * contain the count of the data to be loaded, the data itself, and the
+ * corresponding starting chip address of the starting data location.
+ *
+ * @codec: the HDA codec
+ * @fls: pointer to a fast load image
+ * @ovly: TRUE if overlay format is required
+ * @reloc: Relocation address for loading single-segment overlays, or 0 for
+ *	   no relocation
+ * @autostart: TRUE if DSP starts after loading; ignored if ovly is TRUE
+ * @router_chans: number of audio router channels to be allocated (0 means use
+ *		  internal defaults; max is 32)
+ *
+ * Returns zero or a negative error code.
+ */
 static int dspload_image(struct hda_codec *codec,
 			const struct dsp_image_seg *fls,
 			bool ovly,
-- 
1.7.4.1
