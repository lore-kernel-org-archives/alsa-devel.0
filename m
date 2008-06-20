From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Added SSID for 'Fujitsu Siemens Amilo M1451G'
	laptop
Date: Sat, 21 Jun 2008 03:29:45 +1000
Message-ID: <1213982985.14789.3.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-LWfEeLMwsRecAMlP3Jwe"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-089.dial.usertools.net
	[202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 122D324617
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 19:29:37 +0200 (CEST)
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


--=-LWfEeLMwsRecAMlP3Jwe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Changelog: Add the SSID for the "Fujitsu Siemens Amilo M1451G" laptop to
patch_realtek.c , so that it uses ALC880_FUJITSU by default.


--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -3074,6 +3074,7 @@ static struct snd_pci_quirk alc880_cfg_tbl[] = {
        SND_PCI_QUIRK(0x1695, 0x400d, "EPoX", ALC880_5ST_DIG),
        SND_PCI_QUIRK(0x1695, 0x4012, "EPox EP-5LDA", ALC880_5ST_DIG),
        SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_F1734),
+       SND_PCI_QUIRK(0x1734, 0x1094, "Fujitsu Siemens Amilo M1451G",
ALC880_FUJITSU),
        SND_PCI_QUIRK(0x1734, 0x10ac, "FSC", ALC880_UNIWILL),
        SND_PCI_QUIRK(0x1734, 0x10b0, "Fujitsu", ALC880_FUJITSU),
        SND_PCI_QUIRK(0x1854, 0x0018, "LG LW20", ALC880_LG_LW),



Signed-off-by: Travis Place <wishie@wishie.net>

--=-LWfEeLMwsRecAMlP3Jwe
Content-Disposition: attachment; filename=fujitsu
Content-Type: text/x-patch; name=fujitsu; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -3074,6 +3074,7 @@ static struct snd_pci_quirk alc880_cfg_tbl[] = {
        SND_PCI_QUIRK(0x1695, 0x400d, "EPoX", ALC880_5ST_DIG),
        SND_PCI_QUIRK(0x1695, 0x4012, "EPox EP-5LDA", ALC880_5ST_DIG),
        SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_F1734),
+       SND_PCI_QUIRK(0x1734, 0x1094, "Fujitsu Siemens Amilo M1451G", ALC880_FUJITSU),
        SND_PCI_QUIRK(0x1734, 0x10ac, "FSC", ALC880_UNIWILL),
        SND_PCI_QUIRK(0x1734, 0x10b0, "Fujitsu", ALC880_FUJITSU),
        SND_PCI_QUIRK(0x1854, 0x0018, "LG LW20", ALC880_LG_LW),


--=-LWfEeLMwsRecAMlP3Jwe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-LWfEeLMwsRecAMlP3Jwe--
