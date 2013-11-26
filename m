From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: hda - Enable runtime PM on Panther
	Point
Date: Tue, 26 Nov 2013 09:29:12 +0100
Message-ID: <1385454553-12000-5-git-send-email-tiwai@suse.de>
References: <1385454553-12000-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D2D432615F7
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A706DA7B66
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
In-Reply-To: <1385454553-12000-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now we fixed the long-standing bugs of runtime PM, let's enable
Panther Point again.  The runtime PM was disabled in the HDMI codec
driver due to the S3 issue, and this should have been fixed now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c  | 2 +-
 sound/pci/hda/patch_hdmi.c | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7a09404579a7..b001aa6da3bc 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3979,7 +3979,7 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
 	/* Panther Point */
 	{ PCI_DEVICE(0x8086, 0x1e20),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Lynx Point */
 	{ PCI_DEVICE(0x8086, 0x8c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a6081ed34b88..1773a640e72e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1693,16 +1693,12 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 	}
 
 #ifdef CONFIG_PM
-	/* We're seeing some problems with unsolicited hot plug events on
-	 * PantherPoint after S3, if this is not enabled */
-	if (codec->vendor_id == 0x80862806)
-		codec->bus->power_keep_link_on = 1;
 	/*
 	 * G45/IbexPeak don't support EPSS: the unsolicited pin hot plug event
 	 * can be lost and presence sense verb will become inaccurate if the
 	 * HDA link is powered off at hot plug or hw initialization time.
 	 */
-	else if (!(snd_hda_param_read(codec, codec->afg, AC_PAR_POWER_STATE) &
+	if (!(snd_hda_param_read(codec, codec->afg, AC_PAR_POWER_STATE) &
 	      AC_PWRST_EPSS))
 		codec->bus->power_keep_link_on = 1;
 #endif
-- 
1.8.4.3
