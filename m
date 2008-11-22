From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 2/7] hda - report selected CA index for Audio
	InfoFrame
Date: Sat, 22 Nov 2008 09:40:52 +0800
Message-ID: <20081122014308.926922791@linux.intel.com>
References: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 9477A103806
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:09:00 +0100 (CET)
Content-Disposition: inline; filename=alsa-report-ca.patch
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

Print some CA selecting info, which could be valuable for debugging when
something goes wrong.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -444,14 +444,16 @@ static int hdmi_setup_channel_allocation
 		    (spk_mask & channel_allocations[i].spk_mask) ==
 				channel_allocations[i].spk_mask) {
 			ai->CA = channel_allocations[i].ca_index;
-			return 0;
+			break;
 		}
 	}
 
 	snd_print_channel_allocation(eld->spk_alloc, buf, sizeof(buf));
-	snd_printd(KERN_INFO "failed to setup channel allocation: %d of %s\n",
-			channels, buf);
-	return -1;
+	snd_printdd(KERN_INFO
+			"HDMI: select CA 0x%x for %d-channel allocation: %s\n",
+			ai->CA, channels, buf);
+
+	return ai->CA;
 }
 
 static void hdmi_setup_channel_mapping(struct hda_codec *codec,

-- 
