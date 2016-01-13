From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda - add DP mst verb support
Date: Wed, 13 Jan 2016 19:09:49 +0800
Message-ID: <1452683389-142396-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AD4C260447
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 12:13:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Add snd_hda_get_dev_select() and snd_hda_set_dev_select() functions
for DP MST audio support.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_codec.h |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8374188..95baaba 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -368,6 +368,60 @@ int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 	return devices;
 }
 
+/**
+ * snd_hda_get_dev_select - get device entry select on the pin
+ * @codec: the HDA codec
+ * @nid: NID of the pin to get device entry select
+ *
+ * Get the devcie entry select on the pin. Return the device entry
+ * id selected on the pin. Return 0 means the first device entry
+ * is selected or MST is not supported.
+ */
+int snd_hda_get_dev_select(struct hda_codec *codec, hda_nid_t nid)
+{
+	/* not support dp_mst will always return 0, using first dev_entry */
+	if (!codec->dp_mst)
+		return 0;
+
+	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_DEVICE_SEL, 0);
+}
+EXPORT_SYMBOL_GPL(snd_hda_get_dev_select);
+
+/**
+ * snd_hda_set_dev_select - set device entry select on the pin
+ * @codec: the HDA codec
+ * @nid: NID of the pin to set device entry select
+ * @dev_id: device entry id to be set
+ *
+ * Set the device entry select on the pin nid.
+ */
+int snd_hda_set_dev_select(struct hda_codec *codec, hda_nid_t nid, int dev_id)
+{
+	int ret, dev;
+	unsigned long timeout;
+
+	/* not support dp_mst will always return 0, using first dev_entry */
+	if (!codec->dp_mst)
+		return 0;
+
+	timeout = jiffies + msecs_to_jiffies(500);
+
+	/* make sure the device entry selection takes effect */
+	do {
+		ret = snd_hda_codec_write(codec, nid, 0,
+			AC_VERB_SET_DEVICE_SEL, dev_id);
+		udelay(20);
+
+		dev = snd_hda_get_dev_select(codec, nid);
+		if (dev == dev_id)
+			break;
+		msleep(20);
+	} while (time_before(jiffies, timeout));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_hda_set_dev_select);
+
 /*
  * read widget caps for each widget and store in cache
  */
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 373fcad..22bcad6 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -349,6 +349,8 @@ int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 			   hda_nid_t nid, int recursive);
 int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 			u8 *dev_list, int max_devices);
+int snd_hda_get_dev_select(struct hda_codec *codec, hda_nid_t nid);
+int snd_hda_set_dev_select(struct hda_codec *codec, hda_nid_t nid, int dev_id);
 
 struct hda_verb {
 	hda_nid_t nid;
-- 
1.9.1
