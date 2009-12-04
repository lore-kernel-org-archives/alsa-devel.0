From: David Santinoli <david@santinoli.com>
Subject: [PATCH] hda/realtek: quirk for D945GCLF2 mainboard
Date: Fri, 4 Dec 2009 23:19:18 +0100
Message-ID: <20091204221918.GA28065@aidi.santinoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Quirk for the ALC662 found on the Intel D945GCLF2 (and possibly other)
mainboards.

Signed-off-by: David Santinoli <david@santinoli.com>
---

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7e8b17a..b26fa53 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -16801,6 +16801,7 @@ static struct snd_pci_quirk alc662_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x101e, "Lenovo", ALC662_LENOVO_101E),
 	SND_PCI_QUIRK(0x1849, 0x3662, "ASROCK K10N78FullHD-hSLI R3.0",
 					ALC662_3ST_6ch_DIG),
+	SND_PCI_QUIRK(0x8086, 0xd604, "Intel mobo", ALC662_3ST_2ch_DIG),
 	SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
 			   ALC663_ASUS_H13),
 	{}
