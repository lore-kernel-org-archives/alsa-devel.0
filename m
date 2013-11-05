From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Name Haswell HDMI controllers
	better
Date: Tue,  5 Nov 2013 18:00:31 +0100
Message-ID: <1383670831-12067-2-git-send-email-tiwai@suse.de>
References: <1383670831-12067-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 602C32619F9
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:00:32 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BFBAFA6728
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:00:31 +0100 (CET)
In-Reply-To: <1383670831-12067-1-git-send-email-tiwai@suse.de>
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

"HDA Intel MID" is no correct name for Haswell HDMI controllers.
Give them a better name, "HDA Intel HDMI".

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9cbd1259a5be..17f4aa8cddd5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -569,6 +569,7 @@ enum {
 	AZX_DRIVER_ICH,
 	AZX_DRIVER_PCH,
 	AZX_DRIVER_SCH,
+	AZX_DRIVER_HDMI,
 	AZX_DRIVER_ATI,
 	AZX_DRIVER_ATIHDMI,
 	AZX_DRIVER_ATIHDMI_NS,
@@ -648,6 +649,7 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
 	[AZX_DRIVER_PCH] = "HDA Intel PCH",
 	[AZX_DRIVER_SCH] = "HDA Intel MID",
+	[AZX_DRIVER_HDMI] = "HDA Intel HDMI",
 	[AZX_DRIVER_ATI] = "HDA ATI SB",
 	[AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
 	[AZX_DRIVER_ATIHDMI_NS] = "HDA ATI HDMI",
@@ -3997,11 +3999,11 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_HASWELL },
+	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
 	{ PCI_DEVICE(0x8086, 0x0c0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_HASWELL },
+	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
 	{ PCI_DEVICE(0x8086, 0x0d0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_HASWELL },
+	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
 	/* 5 Series/3400 */
 	{ PCI_DEVICE(0x8086, 0x3b56),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
-- 
1.8.4.2
