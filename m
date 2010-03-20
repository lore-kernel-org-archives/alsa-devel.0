From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: [PATCH] ALSA: hda - Add PCI quirk for HP dv6-1110ax.
Date: Sat, 20 Mar 2010 23:08:01 +0530
Message-ID: <1269106681-5076-1-git-send-email-kunal.gangakhedkar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f191.google.com (mail-qy0-f191.google.com
	[209.85.221.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EA4E103817
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 18:35:50 +0100 (CET)
Received: by qyk29 with SMTP id 29so1761534qyk.2
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 10:35:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Devel List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Goldwyn Rodrigues <goldwynr@gmail.com>, Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
List-Id: alsa-devel@alsa-project.org

Adding this PCI quirk fixes the board config detection.
This also fixes jack sensing by using "hp_detect=1" via properly detected
board config.

Signed-off-by: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 8c416bb..c4be3fa 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1730,6 +1730,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "HP HDX", STAC_HP_HDX),  /* HDX16 */
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x3620,
 		      "HP dv6", STAC_HP_DV5),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3061,
+		      "HP dv6", STAC_HP_DV5), /* HP dv6-1110ax */
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x7010,
 		      "HP", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
-- 
1.6.6.60.gc2ff1
