From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Map ALC662 model for Gigabyte
	945GCM-S2L
Date: Fri, 26 Sep 2008 23:47:45 -0300
Message-ID: <200809262347.45605.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 41557244DD
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 04:48:00 +0200 (CEST)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 794643EB1
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 22:48:13 -0400 (EDT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id 23VKkNRgSA7E for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 22:48:13 -0400 (EDT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 28E9E3EB0
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 22:48:12 -0400 (EDT)
Received: from [172.21.225.14] (unknown [172.21.225.14])
	by fox.conectiva (Postfix) with ESMTP id DE6182F27C
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 23:47:51 -0300 (BRT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use 3stack-6ch-dig ALC662 model for Gigabyte 945GCM-S2L motherboard.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

diff -p -up linux-2.6.26/sound/pci/hda/patch_realtek.c.orig linux-2.6.26/sound/pci/hda/patch_realtek.c
--- linux-2.6.26/sound/pci/hda/patch_realtek.c.orig	2008-09-26 23:11:04.000000000 -0300
+++ linux-2.6.26/sound/pci/hda/patch_realtek.c	2008-09-26 23:22:29.000000000 -0300
@@ -15705,6 +15705,8 @@ static struct snd_pci_quirk alc662_cfg_t
 	SND_PCI_QUIRK(0x17aa, 0x101e, "Lenovo", ALC662_LENOVO_101E),
 	SND_PCI_QUIRK(0x1019, 0x9087, "ECS", ALC662_ECS),
 	SND_PCI_QUIRK(0x105b, 0x0cd6, "Foxconn", ALC662_ECS),
+	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte 945GCM-S2L",
+		      ALC662_3ST_6ch_DIG),
 	SND_PCI_QUIRK(0x1854, 0x2000, "ASUS H13-2000", ALC663_ASUS_H13),
 	SND_PCI_QUIRK(0x1854, 0x2001, "ASUS H13-2001", ALC663_ASUS_H13),
 	SND_PCI_QUIRK(0x1854, 0x2002, "ASUS H13-2002", ALC663_ASUS_H13),
