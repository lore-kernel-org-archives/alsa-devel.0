From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 4/7] hda - ELD proc interface write updates
Date: Sat, 22 Nov 2008 09:40:54 +0800
Message-ID: <20081122014309.145463485@linux.intel.com>
References: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 62607103822
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:09:03 +0100 (CET)
Content-Disposition: inline; filename=alsa-eld-proc-more.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

- rename ELD proc write routine to hdmi_write_eld_info()
- support modifying WMAPro's profile

Write to some ELD fields (monitor_name, manufacture_id, product_id,
eld_version, edid_version) are deliberately not supported, since that
won't correct wrong behaviors and only leads to confusions.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -502,7 +502,7 @@ static void hdmi_print_eld_info(struct s
 		hdmi_print_sad_info(i, e->sad + i, buffer);
 }
 
-static void hdmi_write_eld_item(struct snd_info_entry *entry,
+static void hdmi_write_eld_info(struct snd_info_entry *entry,
 				struct snd_info_buffer *buffer)
 {
 	struct hdmi_eld *e = entry->private_data;
@@ -515,6 +515,11 @@ static void hdmi_write_eld_item(struct s
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%s %llx", name, &val) != 2)
 			continue;
+		/*
+		 * We don't allow modification to these fields:
+		 * 	monitor_name manufacture_id product_id
+		 * 	eld_version edid_version
+		 */
 		if (!strcmp(name, "connection_type"))
 			e->conn_type = val;
 		else if (!strcmp(name, "port_id"))
@@ -548,6 +553,8 @@ static void hdmi_write_eld_item(struct s
 				e->sad[n].sample_bits = val;
 			else if (!strcmp(sname, "_max_bitrate"))
 				e->sad[n].max_bitrate = val;
+			else if (!strcmp(sname, "_profile"))
+				e->sad[n].profile = val;
 			if (n >= e->sad_count)
 				e->sad_count = n + 1;
 		}
@@ -567,7 +574,7 @@ int snd_hda_eld_proc_new(struct hda_code
 		return err;
 
 	snd_info_set_text_ops(entry, eld, hdmi_print_eld_info);
-	entry->c.text.write = hdmi_write_eld_item;
+	entry->c.text.write = hdmi_write_eld_info;
 	entry->mode |= S_IWUSR;
 	eld->proc_entry = entry;
 

-- 
