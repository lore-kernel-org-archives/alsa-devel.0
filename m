From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/13] libhinawa: add 'snd_efw' object as a helper for EFW
	transaction
Date: Sun, 25 Jan 2015 20:34:32 +0900
Message-ID: <1422185674-16431-12-git-send-email-o-takashi@sakamocchi.jp>
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

Fireworks is a board module which Echo Audio produces. This module can
be controlled by Echo Fireworks Transaction (a.k.a. EFW transaction).
The transaction has categories, commands and arguments.

The transaction is transferred by two ways; one is vendor-dependent
AV/C command and another is a pair of request/response transaction to
certain addresses.

ALSA Fireworks driver already supports the latter way because the
former way is not avaibale in some Fireworks based devices. The driver
gives a way for applications to execute this transaction via ALSA
hwdep interface.

This commit adds HINAWA_TYPE_SND_EFW object for this purpose. An
application can transfer requests and wait responses by calling
transact() method after calling listen() method.

This object is an inheritance of HINAWA_TYPE_SND_UNIT, therefore some
signals and properties, methods are also available.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/doc/reference/hinawa-docs.sgml |   1 +
 libhinawa/src/Makefile.am                |   7 +-
 libhinawa/src/internal.h                 |   3 +
 libhinawa/src/snd_efw.c                  | 315 +++++++++++++++++++++++++++++++
 libhinawa/src/snd_efw.h                  |  54 ++++++
 libhinawa/src/snd_unit.c                 |   5 +
 6 files changed, 383 insertions(+), 2 deletions(-)
 create mode 100644 libhinawa/src/snd_efw.c
 create mode 100644 libhinawa/src/snd_efw.h

diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
index 58c862a..731ae15 100644
--- a/libhinawa/doc/reference/hinawa-docs.sgml
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -36,6 +36,7 @@
             <xi:include href="xml/fw_fcp.xml"/>
             <xi:include href="xml/snd_unit.xml"/>
             <xi:include href="xml/snd_dice.xml"/>
+            <xi:include href="xml/snd_efw.xml"/>
         </chapter>
     </part>
 
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index 696e567..b746bf1 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -36,7 +36,9 @@ libhinawa_la_SOURCES =				\
 	snd_unit.h				\
 	snd_unit.c				\
 	snd_dice.h				\
-	snd_dice.c
+	snd_dice.c				\
+	snd_efw.h				\
+	snd_efw.c
 
 pkginclude_HEADERS =				\
 	hinawa_sigs_marshal.h			\
@@ -45,7 +47,8 @@ pkginclude_HEADERS =				\
 	fw_req.h				\
 	fw_fcp.h				\
 	snd_unit.h				\
-	snd_dice.h
+	snd_dice.h				\
+	snd_efw.h
 
 hinawa_sigs_marshal.list:
 	$(AM_V_GEN)( find | grep \.c$$ | xargs cat | 			\
diff --git a/libhinawa/src/internal.h b/libhinawa/src/internal.h
index ddbb298..9ff8fe4 100644
--- a/libhinawa/src/internal.h
+++ b/libhinawa/src/internal.h
@@ -13,6 +13,7 @@
 #include "fw_req.h"
 #include "snd_unit.h"
 #include "snd_dice.h"
+#include "snd_efw.h"
 
 void hinawa_fw_unit_ioctl(HinawaFwUnit *self, int req, void *args, int *err);
 void hinawa_fw_resp_handle_request(HinawaFwResp *self,
@@ -25,4 +26,6 @@ void hinawa_snd_unit_write(HinawaSndUnit *unit,
 			   GError **exception);
 void hinawa_snd_dice_handle_notification(HinawaSndDice *self,
 					 const void *buf, unsigned int len);
+void hinawa_snd_efw_handle_response(HinawaSndEfw *self,
+				    const void *buf, unsigned int len);
 #endif
diff --git a/libhinawa/src/snd_efw.c b/libhinawa/src/snd_efw.c
new file mode 100644
index 0000000..6e1882b
--- /dev/null
+++ b/libhinawa/src/snd_efw.c
@@ -0,0 +1,315 @@
+#include <linux/types.h>
+#include <sound/firewire.h>
+#include <alsa/asoundlib.h>
+#include "snd_efw.h"
+#include "internal.h"
+
+#ifdef HAVE_CONFIG_H
+#  include <config.h>
+#endif
+
+/**
+ * SECTION:snd_efw
+ * @Title: HinawaSndEfw
+ * @Short_description: A transaction executor for Fireworks models
+ *
+ * A #HinawaSndEfw is an application of Echo Fireworks Transaction (EFT).
+ * This inherits #HinawaSndUnit.
+ */
+#define MINIMUM_SUPPORTED_VERSION	1
+#define MAXIMUM_FRAME_BYTES		0x200U
+
+enum efw_status {
+	EFT_STATUS_OK			= 0,
+	EFT_STATUS_BAD			= 1,
+	EFT_STATUS_BAD_COMMAND		= 2,
+	EFT_STATUS_COMM_ERR		= 3,
+	EFT_STATUS_BAD_QUAD_COUNT	= 4,
+	EFT_STATUS_UNSUPPORTED		= 5,
+	EFT_STATUS_1394_TIMEOUT		= 6,
+	EFT_STATUS_DSP_TIMEOUT		= 7,
+	EFT_STATUS_BAD_RATE		= 8,
+	EFT_STATUS_BAD_CLOCK		= 9,
+	EFT_STATUS_BAD_CHANNEL		= 10,
+	EFT_STATUS_BAD_PAN		= 11,
+	EFT_STATUS_FLASH_BUSY		= 12,
+	EFT_STATUS_BAD_MIRROR		= 13,
+	EFT_STATUS_BAD_LED		= 14,
+	EFT_STATUS_BAD_PARAMETER	= 15,
+};
+static const char *const efw_status_names[] = {
+	[EFT_STATUS_OK]			= "OK",
+	[EFT_STATUS_BAD]		= "bad",
+	[EFT_STATUS_BAD_COMMAND]	= "bad command",
+	[EFT_STATUS_COMM_ERR]		= "comm err",
+	[EFT_STATUS_BAD_QUAD_COUNT]	= "bad quad count",
+	[EFT_STATUS_UNSUPPORTED]	= "unsupported",
+	[EFT_STATUS_1394_TIMEOUT]	= "1394 timeout",
+	[EFT_STATUS_DSP_TIMEOUT]	= "DSP timeout",
+	[EFT_STATUS_BAD_RATE]		= "bad rate",
+	[EFT_STATUS_BAD_CLOCK]		= "bad clock",
+	[EFT_STATUS_BAD_CHANNEL]	= "bad channel",
+	[EFT_STATUS_BAD_PAN]		= "bad pan",
+	[EFT_STATUS_FLASH_BUSY]		= "flash busy",
+	[EFT_STATUS_BAD_MIRROR]		= "bad mirror",
+	[EFT_STATUS_BAD_LED]		= "bad LED",
+	[EFT_STATUS_BAD_PARAMETER]	= "bad parameter",
+};
+
+struct efw_transaction {
+	guint seqnum;
+
+	struct snd_efw_transaction *frame;
+
+	GCond cond;
+};
+
+struct _HinawaSndEfwPrivate {
+	guint seqnum;
+
+	GList *transactions;
+	GMutex lock;
+};
+G_DEFINE_TYPE_WITH_PRIVATE(HinawaSndEfw, hinawa_snd_efw, HINAWA_TYPE_SND_UNIT)
+#define SND_EFW_GET_PRIVATE(obj)					\
+	(G_TYPE_INSTANCE_GET_PRIVATE((obj),				\
+				     HINAWA_TYPE_SND_EFW, HinawaSndEfwPrivate))
+
+static void snd_efw_dispose(GObject *obj)
+{
+	G_OBJECT_CLASS(hinawa_snd_efw_parent_class)->dispose(obj);
+}
+
+static void snd_efw_finalize(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_snd_efw_parent_class)->finalize(gobject);
+}
+
+static void hinawa_snd_efw_class_init(HinawaSndEfwClass *klass)
+{
+	GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
+
+	gobject_class->dispose = snd_efw_dispose;
+	gobject_class->finalize = snd_efw_finalize;
+}
+
+static void hinawa_snd_efw_init(HinawaSndEfw *self)
+{
+	self->priv = hinawa_snd_efw_get_instance_private(self);
+}
+
+/**
+ * hinawa_snd_efw_new:
+ * @path: A path to ALSA hwdep device for Fireworks models (i.e. hw:0)
+ * @exception: A #GError
+ *
+ * Returns: A #HinawaSndEfw
+ */
+void hinawa_snd_efw_open(HinawaSndEfw *self, gchar *path, GError **exception)
+{
+	HinawaSndEfwPrivate *priv;
+	int type;
+
+	g_return_if_fail(HINAWA_IS_SND_EFW(self));
+	priv = SND_EFW_GET_PRIVATE(self);
+
+	hinawa_snd_unit_open(&self->parent_instance, path, exception);
+	if (*exception != NULL) {
+		g_clear_object(&self);
+		return;
+	}
+
+	g_object_get(G_OBJECT(self), "type", &type, NULL);
+	if (type != SNDRV_FIREWIRE_TYPE_FIREWORKS) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EINVAL, "%s", strerror(EINVAL));
+		g_clear_object(&self);
+		return;
+	}
+
+	priv = SND_EFW_GET_PRIVATE(self);
+	priv->seqnum = 0;
+	priv->transactions = NULL;
+	g_mutex_init(&priv->lock);
+}
+
+/**
+ * hinawa_snd_efw_transact:
+ * @self: A #HinawaSndEfw
+ * @category: one of category for the transact
+ * @command: one of commands for the transact
+ * @args: (nullable) (element-type guint32) (array) (in): arguments for the
+ *        transaction
+ * @params: (element-type guint32) (array) (out caller-allocates): return params
+ * @exception: A #GError
+ */
+void hinawa_snd_efw_transact(HinawaSndEfw *self, guint category, guint command,
+			     GArray *args, GArray *params, GError **exception)
+{
+	HinawaSndEfwPrivate *priv;
+	int type;
+
+	struct efw_transaction trans;
+	__le32 *items;
+
+	unsigned int quads;
+	unsigned int count;
+	unsigned int i;
+
+	gint64 expiration;
+
+	g_return_if_fail(HINAWA_IS_SND_EFW(self));
+	priv = SND_EFW_GET_PRIVATE(self);
+
+	/* Check unit type and function arguments . */
+	g_object_get(G_OBJECT(self), "type", &type, NULL);
+	if ((type != SNDRV_FIREWIRE_TYPE_FIREWORKS) ||
+	    (args && g_array_get_element_size(args) != sizeof(guint32)) ||
+	    (params && g_array_get_element_size(params) != sizeof(guint32))) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EINVAL, "%s", strerror(EINVAL));
+		return;
+	}
+
+	trans.frame = g_malloc0(MAXIMUM_FRAME_BYTES);
+	if (trans.frame == NULL) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ENOMEM, "%s", strerror(ENOMEM));
+		return;
+	}
+
+	/* Increment the sequence number for next transaction. */
+	trans.frame->seqnum = priv->seqnum;
+	priv->seqnum += 2;
+	if (priv->seqnum > SND_EFW_TRANSACTION_USER_SEQNUM_MAX)
+		priv->seqnum = 0;
+
+	/* Fill transaction frame. */
+	quads = sizeof(struct snd_efw_transaction) / 4;
+	if (args)
+		quads += args->len;
+	trans.frame->length	= quads;
+	trans.frame->version	= MINIMUM_SUPPORTED_VERSION;
+	trans.frame->category	= category;
+	trans.frame->command	= command;
+	trans.frame->status	= 0xff;
+	if (args)
+		memcpy(trans.frame->params,
+		       args->data, args->len * sizeof(guint32));
+
+	/* The transactions are aligned to big-endian. */
+	items = (__le32 *)trans.frame;
+	for (i = 0; i < quads; i++)
+		items[i] = htobe32(items[i]);
+
+	/* Insert this entry to list and enter critical section. */
+	g_mutex_lock(&priv->lock);
+	priv->transactions = g_list_append(priv->transactions, &trans);
+
+	/* NOTE: Timeout is 200 milli-seconds. */
+	expiration = g_get_monotonic_time() + 200 * G_TIME_SPAN_MILLISECOND;
+	g_cond_init(&trans.cond);
+
+	/* Send this request frame. */
+	hinawa_snd_unit_write(&self->parent_instance, trans.frame, quads * 4,
+			      exception);
+	if (*exception != NULL)
+		goto end;
+
+	/*
+	 * Wait corresponding response till timeout and temporarily leave the
+	 * critical section.
+	 */
+	if (!g_cond_wait_until(&trans.cond, &priv->lock, expiration)) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ETIMEDOUT, "%s", strerror(ETIMEDOUT));
+		goto end;
+	}
+
+	quads = be32toh(trans.frame->length);
+
+	/* The transactions are aligned to big-endian. */
+	items = (__le32 *)trans.frame;
+	for (i = 0; i < quads; i++)
+		items[i] = be32toh(items[i]);
+
+	/* Check transaction status. */
+	if (trans.frame->status != EFT_STATUS_OK) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EPROTO, "%s",
+			    efw_status_names[trans.frame->status]);
+		goto end;
+	}
+
+	/* Check transaction headers. */
+	if ((trans.frame->version  <  MINIMUM_SUPPORTED_VERSION) ||
+	    (trans.frame->category != category) ||
+	    (trans.frame->command  != command)) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EIO, "%s", strerror(EIO));
+		goto end;
+	}
+
+	/* Check returned parameters. */
+	count = quads - sizeof(struct snd_efw_transaction) / 4;
+	if (count > 0 && params == NULL) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EINVAL, "%s", strerror(EINVAL));
+		goto end;
+	}
+
+	/* Copy parameters. */
+	g_array_insert_vals(params, 0, trans.frame->params, count);
+end:
+	/* Remove thie entry from list and leave the critical section. */
+	priv->transactions =
+			g_list_remove(priv->transactions, (gpointer *)&trans);
+	g_mutex_unlock(&priv->lock);
+
+	g_free(trans.frame);
+}
+
+void hinawa_snd_efw_handle_response(HinawaSndEfw *self,
+				    const void *buf, unsigned int len)
+{
+	HinawaSndEfwPrivate *priv;
+	struct snd_firewire_event_efw_response *event =
+				(struct snd_firewire_event_efw_response *)buf;
+	guint *responses = event->response;
+
+	struct snd_efw_transaction *resp_frame;
+	struct efw_transaction *trans;
+
+	unsigned int quadlets;
+	GList *entry;
+
+	g_return_if_fail(HINAWA_IS_SND_EFW(self));
+	priv = SND_EFW_GET_PRIVATE(self);
+
+	while (len > 0) {
+		resp_frame =  (struct snd_efw_transaction *)responses;
+
+		g_mutex_lock(&priv->lock);
+
+		trans = NULL;
+		for (entry = priv->transactions;
+		     entry != NULL; entry = entry->next) {
+			trans = (struct efw_transaction *)entry->data;
+
+			if (be32toh(resp_frame->seqnum) == trans->seqnum)
+				break;
+		}
+
+		g_mutex_unlock(&priv->lock);
+
+		if (trans == NULL)
+			continue;
+
+		quadlets = be32toh(resp_frame->length);
+		memcpy(trans->frame, resp_frame, quadlets * 4);
+		g_cond_signal(&trans->cond);
+
+		responses += quadlets;
+		len -= quadlets * sizeof(guint);
+	}
+}
diff --git a/libhinawa/src/snd_efw.h b/libhinawa/src/snd_efw.h
new file mode 100644
index 0000000..cdc514b
--- /dev/null
+++ b/libhinawa/src/snd_efw.h
@@ -0,0 +1,54 @@
+#ifndef __ALSA_TOOLS_HINAWA_SND_EFW_H__
+#define __ALSA_TOOLS_HINAWA_SND_EFW_H__
+
+#include <glib.h>
+#include <glib-object.h>
+#include "snd_unit.h"
+
+G_BEGIN_DECLS
+
+#define HINAWA_TYPE_SND_EFW	(hinawa_snd_efw_get_type())
+
+#define HINAWA_SND_EFW(obj)					\
+	(G_TYPE_CHECK_INSTANCE_CAST((obj),			\
+				    HINAWA_TYPE_SND_EFW,	\
+				    HinawaSndEfw))
+#define HINAWA_IS_SND_EFW(obj)					\
+	(G_TYPE_CHECK_INSTANCE_TYPE((obj),			\
+				    HINAWA_TYPE_SND_EFW))
+
+#define HINAWA_SND_EFW_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_CAST((klass),			\
+				 HINAWA_TYPE_SND_EFW,		\
+				 HinawaSndEfwClass))
+#define HINAWA_IS_SND_EFW_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_TYPE((klass),			\
+				 HINAWA_TYPE_SND_EFW))
+#define HINAWA_SND_EFW_GET_CLASS(obj)				\
+	(G_TYPE_INSTANCE_GET_CLASS((obj),			\
+				   HINAWA_TYPE_SND_EFW,		\
+				   HinawaSndEfwClass))
+
+typedef struct _HinawaSndEfw		HinawaSndEfw;
+typedef struct _HinawaSndEfwClass	HinawaSndEfwClass;
+typedef struct _HinawaSndEfwPrivate	HinawaSndEfwPrivate;
+
+struct _HinawaSndEfw {
+	HinawaSndUnit parent_instance;
+
+	HinawaSndEfwPrivate *priv;
+};
+
+struct _HinawaSndEfwClass {
+	HinawaSndUnitClass parent_class;
+};
+
+GType hinawa_snd_efw_get_type(void) G_GNUC_CONST;
+
+void hinawa_snd_efw_open(HinawaSndEfw *self, gchar *path, GError **exception);
+
+void hinawa_snd_efw_transact(HinawaSndEfw *self, guint category, guint command,
+			     GArray *args, GArray *params,
+			     GError **exception);
+
+#endif
diff --git a/libhinawa/src/snd_unit.c b/libhinawa/src/snd_unit.c
index b7537a3..eea6bbe 100644
--- a/libhinawa/src/snd_unit.c
+++ b/libhinawa/src/snd_unit.c
@@ -7,6 +7,7 @@
 #include "fw_req.h"
 #include "fw_fcp.h"
 #include "snd_dice.h"
+#include "snd_efw.h"
 #include "internal.h"
 
 #ifdef HAVE_CONFIG_H
@@ -412,6 +413,10 @@ static gboolean check_src(GSource *gsrc)
 		 common->type == SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION)
 		hinawa_snd_dice_handle_notification(HINAWA_SND_DICE(unit),
 						    priv->buf, len);
+	else if (HINAWA_IS_SND_EFW(unit) &&
+		 common->type == SNDRV_FIREWIRE_EVENT_EFW_RESPONSE)
+		hinawa_snd_efw_handle_response(HINAWA_SND_EFW(unit),
+					       priv->buf, len);
 end:
 	/* Don't go to dispatch, then continue to process this source. */
 	return FALSE;
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
