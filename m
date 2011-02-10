From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH resend] ALSA: hda - add quirk for Ordissimo EVE
 using a realtek ALC662
Date: Thu, 10 Feb 2011 13:14:44 +0100
Message-ID: <20110210131444.5c2c9448@destiny.ordissimo>
References: <20110121154544.4e5ed4e6@destiny.ordissimo>
	<1295624188.12720.68.camel@mattotaupa>
	<s5hvd1e77ce.wl%tiwai@suse.de>
	<20110124174300.079c8cb7@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7AFD2244C7
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 13:15:55 +0100 (CET)
Received: by fxm5 with SMTP id 5so1407418fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 04:15:55 -0800 (PST)
In-Reply-To: <20110124174300.079c8cb7@destiny.ordissimo>
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
Cc: Takashi Iwai <tiwai@suse.de>, Paul Menzel <paulepanter@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


This netbook has a only one jack output and an internal mic.

By default, mic and jack sense aren't working. Using lenovo-101e
parameters makes both work.

The device seems based on a Sharetronic Q70, so this should fix audio for
this model too.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi,

Sorry for the delay. As usual, this is based on sound-2.6/for-next.

Regards,

Anisse
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1e092b3..6a43c1c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -18934,6 +18934,7 @@ static struct snd_pci_quirk alc662_cfg_tbl[] = {
 					ALC662_3ST_6ch_DIG),
 	SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
 			   ALC663_ASUS_H13),
+	SND_PCI_QUIRK(0x1991, 0x5628, "Ordissimo EVE", ALC662_LENOVO_101E),
 	{}
 };
 
-- 
1.7.3.2
