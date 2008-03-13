From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Map 3stack-6ch-dig ALC662 model for Asus
	P5GC-MX
Date: Thu, 13 Mar 2008 16:21:27 -0300
Message-ID: <200803131621.28084.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id B181B103874
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 20:21:29 +0100 (CET)
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
Cc: Claudio Matsuoka <cmatsuoka@gmail.com>, Ferry Toth <ftoth@exalondelft.nl>
List-Id: alsa-devel@alsa-project.org

Map 3stack-6ch-dig ALC662 model for Asus P5GC-MX.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up linux-2.6.24/sound/pci/hda/patch_realtek.c.orig linux-2.6.24/sound/pci/hda/patch_realtek.c
--- linux-2.6.24/sound/pci/hda/patch_realtek.c.orig	2008-03-11 16:00:01.000000000 -0300
+++ linux-2.6.24/sound/pci/hda/patch_realtek.c	2008-03-11 16:09:43.000000000 -0300
@@ -13399,6 +13399,7 @@ static const char *alc662_models[ALC662_
 };
 
 static struct snd_pci_quirk alc662_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x1043, 0x8290, "ASUS P5GC-MX", ALC662_3ST_6ch_DIG),
 	SND_PCI_QUIRK(0x1043, 0x82a1, "ASUS Eeepc", ALC662_ASUS_EEEPC_P701),
 	SND_PCI_QUIRK(0x1043, 0x82d1, "ASUS Eeepc EP20", ALC662_ASUS_EEEPC_EP20),
 	SND_PCI_QUIRK(0x17aa, 0x101e, "Lenovo", ALC662_LENOVO_101E),


-- 
[]'s
Herton
