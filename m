From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Add configuration for HP EliteBook 2530p
Date: Wed, 1 Apr 2009 00:33:10 +0100
Message-ID: <20090331233310.GA32128@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vavatch.codon.org.uk (cavan.codon.org.uk [93.93.128.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CFB524438
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 01:33:15 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The HP EliteBook 2530p needs the AD1884A_LAPTOP codec setup.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 5bb48ee..945b029 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -3924,6 +3924,7 @@ static struct snd_pci_quirk ad1884a_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x3056, "HP", AD1884A_MOBILE),
 	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x3070, "HP", AD1884A_MOBILE),
 	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x30e0, "HP laptop", AD1884A_LAPTOP),
+	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x30e1, "HP laptop", AD1884A_LAPTOP),
 	SND_PCI_QUIRK_MASK(0x103c, 0xff00, 0x3600, "HP laptop", AD1884A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x20ac, "Thinkpad X300", AD1884A_THINKPAD),
 	{}

-- 
Matthew Garrett | mjg59@srcf.ucam.org
