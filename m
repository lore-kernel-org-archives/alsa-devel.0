From: Josh Boyer <jwboyer@redhat.com>
Subject: [PATCH] ALSA: hda/realtek - Add quirk for Mac Pro 5,1 machines
Date: Thu, 12 Apr 2012 13:55:36 -0400
Message-ID: <20120412175536.GB25425@zod.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Gabriel Somlo <somlo@cmu.edu>, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org
List-Id: alsa-devel@alsa-project.org

A user reported that setting model=imac24 used to allow sound to work on their
Mac Pro 5,1 machine.  Commit 5671087ffa "Move ALC885 macpro and imac24 models
to auto-parser" removed this model option.  All Mac machines are now explicitly
handled with a quirk and the auto-parser.  This adds a quirk for the device
found on the Mac Pro 5,1 machines.

This (partially) fixes https://bugzilla.redhat.com/show_bug.cgi?id=808559

Reported-by: Gabriel Somlo <somlo@cmu.edu>
Signed-off-by: Josh Boyer <jwboyer@redhat.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9917e55..1e0eea8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5371,6 +5371,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x00a1, "Macbook", ALC889_FIXUP_MBP_VREF),
 	SND_PCI_QUIRK(0x106b, 0x00a4, "MacbookPro 4,1", ALC889_FIXUP_MBP_VREF),
 	SND_PCI_QUIRK(0x106b, 0x0c00, "Mac Pro", ALC885_FIXUP_MACPRO_GPIO),
+	SND_PCI_QUIRK(0x106b, 0x4200,  "Mac Pro 5,1", ALC885_FIXUP_MACPRO_GPIO),
 	SND_PCI_QUIRK(0x106b, 0x1000, "iMac 24", ALC885_FIXUP_MACPRO_GPIO),
 	SND_PCI_QUIRK(0x106b, 0x2800, "AppleTV", ALC885_FIXUP_MACPRO_GPIO),
 	SND_PCI_QUIRK(0x106b, 0x2c00, "MacbookPro rev3", ALC889_FIXUP_MBP_VREF),
-- 
1.7.7.6
