From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/13] libhinawa: add 'snd_dice' object as a helper for Dice
	notification
Date: Sun, 25 Jan 2015 20:34:31 +0900
Message-ID: <1422185674-16431-11-git-send-email-o-takashi@sakamocchi.jp>
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

Dice is 'Digital Interface Communications Engine' which TC Applied
Technologies produced. Several chipset are produced under a name
of Dice. For Dice chipset, well-known FCP or AV/C commands are not
used to control devices. It's performed by read/write transactions
into specific addresses.

Dice has a specific mechanism called as 'notification'. When device
status is changed, Dice devices tells the event by sending transaction.
This notification is sent to an address to which ALSA Dice driver
listens. Then the driver allows applications to read it via ALSA
hwdep interface.

This commit adds HINAWA_TYPE_SND_DICE object to handle the notification.
When applications calls listen() method, the instance generates
'notified' signal when the Dice unit transfer notification. This object
also have transact() method. An application can change unit status and
wait the notification with given bit flag.

This object is an inheritance of HINAWA_TYPE_SND_UNIT, thus any
signals and properties, methods are also available.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/doc/reference/hinawa-docs.sgml |   1 +
 libhinawa/src/Makefile.am                |   7 +-
 libhinawa/src/internal.h                 |   3 +
 libhinawa/src/snd_dice.c                 | 195 +++++++++++++++++++++++++++++++
 libhinawa/src/snd_dice.h                 |  53 +++++++++
 libhinawa/src/snd_unit.c                 |   5 +
 6 files changed, 262 insertions(+), 2 deletions(-)
 create mode 100644 libhinawa/src/snd_dice.c
 create mode 100644 libhinawa/src/snd_dice.h

diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
index 8d4483e..58c862a 100644
--- a/libhinawa/doc/reference/hinawa-docs.sgml
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -35,6 +35,7 @@
             <xi:include href="xml/fw_req.xml"/>
             <xi:include href="xml/fw_fcp.xml"/>
             <xi:include href="xml/snd_unit.xml"/>
+            <xi:include href="xml/snd_dice.xml"/>
         </chapter>
     </part>
 
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index b717e4e..696e567 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -34,7 +34,9 @@ libhinawa_la_SOURCES =				\
 	fw_fcp.h				\
 	fw_fcp.c				\
 	snd_unit.h				\
-	snd_unit.c
+	snd_unit.c				\
+	snd_dice.h				\
+	snd_dice.c
 
 pkginclude_HEADERS =				\
 	hinawa_sigs_marshal.h			\
@@ -42,7 +44,8 @@ pkginclude_HEADERS =				\
 	fw_resp.h				\
 	fw_req.h				\
 	fw_fcp.h				\
-	snd_unit.h
+	snd_unit.h				\
+	snd_dice.h
 
 hinawa_sigs_marshal.list:
 	$(AM_V_GEN)( find | grep \.c$$ | xargs cat | 			\
diff --git a/libhinawa/src/internal.h b/libhinawa/src/internal.h
index 717cda3..ddbb298 100644
--- a/libhinawa/src/internal.h
+++ b/libhinawa/src/internal.h
@@ -12,6 +12,7 @@
 #include "fw_resp.h"
 #include "fw_req.h"
 #include "snd_unit.h"
+#include "snd_dice.h"
 
 void hinawa_fw_unit_ioctl(HinawaFwUnit *self, int req, void *args, int *err);
 void hinawa_fw_resp_handle_request(HinawaFwResp *self,
@@ -22,4 +23,6 @@ void hinawa_fw_req_handle_response(HinawaFwReq *self,
 void hinawa_snd_unit_write(HinawaSndUnit *unit,
 			   const void *buf, unsigned int length,
 			   GError **exception);
+void hinawa_snd_dice_handle_notification(HinawaSndDice *self,
+					 const void *buf, unsigned int len);
 #endif
diff --git a/libhinawa/src/snd_dice.c b/libhinawa/src/snd_dice.c
new file mode 100644
index 0000000..a3b839e
--- /dev/null
+++ b/libhinawa/src/snd_dice.c
@@ -0,0 +1,195 @@
+#include <linux/types.h>
+#include <sound/firewire.h>
+#include <alsa/asoundlib.h>
+#include "snd_dice.h"
+#include "internal.h"
+
+#ifdef HAVE_CONFIG_H
+#  include <config.h>
+#endif
+
+/**
+ * SECTION:snd_dice
+ * @Title: HinawaSndDice
+ * @Short_description: A notification listener for Dice models
+ *
+ * A #HinawaSndDice listen to Dice notification and generates signal when
+ * received. This inherits #HinawaSndUnit.
+ */
+
+struct notification_waiter {
+	guint32 bit_flag;
+	GCond cond;
+};
+
+struct _HinawaSndDicePrivate {
+	GList *waiters;
+	GMutex lock;
+};
+G_DEFINE_TYPE_WITH_PRIVATE(HinawaSndDice, hinawa_snd_dice, HINAWA_TYPE_SND_UNIT)
+#define SND_DICE_GET_PRIVATE(obj)					\
+	(G_TYPE_INSTANCE_GET_PRIVATE((obj),				\
+				     HINAWA_TYPE_SND_DICE,		\
+				     HinawaSndDicePrivate))
+
+/* This object has one signal. */
+enum dice_sig_type {
+	DICE_SIG_TYPE_NOTIFIED,
+	DICE_SIG_TYPE_COUNT,
+};
+static guint dice_sigs[DICE_SIG_TYPE_COUNT] = { 0 };
+
+static void snd_dice_dispose(GObject *obj)
+{
+	G_OBJECT_CLASS(hinawa_snd_dice_parent_class)->dispose(obj);
+}
+
+static void snd_dice_finalize(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_snd_dice_parent_class)->finalize(gobject);
+}
+
+static void hinawa_snd_dice_class_init(HinawaSndDiceClass *klass)
+{
+	GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
+
+	gobject_class->dispose = snd_dice_dispose;
+	gobject_class->finalize = snd_dice_finalize;
+
+	/**
+	 * HinawaSndDice::notified:
+	 * @self: A #HinawaSndDice
+	 * @message: A notification message
+	 *
+	 * When Dice models transfer notification, the ::notified signal is
+	 * generated.
+	 */
+	dice_sigs[DICE_SIG_TYPE_NOTIFIED] =
+		g_signal_new("notified",
+			     G_OBJECT_CLASS_TYPE(klass),
+			     G_SIGNAL_RUN_LAST,
+			     0,
+			     NULL, NULL,
+			     g_cclosure_marshal_VOID__ULONG,
+			     G_TYPE_NONE, 1, G_TYPE_ULONG);
+}
+
+static void hinawa_snd_dice_init(HinawaSndDice *self)
+{
+	self->priv = hinawa_snd_dice_get_instance_private(self);
+}
+
+/**
+ * hinawa_snd_dice_new:
+ * @path: A path to ALSA hwdep device for Dice models (i.e. hw:0)
+ * @exception: A #GError
+ *
+ * Returns: An instance of #HinawaSndDice
+ */
+void hinawa_snd_dice_open(HinawaSndDice *self, gchar *path, GError **exception)
+{
+	HinawaSndDicePrivate *priv;
+	int type;
+
+	g_return_if_fail(HINAWA_IS_SND_DICE(self));
+
+	hinawa_snd_unit_open(&self->parent_instance, path, exception);
+	if (*exception != NULL) {
+		g_clear_object(&self);
+		return;
+	}
+
+	g_object_get(G_OBJECT(self), "type", &type, NULL);
+	if (type != SNDRV_FIREWIRE_TYPE_DICE) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EINVAL, "%s", strerror(EINVAL));
+		g_clear_object(&self);
+	}
+	priv = SND_DICE_GET_PRIVATE(self);
+
+	priv->waiters = NULL;
+	g_mutex_init(&priv->lock);
+}
+
+/**
+ * hinawa_snd_dice_transact:
+ * @self: A #HinawaSndDice
+ * @addr: A destination address of target device
+ * @frame: (element-type guint32) (array) (in): a 32bit array
+ * @bit_flag: bit flag to wait
+ * @exception: A #GError
+ *
+ * Execute write transactions to the given address, then wait and check
+ * notification.
+ */
+void hinawa_snd_dice_transact(HinawaSndDice *self, guint64 addr,
+			      GArray *frame, guint32 bit_flag,
+			      GError **exception)
+{
+	HinawaSndDicePrivate *priv;
+	struct notification_waiter waiter = {0};
+	gint64 expiration;
+
+	g_return_if_fail(HINAWA_IS_SND_DICE(self));
+	priv = SND_DICE_GET_PRIVATE(self);
+
+	/* Insert this entry to list and enter critical section. */
+	g_mutex_lock(&priv->lock);
+	priv->waiters = g_list_append(priv->waiters, &waiter);
+
+	/* NOTE: Timeout is 200 milli-seconds. */
+	expiration = g_get_monotonic_time() + 200 * G_TIME_SPAN_MILLISECOND;
+	g_cond_init(&waiter.cond);
+
+	waiter.bit_flag = bit_flag;
+	hinawa_snd_unit_write_transact(&self->parent_instance, addr, frame,
+				       exception);
+	if (*exception != NULL)
+		goto end;
+
+	/*
+	 * Wait notification till timeout and temporarily leave the critical
+	 * section.
+	 */
+	if (!g_cond_wait_until(&waiter.cond, &priv->lock, expiration))
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ETIMEDOUT, "%s", strerror(ETIMEDOUT));
+end:
+	priv->waiters = g_list_remove(priv->waiters, (gpointer *)&waiter);
+
+	g_mutex_unlock(&priv->lock);
+}
+
+void hinawa_snd_dice_handle_notification(HinawaSndDice *self,
+					 const void *buf, unsigned int len)
+{
+	HinawaSndDicePrivate *priv;
+
+	GList *entry;
+	struct notification_waiter *waiter;
+
+	struct snd_firewire_event_dice_notification *event =
+			(struct snd_firewire_event_dice_notification *)buf;
+
+	g_return_if_fail(HINAWA_IS_SND_DICE(self));
+	priv = SND_DICE_GET_PRIVATE(self);
+
+	g_signal_emit(self, dice_sigs[DICE_SIG_TYPE_NOTIFIED],
+		      0, event->notification);
+
+	g_mutex_lock(&priv->lock);
+
+	for (entry = priv->waiters; entry != NULL; entry = entry->next) {
+		waiter = (struct notification_waiter *)entry->data;
+
+		if (waiter->bit_flag & event->notification)
+			break;
+	}
+
+	g_mutex_unlock(&priv->lock);
+
+	if (entry == NULL)
+		return;
+
+	g_cond_signal(&waiter->cond);
+}
diff --git a/libhinawa/src/snd_dice.h b/libhinawa/src/snd_dice.h
new file mode 100644
index 0000000..f33835a
--- /dev/null
+++ b/libhinawa/src/snd_dice.h
@@ -0,0 +1,53 @@
+#ifndef __ALSA_TOOLS_HINAWA_SND_DICE_H__
+#define __ALSA_TOOLS_HINAWA_SND_DICE_H__
+
+#include <glib.h>
+#include <glib-object.h>
+#include "snd_unit.h"
+
+G_BEGIN_DECLS
+
+#define HINAWA_TYPE_SND_DICE	(hinawa_snd_dice_get_type())
+
+#define HINAWA_SND_DICE(obj)					\
+	(G_TYPE_CHECK_INSTANCE_CAST((obj),			\
+				    HINAWA_TYPE_SND_DICE,	\
+				    HinawaSndDice))
+#define HINAWA_IS_SND_DICE(obj)					\
+	(G_TYPE_CHECK_INSTANCE_TYPE((obj),			\
+				    HINAWA_TYPE_SND_DICE))
+
+#define HINAWA_SND_DICE_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_CAST((klass),			\
+				 HINAWA_TYPE_SND_DICE,		\
+				 HinawaSndDiceClass))
+#define HINAWA_IS_SND_DICE_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_TYPE((klass),			\
+				 HINAWA_TYPE_SND_DICE))
+#define HINAWA_SND_DICE_GET_CLASS(obj)				\
+	(G_TYPE_INSTANCE_GET_CLASS((obj),			\
+				   HINAWA_TYPE_SND_DICE,	\
+				   HinawaSndDiceClass))
+
+typedef struct _HinawaSndDice		HinawaSndDice;
+typedef struct _HinawaSndDiceClass	HinawaSndDiceClass;
+typedef struct _HinawaSndDicePrivate	HinawaSndDicePrivate;
+
+struct _HinawaSndDice {
+	HinawaSndUnit parent_instance;
+
+	HinawaSndDicePrivate *priv;
+};
+
+struct _HinawaSndDiceClass {
+	HinawaSndUnitClass parent_class;
+};
+
+GType hinawa_snd_dice_get_type(void) G_GNUC_CONST;
+
+void hinawa_snd_dice_open(HinawaSndDice *self, gchar *path, GError **exception);
+
+void hinawa_snd_dice_transact(HinawaSndDice *self, guint64 addr,
+			      GArray *frame, guint32 bit_flag,
+			      GError **exception);
+#endif
diff --git a/libhinawa/src/snd_unit.c b/libhinawa/src/snd_unit.c
index 859cab2..b7537a3 100644
--- a/libhinawa/src/snd_unit.c
+++ b/libhinawa/src/snd_unit.c
@@ -6,6 +6,7 @@
 #include "snd_unit.h"
 #include "fw_req.h"
 #include "fw_fcp.h"
+#include "snd_dice.h"
 #include "internal.h"
 
 #ifdef HAVE_CONFIG_H
@@ -407,6 +408,10 @@ static gboolean check_src(GSource *gsrc)
 
 	if (common->type == SNDRV_FIREWIRE_EVENT_LOCK_STATUS)
 		handle_lock_event(unit, priv->buf, len);
+	else if (HINAWA_IS_SND_DICE(unit) &&
+		 common->type == SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION)
+		hinawa_snd_dice_handle_notification(HINAWA_SND_DICE(unit),
+						    priv->buf, len);
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
