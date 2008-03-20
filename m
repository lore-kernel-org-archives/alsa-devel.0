From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Map clevo-m720r ALC883 model for Clevo M720SR
Date: Thu, 20 Mar 2008 17:08:06 -0300
Message-ID: <200803201708.06900.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F31E245C6
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 21:08:11 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 8DBBC3EA5
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 17:08:08 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id ADuH1twqmsXG for <alsa-devel@alsa-project.org>;
	Thu, 20 Mar 2008 17:08:08 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 411E43E7FE
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 17:08:07 -0300 (BRT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 526552F283
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 17:08:07 -0300 (BRT)
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

Map clevo-m720r ALC883 model for Clevo M720SR.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up alsa-kernel/pci/hda/patch_realtek.c.orig alsa-kernel/pci/hda/patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c.orig	2008-03-20 16:32:34.000000000 -0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2008-03-20 16:43:55.000000000 -0300
@@ -7650,6 +7650,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x147b, 0x1083, "Abit IP35-PRO", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1558, 0x0721, "Clevo laptop M720R", ALC883_CLEVO_M720R),
+	SND_PCI_QUIRK(0x1558, 0x0722, "Clevo laptop M720SR", ALC883_CLEVO_M720R),
 	SND_PCI_QUIRK(0x1558, 0, "Clevo laptop", ALC883_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x15d9, 0x8780, "Supermicro PDSBA", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),

-- 
[]'s
Herton
