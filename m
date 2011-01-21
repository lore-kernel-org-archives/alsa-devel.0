From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ALSA: hda - add quirk for Ordissimo EVE using
 a realtek ALC662
Date: Fri, 21 Jan 2011 15:45:44 +0100
Message-ID: <20110121154544.4e5ed4e6@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6F5EE2461D
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 15:46:17 +0100 (CET)
Received: by fxm5 with SMTP id 5so1849260fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 06:46:17 -0800 (PST)
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



---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7262980..a72c8bd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -18292,6 +18292,7 @@ static struct snd_pci_quirk alc662_cfg_tbl[] = {
 					ALC662_3ST_6ch_DIG),
 	SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
 			   ALC663_ASUS_H13),
+	SND_PCI_QUIRK(0x1991, 0x5628, "Ordissimo EVE", ALC662_LENOVO_101E),
 	{}
 };
 
-- 
1.7.3.2
