From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/13] libhinawa: add 'fw_req' object as requester for
	FireWire transaction
Date: Sun, 25 Jan 2015 20:34:28 +0900
Message-ID: <1422185674-16431-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Each applications are allows to transfer requests to units on IEEE 1394
bus to control the units. The request transaction is defined in IEEE 1212.
There are three types of the transaction; read, write and lock.

Linux FireWire subsystem gives a way to perform this. Applications can
start the three types of transaction by ioctl(2), then receive the result
by read(2).

This commit adds HINAWA_TYPE_FW_REQ object for this purpose. When
constructing the instance, applications can transact by read()/write()/lock()
method. These methods are programmed with threading. When the instance
cannot read the result within timeout, these methods sets ETIMEDOUT to
GError and returns. Currently, the timeout is 10 milli-seconds.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/doc/reference/hinawa-docs.sgml |   1 +
 libhinawa/src/Makefile.am                |   7 +-
 libhinawa/src/fw_req.c                   | 265 +++++++++++++++++++++++++++++++
 libhinawa/src/fw_req.h                   |  56 +++++++
 libhinawa/src/fw_unit.c                  |   4 +
 libhinawa/src/internal.h                 |   3 +
 6 files changed, 334 insertions(+), 2 deletions(-)
 create mode 100644 libhinawa/src/fw_req.c
 create mode 100644 libhinawa/src/fw_req.h

diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
index 419e431..ff00ecc 100644
--- a/libhinawa/doc/reference/hinawa-docs.sgml
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -32,6 +32,7 @@
             </para>
             <xi:include href="xml/fw_unit.xml"/>
             <xi:include href="xml/fw_resp.xml"/>
+            <xi:include href="xml/fw_req.xml"/>
         </chapter>
     </part>
 
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index 7c09088..91726b8 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -27,12 +27,15 @@ libhinawa_la_SOURCES =				\
 	fw_unit.h				\
 	fw_unit.c				\
 	fw_resp.h				\
-	fw_resp.c
+	fw_resp.c				\
+	fw_req.h				\
+	fw_req.c
 
 pkginclude_HEADERS =				\
 	hinawa_sigs_marshal.h			\
 	fw_unit.h				\
-	fw_resp.h
+	fw_resp.h				\
+	fw_req.h
 
 hinawa_sigs_marshal.list:
 	$(AM_V_GEN)( find | grep \.c$$ | xargs cat | 			\
diff --git a/libhinawa/src/fw_req.c b/libhinawa/src/fw_req.c
new file mode 100644
index 0000000..49f78cc
--- /dev/null
+++ b/libhinawa/src/fw_req.c
@@ -0,0 +1,265 @@
+#include <sys/ioctl.h>
+#include "fw_req.h"
+#include "internal.h"
+
+#ifdef HAVE_CONFIG_H
+#  include <config.h>
+#endif
+
+/**
+ * SECTION:fw_req
+ * @Title: HinawaFwReq
+ * @Short_description: A transaction executor to a FireWire unit
+ *
+ * A HinawaFwReq supports three types of transactions in IEEE 1212:
+ *  - read
+ *  - write
+ *  - lock
+ *
+ * Any of transaction frames should be aligned to 32bit (quadlet).
+ * This class is an application of Linux FireWire subsystem. All of operations
+ * utilize ioctl(2) with subsystem specific request commands.
+ */
+
+enum fw_req_type {
+	FW_REQ_TYPE_WRITE = 0,
+	FW_REQ_TYPE_READ,
+	FW_REQ_TYPE_COMPARE_SWAP,
+};
+
+/* NOTE: This object has no properties and no signals. */
+struct _HinawaFwReqPrivate {
+	GArray *frame;
+
+	GCond cond;
+};
+G_DEFINE_TYPE_WITH_PRIVATE(HinawaFwReq, hinawa_fw_req, G_TYPE_OBJECT)
+#define FW_REQ_GET_PRIVATE(obj)						\
+	(G_TYPE_INSTANCE_GET_PRIVATE((obj),				\
+				     HINAWA_TYPE_FW_REQ, HinawaFwReqPrivate))
+
+static void fw_req_dispose(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_fw_req_parent_class)->dispose(gobject);
+}
+
+static void fw_req_finalize(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_fw_req_parent_class)->finalize(gobject);
+}
+
+static void hinawa_fw_req_class_init(HinawaFwReqClass *klass)
+{
+	GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
+
+	gobject_class->get_property = NULL;
+	gobject_class->set_property = NULL;
+	gobject_class->dispose = fw_req_dispose;
+	gobject_class->finalize = fw_req_finalize;
+}
+
+static void hinawa_fw_req_init(HinawaFwReq *self)
+{
+	self->priv = hinawa_fw_req_get_instance_private(self);
+}
+
+static void fw_req_transact(HinawaFwReq *self, HinawaFwUnit *unit,
+			    enum fw_req_type type, guint64 addr, GArray *frame,
+			    gint *err)
+{
+	struct fw_cdev_send_request req = {0};
+	HinawaFwReqPrivate *priv = FW_REQ_GET_PRIVATE(self);
+	int tcode;
+
+	guint64 generation;
+
+	guint64 expiration;
+	GMutex lock;
+
+	guint32 *buf;
+	int i;
+
+	/* From host order to be32. */
+	if (frame != NULL) {
+		buf = (guint32 *)frame->data;
+		for (i = 0; i < frame->len; i++)
+			buf[i] = htobe32(buf[i]);
+	}
+
+	/* Setup a private structure. */
+	if (type == FW_REQ_TYPE_READ) {
+		priv->frame = frame;
+		req.data = (guint64)NULL;
+		if (frame->len == 1)
+			tcode = TCODE_READ_QUADLET_REQUEST;
+		else
+			tcode = TCODE_READ_BLOCK_REQUEST;
+	} else if (type == FW_REQ_TYPE_WRITE) {
+		priv->frame = NULL;
+		req.data = (guint64)frame->data;
+		if (frame->len == 1)
+			tcode = TCODE_WRITE_QUADLET_REQUEST;
+		else
+			tcode = TCODE_WRITE_BLOCK_REQUEST;
+	} else if ((type == FW_REQ_TYPE_COMPARE_SWAP) &&
+		   ((frame->len == 2) || (frame->len == 4))) {
+			priv->frame = NULL;
+			req.data = (guint64)frame->data;
+			tcode = TCODE_LOCK_COMPARE_SWAP;
+	} else {
+		*err = EINVAL;
+		return;
+	}
+
+	/* Get unit properties. */
+	g_object_get(G_OBJECT(unit), "generation", &generation, NULL);
+
+	/* Setup a transaction structure. */
+	req.tcode = tcode;
+	req.length = frame->len * sizeof(guint32);
+	req.offset = addr;
+	req.closure = (guint64)self;
+	req.generation = generation;
+
+	/* NOTE: Timeout is 10 milli-seconds. */
+	expiration = g_get_monotonic_time() + 10 * G_TIME_SPAN_MILLISECOND;
+	g_cond_init(&priv->cond);
+	g_mutex_init(&lock);
+
+	/* Send this transaction. */
+	hinawa_fw_unit_ioctl(unit, FW_CDEV_IOC_SEND_REQUEST, &req, err);
+	/* Wait for a response with timeout, waken by a response handler. */
+	if (*err == 0) {
+		g_mutex_lock(&lock);
+		if (!g_cond_wait_until(&priv->cond, &lock, expiration))
+			*err = ETIMEDOUT;
+		else
+			*err = 0;
+		g_mutex_unlock(&lock);
+	}
+
+	/* From be32 to host order. */
+	if (frame != NULL) {
+		buf = (guint32 *)frame->data;
+		for (i = 0; i < frame->len; i++)
+			buf[i] = be32toh(buf[i]);
+	}
+
+	g_mutex_clear(&lock);
+	g_cond_clear(&priv->cond);
+}
+
+/**
+ * hinawa_fw_req_write:
+ * @self: A #HinawaFwReq
+ * @unit: A #HinawaFwUnit
+ * @addr: A destination address of target device
+ * @frame: (element-type guint32) (array) (in): a 32bit array
+ * @exception: A #GError
+ *
+ * Execute write transactions to the given unit.
+ */
+void hinawa_fw_req_write(HinawaFwReq *self, HinawaFwUnit *unit, guint64 addr,
+			 GArray *frame, GError **exception)
+{
+	int err;
+
+	g_return_if_fail(HINAWA_IS_FW_REQ(self));
+
+	if (frame == NULL || g_array_get_element_size(frame) != 4) {
+		err = EINVAL;
+	} else {
+		g_object_ref(unit);
+		fw_req_transact(self, unit,
+				FW_REQ_TYPE_WRITE, addr, frame, &err);
+		g_object_unref(unit);
+	}
+
+	if (err != 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    err, "%s", strerror(err));
+}
+
+/**
+ * hinawa_fw_req_read:
+ * @self: A #HinawaFwReq
+ * @unit: A #HinawaFwUnit
+ * @addr: A destination address of target device
+ * @frame: (element-type guint32) (array) (out caller-allocates): a 32bit array
+ * @len: the bytes to read
+ * @exception: A #GError
+ *
+ * Execute read transaction to the given unit.
+ */
+void hinawa_fw_req_read(HinawaFwReq *self, HinawaFwUnit *unit, guint64 addr,
+			GArray *frame, guint len, GError **exception)
+{
+	int err;
+
+	g_return_if_fail(HINAWA_IS_FW_REQ(self));
+
+	if (frame == NULL || g_array_get_element_size(frame) != 4) {
+		err = EINVAL;
+	} else {
+		g_object_ref(unit);
+		g_array_set_size(frame, len);
+		fw_req_transact(self, unit,
+				FW_REQ_TYPE_READ, addr, frame, &err);
+		g_object_unref(unit);
+	}
+
+	if (err != 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    err, "%s", strerror(err));
+}
+
+/**
+ * hinawa_fw_req_lock:
+ * @self: A #HinawaFwReq
+ * @unit: A #HinawaFwUnit
+ * @addr: A destination address of target device
+ * @frame: (element-type guint32) (array) (inout): a 32bit array
+ * @exception: A #GError
+ *
+ * Execute lock transaction to the given unit.
+ */
+void hinawa_fw_req_lock(HinawaFwReq *self, HinawaFwUnit *unit,
+			guint64 addr, GArray *frame,  GError **exception)
+{
+	int err;
+
+	g_return_if_fail(HINAWA_IS_FW_REQ(self));
+
+	if (frame == NULL || g_array_get_element_size(frame) != 4) {
+		err = EINVAL;
+	} else {
+		g_object_ref(unit);
+		fw_req_transact(self, unit,
+				FW_REQ_TYPE_COMPARE_SWAP, addr, frame, &err);
+		g_object_unref(unit);
+	}
+
+	if (err != 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    err, "%s", strerror(err));
+}
+
+/* NOTE: For HinawaFwUnit, internal. */
+void hinawa_fw_req_handle_response(HinawaFwReq *self,
+				   struct fw_cdev_event_response *event)
+{
+	HinawaFwReqPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_FW_REQ(self));
+	priv = FW_REQ_GET_PRIVATE(self);
+
+	/* Copy transaction frame. */
+	if (priv->frame != NULL) {
+		priv->frame->len = 0;
+		g_array_append_vals(priv->frame, event->data,
+			event->length / g_array_get_element_size(priv->frame));
+	}
+
+	/* Waken a thread of an user application. */
+	g_cond_signal(&priv->cond);
+}
diff --git a/libhinawa/src/fw_req.h b/libhinawa/src/fw_req.h
new file mode 100644
index 0000000..057a3d5
--- /dev/null
+++ b/libhinawa/src/fw_req.h
@@ -0,0 +1,56 @@
+#ifndef __ALSA_TOOLS_HINAWA_FW_REQ_H__
+#define __ALSA_TOOLS_HINAWA_FW_REQ_H__
+
+#include <glib.h>
+#include <glib-object.h>
+#include "fw_unit.h"
+
+G_BEGIN_DECLS
+
+#define HINAWA_TYPE_FW_REQ	(hinawa_fw_req_get_type())
+
+#define HINAWA_FW_REQ(obj)					\
+	(G_TYPE_CHECK_INSTANCE_CAST((obj),			\
+				    HINAWA_TYPE_FW_REQ,		\
+				    HinawaFwReq))
+#define HINAWA_IS_FW_REQ(obj)					\
+	(G_TYPE_CHECK_INSTANCE_TYPE((obj),			\
+				    HINAWA_TYPE_FW_REQ))
+
+#define HINAWA_FW_REQ_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_CAST((klass),			\
+				 HINAWA_TYPE_FW_REQ,		\
+				 HinawaFwReq))
+#define HINAWA_IS_FW_REQ_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_TYPE((klass),			\
+				 HINAWA_TYPE_Seq))
+#define HINAWA_FW_REQ_GET_CLASS(obj)				\
+	(G_TYPE_INSTANCE_GET_CLASS((obj),			\
+				   HINAWA_TYPE_FW_REQ,		\
+				   HinawaFwReq))
+
+typedef struct _HinawaFwReq		HinawaFwReq;
+typedef struct _HinawaFwReqClass	HinawaFwReqClass;
+typedef struct _HinawaFwReqPrivate	HinawaFwReqPrivate;
+
+struct _HinawaFwReq {
+	GObject parent_instance;
+
+	HinawaFwReqPrivate *priv;
+};
+
+struct _HinawaFwReqClass {
+	GObjectClass parent_class;
+};
+
+GType hinawa_fw_req_get_type(void) G_GNUC_CONST;
+
+void hinawa_fw_req_write(HinawaFwReq *self, HinawaFwUnit *unit, guint64 addr,
+			 GArray *frame, GError **exception);
+
+void hinawa_fw_req_read(HinawaFwReq *self, HinawaFwUnit *unit, guint64 addr,
+			GArray *frame, guint len, GError **exception);
+
+void hinawa_fw_req_lock(HinawaFwReq *self, HinawaFwUnit *unit,
+			guint64 addr, GArray *frame, GError **exception);
+#endif
diff --git a/libhinawa/src/fw_unit.c b/libhinawa/src/fw_unit.c
index 019105d..65f37cd 100644
--- a/libhinawa/src/fw_unit.c
+++ b/libhinawa/src/fw_unit.c
@@ -239,6 +239,10 @@ static gboolean check_src(GSource *gsrc)
 		 common->type == FW_CDEV_EVENT_REQUEST2)
 		hinawa_fw_resp_handle_request(HINAWA_FW_RESP(common->closure),
 				(struct fw_cdev_event_request2 *)common);
+	else if (HINAWA_IS_FW_REQ(common->closure) &&
+		 common->type == FW_CDEV_EVENT_RESPONSE)
+		hinawa_fw_req_handle_response(HINAWA_FW_REQ(common->closure),
+				(struct fw_cdev_event_response *)common);
 end:
 	/* Don't go to dispatch, then continue to process this source. */
 	return FALSE;
diff --git a/libhinawa/src/internal.h b/libhinawa/src/internal.h
index 1ee88ec..7ac672c 100644
--- a/libhinawa/src/internal.h
+++ b/libhinawa/src/internal.h
@@ -9,8 +9,11 @@
 
 #include "fw_unit.h"
 #include "fw_resp.h"
+#include "fw_req.h"
 
 void hinawa_fw_unit_ioctl(HinawaFwUnit *self, int req, void *args, int *err);
 void hinawa_fw_resp_handle_request(HinawaFwResp *self,
 				   struct fw_cdev_event_request2 *event);
+void hinawa_fw_req_handle_response(HinawaFwReq *self,
+				   struct fw_cdev_event_response *event);
 #endif
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
