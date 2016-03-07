From: libin.yang@linux.intel.com
Subject: [PATCH 2/4] ALSA: hda - add DP mst verb support
Date: Mon,  7 Mar 2016 22:57:44 +0800
Message-ID: <1457362666-53937-3-git-send-email-libin.yang@linux.intel.com>
References: <1457362666-53937-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 733E326154F
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 16:02:44 +0100 (CET)
In-Reply-To: <1457362666-53937-1-git-send-email-libin.yang@linux.intel.com>
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
 sound/pci/hda/hda_codec.c | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 sound/pci/hda/hda_codec.h |  3 ++
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index d4c81f7..1a42c51 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -424,8 +424,16 @@ int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 EXPORT_SYMBOL_GPL(snd_hda_get_conn_index);
 
 
-/* return DEVLIST_LEN parameter of the given widget */
-static unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
+/**
+ * snd_hda_get_num_devices - get DEVLIST_LEN parameter of the given widget
+ *  @codec: the HDA codec
+ *  @nid: NID of the pin to parse
+ *
+ * Get the device entry number on the given widget.
+ * This is a feature of DP MST audio. Each pin can
+ * have several device entries in it.
+ */
+unsigned int snd_hda_get_num_devices(struct hda_codec *codec, hda_nid_t nid)
 {
 	unsigned int wcaps = get_wcaps(codec, nid);
 	unsigned int parm;
@@ -439,6 +447,7 @@ static unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
 		parm = 0;
 	return parm & AC_DEV_LIST_LEN_MASK;
 }
+EXPORT_SYMBOL_GPL(snd_hda_get_num_devices);
 
 /**
  * snd_hda_get_devices - copy device list without cache
@@ -456,7 +465,7 @@ int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int parm;
 	int i, dev_len, devices;
 
-	parm = get_num_devices(codec, nid);
+	parm = snd_hda_get_num_devices(codec, nid);
 	if (!parm)	/* not multi-stream capable */
 		return 0;
 
@@ -480,6 +489,71 @@ int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
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
+	/* If Device List Length is 0, the pin is not multi stream capable.
+	 */
+	if ((snd_hda_get_num_devices(codec, nid) + 1) == 0)
+		return 0;
+
+	/* Behavior of setting index being equal to or greater than
+	 * Device List Length is not predictable
+	 */
+	if ((snd_hda_get_num_devices(codec, nid) + 1) <= dev_id)
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
index deeed35..8362cb6 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -352,8 +352,11 @@ int snd_hda_override_conn_list_mst(struct hda_codec *codec, hda_nid_t nid,
 			   int dev_id, int len, const hda_nid_t *list);
 int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 			   hda_nid_t nid, int recursive);
+unsigned int snd_hda_get_num_devices(struct hda_codec *codec, hda_nid_t nid);
 int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 			u8 *dev_list, int max_devices);
+int snd_hda_get_dev_select(struct hda_codec *codec, hda_nid_t nid);
+int snd_hda_set_dev_select(struct hda_codec *codec, hda_nid_t nid, int dev_id);
 
 struct hda_verb {
 	hda_nid_t nid;
-- 
1.9.1
