From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/38] ALSA: hda/realtek - Add the support for
	HP Presario B1900
Date: Fri, 24 Feb 2012 17:36:00 +0100
Message-ID: <1330101391-8788-8-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 144A110430F
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6168C90CE3
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

HP Presario B1900 needs a similar hack like Replacer, toggling GPIO1
per the jack state, in addition to the COEF setup used for other Acer
laptops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cfa6ad7..db1d8c8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4213,6 +4213,7 @@ enum {
 	ALC260_FIXUP_GPIO1,
 	ALC260_FIXUP_GPIO1_TOGGLE,
 	ALC260_FIXUP_REPLACER,
+	ALC260_FIXUP_HP_B1900,
 };
 
 static void alc260_gpio1_automute(struct hda_codec *codec)
@@ -4285,6 +4286,12 @@ static const struct alc_fixup alc260_fixups[] = {
 		.chained = true,
 		.chain_id = ALC260_FIXUP_GPIO1_TOGGLE,
 	},
+	[ALC260_FIXUP_HP_B1900] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc260_fixup_gpio1_toggle,
+		.chained = true,
+		.chain_id = ALC260_FIXUP_COEF,
+	}
 };
 
 static const struct snd_pci_quirk alc260_fixup_tbl[] = {
@@ -4292,6 +4299,7 @@ static const struct snd_pci_quirk alc260_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x007f, "Acer Aspire 9500", ALC260_FIXUP_COEF),
 	SND_PCI_QUIRK(0x1025, 0x008f, "Acer", ALC260_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x103c, 0x280a, "HP dc5750", ALC260_FIXUP_HP_DC5750),
+	SND_PCI_QUIRK(0x103c, 0x30ba, "HP Presario B1900", ALC260_FIXUP_HP_B1900),
 	SND_PCI_QUIRK(0x161f, 0x2057, "Replacer 672V", ALC260_FIXUP_REPLACER),
 	SND_PCI_QUIRK(0x1631, 0xc017, "PB V7900", ALC260_FIXUP_COEF),
 	{}
-- 
1.7.9
