From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ALSA: hda - Add PCI quirks for MSI all-in-one
 computers NetOn AP1900 and Wind Top AE2220
Date: Wed, 10 Mar 2010 19:17:46 +0100
Message-ID: <20100310191746.5ff22c1b@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 53FC310380A
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 19:17:56 +0100 (CET)
Received: by ewy23 with SMTP id 23so1849226ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 10:17:55 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org



Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi,

This should make the speakers and jack detection work on those computers.

Regards,

Anisse

 sound/pci/hda/patch_realtek.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e8cbe21..970d0b2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9191,6 +9191,7 @@ static struct snd_pci_quirk alc882_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1462, 0x4314, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x4319, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x4324, "MSI", ALC883_TARGA_DIG),
+	SND_PCI_QUIRK(0x1462, 0x4570, "MSI Wind Top AE2220", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x6510, "MSI GX620", ALC883_TARGA_8ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7187, "MSI", ALC883_6ST_DIG),
@@ -9200,6 +9201,7 @@ static struct snd_pci_quirk alc882_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1462, 0x7280, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7327, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI", ALC883_6ST_DIG),
+	SND_PCI_QUIRK(0x1462, 0x7437, "MSI NetOn AP1900", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0xaa08, "MSI", ALC883_TARGA_2ch_DIG),
 
-- 
1.6.5.7
