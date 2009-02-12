From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Change HP dv7 (103c:30f4) quirk
	from hp-m4 to hp-dv5 model
Date: Thu, 12 Feb 2009 17:27:27 -0200
Message-ID: <200902121727.27839.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B6BE24377
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 20:27:14 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 716633EAF
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 14:27:30 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id T3PhWZYjslGW for <alsa-devel@alsa-project.org>;
	Thu, 12 Feb 2009 14:27:29 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 2D0D03EA5
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 14:27:29 -0500 (EST)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 9C55B2F428
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 16:27:12 -0300 (BRT)
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

Change HP dv7 quirk: although reported to work with hp-m4 model
(https://bugzilla.novell.com/show_bug.cgi?id=445321), the original
report doesn't contain info about testing of internal microphone.

Recently I received a report about internal mic not working
(https://qa.mandriva.com/show_bug.cgi?id=44855#c193), this must be
related with the forced line in on pin 0x0e done with hp-m4 model. Thus
change the current quirk from STAC_HP_M4 to STAC_HP_DV5, later reported
to be fixed on a provided kernel with this change
(https://qa.mandriva.com/show_bug.cgi?id=44855#c196).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_sigmatel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3c84817..efc1aff 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1811,7 +1811,7 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f2,
 		      "HP dv5", STAC_HP_M4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f4,
-		      "HP dv7", STAC_HP_M4),
+		      "HP dv7", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f7,
 		      "HP dv4", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fc,
-- 
1.6.1.3
