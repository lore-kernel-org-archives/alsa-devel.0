From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: More subsystem id BIOS changes
Date: Thu, 13 Sep 2007 17:18:41 -0400
Message-ID: <46E9A931.1050308@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070008040303060502040507"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by alsa0.perex.cz (Postfix) with SMTP id 4BEE2243BC
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 23:19:23 +0200 (CEST)
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
--------------070008040303060502040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

More laptop BIOS changes the subsystem id for STAC9205 cards if the 
microphone is toggled on/off in the settings.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------070008040303060502040507
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="more_m43xx_disabled_mic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="more_m43xx_disabled_mic.patch"

diff -r 9fe2d7b6498b pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Sep 12 13:31:47 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Thu Sep 13 17:09:17 2007 -0400
@@ -1183,6 +1183,8 @@ static struct snd_pci_quirk stac9205_cfg
 		      "unknown Dell", STAC_9205_DELL_M42),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f8,
 		      "Dell Precision", STAC_9205_M43xx),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x021c,
+			  "Dell Precision", STAC_9205_M43xx),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f9,
 		      "Dell Precision", STAC_9205_DELL_M43),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x021b,

--------------070008040303060502040507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070008040303060502040507--
