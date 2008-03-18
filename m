From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Map 3stack-6ch-dig ALC883 model for MSI
	945GCM5 V2 (MSI-7267)
Date: Tue, 18 Mar 2008 00:57:33 -0300
Message-ID: <200803180057.33996.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 89BF924345
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 04:57:35 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C65103D8AC
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 00:57:34 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id 2B2E9S8ruICW for <alsa-devel@alsa-project.org>;
	Tue, 18 Mar 2008 00:57:34 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 744773D8AA
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 00:57:34 -0300 (BRT)
Received: from [172.21.225.22] (unknown [172.21.225.22])
	by fox.conectiva (Postfix) with ESMTP id 198FD2F09B
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 00:57:34 -0300 (BRT)
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

Map 3stack-6ch-dig ALC883 model for MSI 945GCM5 V2 (MSI-7267).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up alsa-kernel/pci/hda/patch_realtek.c.orig alsa-kernel/pci/hda/patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c.orig	2008-03-18 00:18:52.000000000 -0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2008-03-18 00:48:18.000000000 -0300
@@ -7763,6 +7763,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7187, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7250, "MSI", ALC883_6ST_DIG),
+	SND_PCI_QUIRK(0x1462, 0x7267, "MSI", ALC883_3ST_6ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7280, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7327, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),

-- 
[]'s
Herton
