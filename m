From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: hda - Add hduadio support to DEVTABLE
Date: Fri, 16 Oct 2015 18:20:54 +0200
Message-ID: <1445012458-3337-3-git-send-email-tiwai@suse.de>
References: <1445012458-3337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8886B266720
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:21:07 +0200 (CEST)
In-Reply-To: <1445012458-3337-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja Kp <jeeja.kp@intel.com>, Subhransu S Prusty <subhransu.s.prusty@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

For generating modalias entries automatically, move the definition of
struct hda_device_id to linux/mod_devicetable.h and add the handling
of this record in file2alias helper.  The new modalias is represented
with combination of vendor id, device id, and api version as
"hdaudio:vNrNaN".

This patch itself doesn't convert the existing modaliases.  Since they
were added manually, this patch won't give any regression by itself at
this point.

[Modified the modalias format to adapt the api_version field, and drop
 invalid ANY_ID definition by tiwai]

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/mod_devicetable.h   |  8 ++++++++
 include/sound/hdaudio.h           | 12 +-----------
 scripts/mod/devicetable-offsets.c |  5 +++++
 scripts/mod/file2alias.c          | 17 +++++++++++++++++
 sound/hda/hda_bus_type.c          |  1 +
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 688997a24aad..00825672d256 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -219,6 +219,14 @@ struct serio_device_id {
 	__u8 proto;
 };
 
+struct hda_device_id {
+	__u32 vendor_id;
+	__u32 rev_id;
+	__u8 api_version;
+	const char *name;
+	unsigned long driver_data;
+};
+
 /*
  * Struct used for matching a device
  */
diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index b35bf59a1ecc..ddca48eb02e0 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -21,6 +21,7 @@ struct hdac_stream;
 struct hdac_device;
 struct hdac_driver;
 struct hdac_widget_tree;
+struct hda_device_id;
 
 /*
  * exported bus type
@@ -28,17 +29,6 @@ struct hdac_widget_tree;
 extern struct bus_type snd_hda_bus_type;
 
 /*
- * HDA device table
- */
-struct hda_device_id {
-	__u32 vendor_id;
-	__u32 rev_id;
-	__u8 api_version;
-	const char *name;
-	unsigned long driver_data;
-};
-
-/*
  * generic arrays
  */
 struct snd_array {
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index e70fcd12eeeb..e1a5110bd63b 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -196,5 +196,10 @@ int main(void)
 	DEVID_FIELD(ulpi_device_id, vendor);
 	DEVID_FIELD(ulpi_device_id, product);
 
+	DEVID(hda_device_id);
+	DEVID_FIELD(hda_device_id, vendor_id);
+	DEVID_FIELD(hda_device_id, rev_id);
+	DEVID_FIELD(hda_device_id, api_version);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5f2088209132..fc51d4bff3f8 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1250,6 +1250,23 @@ static int do_ulpi_entry(const char *filename, void *symval,
 }
 ADD_TO_DEVTABLE("ulpi", ulpi_device_id, do_ulpi_entry);
 
+/* Looks like: hdaudio:vNrNaN */
+static int do_hda_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, hda_device_id, vendor_id);
+	DEF_FIELD(symval, hda_device_id, rev_id);
+	DEF_FIELD(symval, hda_device_id, api_version);
+
+	strcpy(alias, "hdaudio:");
+	ADD(alias, "v", vendor_id != 0, vendor_id);
+	ADD(alias, "r", rev_id != 0, rev_id);
+	ADD(alias, "a", api_version != 0, api_version);
+
+	add_wildcard(alias);
+	return 1;
+}
+ADD_TO_DEVTABLE("hdaudio", hda_device_id, do_hda_entry);
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index 89c2711baaaf..bcb1a79eec38 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/export.h>
 #include <sound/hdaudio.h>
 
-- 
2.6.1
