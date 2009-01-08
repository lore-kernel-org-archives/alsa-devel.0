From: =?UTF-8?Q?=C5=81ukasz_Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: Autodetection for Acer Aspire 5930G and 6930G
Date: Thu, 08 Jan 2009 11:13:23 +0100
Message-ID: <1231409603.4324.0.camel@nslw.hstl2.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id F295F1037E3
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 11:13:30 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so3310516fgg.44
	for <alsa-devel@alsa-project.org>; Thu, 08 Jan 2009 02:13:30 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

This is a patch which adds correct auto detection of model for
snd-hda-intel for Acer Aspire 5930G and 6930G. Tested on my 5930G. It
finally adds hp jack sense and 5.1 speaker system sliders.

Information about 5930G
Codec: Realtek ALC888
Address: 0
Vendor Id: 0x10ec0888
Subsystem Id: 0x1025013f
Revision Id: 0x100202

Information about 6930G
Codec: Realtek ALC888
Address: 0
Vendor Id: 0x10ec0888
Subsystem Id: 0x1025015e
Revision Id: 0x100202

It is first patch prepared by me and it is against commit
daead538e9d8efe61d7d2bd12993c8d961b0abd6 from
"http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=daead538e9d8efe61d7d2bd12993c8d961b0abd6"

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8461,5 +8461,6 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0112, "Acer Aspire 9303", ALC883_ACER_ASPIRE),
	SND_PCI_QUIRK(0x1025, 0x0121, "Acer Aspire 5920G", ALC883_ACER_ASPIRE),
-	SND_PCI_QUIRK(0x1025, 0x013e, "Acer Aspire 4930G",
-		ALC888_ACER_ASPIRE_4930G),
+	SND_PCI_QUIRK(0x1025, 0x013e, "Acer Aspire 4930G",
ALC888_ACER_ASPIRE_4930G),
+	SND_PCI_QUIRK(0x1025, 0x013f, "Acer Aspire 5930G",
ALC888_ACER_ASPIRE_4930G),
+	SND_PCI_QUIRK(0x1025, 0x015e, "Acer Aspire 6930G",
ALC888_ACER_ASPIRE_4930G),
	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER), /* default Acer
*/
