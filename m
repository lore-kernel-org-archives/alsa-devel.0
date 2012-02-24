From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/38] ALSA: hda - Suppress auto-mute feature
	on some machines with ALC861
Date: Fri, 24 Feb 2012 17:35:55 +0100
Message-ID: <1330101391-8788-3-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id C2B8D1042FB
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5A6B18FFDD
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

A few machines with ALC861 & co are reported not to work properly with
the auto-mute feature in software.  The auto-mute feature is implemented
in the hardware level, and the jack-detection never works with them.

Also, rename the fixup index as ALC861_FIXUP_* to follow the standard.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4a2a49f..c630598 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5563,8 +5563,10 @@ static const struct hda_amp_list alc861_loopbacks[] = {
 
 /* Pin config fixes */
 enum {
-	PINFIX_FSC_AMILO_PI1505,
-	PINFIX_ASUS_A6RP,
+	ALC861_FIXUP_FSC_AMILO_PI1505,
+	ALC861_FIXUP_AMP_VREF_0F,
+	ALC861_FIXUP_NO_JACK_DETECT,
+	ALC861_FIXUP_ASUS_A6RP,
 };
 
 /* On some laptops, VREF of pin 0x0f is abused for controlling the main amp */
@@ -5586,8 +5588,16 @@ static void alc861_fixup_asus_amp_vref_0f(struct hda_codec *codec,
 	spec->keep_vref_in_automute = 1;
 }
 
+/* suppress the jack-detection */
+static void alc_fixup_no_jack_detect(struct hda_codec *codec,
+				     const struct alc_fixup *fix, int action)
+{
+	if (action == ALC_FIXUP_ACT_PRE_PROBE)
+		codec->no_jack_detect = 1;
+}	
+
 static const struct alc_fixup alc861_fixups[] = {
-	[PINFIX_FSC_AMILO_PI1505] = {
+	[ALC861_FIXUP_FSC_AMILO_PI1505] = {
 		.type = ALC_FIXUP_PINS,
 		.v.pins = (const struct alc_pincfg[]) {
 			{ 0x0b, 0x0221101f }, /* HP */
@@ -5595,17 +5605,29 @@ static const struct alc_fixup alc861_fixups[] = {
 			{ }
 		}
 	},
-	[PINFIX_ASUS_A6RP] = {
+	[ALC861_FIXUP_AMP_VREF_0F] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc861_fixup_asus_amp_vref_0f,
 	},
+	[ALC861_FIXUP_NO_JACK_DETECT] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc_fixup_no_jack_detect,
+	},
+	[ALC861_FIXUP_ASUS_A6RP] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc861_fixup_asus_amp_vref_0f,
+		.chained = true,
+		.chain_id = ALC861_FIXUP_NO_JACK_DETECT,
+	}
 };
 
 static const struct snd_pci_quirk alc861_fixup_tbl[] = {
-	SND_PCI_QUIRK_VENDOR(0x1043, "ASUS laptop", PINFIX_ASUS_A6RP),
-	SND_PCI_QUIRK(0x1584, 0x0000, "Uniwill ECS M31EI", PINFIX_ASUS_A6RP),	
-	SND_PCI_QUIRK(0x1584, 0x2b01, "Haier W18", PINFIX_ASUS_A6RP),
-	SND_PCI_QUIRK(0x1734, 0x10c7, "FSC Amilo Pi1505", PINFIX_FSC_AMILO_PI1505),
+	SND_PCI_QUIRK(0x1043, 0x1393, "ASUS A6Rp", ALC861_FIXUP_ASUS_A6RP),
+	SND_PCI_QUIRK_VENDOR(0x1043, "ASUS laptop", ALC861_FIXUP_AMP_VREF_0F),
+	SND_PCI_QUIRK(0x1462, 0x7254, "HP DX2200", ALC861_FIXUP_NO_JACK_DETECT),
+	SND_PCI_QUIRK(0x1584, 0x2b01, "Haier W18", ALC861_FIXUP_AMP_VREF_0F),
+	SND_PCI_QUIRK(0x1584, 0x0000, "Uniwill ECS M31EI", ALC861_FIXUP_AMP_VREF_0F),
+	SND_PCI_QUIRK(0x1734, 0x10c7, "FSC Amilo Pi1505", ALC861_FIXUP_FSC_AMILO_PI1505),
 	{}
 };
 
-- 
1.7.9
