From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: [PATCH] Recognise and use subdevice 0x3061 found in
	some HP dv6 notebooks.
Date: Mon, 14 Dec 2009 00:29:42 +0530
Message-ID: <200912140029.42677.kunal.gangakhedkar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EED01037F1
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 19:59:49 +0100 (CET)
Received: by pzk9 with SMTP id 9so1710154pzk.16
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 10:59:47 -0800 (PST)
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

Obvious patch.
Recently bought an HP Pavilion dv6-1110ax notebook. The modparm 'model=hp-dv5'
works, but I thought it was better if it were natively supported.

Also, the 'hp_detect=1' hint
(echo "hp_detect = 1" > /sys/class/sound/hwC0D0/hints) works nicely to mute the
speakers when using the headphone jack(s). Is there any way to automatically
enable this?
I'm no alsa dev - just scratching my itch here ;)

PS: I'm not subscribed to the list - so, please put me in Cc: in the replies.

Thanks,
Kunal

Signed-off-by: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3d59f83..0ed9a09 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1725,6 +1725,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "HP HDX", STAC_HP_HDX),  /* HDX16 */
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x3620,
 		      "HP dv6", STAC_HP_DV5),
+	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x3061,
+		      "HP dv6", STAC_HP_DV5),  /* HP Pavilion dv6-1110ax */
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x7010,
 		      "HP", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
-- 
1.6.5.GIT
