From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH 3/3] ALSA: hda - Map 3stack-hp model (ALC888)
	for HP Educ.ar
Date: Wed,  4 Mar 2009 14:22:52 -0300
Message-ID: <1236187372-15818-3-git-send-email-herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 90862103872
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 18:28:45 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: alsa-devel@alsa-project.org

Added model=3stack-hp for HP Educ.ar desktop machine (103c:2a72).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 251647d..91ef9f2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8673,6 +8673,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2a60, "HP Lucknow", ALC888_3ST_HP),
 	SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x103c, 0x2a66, "HP Acacia", ALC888_3ST_HP),
+	SND_PCI_QUIRK(0x103c, 0x2a72, "HP Educ.ar", ALC888_3ST_HP),
 	SND_PCI_QUIRK(0x1043, 0x1873, "Asus M90V", ALC888_ASUS_M90V),
 	SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI", ALC883_3ST_6ch_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8284, "Asus Z37E", ALC883_6ST_DIG),
-- 
1.6.1.3
