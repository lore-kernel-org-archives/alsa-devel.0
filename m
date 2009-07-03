From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 5/13] Intel SST driver interface module
Date: Fri,  3 Jul 2009 12:33:58 +0530
Message-ID: <1246604638-12896-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C4BD02476D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:54:57 +0200 (CEST)
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

This patch adds the SST driver interface modules. Interface
module is the one which talks to other layers of SST drivers.
intel_sst_interface.c - This file implements the MAD driver
registration and de registration functions. SST driver is also
a character driver that allows players/middleware to communicate
with SST driver. All char driver routines are implemented here.
The ioctls used by middleware to open/close, control and
configure stream and transfer the data are implemented here

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: R Dharageswari <dharageswari.r@intel.com>

	new file:   sound/pci/sst/intel_sst_interface.c
---
 sound/pci/sst/intel_sst_interface.c | 1359 +++++++++++++++++++++++++++++++++++
 1 files changed, 1359 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intel_sst_interface.c

diff --git a/sound/pci/sst/intel_sst_interface.c b/sound/pci/sst/intel_sst_interface.c
new file mode 100644
index 0000000..f8cefa5
--- /dev/null
+++ b/sound/pci/sst/intel_sst_interface.c
@@ -0,0 +1,1359 @@
+/*
+ *  intel_sst_interface.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-09 	Intel Corporation
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *  		Harsha Priya <priya.harsha@intel.com>
+ *  		R Dharageswari <dharageswari.r@intel.com>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	and middleware.
+ *  Upper layer interfaces (MAD driver, MMF) to SST driver
+ */
+
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/fcntl.h>
+#include <linux/uaccess.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/workqueue.h>
+#include <linux/pci.h>
+#include <linux/firmware.h>
+#include <asm/div64.h>
+#include <linux/ioctl.h>
+#include <sound/intel_sst.h>
+#include <sound/intel_sst_ioctl.h>
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+#include "intel_sst_pvt.h"
+#ifdef CONFIG_SST_OSPM_SUPPORT
+#include <linux/intel_mid.h>
+#endif
+
+
+int sst_download_fw(void)
+{
+	int retval = 0;
+	const struct firmware *fw_sst;
+
+	sst_dbg("SST Downloading FW now...\n");
+	retval = request_firmware(&fw_sst,
+				SST_FW_STD_FILENAME,
+				&sst_ops->pci->dev);
+	if (0 != retval) {
+		sst_err("fw load failed %d \n", retval);
+		return retval;
+	}
+	sst_ops->alloc_block[0].sst_id = 0xFF;
+	sst_load_fw(fw_sst, NULL);
+	retval = sst_wait_timeout(sst_ops, &sst_ops->alloc_block[0]);
+	release_firmware(fw_sst);
+	sst_ops->alloc_block[0].sst_id = BLOCK_UNINIT;
+	return retval;
+}
+
+/**
+* intel_sst_open - opens a handle to driver
+* @i_node:	inode structure
+* @file_ptr:pointer to file
+*
+* This function is called by OS when a user space component
+* tries to get a driver handle. Only one handle at a time
+* will be allowed
+*/
+int intel_sst_open(struct inode *i_node, struct file *file_ptr)
+{
+	dev_t device = i_node->i_rdev;
+	unsigned int retval = 0;
+	struct ioctl_pvt_data *data = NULL;
+
+	if (sst_ops->pmic_state != PMIC_SND_INIT_DONE) {
+		sst_err("Sound card not availble \n");
+		return -EIO;
+	}
+
+	if (SST_UN_INIT == sst_ops->sst_state) {
+		/*FW is not downloaded*/
+		retval = sst_download_fw();
+		if (retval != 0) {
+			sst_err("FW download failed...abort\n");
+			return -ENODEV;
+		}
+	}
+	if (device == MKDEV(INTEL_SST_MAJOR, 0)) {
+		/*app open*/
+		if (sst_ops->active_cnt < MAX_ENC_STREAM) {
+			data = kzalloc(sizeof(*data), GFP_KERNEL);
+			if (NULL == data)
+				return -ENOMEM;
+			sst_ops->active_cnt++;
+			sst_ops->stream_cnt++;
+			data->pvt_id = sst_assign_pvt_id(sst_ops);
+			data->str_id = 0;
+			file_ptr->private_data = (void *)data;
+			sst_dbg("sst id allocated = %d!\n", data->pvt_id);
+		} else
+			retval = -EACCES;
+	} else if (device == MKDEV(INTEL_SST_MAJOR, 1)) {
+		/*audio manager open*/
+		if (sst_ops->am_cnt < MAX_AM_HANDLES) {
+			sst_ops->am_cnt++;
+			sst_dbg("AM handle opened...\n");
+		} else
+			retval = -EACCES;
+	} else
+		retval = -EINVAL;
+	return retval;
+}
+
+/**
+* intel_sst_release - releases a handle to driver
+* @i_node:	inode structure
+* @file_ptr:	pointer to file
+*
+* This function is called by OS when a user space component
+* tries to release a driver handle.
+*/
+int intel_sst_release(struct inode *i_node, struct file *file_ptr)
+{
+	dev_t device = i_node->i_rdev;
+	struct ioctl_pvt_data *data =
+			(struct ioctl_pvt_data *)file_ptr->private_data;
+
+	sst_dbg("Release called \n");
+	if (device == MKDEV(INTEL_SST_MAJOR, 0)) {
+		/*app close*/
+		sst_dbg("Closing app handle \n");
+		sst_ops->active_cnt--;
+		sst_ops->stream_cnt--;
+		if (0 != sst_free_stream(data->str_id)) {
+			if (sst_validate_strid(data->str_id) == 0)
+				sst_clean_stream(
+					&sst_ops->streams[data->str_id]);
+		}
+		kfree(data);
+	} else if (device == MKDEV(INTEL_SST_MAJOR, 1))
+		/*audio manager close*/
+		sst_dbg("AM handle closed \n");
+		sst_ops->am_cnt--;
+	return 0;
+}
+
+int intel_sst_mmap(struct file *file_ptr, struct vm_area_struct *vma)
+{
+	int retval = 0, length = 0;
+	struct ioctl_pvt_data *data =
+		(struct ioctl_pvt_data *)file_ptr->private_data;
+	int str_id = data->str_id;
+	void *mem_area = NULL;
+
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return -EINVAL;
+
+	length = vma->vm_end - vma->vm_start;
+	sst_dbg("called for stream %d length 0x%x\n", str_id, length);
+
+	if (length > sst_ops->mmap_len)
+		return -ENOMEM;
+	if (sst_ops->mmap_mem == NULL)
+		return -EIO;
+
+	/* round it up to the page bondary */
+	mem_area = (void *)((((unsigned long)sst_ops->mmap_mem) + PAGE_SIZE - 1)
+			& PAGE_MASK);
+
+	/* map the whole physically contiguous area in one piece */
+	retval = remap_pfn_range(vma,
+			vma->vm_start,
+			virt_to_phys((void *)mem_area) >> PAGE_SHIFT,
+			length,
+			vma->vm_page_prot);
+	if (retval != 0) {
+		sst_ops->streams[str_id].mmapped = false;
+		sst_err("mapping failed %d", retval);
+	} else
+		sst_ops->streams[str_id].mmapped = true;
+
+	sst_dbg("mmap ret 0x%x \n", retval);
+	return retval;
+}
+/**
+* intel_sst_write- send data to play out
+*/
+int intel_sst_mmap_play_capture(u32 str_id, struct snd_sst_buffs *mmap_buf)
+{
+	struct sst_stream_bufs *bufs = NULL;
+	int retval = 0, i;
+	struct stream_info *stream = NULL;
+	struct snd_sst_buff_entry *buf_entry = NULL;
+
+	sst_dbg("called for str_id %d \n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0) {
+		sst_err("val failed %d", retval);
+		return -EINVAL;
+	}
+	BUG_ON(!mmap_buf);
+
+	stream = &sst_ops->streams[str_id];
+	if (stream->mmapped != true) {
+		sst_err("stream not mapped!!!");
+		return -EIO;
+	}
+
+	if (stream->status != STREAM_RUNNING &&
+			stream->status != STREAM_INIT) {
+		sst_err("BAD REQUEST!, stream state is %d\n", stream->status);
+		return -EBADRQC;
+	}
+
+	sst_dbg("new buffers count %d status %d\n",
+			mmap_buf->entries, stream->status);
+	buf_entry = mmap_buf->buff;
+	for (i = 0; i < mmap_buf->entries; i++) {
+		BUG_ON(!buf_entry);
+		bufs = kzalloc(sizeof(*bufs), GFP_KERNEL);
+		if (bufs == NULL)
+			return -ENOMEM;
+		bufs->size = buf_entry->size;
+		bufs->offset = buf_entry->buffer.offset;
+		bufs->addr = sst_ops->mmap_mem;
+		bufs->in_use = false;
+		buf_entry++;
+		/*locking here*/
+		mutex_lock(&stream->lock);
+		list_add_tail(&bufs->node, &stream->bufs);
+		mutex_unlock(&stream->lock);
+	}
+
+	mutex_lock(&stream->lock);
+	stream->data_blk.condition = false;
+	stream->data_blk.ret_code = 0;
+	if (stream->status == STREAM_INIT && stream->prev != STREAM_UN_INIT) {
+		stream->prev = stream->status;
+		stream->status = STREAM_RUNNING;
+		if (stream->ops == STREAM_OPS_PLAYBACK) {
+			sst_dbg("play frames...\n");
+			if (sst_play_frame(str_id) < 0) {
+				sst_err("play frames failed \n");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		} else if (stream->ops == STREAM_OPS_CAPTURE) {
+			sst_dbg("capture frames...\n");
+			if (sst_capture_frame(str_id) < 0) {
+				sst_err("capture frames failed \n");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		}
+	}
+	mutex_unlock(&stream->lock);
+	/*Block the call for reply*/
+	if (0 == list_empty(&stream->bufs)) {
+		sst_dbg("ioctl waiting...\n");
+		stream->data_blk.on = true;
+		retval = sst_wait_interruptible(sst_ops, &stream->data_blk);
+	}
+
+	sst_dbg("end of play/rec ioctl!!\n");
+	return retval;
+}
+
+int sst_play_capture(struct stream_info *stream, int str_id)
+{
+	int retval;
+
+	stream->data_blk.condition = false;
+	stream->data_blk.ret_code = 0;
+	mutex_lock(&stream->lock);
+	if (stream->status == STREAM_INIT && stream->prev != STREAM_UN_INIT) {
+		/*stream is started*/
+		stream->prev = stream->status;
+		stream->status = STREAM_RUNNING;
+	}
+
+	if (stream->status == STREAM_INIT && stream->prev == STREAM_UN_INIT) {
+		/*stream is not started yet*/
+		sst_err("Stream isnt started yet state %d, prev %d \n",
+			stream->status, stream->prev);
+	} else if (stream->status == STREAM_RUNNING) {
+		/*stream is started*/
+		if (stream->ops == STREAM_OPS_PLAYBACK) {
+			if (sst_play_frame(str_id) < 0) {
+				sst_err("play frames failed \n");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		} else if (stream->ops == STREAM_OPS_CAPTURE) {
+			if (sst_capture_frame(str_id) < 0) {
+				sst_err("capture frames failed \n");
+				mutex_unlock(&stream->lock);
+				return -EIO;
+			}
+		}
+	} else
+		sst_err("Stream state %d invalid will still block, prev %d\n",
+			stream->status, stream->prev);
+	mutex_unlock(&stream->lock);
+	/*Block the call for reply*/
+	sst_dbg("write waiting...\n");
+	stream->data_blk.on = true;
+	retval = sst_wait_interruptible(sst_ops, &stream->data_blk);
+	if (retval != 0) {
+		stream->status = STREAM_INIT;
+		sst_dbg("wait returned error...\n");
+	}
+	return retval;
+}
+
+int snd_sst_fill_kernel_list(struct stream_info *stream,
+			const struct iovec *iovec, unsigned long nr_segs,
+			struct list_head *copy_to_list)
+{
+	struct sst_stream_bufs *stream_bufs = NULL;
+	unsigned long index, data_not_copied, mmap_len;
+	unsigned char *bufp;
+	unsigned long size, copied_size;
+	int retval = 0, add_to_list = 0;
+	static int sent_offset;
+	static unsigned long sent_index;
+
+	stream_bufs = kzalloc(sizeof(*stream_bufs), GFP_KERNEL);
+	if (stream_bufs == NULL) {
+		sst_err("memory allocation failed \n");
+		return -ENOMEM;
+	}
+
+	mmap_len = sst_ops->mmap_len;
+	stream_bufs->addr = sst_ops->mmap_mem;
+	bufp = stream->cur_ptr;
+
+	sst_dbg("mmap_len - %lx\n", mmap_len);
+	copied_size = 0;
+
+	if (stream->sg_index == 0)
+		sent_index = sent_offset = 0;
+
+	for (index = stream->sg_index; index < nr_segs; index++) {
+		stream->sg_index = index;
+		sst_dbg("index - %lx, cur_ptr - %p\n", index, stream->cur_ptr);
+		sst_dbg("base - %p, size - 0x%x\n", iovec[index].iov_base,
+				iovec[index].iov_len);
+		sst_dbg("bufp - %p\n", bufp);
+		if (stream->cur_ptr == NULL)
+			bufp = iovec[index].iov_base;
+
+		size = ((unsigned long)iovec[index].iov_base
+			+ iovec[index].iov_len) - (unsigned long) bufp;
+
+		sst_dbg("size - %lx\n", size);
+		if ((copied_size + size) > mmap_len)
+			size = mmap_len - copied_size;
+
+		sst_dbg("size - %lx\n", size);
+
+		if (stream->ops == STREAM_OPS_PLAYBACK) {
+			sst_dbg("Playback stream copying now....\n");
+			data_not_copied = copy_from_user(
+				(void *)(stream_bufs->addr + copied_size),
+				bufp, size);
+			if (data_not_copied > 0) {
+				/*Clean up the list and return error code */
+				sst_err("copy from user not copied -%ld\n",
+					data_not_copied);
+				retval = -EIO;
+				break;
+			}
+		} else {
+			struct snd_sst_user_cap_list *entry =
+				kzalloc(sizeof(*entry), GFP_KERNEL);
+
+			if (entry == NULL) {
+				sst_err("mem alloacation failed \n");
+				return -ENOMEM;
+			}
+			entry->iov_index = index;
+			entry->iov_offset = (unsigned long) bufp -
+					(unsigned long)iovec[index].iov_base;
+			entry->offset = copied_size;
+			entry->size = size;
+			sst_dbg("ENTRY:ioindx %d,iooff %ld,koff %ld,ksz %ld \n",
+				entry->iov_index, entry->iov_offset,
+				entry->offset, entry->size);
+			list_add_tail(&entry->node, copy_to_list);
+		}
+
+		sst_dbg("cur_ptr - %lx\n", (unsigned long) stream->cur_ptr);
+		stream->cur_ptr = bufp + size;
+
+		if (((unsigned long)iovec[index].iov_base
+					+ iovec[index].iov_len) ==
+					(unsigned long)stream->cur_ptr) {
+			stream->cur_ptr = NULL;
+			stream->sg_index++;
+		}
+
+		copied_size += size;
+		sst_dbg("copied_size - %lx\n", copied_size);
+		if ((copied_size >= mmap_len) ||
+				(stream->sg_index == nr_segs)) {
+			add_to_list = 1;
+		}
+
+		if (add_to_list) {
+			stream_bufs->in_use = false;
+			stream_bufs->size = copied_size;
+			/*locking here*/
+			mutex_lock(&stream->lock);
+			list_add_tail(&stream_bufs->node, &stream->bufs);
+			mutex_unlock(&stream->lock);
+			break;
+		}
+	}
+	return retval;
+}
+
+int snd_sst_copy_userbuf_capture(struct stream_info *stream,
+			const struct iovec *iovec,
+			struct list_head *copy_to_list)
+{
+	struct snd_sst_user_cap_list *entry, *_entry;
+	struct sst_stream_bufs *kbufs = NULL, *_kbufs;
+	int retval = 0;
+	unsigned long data_not_copied;
+
+	/*copy sent buffers*/
+	sst_dbg("capture stream copying to user now...\n");
+	list_for_each_entry_safe(kbufs, _kbufs, &stream->bufs, node) {
+		if (kbufs->in_use == true) {
+			/*copy to user*/
+			list_for_each_entry_safe(entry, _entry,
+						copy_to_list, node) {
+				sst_dbg("filling now... \n");
+				sst_dbg("iindx %d,ioff %ld,koff %ld,ksz %ld \n",
+					entry->iov_index, entry->iov_offset,
+					entry->offset, entry->size);
+				sst_dbg("Copying at %p size %lx\n",
+					iovec[entry->iov_index].iov_base +
+						entry->iov_offset,
+					entry->size);
+				data_not_copied = copy_to_user((void *)
+					iovec[entry->iov_index].iov_base +
+						entry->iov_offset,
+					kbufs->addr + entry->offset,
+					entry->size);
+				if (data_not_copied > 0) {
+					/*Clean up the list and return error*/
+					sst_err("copy to user err -%ld\n",
+						data_not_copied);
+					retval = -EIO;
+					break;
+				}
+				list_del(&entry->node);
+				kfree(entry);
+			}
+			sst_dbg("coming out of loop\n");
+		}
+	}
+	sst_dbg("end of cap copy\n");
+	return retval;
+}
+/*
+ * snd_sst_userbufs_play_cap - constructs the list from user buffers
+ * @iovec:      pointer to iovec structure
+ * @nr_segs:    number entries in the iovec structure
+ * @str_id:	stream id
+ * @stream:   	pointer to stream_info structure
+ * This function will traverse the user list and copy the data to the kernel
+ * space buffers.
+ */
+int snd_sst_userbufs_play_cap(const struct iovec *iovec,
+			unsigned long nr_segs, unsigned int str_id,
+			struct stream_info *stream)
+{
+	int retval = 0;
+	LIST_HEAD(copy_to_list);
+
+
+	retval = snd_sst_fill_kernel_list(stream, iovec, nr_segs,
+		       &copy_to_list);
+
+	retval = sst_play_capture(stream, str_id);
+	if (retval < 0)
+		return retval;
+
+	if (stream->ops == STREAM_OPS_CAPTURE) {
+		retval = snd_sst_copy_userbuf_capture(stream, iovec,
+				&copy_to_list);
+	}
+	return retval;
+}
+
+int intel_sst_read_write(unsigned int str_id, char __user *buf, size_t count)
+{
+	int retval = 0;
+	struct stream_info *stream = NULL;
+	struct iovec iovec;
+	unsigned long nr_segs;
+
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return -EINVAL;
+	stream = &sst_ops->streams[str_id];
+	if (stream->mmapped == true) {
+		sst_err("user write & stream is mapped!!!");
+		return -EIO;
+	}
+	if (count == 0) {
+		sst_err("args invalid %d", retval);
+		return -EINVAL;
+	}
+	/*copy user buf details*/
+	if (stream->status != STREAM_RUNNING && stream->status != STREAM_INIT) {
+		sst_err("BAD REQUEST!\n");
+		return -EBADRQC;
+	}
+	sst_dbg("new buffers %p, copy size %d, status %d\n" ,
+			buf, (int) count, (int) stream->status);
+
+	stream->buf_type = SST_BUF_USER_STATIC;
+	iovec.iov_base = (void *)buf;
+	iovec.iov_len  = count;
+	nr_segs = 1;
+
+	do {
+		retval = snd_sst_userbufs_play_cap(&iovec, nr_segs,
+						str_id, stream);
+
+		if (retval < 0)
+			break;
+
+	} while (stream->sg_index < nr_segs);
+
+	stream->sg_index = 0;
+	stream->cur_ptr = NULL;
+	return retval;
+}
+
+int intel_sst_write(struct file *file_ptr, const char __user *buf,
+			size_t count, loff_t *offset)
+{
+	struct ioctl_pvt_data *data =
+			(struct ioctl_pvt_data *)file_ptr->private_data;
+	int str_id = data->str_id;
+
+	sst_dbg("called for %d\n", str_id);
+	return intel_sst_read_write(str_id, (char __user *)buf, count);
+}
+
+/*
+ *
+ *  intel_sst_aio_write- send data to play out
+ *
+ */
+ssize_t intel_sst_aio_write(struct kiocb *kiocb, const struct iovec *iov,
+			unsigned long nr_segs, loff_t  offset)
+{
+	int retval = 0;
+	struct ioctl_pvt_data *data =
+			(struct ioctl_pvt_data *)kiocb->ki_filp->private_data;
+	int str_id = data->str_id;
+	struct stream_info *stream = NULL;
+
+	sst_dbg("entry - %ld\n", nr_segs);
+
+	if (is_sync_kiocb(kiocb) == false) {
+		sst_dbg("aio_read from user space is not allowed\n");
+		return -EINVAL;
+	}
+
+	sst_dbg("called for str_id %d \n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return -EINVAL;
+	stream = &sst_ops->streams[str_id];
+	if (stream->mmapped == true) {
+		sst_err("user write & stream is mapped!!!");
+		return -EIO;
+	}
+	if (stream->status != STREAM_RUNNING && stream->status != STREAM_INIT) {
+		sst_err("BAD REQUEST!\n");
+		return -EBADRQC;
+	}
+	sst_dbg("new segs %ld, offset %d, status %d\n" ,
+			nr_segs, (int) offset, (int) stream->status);
+	stream->buf_type = SST_BUF_USER_STATIC;
+	do {
+		retval = snd_sst_userbufs_play_cap(iov, nr_segs,
+						str_id, stream);
+		if (retval < 0)
+			break;
+
+	} while (stream->sg_index < nr_segs);
+
+	stream->sg_index = 0;
+	stream->cur_ptr = NULL;
+
+	return retval;
+}
+
+/*
+* intel_sst_read- get captured data
+*/
+int intel_sst_read(struct file *file_ptr, char __user *buf,
+			size_t count, loff_t *offset)
+{
+	struct ioctl_pvt_data *data =
+			(struct ioctl_pvt_data *)file_ptr->private_data;
+	int str_id = data->str_id;
+
+	sst_dbg("called for %d\n", str_id);
+	return intel_sst_read_write(str_id, buf, count);
+}
+
+ssize_t intel_sst_aio_read(struct kiocb *kiocb, const struct iovec *iov,
+			 unsigned long nr_segs, loff_t offset)
+{
+	int retval = 0;
+	struct ioctl_pvt_data *data =
+			(struct ioctl_pvt_data *)kiocb->ki_filp->private_data;
+	int str_id = data->str_id;
+	struct stream_info *stream = NULL;
+
+	sst_dbg("entry - %ld\n", nr_segs);
+
+	if (is_sync_kiocb(kiocb) == false) {
+		sst_dbg("aio_read from user space is not allowed\n");
+		return -EINVAL;
+	}
+
+	sst_dbg("called for str_id %d \n", str_id);
+	retval = sst_validate_strid(str_id);
+	if (retval != 0)
+		return -EINVAL;
+	stream = &sst_ops->streams[str_id];
+	if (stream->mmapped == true) {
+		sst_err("user write & stream is mapped!!!");
+		return -EIO;
+	}
+	if (stream->status != STREAM_RUNNING && stream->status != STREAM_INIT) {
+		sst_err("BAD REQUEST!\n");
+		return -EBADRQC;
+	}
+	sst_dbg("new segs %ld, offset %d, status %d\n" ,
+			nr_segs, (int) offset, (int) stream->status);
+	stream->buf_type = SST_BUF_USER_STATIC;
+	do {
+		retval = snd_sst_userbufs_play_cap(iov, nr_segs,
+						str_id, stream);
+		if (retval < 0)
+			break;
+
+	} while (stream->sg_index < nr_segs);
+
+	stream->sg_index = 0;
+	stream->cur_ptr = NULL;
+
+	return retval;
+}
+
+int sst_get_stream_allocated(struct snd_sst_params *str_param,
+			u32 block, u32 pvt_id)
+{
+	int retval = 0;
+
+	retval = sst_alloc_stream((char *) &str_param->sparams, str_param->ops,
+				str_param->codec, pvt_id);
+	if (0 != retval) {
+		sst_err("sst_alloc_stream failed %d", retval);
+		goto err;
+	}
+	/*Block the call for reply*/
+	retval = sst_wait_timeout(sst_ops, &sst_ops->alloc_block[block]);
+err:	return retval;
+}
+
+void set_port_params(struct snd_sst_params *str_param,
+				enum snd_sst_stream_ops ops)
+{
+	int sfreq = str_param->sparams.uc.pcm_params.sfreq;
+	int word_size = str_param->sparams.uc.pcm_params.pcm_wd_sz;
+
+	sst_dbg("sampling frequency = %d wd_size = %d \n", sfreq, word_size);
+
+	if (ops == STREAM_OPS_PLAYBACK) {
+		sst_dbg("Setting playback path and port settings...\n");
+		sst_ops->scard_ops.init_card();
+		sst_ops->scard_ops.set_pcm_params(sfreq, word_size);
+	} else if (ops == STREAM_OPS_CAPTURE) {
+		sst_dbg("Setting capture path...\n");
+		if (sst_ops->scard_ops.init_card_capture != NULL)
+			sst_ops->scard_ops.init_card_capture();
+	}
+	return;
+}
+
+int sst_get_stream(struct snd_sst_params *str_param, u32 pvt_id)
+{
+	int i = 0, retval = 0;
+
+	/*stream is not allocated, we are allocating*/
+	i = sst_get_block_stream(sst_ops);
+	sst_dbg("alloc block allocated = %d\n", i);
+	if (i < 0)
+		return -ENOMEM;
+	sst_ops->alloc_block[i].sst_id = pvt_id;
+
+	retval = sst_get_stream_allocated(str_param, i, pvt_id);
+	if (retval == -(SST_LIB_ERR_LIB_DNLD_REQUIRED)) {
+		/*codec download is required*/
+		struct snd_sst_alloc_response *response =
+				sst_ops->alloc_block[i].ops_block.data;
+		sst_dbg("Codec is required.... trying that\n");
+		retval = sst_load_library(&response->lib_dnld,
+				str_param->ops, pvt_id);
+		kfree(response);
+
+		if (retval == 0) {
+			sst_dbg("codec was downloaded sucesfully \n");
+			sst_dbg("try alloac again\n");
+			sst_ops->alloc_block[i].ops_block.condition = false;
+
+			retval = sst_get_stream_allocated(str_param, i, pvt_id);
+
+			if (retval <= 0)
+				goto err;
+			set_port_params(str_param, str_param->ops);
+
+			sst_dbg("Allocation done stream id %d \n", retval);
+		} else {
+			sst_dbg("codec download failed \n");
+			retval = -EIO;
+			goto err;
+		}
+	} else if  (retval <= 0)
+		goto err;
+	else
+		set_port_params(str_param, str_param->ops);
+
+err:
+	sst_ops->alloc_block[i].sst_id = BLOCK_UNINIT;
+	return retval;
+}
+
+/**
+* intel_sst_ioctl - recieves the device ioctl's
+* @i_node:	inode structure
+* @file_ptr:	pointer to file
+* @cmd: 	Ioctl cmd
+* @arg:		data
+*
+* This function is called by OS when a user space component
+* sends an Ioctl to SST driver
+*/
+int intel_sst_ioctl(struct inode *i_node, struct file *file_ptr,
+				unsigned int cmd, unsigned long arg)
+{
+	int retval = 0, i = 0;
+	struct ioctl_pvt_data *data = (struct ioctl_pvt_data *)
+			file_ptr->private_data;
+	int str_id = data->str_id, minor;
+
+	dev_t device = i_node->i_rdev;
+
+	if (device == MKDEV(INTEL_SST_MAJOR, 0))
+		minor = 0;
+	else if (device == MKDEV(INTEL_SST_MAJOR, 1))
+		minor = 1;
+	else
+		return -EINVAL;
+
+	if (SST_FW_RUNNING != sst_ops->sst_state) {
+		sst_err("SST Not runng %d\n", sst_ops->sst_state);
+		return -EBUSY;
+	}
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(SNDRV_SST_STREAM_PAUSE):
+		sst_dbg("SNDRV_SST_IOCTL_PAUSE recieved for %d!\n", str_id);
+		if (minor != 0) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_pause_stream(str_id);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_RESUME):
+		sst_dbg("SNDRV_SST_IOCTL_RESUME recieved!\n");
+		if (minor != 0) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_resume_stream(str_id);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_SET_PARAMS): {
+		struct snd_sst_params *str_param = (struct snd_sst_params *)arg;
+
+		sst_dbg("IOCTL_SET_PARAMS recieved!\n");
+		if (minor != 0) {
+			retval = -EINVAL;
+			break;
+		}
+		sst_print_params(&str_param->sparams);
+
+		if (str_id == 0) {
+			retval = sst_get_stream(str_param, data->pvt_id);
+			if (retval > 0) {
+				data->str_id = retval;
+				retval = 0;
+			} else {
+				if (retval == -SST_ERR_INVALID_PARAMS)
+					retval = -EINVAL;
+			}
+		} else {
+			sst_dbg("SET_STREAM_PARAMS recieved!\n");
+			/*allocated set params only*/
+			retval = sst_set_stream_param(str_id, str_param);
+			/*Block the call for reply*/
+			if (retval == 0) {
+				int sfreq = 0, word_size = 0;
+				sfreq =	str_param->sparams.uc.pcm_params.sfreq;
+				word_size = str_param->sparams.
+						uc.pcm_params.pcm_wd_sz;
+				retval = sst_wait_timeout(sst_ops,
+					&sst_ops->alloc_block[i]);
+				sst_dbg("SST sampling frequency= %d\n" , sfreq);
+				sst_ops->scard_ops.set_pcm_params(sfreq,
+							word_size);
+			}
+		}
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_MMAP_PLAY):
+	case _IOC_NR(SNDRV_SST_MMAP_CAPTURE):
+		sst_dbg("SNDRV_SST_MMAP_PLAY/CAPTURE recieved!\n");
+		if (minor != 0) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = intel_sst_mmap_play_capture(str_id,
+				(struct snd_sst_buffs *)arg);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_DROP):
+		sst_dbg("SNDRV_SST_IOCTL_DROP recieved!\n");
+		if (minor != 0) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_drop_stream(str_id);
+		break;
+
+	case _IOC_NR(SNDRV_SST_STREAM_GET_TSTAMP): {
+		unsigned long long *ms = (unsigned long long *)arg;
+		struct snd_sst_tstamp tstamp = {0};
+		unsigned long long time = 0, freq = 0;
+		unsigned long mod = 0;
+
+		sst_dbg("SNDRV_SST_STREAM_GET_TSTAMP recieved!\n");
+		if (minor != 0) {
+			retval = -EINVAL;
+			break;
+		}
+		memcpy_fromio(&tstamp,
+			((void *)(sst_ops->mailbox + SST_TIME_STAMP)
+			+(str_id * sizeof(tstamp))),
+			sizeof(tstamp));
+		time = tstamp.samples_rendered;
+		sst_dbg("samples rendered! = 0x%llx\n", time);
+		freq = (unsigned long long) tstamp.sampling_frequency;
+		sst_dbg("freq = %llx\n", freq);
+		mod = do_div(time, freq);
+		sst_dbg("mod = 0x%lx\n", mod);
+		sst_dbg("sec = 0x%llx\n", time);
+		time = time * 1000;
+		sst_dbg("msec = 0x%llx\n", time);
+		retval = copy_to_user(ms, &time, sizeof(*ms));
+		if (retval != 0)
+			sst_err("copy failed = %d\n", retval);
+		break;
+	}
+
+	case _IOC_NR(SNDRV_SST_STREAM_START):{
+		struct stream_info *stream = NULL;
+
+		sst_dbg("SNDRV_SST_STREAM_START recieved!\n");
+		if (minor != 0) {
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_validate_strid(str_id);
+		if (retval !=  0)
+			break;
+		stream = &sst_ops->streams[str_id];
+		mutex_lock(&stream->lock);
+		if (stream->status == STREAM_INIT) {
+			sst_dbg("calling play frames...\n");
+			stream->prev = stream->status;
+			stream->status = STREAM_RUNNING;
+			if (stream->ops == STREAM_OPS_PLAYBACK) {
+				retval = sst_play_frame(str_id);
+#ifdef CONFIG_SST_OSPM_SUPPORT
+				sst_ospm_send_event(
+					OSPM_EVENT_SUBSYS_START_PLAY);
+#endif
+			} else if (stream->ops == STREAM_OPS_CAPTURE)
+				retval = sst_capture_frame(str_id);
+			else {
+				sst_err("Invalid ops 0x%x\n", stream->ops);
+				retval = -EINVAL;
+				mutex_unlock(&sst_ops->streams[str_id].lock);
+				break;
+			}
+			if (retval < 0) {
+				sst_err("play/capture frames failed \n");
+				stream->status = STREAM_INIT;
+				mutex_unlock(&sst_ops->streams[str_id].lock);
+				break;
+			}
+		} else {
+			sst_err("Invalid start for stream %d state 0x%x\n",
+					str_id, stream->status);
+			retval = -EINVAL;
+		}
+		mutex_unlock(&sst_ops->streams[str_id].lock);
+		break;
+	}
+	case _IOC_NR(SNDRV_SST_SET_TARGET_DEVICE): {
+		struct snd_sst_target_device *target_device = NULL;
+
+		sst_info("SNDRV_SST_SET_TARGET_PLAYBACK DEVICE recieved!\n");
+		target_device =	(struct snd_sst_target_device *)arg;
+		BUG_ON(!target_device);
+		if (minor != 1) {
+			sst_err("called for non AM handle minor %d\n", minor);
+			retval = -EINVAL;
+			break;
+		}
+		retval = sst_target_device_select(target_device);
+		if (0 != retval)
+			return retval;
+		break;
+
+	}
+
+	case _IOC_NR(SNDRV_SST_DRIVER_INFO): {
+		struct snd_sst_driver_info *info =
+			(struct snd_sst_driver_info *)arg;
+		sst_dbg("SNDRV_SST_DRIVER_INFO recived \n");
+		info->version = SST_VERSION_NUM;
+		/*hard coding, shud get sumhow later*/
+		info->active_pcm_streams = sst_ops->stream_cnt -
+						sst_ops->active_cnt;
+		info->active_enc_streams = sst_ops->active_cnt;
+		info->max_pcm_streams = MAX_ACTIVE_STREAM - MAX_ENC_STREAM;
+		info->max_enc_streams = MAX_ENC_STREAM;
+		info->buf_per_stream = sst_ops->mmap_len;
+		break;
+	}
+
+	default:
+		sst_dbg("IOCTL not supported yet !\n");
+		retval = -ENOTTY;
+	}
+	sst_dbg("...complete ret code = %d\n", retval);
+
+	return retval;
+}
+
+/*
+	MAD Routines
+*/
+
+/**
+* sst_control_set - Set Control params
+* @control_list:	list of controls to be set
+*
+* This function is called by MID sound card driver to set
+* SST/Sound card controls. This is registered with MID driver
+*/
+int sst_control_set(int control_element, void *value)
+{
+	int retval = 0, str_id = 0;
+
+	if (SST_UN_INIT == sst_ops->sst_state) {
+		/*FW is not downloaded*/
+		sst_dbg("DSP Downloading FW now...\n");
+		retval = sst_download_fw();
+		if (retval != 0) {
+			sst_err("FW download failed = 0x%x, abort\n", retval);
+			return retval;
+		}
+	}
+
+	switch (control_element) {
+	case SST_SND_ALLOC: {
+		struct snd_sst_params *str_param = NULL;
+		int pcm_id = sst_assign_pvt_id(sst_ops);
+
+		str_param = (struct snd_sst_params *)value;
+		BUG_ON(!str_param);
+		sst_print_params(&str_param->sparams);
+		retval = sst_get_stream(str_param, pcm_id);
+		if (retval >= 0)
+			sst_ops->stream_cnt++;
+#ifdef CONFIG_SST_OSPM_SUPPORT
+		if (str_param->ops == STREAM_OPS_PLAYBACK)
+			sst_ospm_send_event(OSPM_EVENT_SUBSYS_START_PLAY);
+#endif
+
+		break;
+	}
+
+	case SST_SND_PAUSE:
+		retval = sst_pause_stream(*(int *)value);
+		break;
+
+	case SST_SND_RESUME:
+	    retval = sst_resume_stream(*(int *)value);
+		break;
+
+	case SST_SND_DROP:
+		retval = sst_drop_stream(*(int *)value);
+		break;
+
+	case SST_SND_FREE: {
+		struct stream_info *stream = NULL;
+
+		str_id = *(int *)value;
+		stream = &sst_ops->streams[str_id];
+		retval = sst_free_stream(str_id);
+		if (retval == 0) {
+			stream->pcm_substream = NULL;
+			stream->period_elapsed = NULL;
+			sst_ops->stream_cnt--;
+		}
+		break;
+	}
+
+	case SST_SND_STREAM_INIT: {
+		struct pcm_stream_info *str_info = NULL;
+		struct stream_info *stream = NULL;
+
+		sst_dbg("stream init called\n");
+		str_info = (struct pcm_stream_info *)value;
+		str_id = str_info->str_id;
+		retval = sst_validate_strid(str_id);
+		if (retval !=  0)
+			break;
+
+		stream = &sst_ops->streams[str_id];
+		sst_dbg("setting the period ptrs\n");
+		stream->pcm_substream = str_info->mad_substream;
+		stream->period_elapsed = str_info->period_elapsed;
+		break;
+	}
+
+	case SST_SND_BUFFER_POINTER: {
+		struct pcm_stream_info *buf_ptr;
+		struct snd_sst_tstamp fw_tstamp = {0,};
+		struct stream_info *stream = NULL;
+
+		sst_dbg("buffer pointer query\n");
+
+		buf_ptr = (struct pcm_stream_info *)value;
+		str_id = buf_ptr->str_id;
+		retval = sst_validate_strid(str_id);
+		if (retval !=  0)
+			break;
+		stream = &sst_ops->streams[str_id];
+
+		if (stream->pcm_substream == NULL)
+			break;
+		memcpy_fromio(&fw_tstamp,
+			((void *)(sst_ops->mailbox + SST_TIME_STAMP)
+			+(str_id * sizeof(fw_tstamp))),
+			sizeof(fw_tstamp));
+
+		sst_dbg("strid = %d\n", str_id);
+
+		if (stream->ops == STREAM_OPS_PLAYBACK)
+			buf_ptr->buffer_ptr = fw_tstamp.samples_rendered;
+		else
+			buf_ptr->buffer_ptr = fw_tstamp.samples_processed;
+		sst_dbg("samples played = %ld\n",
+				buf_ptr->buffer_ptr);
+		break;
+	}
+
+	default:
+		/*Illegal case*/
+		sst_err("illegal req\n");
+		return -EINVAL;
+	}
+	sst_dbg("...complete ret code = %d\n", retval);
+
+	return retval;
+}
+
+
+/**
+* sst_send_data_to_HW - send data buffers
+* @buffer_data:		user buffer
+*
+* This function is called by MID sound card driver to send buffer
+* to HW. This is registered with MID driver
+*/
+int sst_send_buffer_to_HW(int str_id, struct stream_buffer *mad_buf)
+{
+	/*recvd a buffer map it to stream*/
+	/*this is a PCM stream and playback*/
+	int retval = 0;
+	bool flag_add = false;
+	struct sst_stream_bufs *sst_buf = NULL;
+	struct stream_info *stream = NULL;
+
+	if (NULL == mad_buf ||
+			0 == mad_buf->addr ||
+			0 == mad_buf->length) {
+		sst_err("Null Ptr or buf size = 0\n");
+		return -EINVAL;
+	}
+
+	if (SST_FW_RUNNING != sst_ops->sst_state) {
+		sst_err("SST Not runng: %d\n", sst_ops->sst_state);
+		return -EBUSY;
+	}
+
+	retval = sst_validate_strid(str_id);
+	if (retval < 0)
+		return -EINVAL;
+
+	stream = &sst_ops->streams[str_id];
+	sst_dbg("stream status = %d strid=%d\n", stream->status, str_id);
+	sst_dbg("stream codec = %d, prevstate=%d\n",
+			stream->codec, stream->prev);
+	if (stream->status == STREAM_UN_INIT) {
+		sst_err("BAD REQUEST!\n");
+		return -EBADRQC;
+	}
+	sst_dbg("received addr=0x%x size = 0x%x\n",
+			(unsigned int)mad_buf->addr, mad_buf->length);
+	/*list is not empty*/
+	list_for_each_entry(sst_buf, &stream->bufs, node) {
+		if (sst_buf->in_use == true)
+			continue;
+		else if ((int) mad_buf->addr !=
+				(int)sst_buf->addr + sst_buf->size)
+			continue;
+		else {
+			sst_buf->size += mad_buf->length;
+			flag_add = true;
+			sst_dbg("inc addr = 0x%p, base = 0x%x inc_val = 0x%x\n",
+				sst_buf->addr, sst_buf->size, mad_buf->length);
+			break;
+		}
+	}
+
+	if (flag_add == false) {
+		sst_buf = kzalloc(sizeof(*sst_buf), GFP_ATOMIC);
+		if (sst_buf == NULL)
+			return -ENOMEM;
+		sst_buf->size = mad_buf->length;
+		sst_buf->addr = (void *)mad_buf->addr;
+		sst_buf->offset = 0;
+		sst_buf->in_use = false;
+		list_add_tail(&sst_buf->node, &stream->bufs);
+		flag_add = true;
+		sst_dbg("entry added addr = 0x%x size = 0x%x\n",
+				(unsigned int)mad_buf->addr, mad_buf->length);
+	}
+
+	if (stream->status == STREAM_INIT) {
+		sst_dbg("play/capt frames...\n");
+		stream->prev = stream->status;
+		stream->status = STREAM_RUNNING;
+		stream->data_blk.on = false;
+		if (stream->ops == STREAM_OPS_PLAYBACK)
+			retval = sst_play_frame(str_id);
+		else if (stream->ops == STREAM_OPS_CAPTURE)
+			retval = sst_capture_frame(str_id);
+		else
+			return -EINVAL;
+		if (retval < 0) {
+			sst_err("play/capture frames failed \n");
+			return -EIO;
+		}
+	}
+
+	return retval;
+}
+
+struct intel_sst_card_ops sst_pmic_ops = {
+	.control_set = sst_control_set,
+	.send_buffer = sst_send_buffer_to_HW,
+};
+
+/**
+* register_sst_card- function for sound card to register
+*@card:     pointer to structure of operations
+* This function is called card driver loads and is ready for registration
+*/
+int register_sst_card(struct intel_sst_card_ops *card)
+{
+
+	if (NULL == card ||
+		NULL == card->module_name) {
+			sst_err(" Null Pointer Passed\n");
+			return -EINVAL;
+	}
+
+	if (PMIC_SND_UN_INIT == sst_ops->pmic_state) {
+		/*register this driver*/
+		if (0 == (strncmp(SST_CARD_NAMES, card->module_name,
+				strlen(SST_CARD_NAMES)))) {
+			sst_ops->pmic_vendor = card->vendor_id;
+			sst_ops->scard_ops =  *card->scard_ops;
+			sst_pmic_ops.module_name = card->module_name;
+			sst_ops->pmic_state = PMIC_SND_INIT_DONE;
+			card->control_set = sst_pmic_ops.control_set;
+			card->send_buffer = sst_pmic_ops.send_buffer;
+			return 0;
+		} else {
+			sst_err("strcmp failed %s \n", card->module_name);
+			return -EINVAL;
+		}
+
+	} else {
+		/*already registered a driver*/
+		sst_err("Repeat for register..denied\n");
+		return -EBADRQC;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_sst_card);
+
+/**
+* unregister_sst_card- function for sound card to un-register
+*@card:     pointer to structure of operations
+* This function is called when card driver unloads
+*/
+void unregister_sst_card(struct intel_sst_card_ops *card)
+{
+	if (sst_pmic_ops.module_name == card->module_name) {
+		/*unreg*/
+		sst_pmic_ops.module_name = "";
+		sst_ops->pmic_state = PMIC_SND_UN_INIT;
+		sst_dbg("Unregistered %s\n", card->module_name);
+	}
+	return;
+}
+EXPORT_SYMBOL_GPL(unregister_sst_card);
+
+int lpe_mask_periphral_intr(enum lpe_periphral device)
+{
+	union sst_pimr_reg pimr = {{0},};
+	if (sst_ops == NULL)
+		return -EIO;
+
+	pimr.full = readl(sst_ops->shim + SST_PIMR);
+
+	switch (device) {
+	case LPE_DMA:
+		pimr.part.dmac_sc = 1;
+		writel(pimr.full, sst_ops->shim + SST_PIMR);
+		break;
+
+	case LPE_SSP0:
+		break;
+
+	case LPE_SSP1:
+		break;
+
+	default:
+		break;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpe_mask_periphral_intr);
+
+int lpe_unmask_periphral_intr(enum lpe_periphral device)
+{
+	union sst_pimr_reg pimr = {{0},};
+	if (sst_ops == NULL)
+		return -EIO;
+
+	pimr.full = readl(sst_ops->shim + SST_PIMR);
+
+	switch (device) {
+	case LPE_DMA:
+		pimr.part.dmac_sc = 0;
+		writel(pimr.full, sst_ops->shim + SST_PIMR);
+		break;
+
+	case LPE_SSP0:
+		break;
+
+	case LPE_SSP1:
+		break;
+
+	default:
+		break;
+	}
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(lpe_unmask_periphral_intr);
+
+int lpe_periphral_intr_status(enum lpe_periphral device, int *status)
+{
+	union sst_pisr_reg pisr = {{0},};
+	if (sst_ops == NULL)
+		return -EIO;
+
+	pisr.full = readl(sst_ops->shim + SST_PISR);
+
+	switch (device) {
+	case LPE_DMA:
+		*status = pisr.part.dmac;
+		break;
+
+	case LPE_SSP0:
+		break;
+
+	case LPE_SSP1:
+		break;
+
+	default:
+		break;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpe_periphral_intr_status);
-- 
1.5.4.5
