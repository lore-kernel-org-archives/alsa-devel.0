From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH] hda: modify monitor name to be consistent with
	other ELD	proc items
Date: Fri, 21 Nov 2008 12:34:05 +0800
Message-ID: <20081121043405.GA14876@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F1202444F
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 05:34:16 +0100 (CET)
Content-Disposition: inline
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

Rename "monitor name" to "monitor_name" to conform with the keyword style.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -477,7 +477,7 @@ static void hdmi_print_eld_info(struct s
 	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 	int i;
 
-	snd_iprintf(buffer, "monitor name\t\t%s\n", e->monitor_name);
+	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
 	snd_iprintf(buffer, "connection_type\t\t%s\n",
 				eld_connection_type_names[e->conn_type]);
 	snd_iprintf(buffer, "eld_version\t\t[0x%x] %s\n", e->eld_ver,
