From: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v7 06/13] slimbus: Add messaging APIs to slimbus framework
Date: Wed, 15 Nov 2017 14:10:36 +0000
Message-ID: <20171115141043.29202-7-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Slimbus devices use value-element, and information elements to
control device parameters (e.g. value element is used to represent
gain for codec, information element is used to represent interrupt
status for codec when codec interrupt fires).
Messaging APIs are used to set/get these value and information
elements. Slimbus specification uses 8-bit "transaction IDs" for
messages where a read-value is anticipated. Framework uses a table
of pointers to store those TIDs and responds back to the caller in
O(1).
Caller can do synchronous and asynchronous reads/writes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/slimbus/Makefile    |   2 +-
 drivers/slimbus/messaging.c | 415 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/slimbus/slimbus.h   |  74 ++++++++
 include/linux/slimbus.h     |  31 ++++
 4 files changed, 521 insertions(+), 1 deletion(-)
 create mode 100644 drivers/slimbus/messaging.c

diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
index 50deace4e76d..dfa049a382ef 100644
--- a/drivers/slimbus/Makefile
+++ b/drivers/slimbus/Makefile
@@ -2,4 +2,4 @@
 # Makefile for kernel slimbus framework.
 #
 obj-$(CONFIG_SLIMBUS)			+= slimbus.o
-slimbus-y				:= core.o
+slimbus-y				:= core.o messaging.o
diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
new file mode 100644
index 000000000000..ba78c1bfe15d
--- /dev/null
+++ b/drivers/slimbus/messaging.c
@@ -0,0 +1,415 @@
+/* Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/slab.h>
+#include "slimbus.h"
+
+/**
+ * slim_msg_response() - Deliver Message response received from a device to the
+ *			framework.
+ *
+ * @ctrl: Controller handle
+ * @reply: Reply received from the device
+ * @len: Length of the reply
+ * @tid: Transaction ID received with which framework can associate reply.
+ *
+ * Called by controller to inform framework about the response received.
+ * This helps in making the API asynchronous, and controller-driver doesn't need
+ * to manage 1 more table other than the one managed by framework mapping TID
+ * with buffers
+ */
+void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
+{
+	struct slim_msg_txn *txn;
+	struct slim_val_inf *msg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+	txn = idr_find(&ctrl->tid_idr, tid);
+	if (txn == NULL) {
+		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+		return;
+	}
+
+	msg = txn->msg;
+	if (msg == NULL || msg->rbuf == NULL) {
+		dev_err(ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
+				tid, len);
+		return;
+	}
+
+	idr_remove(&ctrl->tid_idr, tid);
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+
+	memcpy(msg->rbuf, reply, len);
+	if (txn->comp)
+		complete(txn->comp);
+}
+EXPORT_SYMBOL_GPL(slim_msg_response);
+
+/**
+ * slim_do_transfer() - Process a slimbus-messaging transaction
+ *
+ * @ctrl: Controller handle
+ * @txn: Transaction to be sent over SLIMbus
+ *
+ * Called by controller to transmit messaging transactions not dealing with
+ * Interface/Value elements. (e.g. transmittting a message to assign logical
+ * address to a slave device
+ *
+ * Return: -ETIMEDOUT: If transmission of this message timed out
+ *	(e.g. due to bus lines not being clocked or driven by controller)
+ *	-ENOTCONN: If the transmitted message was not ACKed by destination
+ *	device.
+ */
+int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	bool need_tid;
+	unsigned long flags;
+	int ret, tid, timeout;
+
+	need_tid = slim_tid_txn(txn->mt, txn->mc);
+
+	if (need_tid) {
+		spin_lock_irqsave(&ctrl->txn_lock, flags);
+		tid = idr_alloc(&ctrl->tid_idr, txn, 0,
+				SLIM_MAX_TIDS, GFP_KERNEL);
+		txn->tid = tid;
+
+		if (!txn->msg->comp)
+			txn->comp = &done;
+		else
+			txn->comp = txn->comp;
+
+		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+
+		if (tid < 0)
+			return tid;
+	}
+
+	ret = ctrl->xfer_msg(ctrl, txn);
+
+	if (ret && need_tid && !txn->msg->comp) {
+		unsigned long ms = txn->rl + HZ;
+
+		timeout = wait_for_completion_timeout(txn->comp,
+						      msecs_to_jiffies(ms));
+		if (!timeout) {
+			ret = -ETIMEDOUT;
+			spin_lock_irqsave(&ctrl->txn_lock, flags);
+			idr_remove(&ctrl->tid_idr, tid);
+			spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+		}
+	}
+
+	if (ret)
+		dev_err(ctrl->dev, "Tx:MT:0x%x, MC:0x%x, LA:0x%x failed:%d\n",
+			txn->mt, txn->mc, txn->la, ret);
+
+	return ret;
+}
+
+static int slim_val_inf_sanity(struct slim_controller *ctrl,
+			       struct slim_val_inf *msg, u8 mc)
+{
+	if (!msg || msg->num_bytes > 16 ||
+	    (msg->start_offset + msg->num_bytes) > 0xC00)
+		goto reterr;
+	switch (mc) {
+	case SLIM_MSG_MC_REQUEST_VALUE:
+	case SLIM_MSG_MC_REQUEST_INFORMATION:
+		if (msg->rbuf != NULL)
+			return 0;
+		break;
+	case SLIM_MSG_MC_CHANGE_VALUE:
+	case SLIM_MSG_MC_CLEAR_INFORMATION:
+		if (msg->wbuf != NULL)
+			return 0;
+		break;
+	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
+	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
+		if (msg->rbuf != NULL && msg->wbuf != NULL)
+			return 0;
+		break;
+	default:
+		break;
+	}
+reterr:
+	dev_err(ctrl->dev, "Sanity check failed:msg:offset:0x%x, mc:%d\n",
+		msg->start_offset, mc);
+	return -EINVAL;
+}
+
+static u16 slim_slicesize(int code)
+{
+	static const u8 sizetocode[16] = {
+		0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7
+	};
+
+	clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
+	return sizetocode[code - 1];
+}
+
+static int slim_xfer_msg(struct slim_controller *ctrl,
+			 struct slim_device *sbdev,
+			 struct slim_val_inf *msg, u8 mc)
+{
+	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
+	struct slim_msg_txn *txn = &txn_stack;
+	int ret;
+	u16 sl;
+
+	ret = slim_val_inf_sanity(ctrl, msg, mc);
+	if (ret)
+		return ret;
+
+	sl = slim_slicesize(msg->num_bytes);
+
+	dev_dbg(ctrl->dev, "SB xfer msg:os:%x, len:%d, MC:%x, sl:%x\n",
+		msg->start_offset, msg->num_bytes, mc, sl);
+
+	txn->ec = ((sl | (1 << 3)) | ((msg->start_offset & 0xFFF) << 4));
+
+	switch (mc) {
+	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
+	case SLIM_MSG_MC_CHANGE_VALUE:
+	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
+	case SLIM_MSG_MC_CLEAR_INFORMATION:
+		txn->rl += msg->num_bytes;
+	default:
+		break;
+	}
+
+	if (slim_tid_txn(txn->mt, txn->mc))
+		txn->rl++;
+
+	return slim_do_transfer(ctrl, txn);
+}
+
+/**
+ * slim_request_val_element() - request value element
+ *
+ * @sb: client handle requesting elemental message reads, writes.
+ * @msg: Input structure for start-offset, number of bytes to read.
+ * context: can sleep
+ *
+ * Return: -EINVAL: Invalid parameters
+ *	-ETIMEDOUT: If transmission of this message timed out (e.g. due to
+ *	 bus lines not being clocked or driven by controller)
+ *	-ENOTCONN: If the transmitted message was not ACKed by the device.
+ */
+int slim_request_val_element(struct slim_device *sb,
+				struct slim_val_inf *msg)
+{
+	struct slim_controller *ctrl = sb->ctrl;
+
+	if (!ctrl)
+		return -EINVAL;
+
+	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_VALUE);
+}
+EXPORT_SYMBOL_GPL(slim_request_val_element);
+
+/**
+ * slim_request_inf_element() - Request a info element
+ *
+ * @sb: client handle requesting elemental message reads.
+ * @msg: Input structure for start-offset, number of bytes to read
+ *	wbuf will contain information element(s) bit masks to be cleared.
+ *	rbuf will return what the information element value was
+ */
+int slim_request_inf_element(struct slim_device *sb,
+				struct slim_val_inf *msg)
+{
+	struct slim_controller *ctrl = sb->ctrl;
+
+	if (!ctrl)
+		return -EINVAL;
+
+	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_INFORMATION);
+}
+EXPORT_SYMBOL_GPL(slim_request_inf_element);
+
+/**
+ * slim_change_val_element: change a given value element
+ *
+ * @sb: client handle requesting elemental message reads, writes.
+ * @msg: Input structure for start-offset, number of bytes to write.
+ * context: can sleep
+ *
+ * Return:
+ *	-EINVAL: Invalid parameters
+ *	-ETIMEDOUT: If transmission of this message timed out (e.g. due to
+ *	 bus lines not being clocked or driven by controller)
+ *	-ENOTCONN: If the transmitted message was not ACKed by the device.
+ */
+int slim_change_val_element(struct slim_device *sb, struct slim_val_inf *msg)
+{
+	struct slim_controller *ctrl = sb->ctrl;
+
+	if (!ctrl)
+		return -EINVAL;
+
+	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_CHANGE_VALUE);
+}
+EXPORT_SYMBOL_GPL(slim_change_val_element);
+
+/**
+ * slim_clear_inf_element() - Clear info element
+ *
+ * @sb: client handle requesting elemental message reads, writes.
+ * @msg: Input structure for start-offset, number of bytes to read
+ *	wbuf will contain information element(s) bit masks to be cleared.
+ *	rbuf will return what the information element value was
+ */
+int slim_clear_inf_element(struct slim_device *sb, struct slim_val_inf *msg)
+{
+	struct slim_controller *ctrl = sb->ctrl;
+
+	if (!ctrl)
+		return -EINVAL;
+
+	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_CLEAR_INFORMATION);
+}
+EXPORT_SYMBOL_GPL(slim_clear_inf_element);
+
+/**
+ * slim_request_val_element() - change and request a given value element
+ *
+ * @sb: client handle requesting elemental message reads, writes.
+ * @msg: Input structure for start-offset, number of bytes to write.
+ * context: can sleep
+ *
+ * Return:
+ *	-EINVAL: Invalid parameters
+ *	-ETIMEDOUT: If transmission of this message timed out (e.g. due to
+ *	 bus lines not being clocked or driven by controller)
+ *	-ENOTCONN: If the transmitted message was not ACKed by the device.
+ */
+int slim_request_change_val_element(struct slim_device *sb,
+					struct slim_val_inf *msg)
+{
+	struct slim_controller *ctrl = sb->ctrl;
+
+	if (!ctrl)
+		return -EINVAL;
+
+	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_CHANGE_VALUE);
+}
+EXPORT_SYMBOL_GPL(slim_request_change_val_element);
+
+/**
+ * slim_request_clear_inf_element() - Clear and request info element
+ *
+ * @sb: client handle requesting elemental message reads, writes.
+ * @msg: Input structure for start-offset, number of bytes to read
+ *	wbuf will contain information element(s) bit masks to be cleared.
+ *	rbuf will return what the information element value was
+ */
+int slim_request_clear_inf_element(struct slim_device *sb,
+					struct slim_val_inf *msg)
+{
+	struct slim_controller *ctrl = sb->ctrl;
+
+	if (!ctrl)
+		return -EINVAL;
+
+	return slim_xfer_msg(ctrl, sb, msg,
+					SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION);
+}
+EXPORT_SYMBOL_GPL(slim_request_clear_inf_element);
+
+static void slim_fill_msg(struct slim_val_inf *msg, u32 addr,
+			 size_t count, u8 *rbuf, u8 *wbuf)
+{
+	msg->start_offset = addr;
+	msg->num_bytes = count;
+	msg->rbuf = rbuf;
+	msg->wbuf = wbuf;
+}
+
+/**
+ * slim_read() - Read slimbus value element
+ *
+ * @sdev: client handle.
+ * @addr:  address of value element to read.
+ * @count: number of bytes to read. Maximum bytes allowed are 16.
+ * @val: will return what the value element value was
+ */
+int slim_read(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
+{
+	struct slim_val_inf msg;
+	int ret;
+
+	slim_fill_msg(&msg, addr, count, val, NULL);
+
+	ret = slim_request_val_element(sdev, &msg);
+
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(slim_read);
+
+/**
+ * slim_readb() - Read byte from slimbus value element
+ *
+ * @sdev: client handle.
+ * @addr:  address in the value element to read.
+ *
+ * Return: byte value of value element.
+ */
+int slim_readb(struct slim_device *sdev, u32 addr)
+{
+	int ret;
+	u8 buf;
+
+	ret = slim_read(sdev, addr, 1, &buf);
+	if (ret < 0)
+		return ret;
+	else
+		return buf;
+}
+EXPORT_SYMBOL_GPL(slim_readb);
+
+/**
+ * slim_write() - Write slimbus value element
+ *
+ * @sdev: client handle.
+ * @addr:  address in the value element to write.
+ * @count: number of bytes to write. Maximum bytes allowed are 16.
+ * @val: value to write to value element
+ */
+int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
+{
+	struct slim_val_inf msg;
+	int ret;
+
+	slim_fill_msg(&msg, addr, count,  val, NULL);
+	ret = slim_change_val_element(sdev, &msg);
+
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(slim_write);
+
+/**
+ * slim_writeb() - Write byte to slimbus value element
+ *
+ * @sdev: client handle.
+ * @addr:  address of value element to write.
+ * @value: value to write to value element
+ */
+int slim_writeb(struct slim_device *sdev, u32 addr, u8 value)
+{
+	return slim_write(sdev, addr, 1, &value);
+}
+EXPORT_SYMBOL_GPL(slim_writeb);
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index b53319992ad4..f3ed5d4dbb0a 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -15,8 +15,31 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include <linux/completion.h>
 #include <linux/slimbus.h>
 
+/* SLIMbus message types. Related to interpretation of message code. */
+#define SLIM_MSG_MT_CORE			0x0
+
+
+/* Information Element management messages */
+#define SLIM_MSG_MC_REQUEST_INFORMATION          0x20
+#define SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION    0x21
+#define SLIM_MSG_MC_REPLY_INFORMATION            0x24
+#define SLIM_MSG_MC_CLEAR_INFORMATION            0x28
+#define SLIM_MSG_MC_REPORT_INFORMATION           0x29
+
+/* Value Element management messages */
+#define SLIM_MSG_MC_REQUEST_VALUE                0x60
+#define SLIM_MSG_MC_REQUEST_CHANGE_VALUE         0x61
+#define SLIM_MSG_MC_REPLY_VALUE                  0x64
+#define SLIM_MSG_MC_CHANGE_VALUE                 0x68
+
+/* Destination type Values */
+#define SLIM_MSG_DEST_LOGICALADDR	0
+#define SLIM_MSG_DEST_ENUMADDR		1
+#define	SLIM_MSG_DEST_BROADCAST		3
+
 /* Standard values per SLIMbus spec needed by controllers and devices */
 #define SLIM_MAX_CLK_GEAR		10
 #define SLIM_MIN_CLK_GEAR		1
@@ -24,6 +47,7 @@
 /* Manager's logical address is set to 0xFF per spec */
 #define SLIM_LA_MANAGER 0xFF
 
+#define SLIM_MAX_TIDS			256
 /**
  * struct slim_framer - Represents Slimbus framer.
  * Every controller may have multiple framers. There is 1 active framer device
@@ -44,6 +68,40 @@ struct slim_framer {
 
 #define to_slim_framer(d) container_of(d, struct slim_framer, dev)
 
+/**
+ * struct slim_msg_txn - Message to be sent by the controller.
+ *			This structure has packet header,
+ *			payload and buffer to be filled (if any)
+ * @rl: Header field. remaining length.
+ * @mt: Header field. Message type.
+ * @mc: Header field. LSB is message code for type mt.
+ * @dt: Header field. Destination type.
+ * @ec: Element code. Used for elemental access APIs.
+ * @len: Length of payload. (excludes ec)
+ * @tid: Transaction ID. Used for messages expecting response.
+ *	(relevant for message-codes involving read operation)
+ * @la: Logical address of the device this message is going to.
+ *	(Not used when destination type is broadcast.)
+ * @msg: Elemental access message to be read/written
+ * @comp: completion if read/write is synchronous, used internally
+ *	for tid based transactions.
+ */
+struct slim_msg_txn {
+	u8			rl;
+	u8			mt;
+	u8			mc;
+	u8			dt;
+	u16			ec;
+	u8			tid;
+	u8			la;
+	struct slim_val_inf	*msg;
+	struct	completion	*comp;
+};
+
+/* Frequently used message transaction structures */
+#define DEFINE_SLIM_LDEST_TXN(name, mc, rl, la, msg) \
+	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_LOGICALADDR, 0,\
+					0, la, msg, }
 /**
  * struct slim_controller  - Controls every instance of SLIMbus
  *				(similar to 'master' on SPI)
@@ -60,6 +118,9 @@ struct slim_framer {
  * @devices: Slim device list
  * @tid_idr: tid id allocator
  * @txn_lock: Lock to protect table of transactions
+ * @xfer_msg: Transfer a message on this controller (this can be a broadcast
+ *	control/status message like data channel setup, or a unicast message
+ *	like value element read/write.
  * @set_laddr: Setup logical address at laddr for the slave with elemental
  *	address e_addr. Drivers implementing controller will be expected to
  *	send unicast message to this device with its logical address.
@@ -101,6 +162,8 @@ struct slim_controller {
 	struct list_head	devices;
 	struct idr		tid_idr;
 	spinlock_t		txn_lock;
+	int			(*xfer_msg)(struct slim_controller *ctrl,
+					    struct slim_msg_txn *tx);
 	int			(*set_laddr)(struct slim_controller *ctrl,
 					     struct slim_eaddr *ea, u8 laddr);
 	int			(*get_laddr)(struct slim_controller *ctrl,
@@ -112,5 +175,16 @@ int slim_device_report_present(struct slim_controller *ctrl,
 void slim_report_absent(struct slim_device *sbdev);
 int slim_register_controller(struct slim_controller *ctrl);
 int slim_unregister_controller(struct slim_controller *ctrl);
+void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 l);
+int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn);
+
+static inline bool slim_tid_txn(u8 mt, u8 mc)
+{
+	return (mt == SLIM_MSG_MT_CORE &&
+		(mc == SLIM_MSG_MC_REQUEST_INFORMATION ||
+		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION ||
+		 mc == SLIM_MSG_MC_REQUEST_VALUE ||
+		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
+}
 
 #endif /* _LINUX_SLIMBUS_H */
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index ba3fdf1f5176..42b2a8561a45 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -14,6 +14,7 @@
 #define _LINUX_SLIMBUS_H
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/completion.h>
 #include <linux/mod_devicetable.h>
 
 /**
@@ -100,6 +101,23 @@ struct slim_driver {
 };
 #define to_slim_driver(d) container_of(d, struct slim_driver, driver)
 
+/**
+ * struct slim_val_inf - Slimbus value or information element
+ * @start_offset: Specifies starting offset in information/value element map
+ * @num_bytes: upto 16. This ensures that the message will fit the slicesize
+ *		per slimbus spec
+ * @comp: completion for asynchronous operations, valid only if TID is
+ *	  required for transaction, like REQUEST operations.
+ *	  Rest of the transactions are synchronous anyway.
+ */
+struct slim_val_inf {
+	u16			start_offset;
+	u8			num_bytes;
+	u8			*rbuf;
+	const u8		*wbuf;
+	struct	completion	*comp;
+};
+
 /*
  * use a macro to avoid include chaining to get THIS_MODULE
  */
@@ -133,4 +151,17 @@ static inline void slim_set_devicedata(struct slim_device *dev, void *data)
 struct slim_device *slim_get_device(struct slim_controller *ctrl,
 				    struct slim_eaddr *e_addr);
 int slim_get_logical_addr(struct slim_device *sbdev, u8 *laddr);
+
+int slim_request_val_element(struct slim_device *sb, struct slim_val_inf *msg);
+int slim_request_inf_element(struct slim_device *sb, struct slim_val_inf *msg);
+int slim_change_val_element(struct slim_device *sb, struct slim_val_inf *msg);
+int slim_clear_inf_element(struct slim_device *sb, struct slim_val_inf *msg);
+int slim_request_change_val_element(struct slim_device *sb,
+				    struct slim_val_inf *msg);
+int slim_request_clear_inf_element(struct slim_device *sb,
+				   struct slim_val_inf *msg);
+int slim_readb(struct slim_device *sdev, u32 addr);
+int slim_writeb(struct slim_device *sdev, u32 addr, u8 value);
+int slim_read(struct slim_device *sdev, u32 addr, size_t count, u8 *val);
+int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val);
 #endif /* _LINUX_SLIMBUS_H */
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
