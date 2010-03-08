From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hdmi - show debug message on changing audio
	infoframe
Date: Mon, 8 Mar 2010 10:45:38 +0800
Message-ID: <20100308024538.GA24058@localhost>
References: <20100308024422.GA24030@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C8B11037EE
	for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2010 03:45:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100308024422.GA24030@localhost>
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
Cc: Wei Ni <wni@nvidia.com>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>, 'linux-kernel' <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Also change printk level for the two others.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_hdmi.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_hdmi.c	2010-03-08 10:11:00.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_hdmi.c	2010-03-08 10:17:35.000000000 +0800
@@ -398,9 +398,8 @@ static int hdmi_setup_channel_allocation
 	}
 
 	snd_print_channel_allocation(eld->spk_alloc, buf, sizeof(buf));
-	snd_printdd(KERN_INFO
-			"HDMI: select CA 0x%x for %d-channel allocation: %s\n",
-			ai->CA, channels, buf);
+	snd_printdd("HDMI: select CA 0x%x for %d-channel allocation: %s\n",
+		    ai->CA, channels, buf);
 
 	return ai->CA;
 }
@@ -442,7 +441,8 @@ static void hdmi_setup_channel_mapping(s
 					  AC_VERB_SET_HDMI_CHAN_SLOT,
 					  hdmi_channel_mapping[ca][i]);
 		if (err) {
-			snd_printdd(KERN_INFO "HDMI: channel mapping failed\n");
+			snd_printdd(KERN_NOTICE
+				    "HDMI: channel mapping failed\n");
 			break;
 		}
 	}
@@ -599,6 +599,10 @@ static void hdmi_setup_audio_infoframe(s
 
 		pin_nid = spec->pin[i];
 		if (!hdmi_infoframe_uptodate(codec, pin_nid, &ai)) {
+			snd_printdd("hdmi_setup_audio_infoframe: "
+				    "cvt=%d pin=%d channels=%d\n",
+				    nid, pin_nid,
+				    substream->runtime->channels);
 			hdmi_setup_channel_mapping(codec, pin_nid, &ai);
 			hdmi_stop_infoframe_trans(codec, pin_nid);
 			hdmi_fill_audio_infoframe(codec, pin_nid, &ai);
