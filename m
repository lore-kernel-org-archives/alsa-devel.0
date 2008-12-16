From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - Add automatic model setting for
	Samsung Q45
Date: Tue, 16 Dec 2008 12:37:47 +1100
Message-ID: <1229391467-13639-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl2.internode.on.net (ipmail05.adl2.internode.on.net
	[203.16.214.145])
	by alsa0.perex.cz (Postfix) with ESMTP id E0D4F1037F2
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 02:37:57 +0100 (CET)
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
Cc: Luke Yelavich <themuso@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

Have the Samsung Q45 (144d:c510) select ALC262_HIPPO by default

Signed-off-by: Luke Yelavich <themuso@ubuntu.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4afa0c9..3b2a793 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10541,6 +10541,7 @@ static struct snd_pci_quirk alc262_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x142d, "Fujitsu Lifebook E8410", ALC262_FUJITSU),
 	SND_PCI_QUIRK(0x144d, 0xc032, "Samsung Q1 Ultra", ALC262_ULTRA),
 	SND_PCI_QUIRK(0x144d, 0xc039, "Samsung Q1U EL", ALC262_ULTRA),
+	SND_PCI_QUIRK(0x144d, 0xc510, "Samsung Q45", ALC262_HIPPO),
 	SND_PCI_QUIRK(0x17aa, 0x384e, "Lenovo 3000 y410", ALC262_LENOVO_3000),
 	SND_PCI_QUIRK(0x17ff, 0x0560, "Benq ED8", ALC262_BENQ_ED8),
 	SND_PCI_QUIRK(0x17ff, 0x058d, "Benq T31-16", ALC262_BENQ_T31),
-- 
1.5.6.3
