From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 6/13] Intel SST driver dsp engine
	interface module
Date: Fri,  3 Jul 2009 12:34:39 +0530
Message-ID: <1246604679-12917-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id DC7B210392B
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:55:37 +0200 (CEST)
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

This adds the IPC module which uses Inter process mechanism
to communicate between driver & SST engine (DSP processor).
To communicate between IA processor and DSP, IPC doorbell
registers are used. A write to these registers triggers
an interrupt to other side. The format of messages
and "mailbox" for message payload is defined in intel_lpe_fw_ipc.h

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	new file:   sound/pci/sst/intel_sst_fw_ipc.h
	new file:   sound/pci/sst/intel_sst_ipc.c
---
 sound/pci/sst/intel_sst_fw_ipc.h |  368 ++++++++++++++++++++++++++
 sound/pci/sst/intel_sst_ipc.c    |  536 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 904 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intel_sst_fw_ipc.h
 create mode 100644 sound/pci/sst/intel_sst_ipc.c

diff --git a/sound/pci/sst/intel_sst_fw_ipc.h b/sound/pci/sst/intel_sst_fw_ipc.h
new file mode 100644
index 0000000..6520e4e
--- /dev/null
+++ b/sound/pci/sst/intel_sst_fw_ipc.h
@@ -0,0 +1,368 @@
+#ifndef __INTEL_SST_FW_IPC_H__
+#define __INTEL_SST_FW_IPC_H__
+/*
+*  intel_sst_fw_ipc.h - Intel SST Driver for audio engine
+*
+*  Copyright (C) 2008-09 	Intel Corporation
+*  Author:	Vinod Koul <vinod.koul@intel.com>
+*  		Harsha Priya <priya.harsha@intel.com>
+*  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; version 2 of the License.
+*
+*  This program is distributed in the hope that it will be useful, but
+*  WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+*  General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License along
+*  with this program; if not, write to the Free Software Foundation, Inc.,
+*  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+*
+* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+*
+*  This driver exposes the audio engine functionalities to the ALSA
+*	and middleware.
+*  This file has definitions shared between the firmware and driver
+*/
+
+#define MAX_NUM_STREAMS 		4
+#define MAX_DBG_RW_BYTES		80
+#define MAX_NUM_SCATTER_BUFFERS		8
+#define MAX_LOOP_BACK_DWORDS		8
+/* IPC base address and mailbox, timestamp offsets */
+#define SST_MAILBOX_SIZE		0x0400
+#define SST_MAILBOX_SEND		0x0000
+#define SST_MAILBOX_RCV 		0x0804
+#define SST_TIME_STAMP 			0x1800
+#define SST_RESERVED_OFFSET		0x1840
+#define SST_CHEKPOINT_OFFSET		0x1C00
+#define REPLY_MSG 		0x80
+
+/* Message ID's for IPC messages */
+/* Bits B7: SST or IA/SC ; B6-B4: Msg Category; B3-B0: Msg Type */
+
+/* I2L Firmware/Codec Download msgs */
+#define IPC_IA_PREP_LIB_DNLD		0x01
+#define IPC_IA_LIB_DNLD_CMPLT		0x02
+
+#define IPC_IA_SET_PMIC_TYPE 		0x03
+#define IPC_IA_GET_FW_VERSION 		0x04
+#define IPC_IA_GET_FW_BUILD_INF		0x05
+#define IPC_IA_GET_FW_INFO		0x06
+
+/* I2L Codec Config/control msgs */
+#define IPC_IA_SET_CODEC_PARAMS		0x10
+#define IPC_IA_GET_CODEC_PARAMS		0x11
+#define IPC_IA_SET_PPP_PARAMS		0x12
+#define IPC_IA_GET_PPP_PARAMS		0x13
+#define IPC_IA_PLAY_FRAMES		0x14
+#define IPC_IA_CAPT_FRAMES		0x15
+#define IPC_IA_PLAY_VOICE		0x16
+#define IPC_IA_CAPT_VOICE		0x17
+#define IPC_IA_DECODE_FRAMES		0x18
+
+/* I2L Stream config/control msgs */
+#define IPC_IA_ALLOC_STREAM		0x20 /* Allocate a stream ID */
+#define IPC_IA_FREE_STREAM		0x21 /* Free the stream ID */
+#define IPC_IA_SET_STREAM_PARAMS 	0x22
+#define IPC_IA_GET_STREAM_PARAMS 	0x23
+#define IPC_IA_PAUSE_STREAM		0x24
+#define IPC_IA_RESUME_STREAM		0x25
+#define IPC_IA_DROP_STREAM		0x26
+#define IPC_IA_DRAIN_STREAM		0x27 /* Short msg with str_id */
+#define IPC_IA_TARGET_DEV_SELECT	0x28
+#define IPC_IA_CONTROL_ROUTING		0x29
+
+/* Debug msgs */
+#define IPC_IA_DBG_MEM_READ		0x40
+#define IPC_IA_DBG_MEM_WRITE		0x41
+#define IPC_IA_DBG_LOOP_BACK		0x42
+
+/* L2I Firmware/Codec Download msgs */
+#define IPC_IA_FW_INIT_CMPLT		0x81
+
+/* L2I Codec Config/control msgs */
+#define IPC_SST_GET_PLAY_FRAMES		0x90 /* Request IA more data */
+#define IPC_SST_GET_CAPT_FRAMES		0x91 /* Request IA more data */
+#define IPC_SST_BUF_UNDER_RUN		0x92 /* PB Under run and stopped */
+#define IPC_SST_BUF_OVER_RUN		0x93 /* CAP Under run and stopped */
+#define IPC_SST_DRAIN_END		0x94 /* PB Drain complete and stopped */
+#define IPC_SST_CHNGE_SSP_PARAMS 	0x95 /* PB SSP parameters changed */
+#define IPC_SST_STREAM_PROCESS_FATAL_ERR 0x96/*error in processing a stream*/
+#define IPC_SST_PERIOD_ELAPSED		0x97 /*period elapsed*/
+#define IPC_IA_TARGET_DEV_CHNGD 	0x98 /* error in processing a stream */
+
+/* L2S messages */
+#define IPC_SC_DDR_LINK_UP		0xC0
+#define IPC_SC_DDR_LINK_DOWN		0xC1
+
+/* L2I Error reporting msgs */
+#define IPC_IA_MEM_ALLOC_FAIL		0xE0
+#define IPC_IA_PROC_ERR 		0xE1 /* error in processing a
+					stream can be used by playback and
+					capture modules */
+
+/* L2I Debug msgs*/
+#define IPC_IA_PRINT_STRING		0xF0
+
+/* Command Response or Acknowledge message to any IPC message will have
+ * same message ID and stream ID information which is sent.
+ * There is no specific Ack message ID. The data field is used as response
+ * meaning.
+ */
+enum ackData {
+	IPC_ACK_SUCCESS = 0,
+	IPC_ACK_FAILURE
+};
+
+
+enum sst_error_codes {
+	/* Error code,response to msgId: Description */
+	/* Common error codes */
+	SST_SUCCESS = 0,	/*Success*/
+	SST_ERR_INVALID_STREAM_ID, /*Invalid stream ID */
+	SST_ERR_INVALID_MSG_ID,	/*Invalid message ID */
+	SST_ERR_INVALID_STREAM_OP, /*Invalid stream operation request */
+	SST_ERR_INVALID_PARAMS,	/*Invalid params */
+	SST_ERR_INVALID_CODEC,	/*Invalid codec type */
+	SST_ERR_INVALID_MEDIA_TYPE, /*Invalid media type */
+	SST_ERR_STREAM_ERR,  /*ANY: Stream control or config or
+					processing error */
+
+	/* IPC specific error codes */
+	SST_IPC_ERR_CALL_BACK_NOT_REGD, /*Call back for msg not regd*/
+	SST_IPC_ERR_STREAM_NOT_ALLOCATED, /*Stream is not allocated */
+	SST_IPC_ERR_STREAM_ALLOC_FAILED, /*ALLOC:Stream alloc failed*/
+	SST_IPC_ERR_GET_STREAM_FAILED, /*ALLOC:Get stream id failed*/
+	SST_ERR_MOD_NOT_AVAIL, /* SET/GET: Mod(AEC/AGC/ALC) not available */
+	SST_ERR_MOD_DNLD_RQD, /* SET/GET: Mod(AEC/AGC/ALC) download required*/
+	SST_ERR_STREAM_STOPPED,		/* ANY: Stream is in stopped state */
+	SST_ERR_STREAM_IN_USE, /* ANY: Stream is already in use */
+
+	/* Capture specific error codes*/
+	SST_CAP_ERR_INCMPLTE_CAPTURE_MSG,/*ANY:Incomplete message */
+	SST_CAP_ERR_CAPTURE_FAIL, /*ANY:Capture op failed */
+	SST_CAP_ERR_GET_DDR_NEW_SGLIST, /*AR: Meena */
+	SST_CAP_ERR_UNDER_RUN,	/* lack of input data */
+	SST_CAP_ERR_OVERFLOW,	/* lack of output space */
+
+	/* Playback specific error codes*/
+	SST_PB_ERR_INCMPLTE_PLAY_MSG, /* ANY: Incomplete message */
+	SST_PB_ERR_PLAY_FAIL, /* ANY: Playback operation failed */
+	SST_PB_ERR_GET_DDR_NEW_SGLIST, /* AR: Ashok */
+
+	/* Codec manager specific error codes*/
+	SST_LIB_ERR_LIB_DNLD_REQUIRED, /* ALLOC: Codec download required */
+	SST_LIB_ERR_LIB_NOT_SUPPORTED, /* Library is not supported */
+
+	/* Library manager specific error codes*/
+	SST_SCC_ERR_PREP_DNLD_FAILED, /* Failed to prepare for codec download */
+	SST_SCC_ERR_LIB_DNLD_RES_FAILED, /* Lib download resume failed */
+	/* Scheduler specific error codes*/
+	SST_SCH_ERR_FAIL, /* REPORT: */
+
+	/* DMA specific error codes */
+	SST_DMA_ERR_NO_CHNL_AVAILABLE, /* DMA Ch not available*/
+	SST_DMA_ERR_INVALID_INPUT_PARAMS, /* Invalid input params */
+	SST_DMA_ERR_CHNL_ALREADY_SUSPENDED, /* Ch is suspended */
+	SST_DMA_ERR_CHNL_ALREADY_STARTED, /* Ch already started */
+	SST_DMA_ERR_CHNL_NOT_ENABLED, /* Ch not enabled */
+	SST_DMA_ERR_TRANSFER_FAILED, /* Transfer failed */
+	SST_SSP_ERR_ALREADY_ENABLED, /* REPORT: SSP already enabled*/
+	SST_SSP_ERR_ALREADY_DISABLED, /* REPORT: SSP already disabled*/
+	SST_SSP_ERR_NOT_INITIALIZED,
+
+	/* Other error codes */
+	SST_ERR_MOD_INIT_FAIL,	/* Firmware Module init failed */
+
+	/* FW init error codes */
+	SST_RDR_ERR_IO_DEV_SEL_NOT_ALLOWED,
+	SST_RDR_ERR_ROUTE_ALREADY_STARTED,
+	SST_RDR_PREP_CODEC_DNLD_FAILED,
+
+	/* Memory debug error codes */
+	SST_ERR_DBG_MEM_READ_FAIL,
+	SST_ERR_DBG_MEM_WRITE_FAIL,
+
+
+};
+
+enum dbg_mem_data_type {
+	/* Data type of debug read/write */
+	DATA_TYPE_U32,
+	DATA_TYPE_U16,
+	DATA_TYPE_U8,
+};
+
+/* CAUTION NOTE: All IPC message body must be multiple of 32 bits.*/
+
+/* IPC Header */
+union ipc_header {
+	struct {
+		u32  msg_id:8; /* Message ID - Max 256 Message Types */
+		u32  str_id:3; /* Undefined for SC communication */
+		u32  large:1;	/* Large Message if large = 1 */
+		u32  reserved:4;/* Reserved for future use */
+		u32  data:14;	/* Ack/Info for msg, size of msg in Mailbox */
+		u32  done:1; /* bit 30 */
+		u32  busy:1; /* bit 31 */
+	} part;
+	u32 full;
+} __attribute__ ((packed));
+
+struct ipc_header_fw_init {
+	struct snd_sst_fw_version fw_version;/* Firmware version details*/
+	u16 result;	/* Fw init result */
+	u8 module_id; /* Module ID in case of error */
+	u8 debug_info; /* Debug info from Module ID in case of fail */
+} __attribute__ ((packed));
+
+/* Firmware build info */
+struct sst_fw_build_info {
+	unsigned char  date[16];	/* Firmware build date */
+	unsigned char  time[16];	/* Firmware build time */
+} __attribute__ ((packed));
+
+/* Address and size info of a frame buffer in DDR */
+struct sst_address_info {
+	u32 addr; /* Address at IA */
+	u32 size; /* Size of the buffer */
+} __attribute__ ((packed));
+
+/* Time stamp */
+struct snd_sst_tstamp {
+	u64 samples_processed;
+	u64 samples_rendered;
+	u32 sampling_frequency;
+};
+
+/* Frame info to play or capture */
+struct sst_frame_info {
+	u16  num_entries; /*  number of entries to follow */
+	u16  rsrvd;
+	struct sst_address_info  addr[MAX_NUM_SCATTER_BUFFERS];
+} __attribute__ ((packed));
+
+/* Frames info for decode */
+struct snd_sst_decode_info {
+	struct snd_sst_dbufs frames_in;
+	struct snd_sst_dbufs frames_out;
+} __attribute__ ((packed));
+/* SST to IA print debug message*/
+struct ipc_sst_ia_print_params {
+	u32 	string_size;	/* Max value is 160 */
+	u8	prt_string[160]; /* Null terminated Char string */
+} __attribute__ ((packed));
+/* Voice data message  */
+struct snd_sst_voice_data {
+	u16 num_bytes;		/* Number of valid voice data bytes */
+	u8  pcm_wd_size; 	/* 0=8 bit, 1=16 bit 2=32 bit*/
+	u8  reserved;		/* Reserved */
+	u8  voice_data_buf[0]; 	/* Voice data buffer in bytes, little endian */
+} __attribute__ ((packed));
+
+/* SST to IA memory read debug message  */
+struct ipc_sst_ia_dbg_mem_rw  {
+	u16  num_bytes; /* Maximum of MAX_DBG_RW_BYTES */
+	u16  data_type; /* enum: dbg_mem_data_type */
+	u32  address;	/* Memory address of data memory of data_type */
+	u8	rw_bytes[MAX_DBG_RW_BYTES];/* Maximum of 64 bytes can be RW */
+} __attribute__ ((packed));
+
+struct ipc_sst_ia_dbg_loop_back {
+	u16 num_dwords; /* Maximum of MAX_DBG_RW_BYTES */
+	u16 increment_val;/* Increments dwords by this value, 0- no increment */
+	u32 lpbk_dwords[MAX_LOOP_BACK_DWORDS];/* Maximum of 8 dwords loopback */
+} __attribute__ ((packed));
+
+/* Stream type params struture for Alloc stream */
+struct snd_sst_str_type {
+	u8 codec_type;		/* Codec type */
+	u8 str_type;		/* 1 = voice 2 = music */
+	u8 operation;		/* Playback or Capture */
+	u8 protected_str;	/* 0=Non DRM, 1=DRM */
+	u8 pvt_id;		/* Driver Private ID */
+	u8 reserved;		/* Reserved */
+	u16 result;		/* Result used for acknowledgment */
+} __attribute__ ((packed));
+
+/* Library info structure */
+struct module_info {
+	u32 lib_version;
+	u32 lib_type;
+	u32 media_type;
+	u8  lib_name[12];
+	u32 lib_caps;
+	unsigned char  b_date[16]; /* Lib build date */
+	unsigned char  b_time[16]; /* Lib build time */
+} __attribute__ ((packed));
+
+/* Library slot info */
+struct lib_slot_info {
+	u8  slot_num; /* 1 or 2*/
+	u8  reserved1;
+	u16 reserved2;
+	u32 iram_size; /* slot size in IRAM */
+	u32 dram_size; /* slot size in DRAM */
+	u32 iram_offset; /* starting offset of slot in IRAM */
+	u32 dram_offset; /* starting offset of slot in DRAM */
+} __attribute__ ((packed));
+
+struct snd_sst_lib_download {
+	struct module_info lib_info; /* library info type, capabilities etc*/
+	struct lib_slot_info slot_info; /* slot info to be downloaded */
+	u32 mod_entry_pt;
+};
+
+struct snd_sst_lib_download_info {
+	struct snd_sst_lib_download dload_lib;
+	u16 result;	/* Result used for acknowledgment */
+	u8 pvt_id; /*Private ID*/
+	u8 reserved;  /*for alignment*/
+};
+
+/* Alloc stream params structure */
+struct snd_sst_alloc_params {
+	struct snd_sst_str_type str_type;
+	struct snd_sst_stream_params stream_params;
+};
+
+struct snd_sst_fw_get_stream_params {
+	struct snd_sst_str_type str_type;
+	struct snd_sst_params codec_params;
+	struct snd_sst_pmic_config pcm_params;
+};
+
+/* Alloc stream response message */
+struct snd_sst_alloc_response {
+	struct snd_sst_str_type str_type; /* Stream type for allocation*/
+	struct snd_sst_lib_download lib_dnld; /*Valid only for codec dnld*/
+};
+
+/*struct ipc_msg_body {
+	 union {
+		 CODEC_PARAM_STRUCTURES;
+		 PPP_PARAM_STRUCTURES;
+		 struct snd_sst_alloc_params alloc_params;
+		 struct snd_sst_alloc_response alloc_response;
+		 struct snd_sst_stream_params stream_params;
+		 struct sst_frame_info frames_info;
+		 struct ipc_sst_ia_print_params print_params;
+		 struct ipc_sst_ia_dbg_mem_rw dbg_mem_rw;
+		 struct ipc_sst_ia_dbg_loop_back loop_back;
+		 struct pmic_pcm_params ssp_params;
+	 } u;
+};*/
+
+
+
+struct ipc_post {
+	struct list_head node;
+	union ipc_header header; /* driver specific */
+	char *mailbox_data;
+};
+
+#endif /*__INTEL_SST_FW_IPC_H__*/
diff --git a/sound/pci/sst/intel_sst_ipc.c b/sound/pci/sst/intel_sst_ipc.c
new file mode 100644
index 0000000..98b4031
--- /dev/null
+++ b/sound/pci/sst/intel_sst_ipc.c
@@ -0,0 +1,536 @@
+/*
+ *  intel_sst_ipc.c - Intel SST Driver for audio engine
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
+ *  This file defines all ipc functions
+ */
+
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+#include <linux/file.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+#include <linux/firmware.h>
+#include <sound/intel_sst.h>
+#include <sound/intel_sst_ioctl.h>
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+#include "intel_sst_pvt.h"
+
+void sst_send_loop_test(int loop_no)
+{
+	struct ipc_post *msg = NULL;
+	struct ipc_sst_ia_dbg_loop_back loop_msg;
+	static int large_num;
+
+	sst_dbg("Loop testing %d \n", loop_no);
+
+	if (large_num >= 4) {
+		sst_dbg("Loop testing complete.....\n");
+		return;
+	}
+	if (loop_no >= 4) {
+		/*large loop*/
+		large_num++;
+		sst_dbg("Large msg \n");
+		if (0 != sst_create_large_msg(&msg))
+			return;
+
+		loop_msg.increment_val = 1;
+		loop_msg.lpbk_dwords[0] = 0x11111111;
+		loop_msg.lpbk_dwords[1] = 0x22222222;
+		loop_msg.lpbk_dwords[2] = 0x33333333;
+		loop_msg.lpbk_dwords[3] = 0x44444444;
+		loop_msg.num_dwords = 4;
+		sst_fill_header(&msg->header, IPC_IA_DBG_LOOP_BACK, 1, loop_no);
+		msg->header.part.data = sizeof(u32) + sizeof(loop_msg);
+		memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+		memcpy(msg->mailbox_data + sizeof(u32),
+				&loop_msg, sizeof(loop_msg));
+	} else {
+		/*short loop*/
+		sst_dbg("Loop Short msg \n");
+		if (0 != sst_create_short_msg(&msg))
+			return;
+		sst_fill_header(&msg->header, IPC_IA_DBG_LOOP_BACK, 0, loop_no);
+	}
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	return;
+}
+
+void sst_send_pmic_type(void)
+{
+	struct ipc_post *msg = NULL;
+
+	sst_dbg("...called\n");
+
+	if (0 != sst_create_short_msg(&msg))
+		return;
+
+	sst_fill_header(&msg->header, IPC_IA_SET_PMIC_TYPE, 0, 0);
+	msg->header.part.data = sst_ops->pmic_vendor;
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	return;
+}
+
+void sst_get_fw_version(void)
+{
+	struct ipc_post *msg = NULL;
+
+	sst_dbg("...called\n");
+
+	if (0 != sst_create_short_msg(&msg))
+		return;
+
+	sst_fill_header(&msg->header, IPC_IA_GET_FW_VERSION, 0, 0);
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	if (0 != sst_create_short_msg(&msg))
+		return;
+
+	sst_fill_header(&msg->header, IPC_IA_GET_FW_BUILD_INF, 0, 0);
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	return;
+}
+
+/**
+* sst_post_message - Posts message to SST
+* @work:	Pointer to work structure
+*
+* This function is called by any component in driver which
+* wants to send an IPC message. This will post message only if
+* busy bit is free
+*/
+void sst_post_message(struct work_struct *work)
+{
+	struct ipc_post *msg;
+	union ipc_header header;
+	union  interrupt_reg imr;
+	imr.full = 0;
+
+	sst_dbg("..called \n");
+	mutex_lock(&sst_ops->list_lock);
+	/*check list*/
+	if (0 != list_empty(&sst_ops->ipc_dispatch_list)) {
+		/*list is empty, mask imr*/
+		sst_dbg(" Empty msg queue... masking \n");
+		imr.full = readl(sst_ops->shim + SST_IMRX);
+		imr.part.done_interrupt = 1;
+		writel(imr.full, sst_ops->shim + SST_IMRX);
+		mutex_unlock(&sst_ops->list_lock);
+		return;
+	}
+
+	/*check busy bit*/
+	header.full = readl(sst_ops->shim + SST_IPCX);
+	if (1 == header.part.busy) {
+		/*busy, unmask*/
+		sst_dbg("Busy not free... unmasking\n");
+		imr.full = readl(sst_ops->shim + SST_IMRX);
+		imr.part.done_interrupt = 0;
+		writel(imr.full, sst_ops->shim + SST_IMRX);
+		mutex_unlock(&sst_ops->list_lock);
+		return;
+	}
+	/*copy msg from list*/
+	msg = list_entry(sst_ops->ipc_dispatch_list.next,
+			struct ipc_post, node);
+	list_del(&msg->node);
+	sst_dbg("Post message: header = %x\n", msg->header.full);
+	sst_dbg("size: = %x\n", msg->header.part.data);
+	if (1 == msg->header.part.large)
+		memcpy_toio(sst_ops->mailbox + SST_MAILBOX_SEND,
+			msg->mailbox_data, msg->header.part.data);
+	writel(msg->header.full, sst_ops->shim + SST_IPCX);
+	mutex_unlock(&sst_ops->list_lock);
+
+	kfree(msg->mailbox_data);
+	kfree(msg);
+	sst_dbg("...done\n");
+	return;
+}
+
+void sst_clear_interrupt(void)
+{
+	union interrupt_reg 	isr;
+	union interrupt_reg 	imr;
+	union ipc_header 	clear_ipc;
+
+	sst_dbg("sst clearing interrupt \n");
+	imr.full = readl(sst_ops->shim + SST_IMRX);
+	isr.full = readl(sst_ops->shim + SST_ISRX);
+	/* write 1 to clear */;
+	isr.part.busy_interrupt = 1;
+	writel(isr.full, sst_ops->shim + SST_ISRX);
+	/*Set IA done bit*/
+	clear_ipc.full = readl(sst_ops->shim + SST_IPCD);
+	clear_ipc.part.busy = 0;
+	clear_ipc.part.done = 1;
+	clear_ipc.part.data = IPC_ACK_SUCCESS;
+	writel(clear_ipc.full, sst_ops->shim + SST_IPCD);
+	/*un mask busy interrupt*/
+	imr.part.busy_interrupt = 0;
+	writel(imr.full, sst_ops->shim + SST_IMRX);
+}
+
+/**
+* sst_process_message - Processes message from SST
+* @work:	Pointer to work structure
+*
+* This function is scheduled by ISR
+* It take a msg from process_queue and does action based on msg
+*/
+void sst_process_message(struct work_struct *work)
+{
+	struct sst_ipc_msg_wq *msg =
+			container_of(work, struct sst_ipc_msg_wq, wq);
+	int str_id = msg->header.part.str_id;
+
+	sst_dbg("called \n");
+
+	/*based on msg in list call respective handler*/
+	switch (msg->header.part.msg_id) {
+	case IPC_SST_BUF_UNDER_RUN:
+	case IPC_SST_BUF_OVER_RUN:
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+		sst_err("Buffer under/overrun for %d\n",
+				msg->header.part.str_id);
+		sst_dbg("Got Underrun & not to send data...ignore\n");
+		break;
+
+	case IPC_SST_GET_PLAY_FRAMES:
+	{
+		struct stream_info *stream ;
+
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+		/*call sst_play_frame*/
+		stream = &sst_ops->streams[str_id];
+		sst_dbg("sst_play_frames for %d\n", msg->header.part.str_id);
+		mutex_lock(&sst_ops->streams[str_id].lock);
+		sst_play_frame(msg->header.part.str_id);
+		mutex_unlock(&sst_ops->streams[str_id].lock);
+		break;
+	}
+
+	case IPC_SST_PERIOD_ELAPSED:
+	{
+		struct snd_sst_tstamp fw_tstamp = {0,};
+		struct stream_info *stream ;
+
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+		stream = &sst_ops->streams[str_id];
+
+		sst_dbg("Period elapsed \n");
+		memcpy_fromio(&fw_tstamp,
+			((void *)(sst_ops->mailbox + SST_TIME_STAMP) +
+			(str_id * sizeof(fw_tstamp))),
+			sizeof(fw_tstamp));
+		sst_dbg("samples played = %lld\n", fw_tstamp.samples_processed);
+		sst_dbg("diff in mesg = %d\n", msg->header.part.data);
+		sst_clear_interrupt();
+		if (stream->period_elapsed)
+			stream->period_elapsed(stream->pcm_substream);
+		return;
+	}
+
+	case IPC_SST_GET_CAPT_FRAMES:
+		/*call sst_capture_frame*/
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+		sst_dbg("sst_capture_frames for %d\n", msg->header.part.str_id);
+		mutex_lock(&sst_ops->streams[str_id].lock);
+		if (sst_ops->streams[str_id].ops == STREAM_OPS_CAPTURE &&
+				sst_ops->streams[str_id].mmapped == false &&
+				sst_ops->streams[str_id].codec !=
+							SST_CODEC_TYPE_PCM) {
+			sst_dbg("waking up block for copy...\n");
+			sst_ops->streams[str_id].data_blk.ret_code = 0;
+			sst_ops->streams[str_id].data_blk.condition = true;
+			sst_ops->streams[str_id].data_blk.on = false;
+			wake_up(&sst_ops->wait_queue);
+		} else
+			sst_capture_frame(msg->header.part.str_id);
+		mutex_unlock(&sst_ops->streams[str_id].lock);
+		break;
+
+	case IPC_IA_PRINT_STRING:
+		sst_dbg("been asked to print something by fw\n");
+		/*TBD*/
+		break;
+
+	case IPC_IA_FW_INIT_CMPLT: {
+		/*send next data to FW*/
+		struct ipc_header_fw_init *init =
+			(struct ipc_header_fw_init *)msg->mailbox;
+
+		sst_dbg("*** FW Init msg came*** \n");
+		if (0 == init->result) {
+			sst_ops->sst_state = SST_FW_RUNNING;
+			sst_info("FW Version %x.%x \n",
+				init->fw_version.major, init->fw_version.minor);
+			sst_info("Build No %x Type %x \n",
+				init->fw_version.build, init->fw_version.type);
+#ifdef SND_LOOP_TEST
+			sst_send_loop_test(0);
+#endif
+			sst_send_pmic_type();
+			sst_get_fw_version();
+		} else {
+			sst_ops->sst_state = SST_ERROR;
+			sst_dbg("FW Init failed, Error %x\n", init->result);
+			sst_dbg("FW Init failed, Module %x, Debug Info %x \n",
+				init->module_id, init->debug_info);
+		}
+		sst_dbg("Waking up... open\n");
+		sst_wake_up_alloc_block(sst_ops, 0xFF, 0, NULL);
+		break;
+	}
+
+	case IPC_SST_STREAM_PROCESS_FATAL_ERR:
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+			sst_err(" codec fatal error %x for stream %d... \n",
+				msg->header.full, msg->header.part.str_id);
+			sst_err("Dropping the stream \n");
+			sst_drop_stream(msg->header.part.str_id);
+		break;
+
+	default:
+		/*Illegal case*/
+		sst_err("Unhandled case msg_id %x message %x\n",
+				msg->header.part.msg_id, msg->header.full);
+	}
+	sst_clear_interrupt();
+	return;
+}
+
+/**
+* sst_process_reply - Processes reply message from SST
+* @work:	Pointer to work structure
+*
+* This function is scheduled by ISR
+* It take a reply msg from response_queue and
+* does action based on msg
+*/
+void sst_process_reply(struct work_struct *work)
+{
+	struct sst_ipc_msg_wq *msg =
+			container_of(work, struct sst_ipc_msg_wq, wq);
+	int str_id = msg->header.part.str_id;
+	struct stream_info *str_info = NULL;
+
+	sst_dbg("called for %x \n", msg->header.full);
+
+	switch (msg->header.part.msg_id) {
+	case IPC_IA_DROP_STREAM:
+	case IPC_IA_PAUSE_STREAM:
+	case IPC_IA_RESUME_STREAM:
+	case IPC_IA_SET_STREAM_PARAMS:
+		if (0 == msg->header.part.data) {
+			sst_dbg("Msg succedded %x \n", msg->header.part.msg_id);
+		} else {
+			sst_err("Msg %x reply error %x \n",
+					msg->header.part.msg_id,
+					msg->header.part.data);
+		}
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+
+		str_info = &sst_ops->streams[str_id];
+		str_info->ctrl_blk.ret_code = msg->header.part.data;
+		if (str_info->ctrl_blk.on == true) {
+			str_info->ctrl_blk.condition = true;
+			wake_up(&sst_ops->wait_queue);
+		}
+		break;
+
+	case IPC_IA_FREE_STREAM:
+		if (0 == msg->header.part.data) {
+			sst_dbg("Stream %d freed\n", str_id);
+		} else {
+			sst_err("Free for %d returned error %x\n",
+					str_id, msg->header.part.data);
+		}
+		break;
+	case IPC_IA_GET_STREAM_PARAMS: {
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+		if (0 == msg->header.part.data) {
+			struct snd_sst_stream_params *params = NULL;
+			params = kzalloc(sizeof(*params), GFP_KERNEL);
+			if (NULL == params) {
+				sst_err("mem allocation failed\n");
+				break;
+			}
+			memcpy(params, &msg->mailbox, sizeof(*params));
+			str_info = &sst_ops->streams[str_id];
+			str_info->get_parameters = params;
+		} else {
+			sst_err("Msg %x reply error %x \n",
+				msg->header.part.msg_id, msg->header.part.data);
+		}
+		break;
+	}
+
+	case IPC_IA_ALLOC_STREAM: {
+		/*map to stream, call play*/
+		struct snd_sst_alloc_response *resp =
+				(struct snd_sst_alloc_response *)msg->mailbox;
+		if (0 != resp->str_type.result) {
+			/*error case*/
+			struct snd_sst_alloc_response *lib = NULL;
+			sst_err("error alloc stream = %x \n",
+					resp->str_type.result);
+			if (resp->str_type.result ==
+					SST_LIB_ERR_LIB_DNLD_REQUIRED) {
+				lib = kzalloc(sizeof(*lib), GFP_ATOMIC);
+				if (NULL == lib) {
+					sst_err("mem allocation failed \n");
+					break;
+				}
+				memcpy(lib, msg->mailbox, sizeof(*lib));
+				/*library needs to be downloaded*/
+				sst_dbg("Codec Download required \n");
+			}
+			sst_wake_up_alloc_block(sst_ops, resp->str_type.pvt_id,
+					(-resp->str_type.result), lib);
+			break;
+		}
+		sst_alloc_stream_response(str_id, &resp->str_type);
+		break;
+	}
+
+	case IPC_IA_DBG_LOOP_BACK:
+		/*Debug loop back msg*/
+		sst_dbg("Loop back came \n");
+		if (0 != msg->header.part.data)
+			sst_dbg("Possible error if not large \n");
+		sst_dbg("Loop ID: %d\n", str_id);
+		if (msg->header.part.large) {
+			struct ipc_sst_ia_dbg_loop_back *loop_msg =
+				(struct ipc_sst_ia_dbg_loop_back *)msg->mailbox;
+			int i;
+			sst_dbg("Got large loop back: Words %d\n",
+						loop_msg->num_dwords);
+			for (i = 0; i < loop_msg->num_dwords; i++) {
+				sst_dbg("Loop Word %d = %d \n", i,
+					loop_msg->lpbk_dwords[i]);
+			}
+		}
+		sst_send_loop_test((str_id + 1));
+		break;
+
+	case IPC_IA_PLAY_FRAMES:
+	case IPC_IA_CAPT_FRAMES:
+		if (sst_validate_strid(str_id) != 0) {
+			sst_err("stream id %d invalid\n", str_id);
+			break;
+		}
+		sst_dbg("Ack for play/capt frames recived \n");
+		break;
+
+	case IPC_IA_PREP_LIB_DNLD: {
+		struct snd_sst_str_type *str_type =
+			(struct snd_sst_str_type *)msg->mailbox;
+		sst_dbg("Prep Lib download %x\n", msg->header.part.msg_id);
+		if (0 !=  str_type->result)
+			sst_err("Error in prep lib download 0x%x\n",
+					str_type->result);
+		else
+			sst_dbg("Need to download codec now...\n");
+		str_type->result = 0;
+		sst_wake_up_alloc_block(sst_ops, str_type->pvt_id,
+				str_type->result, NULL);
+		break;
+	}
+
+	case IPC_IA_LIB_DNLD_CMPLT: {
+		struct snd_sst_lib_download_info *resp =
+			(struct snd_sst_lib_download_info *)msg->mailbox;
+		int retval = resp->result;
+
+		sst_dbg("Lib download cmplt %x\n", msg->header.part.msg_id);
+		if (0 !=  retval)
+			sst_err("Error in lib dload %x\n", resp->result);
+		else {
+			sst_dbg("Codec download complete...\n");
+			sst_info("Dloaded codec Type %d Ver %d Built %s: %s\n",
+				resp->dload_lib.lib_info.lib_type,
+				resp->dload_lib.lib_info.lib_version,
+				resp->dload_lib.lib_info.b_date,
+				resp->dload_lib.lib_info.b_time);
+		}
+		sst_wake_up_alloc_block(sst_ops, resp->pvt_id, retval, NULL);
+		break;
+	}
+
+	case IPC_IA_GET_FW_VERSION: {
+		struct snd_sst_fw_version *version =
+				(struct snd_sst_fw_version *)msg->mailbox;
+		sst_info("***LOADED SST FW VERSION*** = %2d.%02d\n",
+				version->major, version->minor);
+		sst_info("Build No %x Type %x \n",
+				version->build, version->type);
+		break;
+	}
+	case IPC_IA_GET_FW_BUILD_INF: {
+		struct sst_fw_build_info *build =
+			(struct sst_fw_build_info *)msg->mailbox;
+		sst_info("Build date %s Time %s\n",
+				build->date, build->time);
+		break;
+	}
+
+	default:
+		/*Illegal case*/
+		sst_err("process reply :default case = %x\n",
+					msg->header.full);
+
+	}
+	sst_clear_interrupt();
+	return;
+}
-- 
1.5.4.5
