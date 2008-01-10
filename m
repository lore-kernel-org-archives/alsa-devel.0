From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Add new STAC9205 PCI_QUIRK
Date: Thu, 10 Jan 2008 17:05:51 -0500
Message-ID: <478696BF.2040705@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020903050201090109030808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.biz.mail.mud.yahoo.com (smtp110.biz.mail.mud.yahoo.com
	[68.142.201.179]) by alsa0.perex.cz (Postfix) with SMTP id CCD4124745
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 23:05:55 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020903050201090109030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added a new STAC 9205 quirk for Vostro 1500.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------020903050201090109030808
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9205_new_quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9205_new_quirk.patch"

diff -r 1e968b2c8617 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Jan 10 14:50:34 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Jan 10 15:55:23 2008 -0500
@@ -1468,6 +1468,7 @@ static unsigned int ref9205_pin_configs[
     102801FD
     10280204
     1028021F
+    10280228 (Dell Vostro 1500)
 */
 static unsigned int dell_9205_m42_pin_configs[12] = {
 	0x0321101F, 0x03A11020, 0x400003FA, 0x90170310,
@@ -1551,6 +1552,8 @@ static struct snd_pci_quirk stac9205_cfg
 		      "unknown Dell", STAC_9205_DELL_M42),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x021f,
 		      "Dell Inspiron", STAC_9205_DELL_M44),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0228,
+		      "Dell Vostro 1500", STAC_9205_DELL_M42),
 	{} /* terminator */
 };
 

--------------020903050201090109030808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020903050201090109030808--
