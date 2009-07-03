From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 4/13] Intel SST driver common private
	headers
Date: Fri,  3 Jul 2009 12:33:32 +0530
Message-ID: <1246604612-12875-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E6F592476D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:54:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds header files private to the SST
driver and contains the common structures like driver context,
DSP register definitions, and inline utility
functions used by the SST driver and function prototypes of
common functions that are implemented in SST driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	new file:   sound/pci/sst/intel_sst_common.h
	new file:   sound/pci/sst/intel_sst_pvt.h
---
 sound/pci/sst/intel_sst_common.h |  292 +++++++++++++++++++++++++++++
 sound/pci/sst/intel_sst_pvt.h    |  378 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 670 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intel_sst_common.h
 create mode 100644 sound/pci/sst/intel_sst_pvt.h

diff --git a/sound/pci/sst/intel_sst_common.h b/sound/pci/sst/intel_sst_common.h
new file mode 100644
index 0000000..e039489
--- /dev/null
+++ b/sound/pci/sst/intel_sst_common.h
@@ -0,0 +1,292 @@
+#ifndef __INTEL_SST_COMMON_H__
+#define __INTEL_SST_COMMON_H__
+/*
+ *  intel_sst_common.h - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-09 	Intel Corporation
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *  		Harsha Priya <priya.harsha@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  Common private declarations for SST
+ */
+#include <linux/time.h>
+
+/*#define SND_LOOP_TEST*/
+
+#define SST_DRIVER_VERSION "0.04.002"
+#define SST_VERSION_NUM 0x0402
+
+/*
+driver names
+*/
+#define SST_DRV_NAME "intel_sst_driver"
+#define SST_FW_STD_FILENAME "fw_sst.bin"
+
+
+/*
+PMIC and SST hardware states
+*/
+enum sst_pmic_states {
+	PMIC_SND_UN_INIT = 0,
+	PMIC_SND_INIT_DONE,
+};
+
+enum sst_states {
+	SST_FW_LOADED = 1,
+	SST_FW_RUNNING,
+	SST_UN_INIT,
+	SST_ERROR,
+};
+
+#define MAX_ACTIVE_STREAM	3
+#define MAX_ENC_STREAM		1
+#define MAX_AM_HANDLES		1
+#define ALLOC_TIMEOUT 		5000
+/*
+SST numbers
+*/
+#define SST_BLOCK_TIMEOUT	5000
+
+#define INTEL_SST_MAJOR 	255
+#define BLOCK_UNINIT		-1
+
+/*SST register map*/
+#define SST_CSR 		0x00
+#define SST_PISR		0x08
+#define SST_PIMR		0x10
+#define SST_ISRX		0x18
+#define SST_IMRX		0x28
+#define SST_IPCX		0x38 /*IPC IA-SST*/
+#define SST_IPCD		0x40 /*IPC SST-IA*/
+#define SST_SHIM_SIZE		0X44
+
+#define FW_SIGNATURE_SIZE	4
+
+/*
+stream states
+*/
+enum sst_stream_states {
+	STREAM_UN_INIT	= 0,	/*Freed/Not used stream*/
+	STREAM_RUNNING	= 1,	/*Running*/
+	STREAM_PAUSED	= 2,	/*Paused stream*/
+	STREAM_INIT_WT	= 4,	/*stream is init and waiting for FW*/
+	STREAM_INIT	= 5,	/*stream init, waiting for data*/
+};
+
+
+enum sst_ram_type{
+	SST_IRAM 	= 1,
+	SST_DRAM 	= 2,
+};
+/*
+SST shim registers to structure mapping
+*/
+union config_status_reg {
+	struct {
+		u32 rsvd0:1;
+		u32 sst_reset:1;
+		u32 hw_rsvd:3;
+		u32 sst_clk:2;
+		u32 bypass:3;
+		u32 run_stall:1;
+		u32 rsvd:21;
+	} part;
+	u32 full;
+};
+
+union interrupt_reg {
+	struct {
+		u32 done_interrupt:1;
+		u32 busy_interrupt:1;
+		u32 rsvd:30;
+	} part;
+	u32 full;
+};
+
+union sst_pisr_reg {
+	struct {
+		u32 pssp0:1;
+		u32 pssp1:1;
+		u32 rsvd0:3;
+		u32 dmac:1;
+		u32 rsvd1:26;
+	} part;
+	u32 full;
+};
+
+union sst_pimr_reg {
+	struct {
+		u32 ssp0:1;
+		u32 ssp1:1;
+		u32 rsvd0:3;
+		u32 dmac:1;
+		u32 rsvd1:10;
+		u32 ssp0_sc:1;
+		u32 ssp1_sc:1;
+		u32 rsvd2:3;
+		u32 dmac_sc:1;
+		u32 rsvd3:10;
+	} part;
+	u32 full;
+};
+
+
+struct sst_stream_bufs {
+	struct list_head 	node;
+	u32 			size;
+	const char 		*addr;
+	u32 			data_copied;
+	bool			in_use;
+	u32			offset;
+};
+
+struct snd_sst_user_cap_list {
+	unsigned int iov_index; /*index of iov*/
+	unsigned long iov_offset; /*offset in iov*/
+	unsigned long offset; /*offset in kmem*/
+	unsigned long size; /*size copied*/
+	struct list_head node;
+};
+/*
+This structure is used to block a user/fw data call to another
+fw/user call
+*/
+struct sst_block {
+	bool 	condition; /*condition for blocking check*/
+	int	ret_code; /*ret code when block is released*/
+	void 	*data; /*data to be appsed for block if any*/
+	bool	on;
+};
+
+enum snd_sst_buf_type {
+	SST_BUF_USER_STATIC = 1,
+	SST_BUF_USER_DYNAMIC,
+	SST_BUF_MMAP_STATIC,
+	SST_BUF_MMAP_DYNAMIC,
+};
+/*
+structure that holds the stream information
+*/
+struct stream_info {
+	unsigned int 		status;
+	unsigned int		prev;
+	unsigned int		codec;
+	unsigned int		sst_id;
+	unsigned int		ops;
+	struct list_head	bufs;
+	struct mutex		lock; /*mutex*/
+	void 			*get_parameters;
+	bool			mmapped;
+	unsigned int		sg_index; /* current buf Index */
+	unsigned char 		 *cur_ptr; /* Current static bufs */
+	struct snd_sst_buf_entry *buf_entry;
+	struct sst_block	data_blk; /*stream ops block*/
+	struct sst_block	ctrl_blk; /*stream control cmd block*/
+	enum snd_sst_buf_type   buf_type;
+	void 			*pcm_substream;
+	void (*period_elapsed) (void *pcm_substream);
+};
+
+
+
+/*
+this structure is used for blocking the user's alloc calls to
+fw's response to alloc calls
+*/
+struct stream_alloc_block {
+	int 			sst_id; /*session id of blocked stream*/
+	struct sst_block 	ops_block; /*ops block struture*/
+};
+
+#define SST_FW_SIGN "$SST"
+#define SST_FW_LIB_SIGN "$LIB"
+
+/*FW file headers*/
+struct fw_header {
+	unsigned char signature[FW_SIGNATURE_SIZE]; /*FW signature*/
+	u32 file_size; /*size of fw minus this header*/
+	u32 modules; /* # of modules*/
+	u32 file_format; /*version of header format*/
+	u32 reserved[4];
+};
+
+struct fw_module_header {
+	unsigned char signature[FW_SIGNATURE_SIZE]; /*module signature*/
+	u32 mod_size; /*size of module*/
+	u32 blocks; /*# of blocks*/
+	u32 type; /*codec type, pp lib*/
+	u32 entry_point;
+};
+
+struct dma_block_info {
+	enum sst_ram_type 	type;	/*IRAM/DRAM*/
+	u32 		  	size;	/*Bytes*/
+	u32 		  	ram_offset; /*Offset in I/DRAM*/
+	u32 		  	rsvd;	/*Reserved field*/
+};
+
+struct ioctl_pvt_data {
+	int			str_id;
+	int			pvt_id;
+};
+
+struct sst_ipc_msg_wq {
+	union ipc_header	header;
+	char mailbox[SST_MAILBOX_SIZE];
+	struct work_struct	wq;
+};
+#define SST_MMAP_PAGES	(640*1024 / PAGE_SIZE)
+#define SST_MMAP_STEP	(40*1024 / PAGE_SIZE)
+
+/*driver ops*/
+struct intel_sst_drv{
+	bool 			pmic_state;
+	int  			pmic_vendor;
+	int  			sst_state;
+	void __iomem 		*shim;
+	void __iomem 		*mailbox;
+	void __iomem		*iram;
+	void __iomem		*dram;
+	unsigned int	 	shim_phy_add;
+	struct list_head 	ipc_dispatch_list;
+	struct work_struct	ipc_post_msg_wq;
+	struct sst_ipc_msg_wq 	ipc_process_msg;
+	struct sst_ipc_msg_wq 	ipc_process_reply;
+	struct sst_ipc_msg_wq 	ipc_post_msg;
+	wait_queue_head_t 	wait_queue;
+
+	struct stream_info	streams[MAX_NUM_STREAMS];
+	struct stream_alloc_block alloc_block[MAX_ACTIVE_STREAM];
+
+	struct mutex 		list_lock;	/*mutex for IPC list locking*/
+	struct snd_pmic_ops	scard_ops;
+	struct pci_dev 		*pci;
+	int 			active_streams[MAX_NUM_STREAMS];
+	struct sst_block	block_status;
+
+	void			*mmap_mem;
+	unsigned int		mmap_len;
+	unsigned int unique_id;
+	unsigned int		stream_cnt;
+	unsigned int		active_cnt;
+	unsigned int		am_cnt;
+};
+
+extern struct intel_sst_drv *sst_ops;
+#endif /*__INTEL_SST_COMMON_H */
diff --git a/sound/pci/sst/intel_sst_pvt.h b/sound/pci/sst/intel_sst_pvt.h
new file mode 100644
index 0000000..a1e786e
--- /dev/null
+++ b/sound/pci/sst/intel_sst_pvt.h
@@ -0,0 +1,378 @@
+#ifndef __INTEL_SST_PVT_H__
+#define __INTEL_SST_PVT_H__
+/*
+ *  intel_sst_pvt.h - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-09 	Intel Corporation
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *  		Harsha Priya <priya.harsha@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file defines all pvt functions
+ */
+int sst_alloc_stream(char *params, int stream_ops, int codec, int session_id);
+int sst_alloc_stream_response(unsigned int str_id,
+				struct snd_sst_str_type *type);
+int sst_pause_stream(int id);
+int sst_resume_stream(int id);
+int sst_drop_stream(int id);
+int sst_free_stream(int id);
+int sst_play_frame(int streamID);
+int sst_capture_frame(int streamID);
+int sst_set_stream_param(int streamID, struct snd_sst_params *str_param);
+int sst_route_control(int streamID);
+int sst_target_device_select(struct snd_sst_target_device *target_device);
+int sst_set_pmic_config(int streamID, struct snd_sst_pmic_config *pc);
+
+void sst_post_message(struct work_struct *work);
+void sst_process_message(struct work_struct *work);
+void sst_process_reply(struct work_struct *work);
+void sst_send_loop_test(int x);
+
+int intel_sst_ioctl(struct inode *i_node, struct file *file_ptr,
+			unsigned int cmd, unsigned long arg);
+int intel_sst_open(struct inode *i_node, struct file *file_ptr);
+int intel_sst_release(struct inode *i_node, struct file *file_ptr);
+int intel_sst_read(struct file *file_ptr, char __user *buf,
+			size_t count, loff_t *ppos);
+int intel_sst_write(struct file *file_ptr, const char __user *buf,
+			size_t count, loff_t *ppos);
+int intel_sst_mmap(struct file *fp, struct vm_area_struct *vma);
+ssize_t intel_sst_aio_write(struct kiocb *kiocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t  offset);
+ssize_t intel_sst_aio_read(struct kiocb *kiocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t offset);
+
+int sst_ospm_send_event(int event);
+void sst_load_fw(const struct firmware *fw, void *context);
+int sst_load_library(struct snd_sst_lib_download *lib, u8 ops, u32 pvt_id);
+
+static inline int sst_scu_ipc_write(u32 addr, u32 value)
+{
+#ifndef CONFIG_SST_IPC_NOT_INCLUDED
+	int retval = 0, retry = 3;
+	struct ipc_reg_data ipc_reg = {0};
+
+	ipc_reg.address = addr;
+	ipc_reg.data = value;
+	ipc_reg.ioc = 1;
+
+	while (retry) {
+		retval = mrst_ipc_write32(&ipc_reg);
+		if (retval == 0)
+			break;
+		retry--;
+		/*error*/
+		sst_err("IPC write failed %x\n", retval);
+	}
+	return retval;
+#else
+	return 0;
+#endif
+}
+static inline void sst_fill_header(union ipc_header *header,
+				int msg, int large, int strID)
+{
+	header->part.msg_id = msg;
+	header->part.str_id = strID;
+	header->part.large = large;
+	header->part.done = 0;
+	header->part.busy = 1;
+	header->part.data = 0;
+}
+
+static inline int sst_get_stream_id(struct intel_sst_drv *sst_ops, int pvt_id)
+{
+	int i;
+
+	for (i = 1; i < MAX_NUM_STREAMS; i++) {
+		if (pvt_id == sst_ops->streams[i].sst_id)
+			return i;
+	}
+	return -EINVAL;
+}
+
+static inline unsigned int sst_assign_pvt_id(struct intel_sst_drv *sst_ops)
+{
+	sst_ops->unique_id++;
+	if (sst_ops->unique_id >= MAX_NUM_STREAMS)
+		sst_ops->unique_id = 1;
+	return sst_ops->unique_id;
+}
+
+static inline int sst_get_block_stream(struct intel_sst_drv *sst_ops)
+{
+	int i;
+
+	for (i = 0; i < MAX_ACTIVE_STREAM; i++) {
+		if (BLOCK_UNINIT == sst_ops->alloc_block[i].sst_id) {
+			sst_ops->alloc_block[i].ops_block.condition = false;
+			sst_ops->alloc_block[i].ops_block.ret_code = 0;
+			sst_ops->alloc_block[i].sst_id = 0;
+			break;
+		}
+	}
+	if (MAX_ACTIVE_STREAM == i) {
+		sst_err("max alloc_stream reached \n");
+		i = -EBUSY; /*active stream limit reached*/
+	}
+	return i;
+}
+
+
+
+static inline void sst_print_hex(unsigned char *buf, unsigned int size)
+{
+	unsigned int i;
+
+	for (i = 0; i < size; i++) {
+		sst_dbg("%02x ", buf[i]);
+		if ((i != 0) && ((i % 8) == 0))
+			sst_dbg("\n");
+	}
+}
+
+static inline void sst_init_stream(struct stream_info *stream,
+		int codec, int sst_id, int ops)
+{
+	stream->status = STREAM_INIT;
+	stream->prev = STREAM_UN_INIT;
+	stream->codec = codec;
+	stream->sst_id = sst_id;
+	stream->ops = ops;
+	stream->data_blk.on = false;
+	stream->data_blk.condition = false;
+	stream->data_blk.ret_code = 0;
+	stream->data_blk.data = NULL;
+	stream->ctrl_blk.on = false;
+	stream->ctrl_blk.condition = false;
+	stream->ctrl_blk.ret_code = 0;
+	stream->ctrl_blk.data = NULL;
+	stream->mmapped = false;
+}
+
+static inline void sst_clean_stream(struct stream_info *stream)
+{
+	struct sst_stream_bufs *bufs = NULL, *_bufs = NULL;
+	stream->status = STREAM_UN_INIT;
+	stream->prev = STREAM_UN_INIT;
+	list_for_each_entry_safe(bufs, _bufs, &stream->bufs, node) {
+		list_del(&bufs->node);
+		kfree(bufs);
+	}
+}
+
+static inline int sst_wait_interruptible(struct intel_sst_drv *sst_ops,
+				struct sst_block *block)
+{
+	int retval = 0;
+
+	if (!wait_event_interruptible(sst_ops->wait_queue, block->condition)) {
+		/*event wake*/
+		if (0 != block->ret_code) {
+			sst_err("stream failed %d\n", block->ret_code);
+			retval = -EBUSY;
+		} else {
+			sst_dbg("event up\n");
+			retval = 0;
+		}
+	} else {
+		sst_err("signal interrupted\n");
+		retval = -EINTR;
+	}
+	return retval;
+
+}
+
+static inline int sst_wait_interruptible_timeout(struct intel_sst_drv *sst_ops,
+				struct sst_block *block, int timeout)
+{
+	int retval = 0;
+
+	sst_dbg("waiting....\n");
+	if (wait_event_interruptible_timeout(sst_ops->wait_queue,
+						block->condition,
+						msecs_to_jiffies(timeout))) {
+		/*event wake*/
+		sst_dbg("Event wake ...\n");
+		if (0 != block->ret_code)
+			sst_err("stream failed %d\n", block->ret_code);
+		else
+			sst_dbg("event up\n");
+		retval = block->ret_code;
+	} else {
+		sst_err("timeout occured...\n");
+		retval = -EBUSY;
+	}
+	return retval;
+
+}
+
+static inline int sst_wait_timeout(struct intel_sst_drv *sst_ops,
+		struct stream_alloc_block *block)
+{
+	int retval = 0;
+
+	/*NOTE:
+	Observed that FW processes the alloc msg and replies even
+	before the alloc thread has finished execution*/
+	sst_dbg("waiting for %x, condition %x \n", block->sst_id,
+			block->ops_block.condition);
+	if (wait_event_interruptible_timeout(sst_ops->wait_queue,
+				block->ops_block.condition,
+				msecs_to_jiffies(SST_BLOCK_TIMEOUT))) {
+		/*event wake*/
+		sst_dbg("Event wake ... %x \n", block->ops_block.condition);
+		/*check return*/
+		if (0 > block->ops_block.ret_code)
+			sst_err("blk failed %d\n", block->ops_block.ret_code);
+		else
+			sst_dbg("blk ret: %d\n", block->ops_block.ret_code);
+		retval = block->ops_block.ret_code;
+	} else {
+		sst_err("Wait timed-out %x\n", block->ops_block.condition);
+		retval = -EBUSY;
+	}
+	return retval;
+
+}
+
+
+static inline int sst_create_large_msg(struct ipc_post **arg)
+{
+	struct ipc_post *msg;
+
+	msg = kzalloc(sizeof(struct ipc_post), GFP_ATOMIC);
+	if (NULL == msg) {
+		sst_err("kzalloc msg failed \n");
+		return -ENOMEM;
+	}
+
+	msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_ATOMIC);
+	if (NULL == msg->mailbox_data) {
+		kfree(msg);
+		sst_err("kzalloc mailbox_data failed \n");
+		return -ENOMEM;
+	};
+	*arg = msg;
+	return 0;
+}
+
+static inline int sst_create_short_msg(struct ipc_post **arg)
+{
+	struct ipc_post *msg;
+
+	msg = kzalloc(sizeof(*msg), GFP_ATOMIC);
+	if (NULL == msg) {
+		sst_err("kzalloc msg failed \n");
+		return -ENOMEM;
+	}
+	msg->mailbox_data = NULL;
+	*arg = msg;
+	return 0;
+}
+
+static inline void sst_print_params(struct snd_sst_stream_params *sparam)
+{
+	switch (sparam->uc.pcm_params.codec) {
+	case SST_CODEC_TYPE_PCM:
+		sst_dbg("pcm \n");
+		sst_dbg("chan=%d, sfreq = %d, wd_sz = %d \
+				 brate = %d framesize = %d \
+				 samples_per_frame = %d \
+				 period_cnt = %d\n",
+			sparam->uc.pcm_params.num_chan,
+			sparam->uc.pcm_params.sfreq,
+			sparam->uc.pcm_params.pcm_wd_sz,
+			sparam->uc.pcm_params.brate,
+			sparam->uc.pcm_params.frame_size,
+			sparam->uc.pcm_params.samples_per_frame,
+			sparam->uc.pcm_params.period_count);
+		break;
+
+	case SST_CODEC_TYPE_MP3:
+		sst_dbg("mp3 \n");
+		sst_dbg("chan=%d, brate=%d, sfreq = %d, wd_sz = %d\n",
+			sparam->uc.mp3_params.num_chan,
+			sparam->uc.mp3_params.brate,
+			sparam->uc.mp3_params.sfreq,
+			sparam->uc.mp3_params.pcm_wd_sz);
+		break;
+
+	case SST_CODEC_TYPE_AAC:
+		sst_dbg("aac \n");
+		sst_dbg("chan=%d, brate=%d, sfreq = %d, wd_sz = %d,asrate=%d\n",
+			sparam->uc.aac_params.num_chan,
+			sparam->uc.aac_params.brate,
+			sparam->uc.aac_params.sfreq,
+			sparam->uc.aac_params.pcm_wd_sz,
+			sparam->uc.aac_params.aac_srate);
+		sst_dbg("mpgid=%d profile=%d, aot = %d\n",
+			sparam->uc.aac_params.mpg_id,
+			sparam->uc.aac_params.aac_profile,
+			sparam->uc.aac_params.aot);
+		break;
+	case SST_CODEC_TYPE_WMA9:
+		sst_dbg("wma type \n");
+		sst_dbg("chan=%d, brate=%d, sfreq = %d, wd_sz = %d, tag=%d\n",
+			sparam->uc.wma_params.num_chan,
+			sparam->uc.wma_params.brate,
+			sparam->uc.wma_params.sfreq,
+			sparam->uc.wma_params.pcm_wd_sz,
+			sparam->uc.wma_params.format_tag);
+		sst_dbg("mask=%d, b align=%d, enc opt =%d, op align =%d\n",
+			sparam->uc.wma_params.channel_mask,
+			sparam->uc.wma_params.block_align,
+			sparam->uc.wma_params.wma_encode_opt,
+			sparam->uc.wma_params.op_align);
+		break;
+	default:
+		sst_dbg("other codec 0x%x\n", sparam->uc.pcm_params.codec);
+	}
+}
+static inline int sst_validate_strid(int str_id)
+{
+	if (str_id <= 0 || str_id >= MAX_NUM_STREAMS) {
+		sst_err("invalid stream id \n");
+		return -EINVAL;
+	} else
+		return 0;
+}
+
+/*NOTE: status will +ve for good cases and -ve for error ones*/
+#define MAX_STREAM_FIELD 255
+static inline void sst_wake_up_alloc_block(struct intel_sst_drv *sst_ops,
+		u8 sst_id, int status, void *data)
+{
+	int i;
+
+	/*Unblock with retval code*/
+	for (i = 0; i < MAX_STREAM_FIELD; i++) {
+		if (sst_id == sst_ops->alloc_block[i].sst_id) {
+			sst_ops->alloc_block[i].ops_block.condition = true;
+			sst_ops->alloc_block[i].ops_block.ret_code = status;
+			sst_ops->alloc_block[i].ops_block.data = data;
+			sst_dbg("wake id %d, sst_id %d condition %x\n", i,
+				sst_ops->alloc_block[i].sst_id,
+				sst_ops->alloc_block[i].ops_block.condition);
+			wake_up(&sst_ops->wait_queue);
+			break;
+		}
+	}
+}
+#endif /*__INTEL_SST_PVT_H__*/
-- 
1.5.4.5
