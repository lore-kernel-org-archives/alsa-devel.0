From: Rick Sherman <rick@shermdog.com>
Subject: [PATCH] ALSA: hda - Add dock support for Thinkpad W541
	(17aa:2211)
Date: Tue, 18 Aug 2015 21:04:30 -0500
Message-ID: <1439949683.6864.0.camel@shermdog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.shermdog.com (mail.shermdog.com [162.243.32.247])
 by alsa0.perex.cz (Postfix) with ESMTP id A52E6261B20
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 04:04:33 +0200 (CEST)
Received: from w541.shermdog.local (unknown [68.184.196.170])
 (Authenticated sender: rick@shermdog.com)
 by mail.shermdog.com (Postfix) with ESMTPSA id 8FC11C2AFD
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 02:04:31 +0000 (UTC)
Resent-To: alsa-devel@alsa-project.org
Resent-Message-Id: <20150819020446.60DC6261B36@alsa0.perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tested with W541 and Ultra Dock 170w
Signed-off-by: Rick Sherman <rick@shermdog.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0b9847a..39a0342 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5291,6 +5291,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad T440s", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x220e, "Thinkpad T440p", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2210, "Thinkpad T540p", ALC292_FIXUP_TPT440_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2211, "Thinkpad W541", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2212, "Thinkpad T440", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad X240", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.4.3
