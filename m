From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/13] libhinawa: add 'unit_query' as a query for ALSA
	FireWire devices
Date: Sun, 25 Jan 2015 20:34:33 +0900
Message-ID: <1422185674-16431-13-git-send-email-o-takashi@sakamocchi.jp>
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

To construct an instance of snd_unit/snd_dice/snd_efw, applications need
to know which hwdep device is corresponding to the target unit.

This commit adds HINAWA_TYPE_UNIT_QUERY object to query hwdep devices for
FireWire unit. This object has no constructor, therefore applications can
get sibling hwdep device or the type of given hwdep device without any
instances.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/doc/reference/hinawa-docs.sgml |   1 +
 libhinawa/src/Makefile.am                |   7 +-
 libhinawa/src/unit_query.c               | 116 +++++++++++++++++++++++++++++++
 libhinawa/src/unit_query.h               |  48 +++++++++++++
 4 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 libhinawa/src/unit_query.c
 create mode 100644 libhinawa/src/unit_query.h

diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
index 731ae15..dbfa0f2 100644
--- a/libhinawa/doc/reference/hinawa-docs.sgml
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -37,6 +37,7 @@
             <xi:include href="xml/snd_unit.xml"/>
             <xi:include href="xml/snd_dice.xml"/>
             <xi:include href="xml/snd_efw.xml"/>
+            <xi:include href="xml/unit_query.xml"/>
         </chapter>
     </part>
 
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index b746bf1..4fbbdd3 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -38,7 +38,9 @@ libhinawa_la_SOURCES =				\
 	snd_dice.h				\
 	snd_dice.c				\
 	snd_efw.h				\
-	snd_efw.c
+	snd_efw.c				\
+	unit_query.h				\
+	unit_query.c
 
 pkginclude_HEADERS =				\
 	hinawa_sigs_marshal.h			\
@@ -48,7 +50,8 @@ pkginclude_HEADERS =				\
 	fw_fcp.h				\
 	snd_unit.h				\
 	snd_dice.h				\
-	snd_efw.h
+	snd_efw.h				\
+	unit_query.h
 
 hinawa_sigs_marshal.list:
 	$(AM_V_GEN)( find | grep \.c$$ | xargs cat | 			\
diff --git a/libhinawa/src/unit_query.c b/libhinawa/src/unit_query.c
new file mode 100644
index 0000000..669513d
--- /dev/null
+++ b/libhinawa/src/unit_query.c
@@ -0,0 +1,116 @@
+#include <unistd.h>
+#include <alsa/asoundlib.h>
+#include <sound/firewire.h>
+
+#include "unit_query.h"
+
+/**
+ * SECTION:unit_query
+ * @Title: HinawaUnitQuery
+ * @Short_description: An query to seek ALSA FireWire devices
+ *
+ */
+G_DEFINE_TYPE(HinawaUnitQuery, hinawa_unit_query, G_TYPE_OBJECT)
+
+static void unit_query_dispose(GObject *obj)
+{
+	G_OBJECT_CLASS(hinawa_unit_query_parent_class)->dispose(obj);
+}
+
+static void unit_query_finalize(GObject *gobject)
+{
+	G_OBJECT_CLASS(hinawa_unit_query_parent_class)->finalize(gobject);
+}
+
+static void hinawa_unit_query_class_init(HinawaUnitQueryClass *klass)
+{
+	GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
+
+	gobject_class->dispose = unit_query_dispose;
+	gobject_class->finalize = unit_query_finalize;
+}
+
+static void hinawa_unit_query_init(HinawaUnitQuery *self)
+{
+	return;
+}
+
+/**
+ * hinawa_unit_query_get_sibling:
+ * @id: The ID of sibling.
+ * @exception: A #GError
+ *
+ * Returns: the ID of sibling.
+ */
+gint hinawa_unit_query_get_sibling(gint id, GError **exception)
+{
+	snd_ctl_t *handle = NULL;
+	int err;
+
+	/* NOTE: at least one sound device is expected to be detected. */
+	err = snd_ctl_open(&handle, "hw:0", 0);
+	if (err < 0)
+		goto end;
+
+	err = snd_ctl_hwdep_next_device(handle, &id);
+	if (err < 0)
+		goto end;
+	if (id < 0) {
+		err = -ENODEV;
+		goto end;
+	}
+
+	hinawa_unit_query_get_unit_type(id, exception);
+end:
+	if (err < 0) {
+		id = -1;
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    -err, "%s", snd_strerror(err));
+	}
+	if (handle != NULL)
+		snd_ctl_close(handle);
+
+	return id;
+}
+
+/**
+ * hinawa_unit_query_get_unit_type:
+ * @id: An ID for unit.
+ * @exception: An #GError
+ *
+ * Returns: The types of the unit. The value of SNDRV_FIREWIRE_TYPE_XXX.
+ */
+gint hinawa_unit_query_get_unit_type(gint id, GError **exception)
+{
+	snd_hwdep_t *handle = NULL;
+	char path[10] = {0};
+	struct snd_firewire_get_info info;
+	gint type = -1;
+	int err;
+
+	/* Check id and make device string */
+	if (id < 0) {
+		err = -EINVAL;
+		goto end;
+	}
+	snprintf(path, sizeof(path), "hw:%d", id);
+
+	/* Open hwdep handle. */
+	err = snd_hwdep_open(&handle, path, 0);
+	if (err < 0)
+		goto end;
+
+	/* Get FireWire sound device information. */
+	err = snd_hwdep_ioctl(handle, SNDRV_FIREWIRE_IOCTL_GET_INFO, &info);
+	if (err < 0)
+		goto end;
+	type = info.type;
+end:
+	if (err < 0)
+		g_set_error(exception, g_quark_from_static_string(__func__),
+			    -err, "%s", snd_strerror(err));
+	if (handle != NULL)
+		snd_hwdep_close(handle);
+
+	return type;
+}
diff --git a/libhinawa/src/unit_query.h b/libhinawa/src/unit_query.h
new file mode 100644
index 0000000..cdaf09b
--- /dev/null
+++ b/libhinawa/src/unit_query.h
@@ -0,0 +1,48 @@
+#ifndef __ALSA_TOOLS_HINAWA_UNIT_QUERY_H__
+#define __ALSA_TOOLS_HINAWA_UNIT_QUERY_H__
+
+#include <glib.h>
+#include <glib-object.h>
+
+G_BEGIN_DECLS
+
+#define HINAWA_TYPE_UNIT_QUERY	(hinawa_unit_query_get_type())
+
+#define HINAWA_UNIT_QUERY(obj)					\
+	(G_TYPE_CHECK_INSTANCE_CAST((obj),			\
+				    HINAWA_TYPE_UNIT_QUERY,	\
+				    HinawaUnitQuery))
+#define HINAWA_IS_UNIT_QUERY(obj)				\
+	(G_TYPE_CHECK_INSTANCE_TYPE((obj),			\
+				    HINAWA_TYPE_UNIT_QUERY))
+
+#define HINAWA_UNIT_QUERY_CLASS(klass)				\
+	(G_TYPE_CHECK_CLASS_CAST((klass),			\
+				 HINAWA_TYPE_UNIT_QUERY,	\
+				 HinawaUnitQueryClass))
+#define HINAWA_IS_UNIT_QUERY_CLASS(klass)			\
+	(G_TYPE_CHECK_CLASS_TYPE((klass),			\
+				 HINAWA_TYPE_UNIT_QUERY))
+#define HINAWA_UNIT_QUERY_GET_CLASS(obj)			\
+	(G_TYPE_INSTANCE_GET_CLASS((obj),			\
+				   HINAWA_TYPE_UNIT_QUERY,	\
+				   HinawaUnitQueryClass))
+
+typedef struct _HinawaUnitQuery		HinawaUnitQuery;
+typedef struct _HinawaUnitQueryClass	HinawaUnitQueryClass;
+
+struct _HinawaUnitQuery {
+	GObject parent_instance;
+};
+
+struct _HinawaUnitQueryClass {
+	GObjectClass parent_class;
+};
+
+GType hinawa_unit_query_get_type(void) G_GNUC_CONST;
+
+gint hinawa_unit_query_get_sibling(gint id, GError **exception);
+
+gint hinawa_unit_query_get_unit_type(gint id, GError **exception);
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
