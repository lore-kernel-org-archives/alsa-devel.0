From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] hda_intel - Add model quirk for Albatron
	KI690-AM2 motherboard
Date: Sat, 02 Feb 2008 02:18:23 -0400
Message-ID: <380e8be9c65b04eb6a4f.1201936703@am2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id DE8EE24628
	for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2008 08:19:29 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so330111ana.80
	for <alsa-devel@alsa-project.org>; Fri, 01 Feb 2008 23:19:28 -0800 (PST)
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

This adds a quirk to the Realtek ALC883 table for the Albatron KI690-AM2
motherboard to use the 6stack-dig model.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r ba9ca6a13ef2 -r 380e8be9c65b pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Fri Feb 01 17:23:54 2008 +0100
+++ b/pci/hda/patch_realtek.c	Sat Feb 02 02:11:00 2008 -0500
@@ -7635,6 +7635,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x17aa, 0x3bfc, "Lenovo NB0763", ALC883_LENOVO_NB0763),
 	SND_PCI_QUIRK(0x17aa, 0x3bfd, "Lenovo NB0763", ALC883_LENOVO_NB0763),
 	SND_PCI_QUIRK(0x17c0, 0x4071, "MEDION MD2", ALC883_MEDION_MD2),
+        SND_PCI_QUIRK(0x17f2, 0x5000, "Albatron KI690-AM2", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1991, 0x5625, "Haier W66", ALC883_HAIER_W66),
 	SND_PCI_QUIRK(0x8086, 0xd601, "D102GGC", ALC883_3ST_6ch),
 	{}
