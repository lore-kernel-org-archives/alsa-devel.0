From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: [PATCH REALTEK] Added quirk to enable sound on Toshiba NB200
Date: Wed, 23 Sep 2009 00:39:45 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0909230036570.29432@little>
Reply-To: Manoj Iyer <manoj.iyer@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753756AbZIWFkP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


>From c96629e96fecbe59de7124ec913019ed378d0029 Mon Sep 17 00:00:00 2001
From: Manoj Iyer <manoj.iyer@canonical.com>
Date: Tue, 22 Sep 2009 18:33:29 -0500
Subject: [PATCH] [PATCH REALTEK] Added quirk to enable sound on Toshiba NB200

Patch was tested on Toshiba NB200 and is found to enable sound.

Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
Cc: stable@kernel.org
---
  sound/pci/hda/patch_realtek.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 30eeb30..713bf69 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -16876,6 +16876,7 @@ static struct snd_pci_quirk alc662_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x105b, 0x0cd6, "Foxconn", ALC662_ECS),
  	SND_PCI_QUIRK(0x105b, 0x0d47, "Foxconn 45CMX/45GMX/45CMX-K",
  		      ALC662_3ST_6ch_DIG),
+	SND_PCI_QUIRK(0x1179, 0xff6e, "Toshiba NB200", ALC663_ASUS_MODE4),
  	SND_PCI_QUIRK(0x144d, 0xca00, "Samsung NC10", ALC272_SAMSUNG_NC10),
  	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte 945GCM-S2L",
  		      ALC662_3ST_6ch_DIG),
-- 
1.6.3.3


--- manjo
