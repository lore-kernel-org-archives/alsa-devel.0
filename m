From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ALSA: hda - add mic fixup for ALC269VB on
	Ordissimo EVE2
Date: Mon,  3 Jun 2013 11:53:10 +0200
Message-ID: <1370253190-25072-1-git-send-email-anisse@astier.eu>
References: <20120717151109.66d239a5@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 32338261986
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 12:03:05 +0200 (CEST)
Received: by mail-wi0-f175.google.com with SMTP id hn14so2488701wib.8
 for <alsa-devel@alsa-project.org>; Mon, 03 Jun 2013 03:03:04 -0700 (PDT)
In-Reply-To: <20120717151109.66d239a5@destiny.ordissimo>
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
Cc: Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com>, Anisse Astier <anisse@astier.eu>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This fixes the internal and external mic on Ordissimo EVE2,  also known
as Malata PC-B1303.

We still don't know how to detect mic jack like Realtek's windows
driver.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi,

I'm on a dead end on this computer, I can't seem to find how the mic jack
presence works. It's always on(presence detected whatever the status) on NID
0x18, the one used for the external mic. I have tried every NID, manually
enabling pin_sense on each, but only the headphone jack detection works. The
mic sense is nowhere to be seen.

This is on top sound/for-next.

Also, I'd love to have access to an ALC269VB datasheet, or at least know the
differences with an ALC269. Do no hesitate to contact me in private.

Regards,

Anisse
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 59d2e91..6b0d8fe 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3225,6 +3225,7 @@ enum {
 	ALC271_FIXUP_HP_GATE_MIC_JACK,
 	ALC269_FIXUP_ACER_AC700,
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST,
+	ALC269VB_FIXUP_ORDISSIMO_EVE2,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -3467,6 +3468,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_limit_int_mic_boost,
 	},
+	[ALC269VB_FIXUP_ORDISSIMO_EVE2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x12, 0x99a3092f }, /* int-mic */
+			{ 0x18, 0x03a11d20 }, /* mic */
+			{ 0x19, 0x411111f0 }, /* Unused bogus pin */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -3533,6 +3543,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
1.8.1.4
