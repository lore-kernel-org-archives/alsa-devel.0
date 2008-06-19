From: Travis Place <wishie@wishie.net>
Subject: Re: [PATCH] Added model selection for iMac 24"
Date: Fri, 20 Jun 2008 04:48:55 +1000
Message-ID: <1213901335.10095.2.camel@temp-fallen>
References: <1213810189.7775.1.camel@temp-fallen>
	<s5hskv99394.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4cpHVRcqdck6aTB8IF/X"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-089.dial.usertools.net
	[202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B30E243BF
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 20:48:49 +0200 (CEST)
In-Reply-To: <s5hskv99394.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-4cpHVRcqdck6aTB8IF/X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is the corrected patch. Sorry

Changelog: Added the SSID of a known iMac 24" to automatically use
ALC885_IMAC24 quirk.

Signed-off-by: Travis Place <wishie@wishie.net>


--=-4cpHVRcqdck6aTB8IF/X
Content-Disposition: attachment; filename=imac24.patch
Content-Type: text/x-patch; name=imac24.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/pci/hda/patch_realtek.c b/pci/hda/patch_realtek.c
index 61f8c13..d96a876 100644
--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -6192,6 +6192,7 @@ static struct snd_pci_quirk alc882_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x817f, "Asus P5LD2", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x81d8, "Asus P5WD", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC882_6ST_DIG),
+	SND_PCI_QUIRK(0x106b, 0x00a0, "Apple iMac 24''", ALC885_IMAC24),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte P35 DS3R", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x28fb, "Targa T8", ALC882_TARGA), /* MSI-1049 T8  */
 	SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC882_6ST_DIG),

--=-4cpHVRcqdck6aTB8IF/X
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-4cpHVRcqdck6aTB8IF/X--
