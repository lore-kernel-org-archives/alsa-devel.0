From: William Weston <weston@sysex.net>
Subject: [Patch] hda-intel: Add quirks for RTL888 & RV630/M76
 based MSI GX710
Date: Tue, 7 Jul 2009 23:25:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0906210513170.28136@astarte.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from astarte.lysdexia.org (unknown [207.55.232.252])
	by alsa0.perex.cz (Postfix) with ESMTP id 63E661037F7
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 08:25:07 +0200 (CEST)
Received: from astarte.lysdexia.org (astarte.lysdexia.org [207.55.232.252])
	by astarte.lysdexia.org (8.14.2/8.14.2) with ESMTP id n686P1q2012709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 7 Jul 2009 23:25:01 -0700
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

Hello,

This patch is for yet another MSI laptop that needs the quirk to 
init the autosense on the headphone jack properly.

Best Regards,
--ww

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bf4b78a..4301680 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9111,6 +9111,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x1462, 0x3fc3, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x3fcc, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x3fdf, "MSI", ALC883_TARGA_DIG),
+	SND_PCI_QUIRK(0x1462, 0x42cd, "MSI GX710", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x4314, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x4319, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x4324, "MSI", ALC883_TARGA_DIG),
@@ -9124,6 +9125,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x1462, 0x7327, "MSI", ALC883_6ST_DIG),
  	SND_PCI_QUIRK(0x1462, 0x7350, "MSI", ALC883_6ST_DIG),
  	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
+	SND_PCI_QUIRK(0x1462, 0xaa08, "MSI GX710", ALC883_TARGA_2ch_DIG),
  	SND_PCI_QUIRK(0x147b, 0x1083, "Abit IP35-PRO", ALC883_6ST_DIG),
  	SND_PCI_QUIRK(0x1558, 0x0721, "Clevo laptop M720R", ALC883_CLEVO_M720),
  	SND_PCI_QUIRK(0x1558, 0x0722, "Clevo laptop M720SR", ALC883_CLEVO_M720),
