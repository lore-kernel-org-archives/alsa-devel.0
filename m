From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 7/13] Intel SST driver stream module
Date: Fri,  3 Jul 2009 12:35:07 +0530
Message-ID: <1246604707-12938-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id E3ADD10393E
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:56:05 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, R Dharageswari <dharageswari.r@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds the stream module which contains the function for
stream operations & control. For a stream the control
and data are two major parts. This module implements the
control (play/pause/resume/stop/free/alloc) for a stream.
It also implements data play/capture frames where buffers
are sent/received to Firmware.
The objective of SST driver is to achieve Low power
playback by utilizing DSP as much as possible. So SST gets
large music buffers from player/middleware and sends
them to firmware in a scatter gather list.
The firmware decodes and renders them, while IA can goto
low power states

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: R Dharageswari <dharageswari.r@intel.com>

	new file:   sound/pci/sst/intel_sst_stream.c
---
 sound/pci/sst/intel_sst_stream.c |  711 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 711 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intel_sst_stream.c

diff --git a/sound/pci/sst/intel_sst_stream.c b/sound/pci/sst/intel_sst_stream.c
new file mode 100644
index 0000000..aabf057
--- /dev/null
+++ b/sound/pci/sst/intel_sst_stream.c
@@ -0,0 +1,711 @@
+/*
+ *  intel_sst_stream.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-09 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *  		Harsha Priya <priya.harsha@intel.com>
+ *  		R Dharageswari <dharageswari.r@intel.com>
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
+ *  This file contains the stream operations of SST driver
+ */
+
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/syscalls.h>
+#include <linux/file.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/uaccess.h>
+#include <linux/firmware.h>
+#include <sound/intel_sst_ioctl.h>
+#include "intel_sst_fw_ipc.h"
+#include <sound/intel_sst.h>
+#include "intel_sst_common.h"
+#include "intel_sst_pvt.h"
+#ifdef CONFIG_SST_OSPM_SUPPORT
+#include <linux/intel_mid.h>
+#endif
+
+/**
+* sst_alloc_stream - Send msg for a new stream ID
+* @params:	stream params
+* @stream_ops:	operation of stream PB/capture
+* @codec:	codec for stream
+* @session_id:	pvt_id passed by MMF to distinguish stream
+*
+* This function is called by any function which wants to start
+* a new stream. This also check if a stream exists which is idle
+* it initializes idle stream id to this request
+*/
+int sst_alloc_stream(char *params, int stream_ops, int codec, int session_id)
+{
+	struct ipc_post *msg = NULL;
+	struct snd_sst_alloc_params alloc_param = {{0,},};
+
+	sst_dbg("entering sst_alloc_stream \n");
+	sst_dbg("%d %d %d\n", stream_ops, codec, session_id);
+
+	BUG_ON(!params);
+
+	/*send msg to FW to allocate a stream*/
+	if (sst_create_large_msg(&msg) != 0)
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header, IPC_IA_ALLOC_STREAM, 1, 0);
+	msg->header.part.data = sizeof(alloc_param) + sizeof(u32);
+	alloc_param.str_type.codec_type = codec;
+	alloc_param.str_type.str_type = 2; /*music*/
+	alloc_param.str_type.operation = stream_ops;
+	alloc_param.str_type.protected_str = 0; /*non drm*/
+	alloc_param.str_type.pvt_id = session_id;
+	memcpy(&alloc_param.stream_params, params,
+			sizeof(struct snd_sst_stream_params));
+
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &alloc_param,
+			sizeof(alloc_param));
+
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	sst_dbg("alloc stream done\n");
+	return 0;
+}
+
+/**
+* sst_alloc_stream_response - process alloc reply
+* @alloc_header:	respose header
+*
+* This function is called by process_reply when reply from FW comes
+* based on response has to process further
+*/
+int sst_alloc_stream_response(unsigned int str_id,
+				struct snd_sst_str_type *type)
+{
+	int retval = 0, i, valid_str = 0;
+	struct ipc_post *msg = NULL;
+
+	/*allocation succesfull*/
+	sst_dbg("stream number given = %d \n", str_id);
+
+	for (i = 0; i < MAX_STREAM_FIELD; i++) {
+		if (type->pvt_id == sst_ops->alloc_block[i].sst_id) {
+			valid_str = 1;
+			break;
+		}
+	}
+	if (valid_str == 0) {
+		/*this is not valid stream*/
+		sst_err("Invalid stream allocation detetcted... freeing\n");
+		if (sst_create_short_msg(&msg) != 0)
+			return -ENOMEM;
+		sst_fill_header(&msg->header, IPC_IA_FREE_STREAM, 0, str_id);
+		list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+		sst_post_message(&sst_ops->ipc_post_msg_wq);
+		return 0;
+	}
+
+	sst_init_stream(&sst_ops->streams[str_id], type->codec_type,
+			type->pvt_id, type->operation);
+
+	sst_dbg("stream pvt id = %d \n", type->pvt_id);
+
+	/*Unblock with retval code*/
+	sst_wake_up_alloc_block(sst_ops, type->pvt_id, str_id, NULL);
+	return retval;
+}
+
+/**
+* sst_pause_stream - Send msg for a pausing stream
+* @id:		 stream ID
+*
+* This function is called by any function which wants to pause
+* an already running stream.
+*/
+int sst_pause_stream(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info = NULL;
+
+	sst_dbg("sst_pause_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return retval;
+	str_info = &sst_ops->streams[str_id];
+	if (STREAM_PAUSED == str_info->status)
+		return 0;
+
+	if (STREAM_RUNNING == str_info->status ||
+			STREAM_INIT == str_info->status) {
+
+		if (str_info->prev == STREAM_UN_INIT)
+			return -EBADRQC;
+
+		mutex_lock(&str_info->lock);
+		if (sst_create_short_msg(&msg) != 0) {
+			mutex_unlock(&str_info->lock);
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_PAUSE_STREAM, 0, str_id);
+		list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+		mutex_unlock(&str_info->lock);
+		sst_post_message(&sst_ops->ipc_post_msg_wq);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		retval = sst_wait_interruptible_timeout(sst_ops,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (retval == 0) {
+			str_info->prev = str_info->status;
+			str_info->status = STREAM_PAUSED;
+#ifdef CONFIG_SST_OSPM_SUPPORT
+			sst_ospm_send_event(OSPM_EVENT_SUBSYS_STOP_PLAY);
+#endif
+		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+			retval = EINVAL;
+			sst_clean_stream(str_info);
+		}
+	} else {
+		retval = -EBADRQC;
+		sst_err("BADQRC for stream\n");
+	}
+
+	return retval;
+}
+
+/**
+* sst_resume_stream - Send msg for resuming stream
+* @id:		stream ID
+*
+* This function is called by any function which wants to resume
+* an already paused stream.
+*/
+int sst_resume_stream(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info = NULL;
+
+	sst_dbg("sst_resume_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return retval;
+	str_info = &sst_ops->streams[str_id];
+	if (STREAM_RUNNING == str_info->status)
+			return 0;
+	if (STREAM_PAUSED == str_info->status) {
+		mutex_lock(&str_info->lock);
+		if (sst_create_short_msg(&msg) != 0) {
+			mutex_unlock(&str_info->lock);
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_RESUME_STREAM, 0, str_id);
+		list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+		mutex_unlock(&str_info->lock);
+		sst_post_message(&sst_ops->ipc_post_msg_wq);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		retval = sst_wait_interruptible_timeout(sst_ops,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (retval == 0) {
+			if (STREAM_RUNNING == str_info->prev)
+				str_info->status = STREAM_RUNNING;
+			else
+				str_info->status = STREAM_INIT;
+			str_info->prev = STREAM_PAUSED;
+#ifdef CONFIG_SST_OSPM_SUPPORT
+			sst_ospm_send_event(OSPM_EVENT_SUBSYS_START_PLAY);
+#endif
+		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+			retval = EINVAL;
+			sst_clean_stream(str_info);
+		}
+	} else {
+		retval = -EBADRQC;
+		sst_err("BADQRC for stream\n");
+	}
+
+	return retval;
+}
+
+
+/**
+* sst_drop_stream - Send msg for stopping stream
+* @id:		stream ID
+*
+* This function is called by any function which wants to stop
+* a stream.
+*/
+int sst_drop_stream(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct sst_stream_bufs *bufs = NULL, *_bufs = NULL;
+	struct stream_info *str_info = NULL;
+
+	sst_dbg("sst_drop_stream for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return retval;
+	str_info = &sst_ops->streams[str_id];
+	if (STREAM_UN_INIT != str_info->status) {
+
+		mutex_lock(&str_info->lock);
+
+		if (sst_create_short_msg(&msg) != 0) {
+			mutex_unlock(&str_info->lock);
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_DROP_STREAM, 0, str_id);
+		list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+		mutex_unlock(&sst_ops->streams[str_id].lock);
+		sst_post_message(&sst_ops->ipc_post_msg_wq);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		retval = sst_wait_interruptible_timeout(sst_ops,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (retval == 0) {
+			str_info->prev = str_info->status;
+			str_info->status = STREAM_INIT;
+			if (str_info->data_blk.on == true) {
+				/*moved codec specfic check to generic check*/
+				str_info->data_blk.condition = true;
+				str_info->data_blk.ret_code = 0;
+				wake_up(&sst_ops->wait_queue);
+			}
+			list_for_each_entry_safe(bufs, _bufs,
+						&str_info->bufs, node) {
+				list_del(&bufs->node);
+				kfree(bufs);
+			}
+#ifdef CONFIG_SST_OSPM_SUPPORT
+			sst_ospm_send_event(OSPM_EVENT_SUBSYS_STOP_PLAY);
+#endif
+		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+			retval = EINVAL;
+			sst_clean_stream(str_info);
+		}
+	} else {
+		retval = -EBADRQC;
+		sst_err("BADQRC for stream\n");
+	}
+
+	return retval;
+}
+
+/**
+* sst_free_stream - Frees a stream
+* @id:		stream ID
+*
+* This function is called by any function which wants to free
+* a stream.
+*/
+int sst_free_stream(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info = NULL;
+
+	sst_dbg("sst_free_stream for %d\n", str_id);
+
+	retval = sst_validate_strid(str_id);
+	if (0 != retval)
+		return retval;
+	str_info = &sst_ops->streams[str_id];
+
+	if (STREAM_UN_INIT != str_info->status) {
+		mutex_lock(&str_info->lock);
+		if (sst_create_short_msg(&msg) != 0) {
+			mutex_unlock(&str_info->lock);
+			return -ENOMEM;
+		}
+		sst_fill_header(&msg->header, IPC_IA_FREE_STREAM, 0, str_id);
+		list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+		mutex_unlock(&str_info->lock);
+		sst_post_message(&sst_ops->ipc_post_msg_wq);
+		str_info->prev =  str_info->status;
+		str_info->status = STREAM_UN_INIT;
+		if (str_info->data_blk.on == true) {
+			str_info->data_blk.condition = true;
+			str_info->data_blk.ret_code = 0;
+			wake_up(&sst_ops->wait_queue);
+		}
+		sst_clean_stream(str_info);
+		sst_dbg("Stream freed\n");
+
+#ifdef CONFIG_SST_OSPM_SUPPORT
+		sst_ospm_send_event(OSPM_EVENT_SUBSYS_STOP_PLAY);
+#endif
+	} else {
+		retval = -EBADRQC;
+		sst_dbg("BADQRC for stream\n");
+	}
+
+	return retval;
+}
+
+
+/**
+* sst_set_stream_param - Send msg for setting stream
+* @id:		stream id
+* @params:	stream params
+*
+* This function  sets stream params during runtime
+*/
+int sst_set_stream_param(int str_id, struct snd_sst_params *str_param)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info = NULL;
+
+	BUG_ON(!str_param);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return retval;
+	sst_dbg("set_stream for %d\n", str_id);
+	if (STREAM_INIT == sst_ops->streams[str_id].status) {
+		mutex_lock(&sst_ops->streams[str_id].lock);
+
+		if (sst_create_large_msg(&msg) != 0) {
+			mutex_unlock(&sst_ops->streams[str_id].lock);
+			return -ENOMEM;
+		}
+
+		sst_fill_header(&msg->header,
+				IPC_IA_SET_STREAM_PARAMS, 1, str_id);
+		msg->header.part.data = sizeof(u32) +
+				sizeof(str_param->sparams);
+		memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+		memcpy(msg->mailbox_data + sizeof(u32), &str_param->sparams,
+				sizeof(str_param->sparams));
+		list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+		sst_post_message(&sst_ops->ipc_post_msg_wq);
+		mutex_unlock(&sst_ops->streams[str_id].lock);
+		str_info->ctrl_blk.condition = false;
+		str_info->ctrl_blk.ret_code = 0;
+		str_info->ctrl_blk.on = true;
+		retval = sst_wait_interruptible_timeout(sst_ops,
+				&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+		if (retval != 0) {
+			retval = EINVAL;
+			sst_free_stream(str_id);
+		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+			retval = EINVAL;
+			sst_clean_stream(str_info);
+		}
+	} else {
+		retval = -EBADRQC;
+		sst_err("BADQRC for stream\n");
+	}
+	return retval;
+}
+
+/**
+* sst_route_control - To start or drop the routing from once device to another.
+* @id:		stream id
+*
+* This function  gets stream params during runtime
+*/
+/*
+int sst_route_control(int str_id)
+{
+	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct snd_sst_control_routing *route = {0,};
+	struct stream_info *str_info = NULL;
+	sst_dbg("sst_route_control for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	route->control = 0;
+	if (0 != retval)
+		return retval;
+	str_info = &sst_ops->streams[str_id];
+	mutex_lock(&str_info->lock);
+	if (sst_create_large_msg(&msg) != 0) {
+		mutex_unlock(&str_info->lock);
+		return -ENOMEM;
+	}
+	sst_fill_header(&msg->header, IPC_IA_CONTROL_ROUTING, 1, str_id);
+	msg->header.part.data = sizeof(u32) + sizeof(*route);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), route,
+			sizeof(*route));
+
+
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	mutex_unlock(&str_info->lock);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+
+	str_info->ctrl_blk.condition = false;
+	str_info->ctrl_blk.ret_code = 0;
+	str_info->ctrl_blk.on = true;
+	retval = sst_wait_interruptible_timeout(sst_ops,
+					&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+	if (retval == 0)
+		return retval;
+	else if (retval == SST_ERR_INVALID_STREAM_ID) {
+		retval = EINVAL;
+		sst_clean_stream(str_info);
+	}
+	return retval;
+
+}*/
+
+/**
+* sst_target_device_select - This fuction allows to select the target device
+*			 for the playback or capture
+* @id:		stream id
+*
+* This function  gets stream params and the target device during runtime
+*/
+
+int sst_target_device_select(struct snd_sst_target_device *target_device)
+{
+/*	int retval = 0;
+	struct ipc_post *msg = NULL;
+	struct snd_sst_slot_info *slot_info = NULL;
+	struct stream_info *str_info = NULL;
+*/	sst_dbg("stream_control ");
+	return 0;
+#if 0
+	if (sst_create_large_msg(&msg) != 0) {
+		mutex_unlock(&str_info->lock);
+		return -ENOMEM;
+	}
+	sst_fill_header(&msg->header, IPC_IA_TARGET_DEV_SELECT,
+							1, str_id);
+	msg->header.part.data = sizeof(u32) + sizeof(*target_device);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), target_device,
+			sizeof(*target_device));
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	mutex_unlock(&str_info->lock);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+
+	str_info->ctrl_blk.condition = false;
+	str_info->ctrl_blk.ret_code = 0;
+	str_info->ctrl_blk.on = true;
+	retval = sst_wait_interruptible_timeout(sst_ops,
+			&str_info->ctrl_blk, SST_BLOCK_TIMEOUT);
+	if (retval == SST_ERR_INVALID_STREAM_ID) {
+		retval = -EINVAL;
+		sst_clean_stream(str_info);
+	}
+	if (target_device->device_route < 0 ||
+			target_device->device_route > 2)
+		return -EINVAL;
+	slot_info = &target_device->devices[0];
+
+	if (slot_info->type == SND_SST_TARGET_PMIC)
+		retval = sst_set_pmic_config(str_id, &slot_info->pcm_params);
+	if (target_device->device_route == 2) {
+		slot_info = &target_device->devices[1];
+		if (target_device->devices[1].type == SND_SST_TARGET_PMIC)
+			retval = sst_set_pmic_config(str_id,
+					&slot_info->pcm_params);
+	}
+	if (retval >= 0)
+		retval = sst_route_control(str_id);
+	return retval;
+#endif
+}
+
+
+int sst_set_pmic_config(int str_id, struct snd_sst_pmic_config *pc)
+{
+	int retval = 0;
+	sst_dbg("stream_control for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (0 != retval)
+		return retval;
+	sst_ops->scard_ops.set_pcm_params(pc->sfreq, pc->pcm_wd_sz);
+	return retval;
+}
+
+
+int sst_create_sg_list(struct stream_info *stream,
+		struct sst_frame_info *sg_list)
+{
+	struct sst_stream_bufs *kbufs = NULL;
+	int i = 0;
+
+	list_for_each_entry(kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == false) {
+			sg_list->addr[i].addr =
+				virt_to_phys((void *)
+					kbufs->addr + kbufs->offset);
+			sst_dbg("phy addr[%d] 0x%x Size 0x%x\n", i,
+				sg_list->addr[i].addr, kbufs->size);
+			sg_list->addr[i].size = kbufs->size;
+			kbufs->in_use = true;
+			i++;
+		}
+		if (i >= MAX_NUM_SCATTER_BUFFERS)
+			break;
+	}
+
+	sg_list->num_entries = i;
+	sst_dbg("sg list entries = %d \n", sg_list->num_entries);
+	return i;
+}
+
+/**
+* sst_play_frame - Send msg for sending stream frames
+* @streamID:	ID of stream
+*
+* This function is called when codec set is sucessfull
+* it send the initial frames to SST
+*/
+int sst_play_frame(int str_id)
+{
+	int i = 0, retval = 0;
+	struct ipc_post *msg = NULL;
+	struct sst_frame_info sg_list = {0};
+	struct sst_stream_bufs *kbufs = NULL, *_kbufs;
+	struct stream_info *stream = NULL;
+
+	sst_dbg("play frame for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return retval;
+
+	stream = &sst_ops->streams[str_id];
+	if (stream->status == STREAM_UN_INIT ||
+			stream->status == STREAM_PAUSED) {
+		sst_err("stream in UNIT state\n");
+		return -EINVAL;
+	}
+	/*clear prev sent buffers*/
+	list_for_each_entry_safe(kbufs, _kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == true) {
+			list_del(&kbufs->node);
+			kfree(kbufs);
+			sst_dbg("del node \n");
+		}
+	}
+	if (list_empty(&stream->bufs)) {
+		/*no user buffer available*/
+		sst_dbg("Null buffer!!!!stream status = %d \n", stream->status);
+		stream->prev = stream->status;
+		stream->status = STREAM_INIT;
+		sst_dbg("new stream status = %d \n", stream->status);
+		if (stream->data_blk.on == true) {
+			sst_dbg("user list is empty.. wake \n");
+			/*unblock*/
+			stream->data_blk.ret_code = 0;
+			stream->data_blk.condition = true;
+			stream->data_blk.on = false;
+			wake_up(&sst_ops->wait_queue);
+		}
+#ifdef CONFIG_SST_OSPM_SUPPORT
+		sst_ospm_send_event(OSPM_EVENT_AUDIO_BUF_EMPTY);
+#endif
+		return -EINVAL;
+	}
+
+	/*create list*/
+	i = sst_create_sg_list(stream, &sg_list);
+
+	/*post msg*/
+	if (0 != sst_create_large_msg(&msg))
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header, IPC_IA_PLAY_FRAMES, 1, str_id);
+	msg->header.part.data = sizeof(u32) + sizeof(sg_list);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &sg_list, sizeof(sg_list));
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	return 0;
+
+}
+
+/**
+* sst_capture_frame - switches based on ecoded/pcm capture for sending stream frames
+* @streamID:	ID of stream
+*
+* This function is called when frames to SST are sent for capture
+*/
+int sst_capture_frame(int str_id)
+{
+	int i = 0, retval = 0;
+	struct ipc_post *msg = NULL;
+	struct sst_frame_info sg_list = {0};
+	struct sst_stream_bufs *kbufs = NULL, *_kbufs;
+	struct stream_info *stream = NULL;
+
+
+	sst_dbg("capture frame for %d\n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return retval;
+
+	stream = &sst_ops->streams[str_id];
+	if (stream->status == STREAM_UN_INIT ||
+			stream->status == STREAM_PAUSED) {
+		sst_err("stream in UNIT state\n");
+		return -EINVAL;
+	}
+
+	/*clear prev sent buffers*/
+	list_for_each_entry_safe(kbufs, _kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == true) {
+			list_del(&kbufs->node);
+			kfree(kbufs);
+			sst_dbg("del node \n");
+		}
+	}
+
+	if (list_empty(&stream->bufs)) {
+		/*no user buffer available*/
+		sst_dbg("Null buffer!!!!stream status = %d \n", stream->status);
+		stream->prev = stream->status;
+		stream->status = STREAM_INIT;
+		sst_dbg("new stream status = %d \n", stream->status);
+		if (stream->data_blk.on == true) {
+			sst_dbg("user list is empty.. wake \n");
+			/*unblock*/
+			stream->data_blk.ret_code = 0;
+			stream->data_blk.condition = true;
+			stream->data_blk.on = false;
+			wake_up(&sst_ops->wait_queue);
+		}
+#ifdef CONFIG_SST_OSPM_SUPPORT
+		sst_ospm_send_event(OSPM_EVENT_AUDIO_BUF_FULL);
+#endif
+		return -EINVAL;
+	}
+
+	/*create new sg list*/
+	i = sst_create_sg_list(stream, &sg_list);
+
+	/*post msg*/
+	if (0 != sst_create_large_msg(&msg))
+		return -ENOMEM;
+
+	sst_fill_header(&msg->header, IPC_IA_CAPT_FRAMES, 1, str_id);
+	msg->header.part.data = sizeof(u32) + sizeof(sg_list);
+	memcpy(msg->mailbox_data, &msg->header, sizeof(u32));
+	memcpy(msg->mailbox_data + sizeof(u32), &sg_list, sizeof(sg_list));
+	list_add_tail(&msg->node, &sst_ops->ipc_dispatch_list);
+	sst_post_message(&sst_ops->ipc_post_msg_wq);
+	return 0;
+}
-- 
1.5.4.5
