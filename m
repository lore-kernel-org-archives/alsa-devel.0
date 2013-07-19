From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/13] ALSA: hda - Drop a few other static
	quirks for AD1986A
Date: Fri, 19 Jul 2013 17:12:21 +0200
Message-ID: <1374246742-14373-13-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CEAA626576E
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A42A1A543A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
In-Reply-To: <1374246742-14373-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Most of ASUS laptops and Lenovo N100 provide proper BIOS pin-configs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index a41e121..3b23280 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1056,15 +1056,6 @@ static const char * const ad1986a_models[AD1986A_MODELS] = {
 
 static const struct snd_pci_quirk ad1986a_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x30af, "HP B2800", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x1153, "ASUS M9", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x11f7, "ASUS U5A", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x1213, "ASUS A6J", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x1263, "ASUS U5F", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x1297, "ASUS Z62F", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x12b3, "ASUS V1j", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x1302, "ASUS W3j", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x1443, "ASUS VX1", AD1986A_LAPTOP),
-	SND_PCI_QUIRK(0x1043, 0x1447, "ASUS A8J", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x817f, "ASUS P5", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x818f, "ASUS P5", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x81b3, "ASUS P5", AD1986A_3STACK),
@@ -1074,7 +1065,6 @@ static const struct snd_pci_quirk ad1986a_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
-	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_LAPTOP_AUTOMUTE),
 	{}
 };
 
-- 
1.8.3.1
