From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH] alsa: hide HDMI/ELD printks unless in debug
	kernels
Date: Mon, 9 Apr 2012 10:15:17 +0800
Message-ID: <20120409021517.GA14618@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id CE476243B2
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Apr 2012 04:15:23 +0200 (CEST)
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
Cc: Keith Packard <keithp@keithp.com>, alsa-devel@alsa-project.org, Nick Bowler <nbowler@elliptictech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

These trivial messages will show up repeatedly on hot plug as well as
video mode changes, which could be annoying.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_eld.c    |    6 +++---
 sound/pci/hda/patch_hdmi.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux.orig/sound/pci/hda/hda_eld.c	2011-11-11 19:08:21.000000000 +0800
+++ linux/sound/pci/hda/hda_eld.c	2011-11-11 19:09:35.000000000 +0800
@@ -410,7 +410,7 @@ static void hdmi_show_short_audio_desc(s
 	else
 		buf2[0] = '\0';
 
-	printk(KERN_INFO "HDMI: supports coding type %s:"
+	snd_printdd("HDMI: supports coding type %s:"
 			" channels = %d, rates =%s%s\n",
 			cea_audio_coding_type_names[a->format],
 			a->channels,
@@ -434,14 +434,14 @@ void snd_hdmi_show_eld(struct hdmi_eld *
 {
 	int i;
 
-	printk(KERN_INFO "HDMI: detected monitor %s at connection type %s\n",
+	snd_printdd("HDMI: detected monitor %s at connection type %s\n",
 			e->monitor_name,
 			eld_connection_type_names[e->conn_type]);
 
 	if (e->spk_alloc) {
 		char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 		snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
-		printk(KERN_INFO "HDMI: available speakers:%s\n", buf);
+		snd_printdd("HDMI: available speakers:%s\n", buf);
 	}
 
 	for (i = 0; i < e->sad_count; i++)
--- linux.orig/sound/pci/hda/patch_hdmi.c	2011-11-11 19:07:15.000000000 +0800
+++ linux/sound/pci/hda/patch_hdmi.c	2011-11-11 19:08:16.000000000 +0800
@@ -757,7 +757,7 @@ static void hdmi_intrinsic_event(struct 
 	int pin_idx;
 	struct hdmi_eld *eld;
 
-	printk(KERN_INFO
+	snd_printdd(
 		"HDMI hot plug event: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, pd, eldv);
 
@@ -989,7 +989,7 @@ static void hdmi_present_sense(struct hd
 	else
 		eld->eld_valid	= 0;
 
-	printk(KERN_INFO
+	snd_printdd(
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
 
