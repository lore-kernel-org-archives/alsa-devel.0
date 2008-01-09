From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC9228 VT fixes
Date: Wed, 09 Jan 2008 17:48:15 -0500
Message-ID: <47854F2F.3040708@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070008040903070003070309"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.biz.mail.mud.yahoo.com (smtp106.biz.mail.mud.yahoo.com
	[68.142.200.254]) by alsa0.perex.cz (Postfix) with SMTP id E6685243D9
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 23:48:23 +0100 (CET)
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
--------------070008040903070003070309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Moved 2 systems PCI_QUIRK values to STAC_DELL_BIOS. Also the second 
front HP jack is incorrect defined in the BIOS VT's for some laptops, 
this patch corrects this.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------070008040903070003070309
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac927x_quirk_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac927x_quirk_fix.patch"

diff -r d09f88bf00e8 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Jan 09 12:30:20 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Jan 09 12:34:59 2008 -0500
@@ -1428,13 +1428,13 @@ static struct snd_pci_quirk stac927x_cfg
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2002, "Intel D965", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2001, "Intel D965", STAC_D965_3ST),
 	/* Dell 3 stack systems */
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f3, "Dell Inspiron 1420", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f7, "Dell XPS M1730", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01dd, "Dell Dimension E520", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01ed, "Dell     ", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f4, "Dell     ", STAC_DELL_3ST),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0227, "Dell Vostro 1400  ", STAC_DELL_3ST),
 	/* Dell 3 stack systems with verb table in BIOS */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f3, "Dell Inspiron 1420", STAC_DELL_BIOS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0227, "Dell Vostro 1400  ", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022f, "Dell     ", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022e, "Dell     ", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0242, "Dell     ", STAC_DELL_BIOS),
@@ -3332,6 +3332,8 @@ static int patch_stac927x(struct hda_cod
 		spec->mixer = stac927x_mixer;
 		break;
 	case STAC_DELL_BIOS:
+		/* correct the front output jack as a hp out */
+		stac92xx_set_config_reg(codec, 0x0f, 0x02270110);
 		/* correct the front input jack as a mic */
 		stac92xx_set_config_reg(codec, 0x0e, 0x02a79130);
 		/* fallthru */

--------------070008040903070003070309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070008040903070003070309--
