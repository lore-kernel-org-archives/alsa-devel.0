From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable AA-mix on Sony Vaio S13
Date: Wed, 21 May 2014 11:16:40 +0200
Message-ID: <1400663800-15463-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D0B82654DC
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 11:16:40 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 10FDEABE8
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 09:16:40 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The analog-loopback causes the speaker noises even if it's set to zero
volume.  As a simple workaround, just get rid of the loopback mixer.

Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=873704
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 680283b23474..bf1e1a625086 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4196,6 +4196,7 @@ enum {
 	ALC269_FIXUP_ASUS_G73JW,
 	ALC269_FIXUP_LENOVO_EAPD,
 	ALC275_FIXUP_SONY_HWEQ,
+	ALC275_FIXUP_SONY_DISABLE_AAMIX,
 	ALC271_FIXUP_DMIC,
 	ALC269_FIXUP_PCM_44K,
 	ALC269_FIXUP_STEREO_DMIC,
@@ -4301,6 +4302,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC275_FIXUP_SONY_VAIO_GPIO2
 	},
+	[ALC275_FIXUP_SONY_DISABLE_AAMIX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_disable_aamix,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_SONY_VAIO
+	},
 	[ALC271_FIXUP_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc271_fixup_dmic,
@@ -4811,6 +4818,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
 	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
+	SND_PCI_QUIRK(0x104d, 0x9099, "Sony VAIO S13", ALC275_FIXUP_SONY_DISABLE_AAMIX),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
-- 
1.9.3
