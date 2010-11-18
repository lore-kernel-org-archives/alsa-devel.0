From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: [PATCH] Enable jack sense for Thinkpad Edge 11
Date: Thu, 18 Nov 2010 15:35:51 -0600
Message-ID: <AANLkTin2zKWLLxsRn+T+U+NpAmbQiOTM_vrg_Z-8JZd-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch enables audio play back from external headphones on Thinkpad Edge 11.

The following changes since commit 0c1c062266ecfeaebadadb780020a422f829284f:
  Manoj Iyer (1):
        Enable jack sense for Thinkpad Edge 11

are available in the git repository at:

  git://kernel.ubuntu.com/git/manjo/linux-2.6.git thinpad11

>From 89796b0608f0c36cbd05d0426e95386766ff20b9 Mon Sep 17 00:00:00 2001
From: Manoj Iyer <manoj.iyer@canonical.com>
Date: Thu, 18 Nov 2010 21:24:42 +0000
Subject: [PATCH] Enable jack sense for Thinkpad Edge 11

Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6361f75..b8d6554 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3108,6 +3108,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
        SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_OLPC_XO_1_5),
        SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400s", CXT5066_THINKPAD),
        SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
+       SND_PCI_QUIRK(0x17aa, 0x21c8, "Thinkpad Edge 11", CXT5066_THINKPAD),
        SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (197)",
CXT5066_IDEAPAD),
        SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD),
        SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
-- 
1.7.0.4

---
Manoj Iyer
