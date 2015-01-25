From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/13] libhinawa: add 'fw_resp' object as a responder for
	FireWire transaction
Date: Sun, 25 Jan 2015 20:34:27 +0900
Message-ID: <1422185674-16431-7-git-send-email-o-takashi@sakamocchi.jp>
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

The units on IEEE 1394 bus transfers any requests to a certain address
on receiver. To receive the request, the receiver should listen to the
address and respond it.

Linux FireWire subsystem gives a way to perform this. Applications
reserve a range of address on IEEE 1394 host controller by ioctl(2).
When the host controller receives any requests, the subsystem
generates readable events for applications. When reading the events,
the application should transfer a response by ioctl(2). The range of
address is an exclusive resource on the host controller, thus the other
applications cannot reserve it.

This commit adds HINAWA_TYPE_FW_RESP object to perform this. When
constructing the instance, applications can reserve the range of
address by register() method. When the host controller receives
a request inner the range, the instance generates 'requested' signal.
If the application want to transfer some data in the response frame,
the handler should return 32bit array. Else return NULL.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/doc/reference/hinawa-docs.sgml |   1 +
 libhinawa/src/Makefile.am                |   7 +-
 libhinawa/src/fw_resp.c                  | 232 +++++++++++++++++++++++++++++++
 libhinawa/src/fw_resp.h                  |  51 +++++++
 libhinawa/src/fw_unit.c                  |   4 +
 libhinawa/src/internal.h                 |   3 +
 6 files changed, 296 insertions(+), 2 deletions(-)
 create mode 100644 libhinawa/src/fw_resp.c
 create mode 100644 libhinawa/src/fw_resp.h

diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
index 662d8c5..419e431 100644
--- a/libhinawa/doc/reference/hinawa-docs.sgml
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -31,6 +31,7 @@
             of the transaction functionality in Linux firewire stack.
             </para>
             <xi:include href="xml/fw_unit.xml"/>
+            <xi:include href="xml/fw_resp.xml"/>
         </chapter>
     </part>
 
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index d9519ab..7c09088 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -25,11 +25,14 @@ libhinawa_la_SOURCES =				\
 	hinawa_sigs_marshal.h			\
 	hinawa_sigs_marshal.c			\
 	fw_unit.h				\
-	fw_unit.c
+	fw_unit.c				\
+	fw_resp.h				\
+	fw_resp.c
 
 pkginclude_HEADERS =				\
 	hinawa_sigs_marshal.h			\
-	fw_unit.h
+	fw_unit.h				\
+	fw_resp.h
 
 hinawa_sigs_marshal.list:
 	$(AM_V_GEN)( find | grep \.c$$ | xargs cat | 			\
diff --git a/libhinawa/src/fw_resp.c b/libhinawa/src/fw_resp.c
new file mode 100644
index 0000000..2ee559b
--- /dev/null
+++ b/libhinawa/src/fw_resp.c
@@ -0,0 +1,232 @@
+#include <sys/ioctl.h>
+#include "fw_resp.h"
+#include "internal.h"
+#include "hinawa_sigs_marshal.h"
+
+#ifdef HAVE_CONFIG_H
+#  include <config.h>
+#endif
+
+/**
+ * SECTION:fw_resp
+ * @Title: HinawaFwResp
+ * @Short_description: A transaction responder for a FireWire unit
+ *
+ * A HinawaFwResp responds requests from any units.
+ *
+ * Any of transaction frames should be aligned to 32bit (quadlet).
+ * This class is an application of Linux FireWire subsystem. All of operations
+ * utilize ioctl(2) with subsystem specific request commands.
+ */
+struct _HinawaFwRespPrivate {
+	HinawaFwUnit *unit;
+
+	guchar *buf;
+	guint width;
+	guint64 addr_handle;
+
+	GArray *req_frame;
+};
+G_DEFINE_TYPE_WITH_PRIVATE(HinawaFwResp, hinawa_fw_resp, G_TYPE_OBJECT)
+#define FW_RESP_GET_PRIVATE(obj)					\
+	(G_TYPE_INSTANCE_GET_PRIVATE((obj),				\
+				     HINAWA_TYPE_FW_RESP, HinawaFwRespPrivate))
+
+/* This object has one signal. */
+enum fw_resp_sig_type {
+	FW_RESP_SIG_TYPE_REQ = 0,
+	FW_RESP_SIG_TYPE_COUNT,
+};
+static guint fw_resp_sigs[FW_RESP_SIG_TYPE_COUNT] = { 0 };
+
+static void fw_resp_dispose(GObject *gobject)
+{
+	HinawaFwResp *self = HINAWA_FW_RESP(gobject);
+
+	hinawa_fw_resp_unregister(self);
+
+	G_OBJECT_CLASS(hinawa_fw_resp_parent_class)->dispose(gobject);
+}
+
+static void fw_resp_finalize(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_fw_resp_parent_class)->finalize(gobject);
+}
+
+static void hinawa_fw_resp_class_init(HinawaFwRespClass *klass)
+{
+	GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
+
+	gobject_class->get_property = NULL;
+	gobject_class->set_property = NULL;
+	gobject_class->dispose = fw_resp_dispose;
+	gobject_class->finalize = fw_resp_finalize;
+
+	/**
+	 * HinawaFwResp::requested:
+	 * @self: A #HinawaFwResp
+	 * @tcode: Transaction code
+	 * @req_frame: (element-type guint32) (array) (transfer none):
+	 *		The frame in request
+	 *
+	 * When any units transfer requests to the range of address to which
+	 * this object listening. The ::requested signal handler can set
+	 * data frame to 'resp_frame' if needed.
+	 *
+	 * Returns: (element-type guint32) (array) (nullable) (transfer full):
+	 *	A data frame for response.
+	 */
+	fw_resp_sigs[FW_RESP_SIG_TYPE_REQ] =
+		g_signal_new("requested",
+			     G_OBJECT_CLASS_TYPE(klass),
+			     G_SIGNAL_RUN_LAST,
+			     0,
+			     NULL, NULL,
+			     hinawa_sigs_marshal_BOXED__INT_BOXED,
+			     G_TYPE_ARRAY, 2, G_TYPE_INT, G_TYPE_ARRAY);
+}
+
+static void hinawa_fw_resp_init(HinawaFwResp *self)
+{
+	self->priv = hinawa_fw_resp_get_instance_private(self);
+}
+
+/**
+ * hinawa_fw_resp_register:
+ * @self: A #HinawaFwResp
+ * @unit: A #HinawaFwUnit
+ * @addr: A start address to listen to in host controller
+ * @width: The byte width of address to listen to host controller
+ * @exception: A #GError
+ *
+ * Start to listen to a range of address in host controller
+ */
+void hinawa_fw_resp_register(HinawaFwResp *self, HinawaFwUnit *unit,
+			     guint64 addr, guint width, GError **exception)
+{
+	HinawaFwRespPrivate *priv;
+	struct fw_cdev_allocate allocate = {0};
+	int err;
+
+	g_return_if_fail(HINAWA_IS_FW_RESP(self));
+	priv = FW_RESP_GET_PRIVATE(self);
+
+	if (priv->unit != NULL) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EINVAL, "%s", strerror(EINVAL));
+		return;
+	}
+	priv->unit = g_object_ref(unit);
+
+	allocate.offset = addr;
+	allocate.closure = (guint64)self;
+	allocate.length = width;
+	allocate.region_end = addr + width;
+
+	hinawa_fw_unit_ioctl(priv->unit, FW_CDEV_IOC_ALLOCATE, &allocate, &err);
+	if (err != 0) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    err, "%s", strerror(err));
+		g_object_unref(priv->unit);
+		priv->unit = NULL;
+		return;
+	}
+
+	priv->buf = g_malloc0(allocate.length);
+	if (priv->buf == NULL) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ENOMEM, "%s", strerror(ENOMEM));
+		hinawa_fw_resp_unregister(self);
+		return;
+	}
+
+	priv->req_frame  = g_array_new(FALSE, TRUE, sizeof(guint32));
+	if (priv->req_frame == NULL) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ENOMEM, "%s", strerror(ENOMEM));
+		hinawa_fw_resp_unregister(self);
+		return;
+	}
+
+	priv->width = allocate.length;
+}
+
+/**
+ * hinawa_fw_resp_unregister:
+ * @self: A HinawaFwResp
+ *
+ * stop to listen to a range of address in host controller
+ */
+void hinawa_fw_resp_unregister(HinawaFwResp *self)
+{
+	HinawaFwRespPrivate *priv;
+	struct fw_cdev_deallocate deallocate = {0};
+	int err;
+
+	g_return_if_fail(HINAWA_IS_FW_RESP(self));
+	priv = FW_RESP_GET_PRIVATE(self);
+
+	if (priv->unit == NULL)
+		return;
+
+	deallocate.handle = priv->addr_handle;
+	hinawa_fw_unit_ioctl(priv->unit, FW_CDEV_IOC_DEALLOCATE, &deallocate,
+			     &err);
+	g_object_unref(priv->unit);
+	priv->unit = NULL;
+
+	if (priv->req_frame != NULL)
+		g_array_free(priv->req_frame, TRUE);
+	priv->req_frame = NULL;
+}
+
+/* NOTE: For HinawaFwUnit, internal. */
+void hinawa_fw_resp_handle_request(HinawaFwResp *self,
+				   struct fw_cdev_event_request2 *event)
+{
+	HinawaFwRespPrivate *priv;
+	struct fw_cdev_send_response resp = {0};
+	guint i, quads;
+	guint32 *buf;
+	GArray *resp_frame;
+	int err;
+
+	g_return_if_fail(HINAWA_IS_FW_RESP(self));
+	priv = FW_RESP_GET_PRIVATE(self);
+
+	if (event->length > priv->width) {
+		resp.rcode = RCODE_CONFLICT_ERROR;
+		goto respond;
+	}
+
+	/* Store requested frame. */
+	quads = event->length / 4;
+	g_array_set_size(priv->req_frame, quads);
+	memcpy(priv->req_frame->data, event->data, event->length);
+
+	/* For endiannness. */
+	buf = (guint32 *)priv->req_frame->data;
+	for (i = 0; i < quads; i++)
+		buf[i] = be32toh(buf[i]);
+
+	/* Emit signal to handlers. */
+	g_signal_emit(self, fw_resp_sigs[FW_RESP_SIG_TYPE_REQ], 0,
+		      event->tcode, priv->req_frame, &resp_frame);
+
+	resp.rcode = RCODE_COMPLETE;
+	if (resp_frame == NULL || resp_frame->len == 0)
+		goto respond;
+
+	/* For endianness. */
+	buf = (guint32 *)resp_frame->data;
+	for (i = 0; i < resp_frame->len; i++)
+		buf[i] = htobe32(buf[i]);
+
+	resp.length = resp_frame->len;
+	resp.data = (guint64)resp_frame->data;
+respond:
+	resp.handle = event->handle;
+
+	hinawa_fw_unit_ioctl(priv->unit, FW_CDEV_IOC_SEND_RESPONSE, &resp,
+			     &err);
+}
diff --git a/libhinawa/src/fw_resp.h b/libhinawa/src/fw_resp.h
new file mode 100644
index 0000000..0e3bb52
--- /dev/null
+++ b/libhinawa/src/fw_resp.h
@@ -0,0 +1,51 @@
+#ifndef __ALSA_TOOLS_HINAWA_FW_RESP_H__
+#define __ALSA_TOOLS_HINAWA_FW_RESP_H__
+
+#include <glib.h>
+#include <glib-object.h>
+#include "fw_unit.h"
+
+G_BEGIN_DECLS
+
+#define HINAWA_TYPE_FW_RESP	(hinawa_fw_resp_get_type())
+
+#define HINAWA_FW_RESP(obj)					\
+	(G_TYPE_CHECK_INSTANCE_CAST((obj),			\
+				    HINAWA_TYPE_FW_RESP,	\
+				    HinawaFwResp))
+#define HINAWA_IS_FW_RESP(obj)					\
+	(G_TYPE_CHECK_INSTANCE_TYPE((obj),			\
+				    HINAWA_TYPE_FW_RESP))
+
+#define HINAWA_FW_RESP_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_CAST((klass),			\
+				 HINAWA_TYPE_FW_RESP,		\
+				 HinawaFwResp))
+#define HINAWA_IS_FW_RESP_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_TYPE((klass),			\
+				 HINAWA_TYPE_Seq))
+#define HINAWA_FW_RESP_GET_CLASS(obj)				\
+	(G_TYPE_INSTANCE_GET_CLASS((obj),			\
+				   HINAWA_TYPE_FW_RESP,		\
+				   HinawaFwResp))
+
+typedef struct _HinawaFwResp		HinawaFwResp;
+typedef struct _HinawaFwRespClass	HinawaFwRespClass;
+typedef struct _HinawaFwRespPrivate	HinawaFwRespPrivate;
+
+struct _HinawaFwResp {
+	GObject parent_instance;
+
+	HinawaFwRespPrivate *priv;
+};
+
+struct _HinawaFwRespClass {
+	GObjectClass parent_class;
+};
+
+GType hinawa_fw_resp_get_type(void) G_GNUC_CONST;
+
+void hinawa_fw_resp_register(HinawaFwResp *self, HinawaFwUnit *unit,
+			     guint64 addr, guint width, GError **exception);
+void hinawa_fw_resp_unregister(HinawaFwResp *self);
+#endif
diff --git a/libhinawa/src/fw_unit.c b/libhinawa/src/fw_unit.c
index b948ef8..019105d 100644
--- a/libhinawa/src/fw_unit.c
+++ b/libhinawa/src/fw_unit.c
@@ -235,6 +235,10 @@ static gboolean check_src(GSource *gsrc)
 	    common->type == FW_CDEV_EVENT_BUS_RESET)
 		handle_update(HINAWA_FW_UNIT(common->closure),
 				(struct fw_cdev_event_bus_reset *)common);
+	else if (HINAWA_IS_FW_RESP(common->closure) &&
+		 common->type == FW_CDEV_EVENT_REQUEST2)
+		hinawa_fw_resp_handle_request(HINAWA_FW_RESP(common->closure),
+				(struct fw_cdev_event_request2 *)common);
 end:
 	/* Don't go to dispatch, then continue to process this source. */
 	return FALSE;
diff --git a/libhinawa/src/internal.h b/libhinawa/src/internal.h
index 83f920b..1ee88ec 100644
--- a/libhinawa/src/internal.h
+++ b/libhinawa/src/internal.h
@@ -8,6 +8,9 @@
 #include <linux/firewire-constants.h>
 
 #include "fw_unit.h"
+#include "fw_resp.h"
 
 void hinawa_fw_unit_ioctl(HinawaFwUnit *self, int req, void *args, int *err);
+void hinawa_fw_resp_handle_request(HinawaFwResp *self,
+				   struct fw_cdev_event_request2 *event);
 #endif
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
