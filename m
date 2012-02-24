From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/38] ALSA: hda/realtek - Replace ALC260
	model=acer with the auto-parser
Date: Fri, 24 Feb 2012 17:35:58 +0100
Message-ID: <1330101391-8788-6-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id C39321042FF
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5FC3090B96
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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

The ALC260 model=acer needs GPIO1 setup.  It could be selected well
if the codec SSID is set properly by BIOS, but to make sure, enable it
forcibly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f5f3710..95ef722 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4210,6 +4210,7 @@ enum {
 	ALC260_FIXUP_HP_DC5750,
 	ALC260_FIXUP_HP_PIN_0F,
 	ALC260_FIXUP_COEF,
+	ALC260_FIXUP_GPIO1,
 };
 
 static const struct alc_fixup alc260_fixups[] = {
@@ -4237,10 +4238,16 @@ static const struct alc_fixup alc260_fixups[] = {
 		.chained = true,
 		.chain_id = ALC260_FIXUP_HP_PIN_0F,
 	},
+	[ALC260_FIXUP_GPIO1] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = alc_gpio1_init_verbs,
+	},
 };
 
 static const struct snd_pci_quirk alc260_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1025, 0x007b, "Acer C20x", ALC260_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x1025, 0x007f, "Acer Aspire 9500", ALC260_FIXUP_COEF),
+	SND_PCI_QUIRK(0x1025, 0x008f, "Acer", ALC260_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x103c, 0x280a, "HP dc5750", ALC260_FIXUP_HP_DC5750),
 	SND_PCI_QUIRK(0x1631, 0xc017, "PB V7900", ALC260_FIXUP_COEF),
 	{}
-- 
1.7.9
