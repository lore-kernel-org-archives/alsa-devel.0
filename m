From: Ozan Caglayan <ozan@pardus.org.tr>
Subject: [PATCH] ALSA: hda - Add model quirk for Sony VAIO
	VGN-NR21E
Date: Tue, 10 Mar 2009 09:51:22 +0200
Message-ID: <1236671482-3748-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (ns2.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id BF548243EE
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 08:49:28 +0100 (CET)
Received: from localhost.localdomain (uekae-subnet-out.ume.tubitak.gov.tr
	[194.27.222.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by pardus.org.tr (Postfix) with ESMTP id 48AED63E5339
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 09:49:23 +0200 (EET)
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

One of our users reported that its laptop doesn't mute the internal
speakers when a jack is inserted into headphones without model=hippo.

Here's the alsa-info output for reference:
http://www.alsa-project.org/db/?f=8dae188ec2db110b9e6804c60f4659f0cb606c62

Signed-off-by: Ozan Caglayan <ozan@pardus.org.tr>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b794cba..6e79770 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10874,6 +10874,7 @@ static struct snd_pci_quirk alc262_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2817, "HP RP5700", ALC262_HP_RP5700),
 	SND_PCI_QUIRK(0x104d, 0x1f00, "Sony ASSAMD", ALC262_SONY_ASSAMD),
 	SND_PCI_QUIRK(0x104d, 0x8203, "Sony UX-90", ALC262_HIPPO),
+	SND_PCI_QUIRK(0x104d, 0x902d, "Sony VAIO VGN-NR21E", ALC262_HIPPO),
 	SND_PCI_QUIRK(0x104d, 0x820f, "Sony ASSAMD", ALC262_SONY_ASSAMD),
 	SND_PCI_QUIRK(0x104d, 0x9016, "Sony VAIO", ALC262_AUTO), /* dig-only */
 	SND_PCI_QUIRK_MASK(0x104d, 0xff00, 0x9000, "Sony VAIO",
-- 
1.6.2
