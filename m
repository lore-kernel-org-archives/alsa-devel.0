From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/13] libhinawa: add 'snd_unit' object as a listener for ALSA
	FireWire devices
Date: Sun, 25 Jan 2015 20:34:30 +0900
Message-ID: <1422185674-16431-10-git-send-email-o-takashi@sakamocchi.jp>
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

ALSA in Linux 3.16 or later extended its support for FireWire sound
devices. Some of ALSA FireWire sound drivers handle any events from
units on IEEE 1394 bus to control AMDTP streams. These drivers
gives a way for applications to read these events via ALSA hwdep
interface.

This commit adds HINAWA_TYPE_SND_UNIT object to listen to the events.
This object uses ALSA hwdep interface to communicate with ALSA FireWire
drivers, therefore depends on:
 - alsa-lib 2.0.28 or later

When constructing an instance of this object and calling open() method
with the name of ALSA hwdep node, then these properties are available:
 - type:	the value of SNDRV_FIREWIRE_TYPE_XXX in <sound/firewire.h>
 - card:	the numerical ID of this sound card
 - device:	the name of FireWire character device for this sound card
 - guid:	the GUID of unit for this sound card
 - streaming:	whether ALSA FireWire driver starts streaming or not
 - generation:	the bus generation (inherited from fw_unit)

This object is an inheritance of HINAWA_TYPE_FW_UNIT, thus some properties
and signals are also available. Additionally, this object gives methods for
read/write/lock/fcp transactions.

These methods are also available:
 - listen():	start listening to events
 - unlisten():	stop listening to events
 - lock():	lock streaming functionality of ALSA FireWire driver
 - unlock():	unlock streaming functionality of ALSA FireWire driver
 - read_transact():	do IEEE 1394 read transaction
 - write_transact():	do IEEE 1394 write transaction
 - lock_transact():	do IEEE 1394 lock transaction
 - fcp_transact():	do IEC 61883-1 FCP transaction

When calling listen() method, 'streaming' property is valid.
Additionally, the instance generates 'lock-status' signal when ALSA
FireWire driver starts or stops AMDTP streams, so as 'bus-update'
signal.

These signals are also available:
 - lock-status:	at changing the status of streaming functionality
 - bus-update:	IEEE 1394 bus reset (inherited from fw_unit)

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/README                         |   1 +
 libhinawa/configure.ac                   |   3 +
 libhinawa/doc/reference/hinawa-docs.sgml |   1 +
 libhinawa/src/Makefile.am                |  13 +-
 libhinawa/src/backport.h                 |  41 +++
 libhinawa/src/internal.h                 |   6 +
 libhinawa/src/snd_unit.c                 | 538 +++++++++++++++++++++++++++++++
 libhinawa/src/snd_unit.h                 |  69 ++++
 8 files changed, 668 insertions(+), 4 deletions(-)
 create mode 100644 libhinawa/src/backport.h
 create mode 100644 libhinawa/src/snd_unit.c
 create mode 100644 libhinawa/src/snd_unit.h

diff --git a/libhinawa/README b/libhinawa/README
index 1bd0d52..42d31f5 100644
--- a/libhinawa/README
+++ b/libhinawa/README
@@ -5,6 +5,7 @@ Requirements
 - Glib 2.32.4 or later
 - GTK-Doc 1.18-2
 - GObject Introspection 1.32.1 or later
+- alsa-lib 1.0.28 or later
 
 How to build
  $ ./autogen.sh
diff --git a/libhinawa/configure.ac b/libhinawa/configure.ac
index b0d9517..d18b08c 100644
--- a/libhinawa/configure.ac
+++ b/libhinawa/configure.ac
@@ -52,6 +52,9 @@ GTK_DOC_CHECK([1.18-2])
 # GObject introspection 1.32.1 or later
 GOBJECT_INTROSPECTION_REQUIRE([1.32.1])
 
+# alsa-lib 1.0.28 or later
+AM_PATH_ALSA(1.0.28)
+
 # The files generated from *.in
 AC_CONFIG_FILES([
   Makefile
diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
index d5773a5..8d4483e 100644
--- a/libhinawa/doc/reference/hinawa-docs.sgml
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -34,6 +34,7 @@
             <xi:include href="xml/fw_resp.xml"/>
             <xi:include href="xml/fw_req.xml"/>
             <xi:include href="xml/fw_fcp.xml"/>
+            <xi:include href="xml/snd_unit.xml"/>
         </chapter>
     </part>
 
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index 0a64658..b717e4e 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -18,7 +18,8 @@ libhinawa_la_LDFLAGS =				\
 	-version-info $(LT_IFACE)
 
 libhinawa_la_LIBADD =				\
-	$(GLIB_LIBS)
+	$(GLIB_LIBS)				\
+	-lasound
 
 libhinawa_la_SOURCES =				\
 	hinawa_context.c			\
@@ -31,14 +32,17 @@ libhinawa_la_SOURCES =				\
 	fw_req.h				\
 	fw_req.c				\
 	fw_fcp.h				\
-	fw_fcp.c
+	fw_fcp.c				\
+	snd_unit.h				\
+	snd_unit.c
 
 pkginclude_HEADERS =				\
 	hinawa_sigs_marshal.h			\
 	fw_unit.h				\
 	fw_resp.h				\
 	fw_req.h				\
-	fw_fcp.h
+	fw_fcp.h				\
+	snd_unit.h
 
 hinawa_sigs_marshal.list:
 	$(AM_V_GEN)( find | grep \.c$$ | xargs cat | 			\
@@ -68,7 +72,8 @@ Hinawa_1_0_gir_LIBS = libhinawa.la
 Hinawa_1_0_gir_FILES = $(libhinawa_la_SOURCES)
 Hinawa_1_0_gir_SCANNERFLAGS =			\
 	--identifier-prefix=Hinawa		\
-	--symbol-prefix=hinawa
+	--symbol-prefix=hinawa			\
+	-lasound
 INTROSPECTION_GIRS += Hinawa-1.0.gir
 
 girdir = $(datadir)/gir-1.0
diff --git a/libhinawa/src/backport.h b/libhinawa/src/backport.h
new file mode 100644
index 0000000..816954f
--- /dev/null
+++ b/libhinawa/src/backport.h
@@ -0,0 +1,41 @@
+/* backporting from 3.16 */
+
+/* alsa-lib 1.0.28 is a lack of some Hwdep interfaces */
+#ifndef SND_HWDEP_IFACE_FW_DICE
+#define SND_HWDEP_IFACE_FW_DICE		(SND_HWDEP_IFACE_SB_RC + 3)
+#define SND_HWDEP_IFACE_FW_FIREWORKS	(SND_HWDEP_IFACE_SB_RC + 4)
+#define SND_HWDEP_IFACE_FW_BEBOB	(SND_HWDEP_IFACE_SB_RC + 5)
+#define SND_HWDEP_IFACE_FW_OXFW		(SND_HWDEP_IFACE_SB_RC + 6)
+#endif
+
+
+
+#ifndef SND_EFW_TRANSACTION_USER_SEQNUM_MAX
+
+#include <linux/types.h>
+
+#define SND_EFW_TRANSACTION_USER_SEQNUM_MAX	((__u32)((__u16)~0) - 1)
+
+/* each field should be in big endian */
+struct snd_efw_transaction {
+	__be32 length;
+	__be32 version;
+	__be32 seqnum;
+	__be32 category;
+	__be32 command;
+	__be32 status;
+	__be32 params[0];
+};
+struct snd_firewire_event_efw_response {
+	unsigned int type;
+	__be32 response[0];	/* some responses */
+};
+
+#define SNDRV_FIREWIRE_EVENT_EFW_RESPONSE       0x4e617475
+
+#define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
+#define SNDRV_FIREWIRE_TYPE_BEBOB	3
+#define SNDRV_FIREWIRE_TYPE_OXFW	4
+
+#endif
+
diff --git a/libhinawa/src/internal.h b/libhinawa/src/internal.h
index 7ac672c..717cda3 100644
--- a/libhinawa/src/internal.h
+++ b/libhinawa/src/internal.h
@@ -7,13 +7,19 @@
 #include <linux/firewire-cdev.h>
 #include <linux/firewire-constants.h>
 
+#include "backport.h"
 #include "fw_unit.h"
 #include "fw_resp.h"
 #include "fw_req.h"
+#include "snd_unit.h"
 
 void hinawa_fw_unit_ioctl(HinawaFwUnit *self, int req, void *args, int *err);
 void hinawa_fw_resp_handle_request(HinawaFwResp *self,
 				   struct fw_cdev_event_request2 *event);
 void hinawa_fw_req_handle_response(HinawaFwReq *self,
 				   struct fw_cdev_event_response *event);
+
+void hinawa_snd_unit_write(HinawaSndUnit *unit,
+			   const void *buf, unsigned int length,
+			   GError **exception);
 #endif
diff --git a/libhinawa/src/snd_unit.c b/libhinawa/src/snd_unit.c
new file mode 100644
index 0000000..859cab2
--- /dev/null
+++ b/libhinawa/src/snd_unit.c
@@ -0,0 +1,538 @@
+#include <unistd.h>
+#include <alsa/asoundlib.h>
+#include <sound/firewire.h>
+
+#include "hinawa_context.h"
+#include "snd_unit.h"
+#include "fw_req.h"
+#include "fw_fcp.h"
+#include "internal.h"
+
+#ifdef HAVE_CONFIG_H
+#  include <config.h>
+#endif
+
+/**
+ * SECTION:snd_unit
+ * @Title: HinawaSndUnit
+ * @Short_description: An event listener for ALSA FireWire sound devices
+ *
+ * This class is an application of ALSA FireWire stack. Any functionality which
+ * ALSA drivers in the stack can be available.
+ */
+
+typedef struct {
+	GSource src;
+	HinawaSndUnit *unit;
+	gpointer tag;
+} SndUnitSource;
+
+struct _HinawaSndUnitPrivate {
+	snd_hwdep_t *hwdep;
+	struct snd_firewire_get_info info;
+
+	gboolean streaming;
+
+	void *buf;
+	unsigned int len;
+	SndUnitSource *src;
+
+	HinawaFwReq *req;
+	HinawaFwFcp *fcp;
+};
+G_DEFINE_TYPE_WITH_PRIVATE(HinawaSndUnit, hinawa_snd_unit, HINAWA_TYPE_FW_UNIT)
+#define SND_UNIT_GET_PRIVATE(obj)					\
+	(G_TYPE_INSTANCE_GET_PRIVATE((obj),				\
+				HINAWA_TYPE_SND_UNIT, HinawaSndUnitPrivate))
+
+enum snd_unit_prop_type {
+	SND_UNIT_PROP_TYPE_FW_TYPE = 1,
+	SND_UNIT_PROP_TYPE_CARD,
+	SND_UNIT_PROP_TYPE_DEVICE,
+	SND_UNIT_PROP_TYPE_GUID,
+	SND_UNIT_PROP_TYPE_STREAMING,
+	SND_UNIT_PROP_TYPE_COUNT,
+};
+static GParamSpec *snd_unit_props[SND_UNIT_PROP_TYPE_COUNT] = { NULL, };
+
+/* This object has one signal. */
+enum snd_unit_sig_type {
+	SND_UNIT_SIG_TYPE_LOCK_STATUS = 0,
+	SND_UNIT_SIG_TYPE_COUNT,
+};
+static guint snd_unit_sigs[SND_UNIT_SIG_TYPE_COUNT] = { 0 };
+
+static void snd_unit_get_property(GObject *obj, guint id,
+				  GValue *val, GParamSpec *spec)
+{
+	HinawaSndUnit *self = HINAWA_SND_UNIT(obj);
+	HinawaSndUnitPrivate *priv = SND_UNIT_GET_PRIVATE(self);
+
+	switch (id) {
+	case SND_UNIT_PROP_TYPE_FW_TYPE:
+		g_value_set_int(val, priv->info.type);
+		break;
+	case SND_UNIT_PROP_TYPE_CARD:
+		g_value_set_int(val, priv->info.card);
+		break;
+	case SND_UNIT_PROP_TYPE_DEVICE:
+		g_value_set_string(val, (const gchar *)priv->info.device_name);
+		break;
+	case SND_UNIT_PROP_TYPE_GUID:
+		g_value_set_uint64(val,
+				GUINT64_FROM_BE(*((guint64 *)priv->info.guid)));
+		break;
+	case SND_UNIT_PROP_TYPE_STREAMING:
+		g_value_set_boolean(val, priv->streaming);
+		break;
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(obj, id, spec);
+		break;
+	}
+}
+
+static void snd_unit_set_property(GObject *obj, guint id,
+				  const GValue *val, GParamSpec *spec)
+{
+	G_OBJECT_WARN_INVALID_PROPERTY_ID(obj, id, spec);
+}
+
+static void snd_unit_dispose(GObject *obj)
+{
+	HinawaSndUnit *self = HINAWA_SND_UNIT(obj);
+	HinawaSndUnitPrivate *priv = SND_UNIT_GET_PRIVATE(self);
+
+	if (priv->src != NULL)
+		hinawa_snd_unit_unlisten(self);
+
+	snd_hwdep_close(priv->hwdep);
+	g_clear_object(&priv->req);
+	g_clear_object(&priv->fcp);
+
+	G_OBJECT_CLASS(hinawa_snd_unit_parent_class)->dispose(obj);
+}
+
+static void snd_unit_finalize(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_snd_unit_parent_class)->finalize(gobject);
+}
+
+static void hinawa_snd_unit_class_init(HinawaSndUnitClass *klass)
+{
+	GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
+
+	gobject_class->get_property = snd_unit_get_property;
+	gobject_class->set_property = snd_unit_set_property;
+	gobject_class->dispose = snd_unit_dispose;
+	gobject_class->finalize = snd_unit_finalize;
+
+	snd_unit_props[SND_UNIT_PROP_TYPE_FW_TYPE] =
+		g_param_spec_int("type", "type",
+				 "The value of SNDRV_FIREWIRE_TYPE_XXX",
+				 0, INT_MAX,
+				 0,
+				 G_PARAM_READABLE);
+	snd_unit_props[SND_UNIT_PROP_TYPE_CARD] =
+		g_param_spec_int("card", "card",
+				 "A numerical ID for ALSA sound card",
+				 0, INT_MAX,
+				 0,
+				 G_PARAM_READABLE);
+	snd_unit_props[SND_UNIT_PROP_TYPE_DEVICE] =
+		g_param_spec_string("device", "device",
+				    "A name of special file as FireWire unit.",
+				    NULL,
+				    G_PARAM_READABLE);
+	snd_unit_props[SND_UNIT_PROP_TYPE_STREAMING] =
+		g_param_spec_boolean("streaming", "streaming",
+				     "Whether this device is streaming or not",
+				     FALSE,
+				     G_PARAM_READABLE);
+	snd_unit_props[SND_UNIT_PROP_TYPE_GUID] =
+		g_param_spec_uint64("guid", "guid",
+				    "Global unique ID for this firewire unit.",
+				    0, ULONG_MAX, 0,
+				    G_PARAM_READABLE);
+
+	g_object_class_install_properties(gobject_class,
+					  SND_UNIT_PROP_TYPE_COUNT,
+					  snd_unit_props);
+
+	/**
+	 * HinawaSndUnit::lock-status:
+	 * @self: A #HinawaSndUnit
+	 * @state: %TRUE when locked, %FALSE when unlocked.
+	 *
+	 * When ALSA kernel-streaming status is changed, this ::lock-status
+	 * signal is generated.
+	 */
+	snd_unit_sigs[SND_UNIT_SIG_TYPE_LOCK_STATUS] =
+		g_signal_new("lock-status",
+			     G_OBJECT_CLASS_TYPE(klass),
+			     G_SIGNAL_RUN_LAST,
+			     0,
+			     NULL, NULL,
+			     g_cclosure_marshal_VOID__BOOLEAN,
+			     G_TYPE_NONE, 1, G_TYPE_BOOLEAN);
+}
+
+static void hinawa_snd_unit_init(HinawaSndUnit *self)
+{
+	self->priv = hinawa_snd_unit_get_instance_private(self);
+}
+
+/* For internal use. */
+void hinawa_snd_unit_open(HinawaSndUnit *self, gchar *path, GError **exception)
+{
+	HinawaSndUnitPrivate *priv;
+	snd_hwdep_t *hwdep = NULL;
+	char fw_cdev[32];
+	int err;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+	priv = SND_UNIT_GET_PRIVATE(self);
+
+	err = snd_hwdep_open(&hwdep, path, SND_HWDEP_OPEN_DUPLEX);
+	if (err < 0)
+		goto end;
+
+	/* Get FireWire sound device information. */
+	err = snd_hwdep_ioctl(hwdep, SNDRV_FIREWIRE_IOCTL_GET_INFO,
+			      &priv->info);
+	if (err < 0)
+		goto end;
+
+	snprintf(fw_cdev, sizeof(fw_cdev), "/dev/%s", priv->info.device_name);
+	hinawa_fw_unit_open(&self->parent_instance, fw_cdev, exception);
+	if (*exception != NULL)
+		goto end;
+
+	priv->hwdep = hwdep;
+	priv->req = g_object_new(HINAWA_TYPE_FW_REQ, NULL);
+	priv->fcp = g_object_new(HINAWA_TYPE_FW_FCP, NULL);
+end:
+	if (err < 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    -err, "%s", snd_strerror(err));
+	if (*exception != NULL)
+		snd_hwdep_close(hwdep);
+}
+
+/**
+ * hinawa_snd_unit_lock:
+ * @self: A #HinawaSndUnit
+ * @exception: A #GError
+ *
+ * Disallow ALSA to start kernel-streaming.
+ */
+void hinawa_snd_unit_lock(HinawaSndUnit *self, GError **exception)
+{
+	int err;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+
+	err = snd_hwdep_ioctl(self->priv->hwdep, SNDRV_FIREWIRE_IOCTL_LOCK,
+			      NULL);
+	if (err < 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    -err, "%s", snd_strerror(err));
+}
+
+/**
+ * hinawa_snd_unit_unlock:
+ * @self: A #HinawaSndUnit
+ * @exception: A #GError
+ *
+ * Allow ALSA to start kernel-streaming.
+ */
+void hinawa_snd_unit_unlock(HinawaSndUnit *self, GError **exception)
+{
+	int err;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+
+	err = snd_hwdep_ioctl(self->priv->hwdep, SNDRV_FIREWIRE_IOCTL_UNLOCK,
+			      NULL);
+	if (err < 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    -err, "%s", snd_strerror(err));
+}
+
+/**
+ * hinawa_snd_unit_read_transact:
+ * @self: A #HinawaSndUnit
+ * @addr: A destination address of target device
+ * @frame: (element-type guint32) (array) (out caller-allocates): a 32bit array
+ * @len: the bytes to read
+ * @exception: A #GError
+ *
+ * Execute read transaction to the given unit.
+ */
+void hinawa_snd_unit_read_transact(HinawaSndUnit *self,
+				   guint64 addr, GArray *frame, guint len,
+				   GError **exception)
+{
+	HinawaSndUnitPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+	priv = SND_UNIT_GET_PRIVATE(self);
+
+	hinawa_fw_req_read(priv->req, &self->parent_instance, addr, frame, len,
+			   exception);
+}
+
+/**
+ * hinawa_snd_unit_write_transact:
+ * @self: A #HinawaSndUnit
+ * @addr: A destination address of target device
+ * @frame: (element-type guint32) (array) (in): a 32bit array
+ * @exception: A #GError
+ *
+ * Execute write transactions to the given unit.
+ */
+void hinawa_snd_unit_write_transact(HinawaSndUnit *self,
+				    guint64 addr, GArray *frame,
+				    GError **exception)
+{
+	HinawaSndUnitPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+	priv = SND_UNIT_GET_PRIVATE(self);
+
+	hinawa_fw_req_write(priv->req, &self->parent_instance, addr, frame,
+			    exception);
+}
+
+/**
+ * hinawa_snd_unit_lock_transact:
+ * @self: A #HinawaSndUnit
+ * @addr: A destination address of target device
+ * @frame: (element-type guint32) (array) (inout): a 32bit array
+ * @exception: A #GError
+ *
+ * Execute lock transaction to the given unit.
+ */
+void hinawa_snd_unit_lock_transact(HinawaSndUnit *self,
+				   guint64 addr, GArray *frame,
+				   GError **exception)
+{
+	HinawaSndUnitPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+	priv = SND_UNIT_GET_PRIVATE(self);
+
+	hinawa_fw_req_lock(priv->req, &self->parent_instance, addr, frame,
+			   exception);
+}
+
+/**
+ * hinawa_snd_unit_fcp_transact:
+ * @self: A #HinawaSndUnit
+ * @req_frame:  (element-type guint8) (array) (in): a byte frame for request
+ * @resp_frame: (element-type guint8) (array) (out caller-allocates): a byte
+ *		frame for response
+ * @exception: A #GError
+ */
+void hinawa_snd_unit_fcp_transact(HinawaSndUnit *self,
+				  GArray *req_frame, GArray *resp_frame,
+				  GError **exception)
+{
+	HinawaSndUnitPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+	priv = SND_UNIT_GET_PRIVATE(self);
+
+	hinawa_fw_fcp_transact(priv->fcp, req_frame, resp_frame, exception);
+}
+
+/* For internal use. */
+void hinawa_snd_unit_write(HinawaSndUnit *self,
+			   const void *buf, unsigned int length,
+			   GError **exception)
+{
+	int err;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+
+	err = snd_hwdep_write(self->priv->hwdep, buf, length);
+	if (err < 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    -err, "%s", snd_strerror(err));
+}
+
+static void handle_lock_event(HinawaSndUnit *self,
+			      void *buf, unsigned int length)
+{
+	struct snd_firewire_event_lock_status *event =
+			(struct snd_firewire_event_lock_status *)buf;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+
+	g_signal_emit(self, snd_unit_sigs[SND_UNIT_SIG_TYPE_LOCK_STATUS], 0,
+		      event->status);
+}
+
+static gboolean prepare_src(GSource *src, gint *timeout)
+{
+	/* Set 2msec for poll(2) timeout. */
+	*timeout = 2;
+
+	/* This source is not ready, let's poll(2) */
+	return FALSE;
+}
+
+static gboolean check_src(GSource *gsrc)
+{
+	SndUnitSource *src = (SndUnitSource *)gsrc;
+	HinawaSndUnit *unit = src->unit;
+	HinawaSndUnitPrivate *priv = SND_UNIT_GET_PRIVATE(unit);
+	GIOCondition condition;
+
+	struct snd_firewire_event_common *common;
+	int len;
+
+	if (unit == NULL)
+		goto end;
+
+	/* Let's process this source if any inputs are available. */
+	condition = g_source_query_unix_fd((GSource *)src, src->tag);
+	if (!(condition & G_IO_IN))
+		goto end;
+
+	len = snd_hwdep_read(priv->hwdep, priv->buf, priv->len);
+	if (len < 0)
+		goto end;
+
+	common = (struct snd_firewire_event_common *)priv->buf;
+
+	if (common->type == SNDRV_FIREWIRE_EVENT_LOCK_STATUS)
+		handle_lock_event(unit, priv->buf, len);
+end:
+	/* Don't go to dispatch, then continue to process this source. */
+	return FALSE;
+}
+
+static gboolean dispatch_src(GSource *src, GSourceFunc callback,
+			     gpointer user_data)
+{
+	/* Just be sure to continue to process this source. */
+	return TRUE;
+}
+
+/**
+ * hinawa_snd_unit_listen:
+ * @self: A #HinawaSndUnit
+ * @exception: A #GError
+ *
+ * Start listening to events.
+ */
+void hinawa_snd_unit_listen(HinawaSndUnit *self, GError **exception)
+{
+	static GSourceFuncs funcs = {
+		.prepare	= prepare_src,
+		.check		= check_src,
+		.dispatch	= dispatch_src,
+		.finalize	= NULL,
+	};
+	HinawaSndUnitPrivate *priv;
+	void *buf;
+	struct pollfd pfds;
+	GSource *src;
+	int err;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+	priv = SND_UNIT_GET_PRIVATE(self);
+
+	/*
+	 * MEMO: allocate one page because we cannot assume the size of
+	 * transaction frame.
+	 */
+	buf = g_malloc(getpagesize());
+	if (buf == NULL) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ENOMEM, "%s", strerror(ENOMEM));
+		return;
+	}
+
+	if (snd_hwdep_poll_descriptors(priv->hwdep, &pfds, 1) != 1) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    EINVAL, "%s", strerror(EINVAL));
+		return;
+	}
+
+	src = g_source_new(&funcs, sizeof(SndUnitSource));
+	if (src == NULL) {
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    ENOMEM, "%s", strerror(ENOMEM));
+		g_free(buf);
+		return;
+	}
+
+	g_source_set_name(src, "HinawaSndUnit");
+	g_source_set_priority(src, G_PRIORITY_HIGH_IDLE);
+	g_source_set_can_recurse(src, TRUE);
+
+	((SndUnitSource *)src)->unit = self;
+	priv->src = (SndUnitSource *)src;
+	priv->buf = buf;
+	priv->len = getpagesize();
+
+	((SndUnitSource *)src)->tag =
+		hinawa_context_add_src(src, pfds.fd, G_IO_IN, exception);
+	if (*exception != NULL) {
+		g_free(buf);
+		g_source_destroy(src);
+		priv->buf = NULL;
+		priv->len = 0;
+		priv->src = NULL;
+		return;
+	}
+
+	hinawa_fw_unit_listen(&self->parent_instance, exception);
+	if (*exception != NULL) {
+		hinawa_snd_unit_unlisten(self);
+		return;
+	}
+
+	hinawa_fw_fcp_listen(priv->fcp, &self->parent_instance, exception);
+	if (*exception != NULL) {
+		hinawa_snd_unit_unlisten(self);
+		hinawa_fw_unit_unlisten(&self->parent_instance);
+	}
+
+	/* Check locked or not. */
+	err = snd_hwdep_ioctl(priv->hwdep, SNDRV_FIREWIRE_IOCTL_LOCK,
+			      NULL);
+	priv->streaming = (err == -EBUSY);
+	if (err == -EBUSY)
+		return;
+	snd_hwdep_ioctl(priv->hwdep, SNDRV_FIREWIRE_IOCTL_UNLOCK, NULL);
+}
+
+/**
+ * hinawa_snd_unit_unlisten:
+ * @self: A #HinawaSndUnit
+ *
+ * Stop listening to events.
+ */
+void hinawa_snd_unit_unlisten(HinawaSndUnit *self)
+{
+	HinawaSndUnitPrivate *priv;
+
+	g_return_if_fail(HINAWA_IS_SND_UNIT(self));
+	priv = SND_UNIT_GET_PRIVATE(self);
+
+	if (priv->streaming)
+		snd_hwdep_ioctl(priv->hwdep, SNDRV_FIREWIRE_IOCTL_UNLOCK, NULL);
+
+	g_source_destroy((GSource *)priv->src);
+	g_free(priv->src);
+	priv->src = NULL;
+
+	g_free(priv->buf);
+	priv->buf = NULL;
+	priv->len = 0;
+
+	hinawa_fw_fcp_unlisten(priv->fcp);
+	hinawa_fw_unit_unlisten(&self->parent_instance);
+}
diff --git a/libhinawa/src/snd_unit.h b/libhinawa/src/snd_unit.h
new file mode 100644
index 0000000..01fcdab
--- /dev/null
+++ b/libhinawa/src/snd_unit.h
@@ -0,0 +1,69 @@
+#ifndef __ALSA_TOOLS_HINAWA_SND_UNIT_H__
+#define __ALSA_TOOLS_HINAWA_SND_UNIT_H__
+
+#include <glib.h>
+#include <glib-object.h>
+#include "fw_unit.h"
+
+G_BEGIN_DECLS
+
+#define HINAWA_TYPE_SND_UNIT	(hinawa_snd_unit_get_type())
+
+#define HINAWA_SND_UNIT(obj)					\
+	(G_TYPE_CHECK_INSTANCE_CAST((obj),			\
+				    HINAWA_TYPE_SND_UNIT,	\
+				    HinawaSndUnit))
+#define HINAWA_IS_SND_UNIT(obj)					\
+	(G_TYPE_CHECK_INSTANCE_TYPE((obj),			\
+				    HINAWA_TYPE_SND_UNIT))
+
+#define HINAWA_SND_UNIT_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_CAST((klass),			\
+				 HINAWA_TYPE_SND_UNIT,		\
+				 HinawaSndUnitClass))
+#define HINAWA_IS_SND_UNIT_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_TYPE((klass),			\
+				 HINAWA_TYPE_SND_UNIT))
+#define HINAWA_SND_UNIT_GET_CLASS(obj)				\
+	(G_TYPE_INSTANCE_GET_CLASS((obj),			\
+				   HINAWA_TYPE_SND_UNIT,	\
+				   HinawaSndUnitClass))
+
+typedef struct _HinawaSndUnit		HinawaSndUnit;
+typedef struct _HinawaSndUnitClass	HinawaSndUnitClass;
+typedef struct _HinawaSndUnitPrivate	HinawaSndUnitPrivate;
+
+struct _HinawaSndUnit {
+	HinawaFwUnit parent_instance;
+
+	HinawaSndUnitPrivate *priv;
+};
+
+struct _HinawaSndUnitClass {
+	HinawaFwUnitClass parent_class;
+};
+
+GType hinawa_snd_unit_get_type(void) G_GNUC_CONST;
+
+void hinawa_snd_unit_open(HinawaSndUnit *self, gchar *path, GError **exception);
+
+void hinawa_snd_unit_lock(HinawaSndUnit *self, GError **exception);
+void hinawa_snd_unit_unlock(HinawaSndUnit *self, GError **exception);
+
+void hinawa_snd_unit_read_transact(HinawaSndUnit *self,
+				   guint64 addr, GArray *frame, guint len,
+				   GError **exception);
+void hinawa_snd_unit_write_transact(HinawaSndUnit *self,
+				    guint64 addr, GArray *frame,
+				    GError **exception);
+void hinawa_snd_unit_lock_transact(HinawaSndUnit *self,
+				   guint64 addr, GArray *frame,
+				   GError **exception);
+void hinawa_snd_unit_fcp_transact(HinawaSndUnit *self,
+				  GArray *req_frame, GArray *resp_frame,
+				  GError **exception);
+
+void hinawa_snd_unit_listen(HinawaSndUnit *self, GError **exception);
+void hinawa_snd_unit_unlisten(HinawaSndUnit *self);
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
