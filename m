From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: BIOS changing subsystem id
Date: Fri, 07 Sep 2007 15:25:47 -0400
Message-ID: <46E1A5BB.4010100@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080504000103090400030508"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.biz.mail.mud.yahoo.com (smtp104.biz.mail.mud.yahoo.com
	[68.142.200.252]) by alsa0.perex.cz (Postfix) with SMTP id 510EA2434D
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 21:26:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080504000103090400030508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some laptop BIOS change the subsystem id for STAC9205 cards if the 
microphone isn't toggled on/off in the settings.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------080504000103090400030508
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="disabled_mic_subsys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disabled_mic_subsys.patch"

diff -r f2c43802b1aa pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Aug 21 15:20:26 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Thu Aug 30 15:24:59 2007 -0400
@@ -824,6 +824,8 @@ static struct snd_pci_quirk stac9205_cfg
 		      "Dell Precision", STAC_9205_M43xx),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f9,
 		      "Dell Precision", STAC_9205_DELL_M43),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x021b,
+		      "Dell Precision", STAC_9205_DELL_M43),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01fa,
 		      "Dell Precision", STAC_9205_DELL_M43),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01fe,

--------------080504000103090400030508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080504000103090400030508--
