From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao
	<fernando_b1@lab.ntt.co.jp>
Subject: [PATCH 1/3] ALSA: hda - Workaround for silent output on Sony Vaio
 VGC-LN51JGB with ALC889
Date: Tue, 12 Feb 2013 16:47:44 +0900
Message-ID: <1360655264.13766.2.camel@nexus.lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Some Vaio all-in-one desktop PCs (for example VGC-LN51JGB) are affected by
the same issue that caused Vaio Z laptops to become silent: the speaker pin
must be connected to the first DAC even though the codec itself advertises
flexible routing through any of the DACs.

Use the no-primary-hp fixup for choosing the speaker pin as the primary so
that the right DAC is assigned on this device.

Cc: stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-3.7.6-orig/sound/pci/hda/patch_realtek.c linux-3.7.6/sound/pci/hda/patch_realtek.c
--- linux-3.7.6-orig/sound/pci/hda/patch_realtek.c	2013-02-08 23:27:05.949484427 +0900
+++ linux-3.7.6/sound/pci/hda/patch_realtek.c	2013-02-08 23:41:04.897644545 +0900
@@ -5388,6 +5388,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE1601),
 	SND_PCI_QUIRK(0x104d, 0x9047, "Sony Vaio TT", ALC889_FIXUP_VAIO_TT),
 	SND_PCI_QUIRK(0x104d, 0x905a, "Sony Vaio Z", ALC882_FIXUP_NO_PRIMARY_HP),
+	SND_PCI_QUIRK(0x104d, 0x9043, "Sony Vaio VGC-LN51JGB", ALC882_FIXUP_NO_PRIMARY_HP),
 
 	/* All Apple entries are in codec SSIDs */
 	SND_PCI_QUIRK(0x106b, 0x00a0, "MacBookPro 3,1", ALC889_FIXUP_MBP_VREF),
