From: Chris Bagwell <chris@cnpbagwell.com>
Subject: [PATCH] ALSA: hda - Add HP Acacia detection
Date: Tue, 23 Dec 2008 13:21:55 -0600
Message-ID: <49513A53.6040407@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp112.sbc.mail.mud.yahoo.com (smtp112.sbc.mail.mud.yahoo.com
	[68.142.198.211])
	by alsa0.perex.cz (Postfix) with SMTP id 0F7F810383A
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 20:21:58 +0100 (CET)
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

Add automatic mapping of HP Acacia motherboards to 3stack-hp.  Allows 
for greater then 2 channel audio by enabling Channel Mode option in mixer.

Motherboard specs: 
http://h10025.www1.hp.com/ewfrf/wc/document?docname=c01321559&lc=en&dlc=en&cc=us&product=3829353&os=2093&lang=en#

Signed-off-by: Chris Bagwell <chris at cnpbagwell dot com>

diff --git a/pci/hda/patch_realtek.c b/pci/hda/patch_realtek.c
index 4afa0c9..410be84 100644
--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -8444,6 +8444,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
        SND_PCI_QUIRK(0x103c, 0x2a4f, "HP Samba", ALC888_3ST_HP),
        SND_PCI_QUIRK(0x103c, 0x2a60, "HP Lucknow", ALC888_3ST_HP),
        SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
+        SND_PCI_QUIRK(0x103c, 0x2a66, "HP Acacia", ALC888_3ST_HP),
        SND_PCI_QUIRK(0x1043, 0x1873, "Asus M90V", ALC888_ASUS_M90V),
        SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI", 
ALC883_3ST_6ch_DIG),
        SND_PCI_QUIRK(0x1043, 0x82fe, "Asus P5Q-EM HDMI", ALC1200_ASUS_P5Q),
