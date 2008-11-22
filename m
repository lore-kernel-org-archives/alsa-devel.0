From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 7/7] hda - fix build warning when
	CONFIG_PROC_FS=n
Date: Sat, 22 Nov 2008 09:40:57 +0800
Message-ID: <20081122014309.534429750@linux.intel.com>
References: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id B21BC103868
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:09:12 +0100 (CET)
Content-Disposition: inline; filename=alsa-fix-unused-value.patch
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

Fix "defined but not used" build warning by moving eld_versoin_names[]
and cea_edid_version_names[] into hdmi_print_eld_info().

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -32,14 +32,6 @@ enum eld_versions {
 	ELD_VER_PARTIAL		= 31,
 };
 
-static char *eld_versoin_names[32] = {
-	"reserved",
-	"reserved",
-	"CEA-861D or below",
-	[3 ... 30] = "reserved",
-	[31] = "partial"
-};
-
 enum cea_edid_versions {
 	CEA_EDID_VER_NONE	= 0,
 	CEA_EDID_VER_CEA861	= 1,
@@ -48,14 +40,6 @@ enum cea_edid_versions {
 	CEA_EDID_VER_RESERVED	= 4,
 };
 
-static char *cea_edid_version_names[8] = {
-	"no CEA EDID Timing Extension block present",
-	"CEA-861",
-	"CEA-861-A",
-	"CEA-861-B, C or D",
-	[4 ... 7] = "reserved"
-};
-
 static char *cea_speaker_allocation_names[] = {
 	/*  0 */ "FL/FR",
 	/*  1 */ "LFE",
@@ -478,6 +462,20 @@ static void hdmi_print_eld_info(struct s
 	struct hdmi_eld *e = entry->private_data;
 	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 	int i;
+	static char *eld_versoin_names[32] = {
+		"reserved",
+		"reserved",
+		"CEA-861D or below",
+		[3 ... 30] = "reserved",
+		[31] = "partial"
+	};
+	static char *cea_edid_version_names[8] = {
+		"no CEA EDID Timing Extension block present",
+		"CEA-861",
+		"CEA-861-A",
+		"CEA-861-B, C or D",
+		[4 ... 7] = "reserved"
+	};
 
 	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
 	snd_iprintf(buffer, "connection_type\t\t%s\n",

-- 
