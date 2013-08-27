From: mengdong.lin@intel.com
Subject: [PATCH v3 2/4] ALSA: hda - add device list & select
	info of display pins to codec proc file
Date: Mon, 26 Aug 2013 21:35:31 -0400
Message-ID: <1377567331-1171-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 543DF2610C6
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 10:34:35 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

If a display codec supports multi-stream transport on the pins, the pin's
device list length and device entries will be exposed to codec proc file.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 9760f00..a8cb22e 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -582,6 +582,36 @@ static void print_gpio(struct snd_info_buffer *buffer,
 	print_nid_array(buffer, codec, nid, &codec->nids);
 }
 
+static void print_device_list(struct snd_info_buffer *buffer,
+			    struct hda_codec *codec, hda_nid_t nid)
+{
+	int i, curr = -1;
+	u8 dev_list[AC_MAX_DEV_LIST_LEN];
+	int devlist_len;
+
+	devlist_len = snd_hda_get_devices(codec, nid, dev_list,
+					AC_MAX_DEV_LIST_LEN);
+	snd_iprintf(buffer, "  Devices: %d\n", devlist_len);
+	if (devlist_len <= 0)
+		return;
+
+	curr = snd_hda_codec_read(codec, nid, 0,
+				AC_VERB_GET_DEVICE_SEL, 0);
+
+	for (i = 0; i < devlist_len; i++) {
+		if (i == curr)
+			snd_iprintf(buffer, "    *");
+		else
+			snd_iprintf(buffer, "     ");
+
+		snd_iprintf(buffer,
+			"Dev %02d: PD = %d, ELDV = %d, IA = %d\n", i,
+			!!(dev_list[i] & AC_DE_PD),
+			!!(dev_list[i] & AC_DE_ELDV),
+			!!(dev_list[i] & AC_DE_IA));
+	}
+}
+
 static void print_codec_info(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
 {
@@ -751,6 +781,9 @@ static void print_codec_info(struct snd_info_entry *entry,
 				    (wid_caps & AC_WCAP_DELAY) >>
 				    AC_WCAP_DELAY_SHIFT);
 
+		if (wid_type == AC_WID_PIN && codec->dp_mst)
+			print_device_list(buffer, codec, nid);
+
 		if (wid_caps & AC_WCAP_CONN_LIST)
 			print_conn_list(buffer, codec, nid, wid_type,
 					conn, conn_len);
-- 
1.8.1.2
