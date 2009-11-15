From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 03/11] intelhdmi - export monitor-presence and
	ELD-valid status
Date: Sun, 15 Nov 2009 19:32:22 +0800
Message-ID: <20091115114439.668482813@intel.com>
References: <20091115113219.606666087@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9804724153
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:14 +0100 (CET)
Content-Disposition: inline; filename=hdmi-export-presence-eld.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_eld.c         |    8 +++++++-
 sound/pci/hda/hda_local.h       |    4 +++-
 sound/pci/hda/patch_intelhdmi.c |    8 +++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:17:26.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:18:47.000000000 +0800
@@ -62,8 +62,6 @@ struct intel_hdmi_spec {
 	/*
 	 * HDMI sink attached to each pin
 	 */
-	bool		sink_present[INTEL_HDMI_PINS];
-	bool		sink_eldv[INTEL_HDMI_PINS];
 	struct hdmi_eld sink_eld[INTEL_HDMI_PINS];
 
 	/*
@@ -645,7 +643,7 @@ static void hdmi_setup_audio_infoframe(s
 	for (i = 0; i < spec->num_pins; i++) {
 		if (spec->pin_cvt[i] != nid)
 			continue;
-		if (spec->sink_present[i] != true)
+		if (!spec->sink_eld[i].monitor_present)
 			continue;
 
 		pin_nid = spec->pin[i];
@@ -675,8 +673,8 @@ static void hdmi_intrinsic_event(struct 
 	if (index < 0)
 		return;
 
-	spec->sink_present[index] = pind;
-	spec->sink_eldv[index] = eldv;
+	spec->sink_eld[index].monitor_present = pind;
+	spec->sink_eld[index].eld_valid = eldv;
 
 	if (pind && eldv) {
 		hdmi_parse_eld(codec, index);
--- sound-2.6.orig/sound/pci/hda/hda_eld.c	2009-11-02 15:14:30.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_eld.c	2009-11-02 15:24:04.000000000 +0800
@@ -477,6 +477,8 @@ static void hdmi_print_eld_info(struct s
 		[4 ... 7] = "reserved"
 	};
 
+	snd_iprintf(buffer, "monitor_present\t\t%d\n", e->monitor_present);
+	snd_iprintf(buffer, "eld_valid\t\t%d\n", e->eld_valid);
 	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
 	snd_iprintf(buffer, "connection_type\t\t%s\n",
 				eld_connection_type_names[e->conn_type]);
@@ -518,7 +520,11 @@ static void hdmi_write_eld_info(struct s
 		 * 	monitor_name manufacture_id product_id
 		 * 	eld_version edid_version
 		 */
-		if (!strcmp(name, "connection_type"))
+		if (!strcmp(name, "monitor_present"))
+			e->monitor_present = val;
+		else if (!strcmp(name, "eld_valid"))
+			e->eld_valid = val;
+		else if (!strcmp(name, "connection_type"))
 			e->conn_type = val;
 		else if (!strcmp(name, "port_id"))
 			e->port_id = val;
--- sound-2.6.orig/sound/pci/hda/hda_local.h	2009-11-02 15:14:30.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_local.h	2009-11-02 15:21:11.000000000 +0800
@@ -516,9 +516,11 @@ struct cea_sad {
  * ELD: EDID Like Data
  */
 struct hdmi_eld {
+	bool	monitor_present;
+	bool	eld_valid;
 	int	eld_size;
 	int	baseline_len;
-	int	eld_ver;	/* (eld_ver == 0) indicates invalid ELD */
+	int	eld_ver;
 	int	cea_edid_ver;
 	char	monitor_name[ELD_MAX_MNL + 1];
 	int	manufacture_id;
