From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/13] libhinawa: add 'fw_fcp' object as a helper of FCP
	transaction
Date: Sun, 25 Jan 2015 20:34:29 +0900
Message-ID: <1422185674-16431-9-git-send-email-o-takashi@sakamocchi.jp>
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

There are a standard way to transport function control data to units;
Function Control Protocol (FCP) in IEC 61883-1. This way uses a pair
of request transaction and response transaction. All of AV/C commands
which 1394TA defines is an application of FCP.

This commit adds HINAWA_TYPE_FW_FCP object for this purpose. This
object uses 'fw_resp' object and 'fw_req' object to support FCP.

I note that 'AV/C Digital Interface Command Set General
Specification Version 4.2' (September 1, 2004 1394TA) defines
'deferred transactions' in its clause 6.1.2. This type of AV/C
command requres FCP backend to wait 'unspecified interval' for next
response when receiving INTERIM type of response. To perform it,
this object uses 200 mili-seconds to wait again.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/doc/reference/hinawa-docs.sgml |   1 +
 libhinawa/src/Makefile.am                |   7 +-
 libhinawa/src/fw_fcp.c                   | 282 +++++++++++++++++++++++++++++++
 libhinawa/src/fw_fcp.h                   |  58 +++++++
 4 files changed, 346 insertions(+), 2 deletions(-)
 create mode 100644 libhinawa/src/fw_fcp.c
 create mode 100644 libhinawa/src/fw_fcp.h

diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
index ff00ecc..d5773a5 100644
--- a/libhinawa/doc/reference/hinawa-docs.sgml
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -33,6 +33,7 @@
             <xi:include href="xml/fw_unit.xml"/>
             <xi:include href="xml/fw_resp.xml"/>
             <xi:include href="xml/fw_req.xml"/>
+            <xi:include href="xml/fw_fcp.xml"/>
         </chapter>
     </part>
 
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index 91726b8..0a64658 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -29,13 +29,16 @@ libhinawa_la_SOURCES =				\
 	fw_resp.h				\
 	fw_resp.c				\
 	fw_req.h				\
-	fw_req.c
+	fw_req.c				\
+	fw_fcp.h				\
+	fw_fcp.c
 
 pkginclude_HEADERS =				\
 	hinawa_sigs_marshal.h			\
 	fw_unit.h				\
 	fw_resp.h				\
-	fw_req.h
+	fw_req.h				\
+	fw_fcp.h
 
 hinawa_sigs_marshal.list:
 	$(AM_V_GEN)( find | grep \.c$$ | xargs cat | 			\
diff --git a/libhinawa/src/fw_fcp.c b/libhinawa/src/fw_fcp.c
new file mode 100644
index 0000000..44c6d3b
--- /dev/null
+++ b/libhinawa/src/fw_fcp.c
@@ -0,0 +1,282 @@
+#include "fw_fcp.h"
+#include "fw_resp.h"
+#include "fw_req.h"
+
+/**
+ * SECTION:fw_fcp
+ * @Title: HinawaFwFcp
+ * @Short_description: A FCP transaction executor to a FireWire unit
+ *
+ * A HinawaFwFcp supports Function Control Protocol (FCP) in IEC 61883-1.
+ * Some types of transaction in 'AV/C Digital Interface Command Set General
+ * Specification Version 4.2' (Sep 1 2004, 1394TA) requires low layer support,
+ * thus this class has a code for them.
+ *
+ * Any of transaction frames should be aligned to 8bit (byte).
+ * This class is an application of #HinawaFwReq / #HinawaFwResp.
+ */
+
+#define FCP_MAXIMUM_FRAME_BYTES	0x200U
+#define FCP_REQUEST_ADDR	0xfffff0000b00
+#define FCP_RESPOND_ADDR	0xfffff0000d00
+
+/* For your information. */
+enum avc_type {
+	AVC_TYPE_CONTROL		= 0x00,
+	AVC_TYPE_STATUS			= 0x01,
+	AVC_TYPE_SPECIFIC_INQUIRY	= 0x02,
+	AVC_TYPE_NOTIFY			= 0x03,
+	AVC_TYPE_GENERAL_INQUIRY	= 0x04,
+	/* 0x05-0x07 are reserved. */
+};
+/* continue */
+enum avc_status {
+	AVC_STATUS_NOT_IMPLEMENTED	= 0x08,
+	AVC_STATUS_ACCEPTED		= 0x09,
+	AVC_STATUS_REJECTED		= 0x0a,
+	AVC_STATUS_IN_TRANSITION	= 0x0b,
+	AVC_STATUS_IMPLEMENTED_STABLE	= 0x0c,
+	AVC_STATUS_CHANGED		= 0x0d,
+	/* reserved */
+	AVC_STATUS_INTERIM		= 0x0f,
+};
+
+struct fcp_transaction {
+	GArray *req_frame;	/* Request frame */
+	GArray *resp_frame;	/* Response frame */
+	GCond cond;
+};
+
+struct _HinawaFwFcpPrivate {
+	HinawaFwUnit *unit;
+	HinawaFwResp *resp;
+
+	GList *transactions;
+	GMutex lock;
+};
+G_DEFINE_TYPE_WITH_PRIVATE(HinawaFwFcp, hinawa_fw_fcp, G_TYPE_OBJECT)
+#define FW_FCP_GET_PRIVATE(obj)						\
+	(G_TYPE_INSTANCE_GET_PRIVATE((obj),				\
+				     HINAWA_TYPE_FW_FCP, HinawaFwFcpPrivate))
+
+static void hinawa_fw_fcp_dispose(GObject *obj)
+{
+	HinawaFwFcp *self = HINAWA_FW_FCP(obj);
+
+	hinawa_fw_fcp_unlisten(self);
+
+	G_OBJECT_CLASS(hinawa_fw_fcp_parent_class)->dispose(obj);
+}
+
+static void hinawa_fw_fcp_finalize(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_fw_fcp_parent_class)->finalize(gobject);
+}
+
+static void hinawa_fw_fcp_class_init(HinawaFwFcpClass *klass)
+{
+	GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
+
+	gobject_class->dispose = hinawa_fw_fcp_dispose;
+	gobject_class->finalize = hinawa_fw_fcp_finalize;
+}
+
+static void hinawa_fw_fcp_init(HinawaFwFcp *self)
+{
+	self->priv = hinawa_fw_fcp_get_instance_private(self);
+}
+
+/**
+ * hinawa_fw_fcp_transact:
+ * @self: A #HinawaFwFcp
+ * @req_frame:  (element-type guint8) (array) (in): a byte frame for request
+ * @resp_frame: (element-type guint8) (array) (out caller-allocates): a byte
+ *		frame for response
+ * @exception: A #GError
+ */
+void hinawa_fw_fcp_transact(HinawaFwFcp *self,
+			    GArray *req_frame, GArray *resp_frame,
+			    GError **exception)
+{
+	HinawaFwFcpPrivate *priv;
+	HinawaFwReq *req;
+	struct fcp_transaction trans = {0};
+	GMutex local_lock;
+	gint64 expiration;
+	guint32 *buf;
+	guint i, quads, bytes;
+
+	g_return_if_fail(HINAWA_IS_FW_FCP(self));
+	priv = FW_FCP_GET_PRIVATE(self);
+
+	if (req_frame  == NULL || g_array_get_element_size(req_frame)  != 1 ||
+	    resp_frame == NULL || g_array_get_element_size(resp_frame) != 1 ||
+	    req_frame->len > FCP_MAXIMUM_FRAME_BYTES) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EINVAL, "%s", strerror(EINVAL));
+		return;
+	}
+
+	req = g_object_new(HINAWA_TYPE_FW_REQ, NULL);
+
+	/* Copy guint8 array to guint32 array. */
+	quads = (req_frame->len + sizeof(guint32) - 1) / sizeof(guint32);
+	trans.req_frame = g_array_sized_new(FALSE, TRUE,
+					    sizeof(guint32), quads);
+	g_array_set_size(trans.req_frame, quads);
+	memcpy(trans.req_frame->data, req_frame->data, req_frame->len);
+	buf = (guint32 *)trans.req_frame->data;
+	for (i = 0; i < trans.req_frame->len; i++)
+		buf[i] = htobe32(buf[i]);
+
+	/* Prepare response buffer. */
+	trans.resp_frame = g_array_sized_new(FALSE, TRUE,
+					     sizeof(guint32), quads);
+
+	/* Insert this entry. */
+	g_mutex_lock(&priv->lock);
+	priv->transactions = g_list_prepend(priv->transactions, &trans);
+	g_mutex_unlock(&priv->lock);
+
+	/* NOTE: Timeout is 200 milli-seconds. */
+	expiration = g_get_monotonic_time() + 200 * G_TIME_SPAN_MILLISECOND;
+	g_cond_init(&trans.cond);
+	g_mutex_init(&local_lock);
+
+	/* Send this request frame. */
+	hinawa_fw_req_write(req, priv->unit, FCP_REQUEST_ADDR, trans.req_frame,
+			    exception);
+	if (*exception != NULL)
+		goto end;
+deferred:
+	/*
+	 * Wait corresponding response till timeout.
+	 * NOTE: Timeout at bus-reset, illegally.
+	 */
+	g_mutex_lock(&local_lock);
+	if (!g_cond_wait_until(&trans.cond, &local_lock, expiration))
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ETIMEDOUT, "%s", strerror(ETIMEDOUT));
+	g_mutex_unlock(&local_lock);
+
+	/* Error happened. */
+	if (*exception != NULL)
+		goto end;
+
+	/* It's a deffered transaction, wait 200 milli-seconds again. */
+	if (trans.resp_frame->data[0] >> 24 == AVC_STATUS_INTERIM) {
+		expiration = g_get_monotonic_time() +
+			     200 * G_TIME_SPAN_MILLISECOND;
+		goto deferred;
+	}
+
+	/* Convert guint32 array to guint8 array. */
+	buf = (guint32 *)trans.resp_frame->data;
+	for (i = 0; i < trans.resp_frame->len; i++)
+		buf[i] = htobe32(buf[i]);
+	bytes = trans.resp_frame->len * sizeof(guint32);
+	g_array_set_size(resp_frame, bytes);
+	memcpy(resp_frame->data, trans.resp_frame->data, bytes);
+end:
+	/* Remove this entry. */
+	g_mutex_lock(&priv->lock);
+	priv->transactions =
+			g_list_remove(priv->transactions, (gpointer *)&trans);
+	g_mutex_unlock(&priv->lock);
+
+	g_array_free(trans.req_frame, TRUE);
+	g_mutex_clear(&local_lock);
+	g_clear_object(&req);
+}
+
+static GArray *handle_response(HinawaFwResp *self, gint tcode,
+			       GArray *req_frame, gpointer user_data)
+{
+	HinawaFwFcp *fcp = (HinawaFwFcp *)user_data;
+	HinawaFwFcpPrivate *priv = FW_FCP_GET_PRIVATE(fcp);
+	struct fcp_transaction *trans;
+	GList *entry;
+
+	g_mutex_lock(&priv->lock);
+
+	/* Seek correcponding request. */
+	for (entry = priv->transactions; entry != NULL; entry = entry->next) {
+		trans = (struct fcp_transaction *)entry->data;
+
+		if ((trans->req_frame->data[1] == req_frame->data[1]) &&
+		    (trans->req_frame->data[2] == req_frame->data[2]))
+			break;
+	}
+
+	/* No requests corresponding to this response. */
+	if (entry == NULL)
+		goto end;
+
+	g_array_insert_vals(trans->resp_frame, 0,
+			    req_frame->data, req_frame->len);
+	g_cond_signal(&trans->cond);
+end:
+	g_mutex_unlock(&priv->lock);
+
+	/* Transfer no data in the response frame. */
+	return NULL;
+}
+
+/**
+ * hinawa_fw_fcp_listen:
+ * @self: A #HinawaFwFcp
+ * @unit: A #HinawaFwUnit
+ * @exception: A #GError
+ *
+ * Start to listen to FCP responses.
+ */
+void hinawa_fw_fcp_listen(HinawaFwFcp *self, HinawaFwUnit *unit,
+			  GError **exception)
+{
+	HinawaFwFcpPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_FW_FCP(self));
+	priv = FW_FCP_GET_PRIVATE(self);
+
+	priv->resp = g_object_new(HINAWA_TYPE_FW_RESP, NULL);
+	priv->unit = g_object_ref(unit);
+
+	hinawa_fw_resp_register(priv->resp, priv->unit,
+				FCP_RESPOND_ADDR, FCP_MAXIMUM_FRAME_BYTES,
+				exception);
+	if (*exception != NULL) {
+		g_clear_object(&priv->resp);
+		priv->resp = NULL;
+		g_object_unref(priv->unit);
+		priv->unit = NULL;
+		return;
+	}
+
+	g_signal_connect(priv->resp, "requested",
+			 G_CALLBACK(handle_response), self);
+
+	g_mutex_init(&priv->lock);
+	priv->transactions = NULL;
+}
+
+/**
+ * hinawa_fw_fcp_unlisten:
+ * @self: A #HinawaFwFcp
+ *
+ * Stop to listen to FCP responses.
+ */
+void hinawa_fw_fcp_unlisten(HinawaFwFcp *self)
+{
+	HinawaFwFcpPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_FW_FCP(self));
+	priv = FW_FCP_GET_PRIVATE(self);
+
+	if (priv->resp == NULL)
+		return;
+
+	hinawa_fw_resp_unregister(priv->resp);
+	priv->resp = NULL;
+	g_object_unref(priv->unit);
+	priv->unit = NULL;
+}
diff --git a/libhinawa/src/fw_fcp.h b/libhinawa/src/fw_fcp.h
new file mode 100644
index 0000000..206ebee
--- /dev/null
+++ b/libhinawa/src/fw_fcp.h
@@ -0,0 +1,58 @@
+#ifndef __ALSA_TOOLS_HINAWA_FW_FCP_H__
+#define __ALSA_TOOLS_HINAWA_FW_FCP_H__
+
+#include <glib.h>
+#include <glib-object.h>
+#include "internal.h"
+#include "fw_unit.h"
+
+G_BEGIN_DECLS
+
+#define HINAWA_TYPE_FW_FCP	(hinawa_fw_fcp_get_type())
+
+#define HINAWA_FW_FCP(obj)					\
+	(G_TYPE_CHECK_INSTANCE_CAST((obj),			\
+				    HINAWA_TYPE_FW_FCP,		\
+				    HinawaFwFcp))
+#define HINAWA_IS_FW_FCP(obj)					\
+	(G_TYPE_CHECK_INSTANCE_TYPE((obj),			\
+				    HINAWA_TYPE_FW_FCP))
+
+#define HINAWA_FW_FCP_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_CAST((klass),			\
+				 HINAWA_TYPE_FW_FCP,		\
+				 HinawaFwFcpClass))
+#define HINAWA_IS_FW_FCP_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_TYPE((klass),			\
+				 HINAWA_TYPE_FW_FCP))
+#define HINAWA_FW_FCP_GET_CLASS(obj)				\
+	(G_TYPE_INSTANCE_GET_CLASS((obj),			\
+				   HINAWA_TYPE_FW_FCP,		\
+				   HinawaFwFcpClass))
+
+typedef struct _HinawaFwFcp		HinawaFwFcp;
+typedef struct _HinawaFwFcpClass	HinawaFwFcpClass;
+typedef struct _HinawaFwFcpPrivate	HinawaFwFcpPrivate;
+
+struct _HinawaFwFcp {
+	GObject parent_instance;
+
+	HinawaFwFcpPrivate *priv;
+};
+
+struct _HinawaFwFcpClass {
+	GObjectClass parent_class;
+};
+
+GType hinawa_fw_fcp_get_type(void) G_GNUC_CONST;
+
+HinawaFwFcp *hinawa_fw_fcp_new(GError **exception);
+
+void hinawa_fw_fcp_listen(HinawaFwFcp *self, HinawaFwUnit *unit,
+			  GError **exception);
+void hinawa_fw_fcp_transact(HinawaFwFcp *self,
+			    GArray *req_frame, GArray *resp_frame,
+			    GError **exception);
+void hinawa_fw_fcp_unlisten(HinawaFwFcp *self);
+
+#endif
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
