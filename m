From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Use LPIB Position fix for Intel SCH
	Poulsbo
Date: Wed, 14 Dec 2011 16:01:08 +0800
Message-ID: <4EE857C4.4070409@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050108040603000000050605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9A71224569
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 09:01:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050108040603000000050605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi,

I just got another position_fix=1 report for the same vendor/deviceID 
[1] as I sent you the other day, and I assume Eric Piel (a month ago on 
this list) have the same chipset as well, although I cannot see his 
alsa-info. I think you have it, can you verify?

So...can we consider quirking the entire chip to use LPIB, like in the 
attached patch (untested)?
If so I'll send another patch later to remove existing quirks for this 
chipset.

// David

[1] 
http://www.alsa-project.org/db/?f=b7421521b8d8a4db3842ee14cdb54b4f440cae5e

--------------050108040603000000050605
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Use-LPIB-Position-fix-for-Intel-SCH-Poulsbo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Use-LPIB-Position-fix-for-Intel-SCH-Poulsbo.pa";
 filename*1="tch"

>From 4f6630ecafc2246c4237f0be5008d4a15cfce733 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 14 Dec 2011 15:52:30 +0800
Subject: [PATCH] ALSA: HDA: Use LPIB Position fix for Intel SCH Poulsbo

Several people with this chipset have reported inconsistent/sloppy
values for position reporting when the DMA position buffer is used,
and that setting position_fix=1 have fixed their problems.

BugLink: https://bugs.launchpad.net/bugs/825709
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0746ab4..f19d7fa 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2971,7 +2971,8 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE},
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_LPIB }, /* Poulsbo */
+	/* ICH */
 	{ PCI_DEVICE(0x8086, 0x2668),
 	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
 	  AZX_DCAPS_BUFSIZE },  /* ICH6 */
-- 
1.7.5.4


--------------050108040603000000050605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050108040603000000050605--
