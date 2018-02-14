From: Jan-Marek Glogowski <glogow@fbihome.de>
Subject: [PATCH v4] ALSA: hda/realtek PCI quirk for Fujitsu U7x7
Date: Wed, 14 Feb 2018 11:36:16 +0100
Message-ID: <eec72aad-e16b-217d-009d-33efb8a11177@fbihome.de>
References: <c6ec1a50-187e-42d8-4137-f162c52e4f79@fbihome.de>
 <dcac37ef-4319-9eb3-4652-17bc6aa8fbc9@fbihome.de>
 <s5h7erh4e7z.wl-tiwai@suse.de>
 <6d34fc90-48fb-8d5a-f7a5-7a3e33ddec9b@fbihome.de>
 <s5hzi4d6t5h.wl-tiwai@suse.de>
 <791b9188-c136-dd65-61c2-cb2e93d52876@fbihome.de>
 <s5hinb12be2.wl-tiwai@suse.de>
 <0973174b-bd33-0a3c-bc12-d37ef61dc743@fbihome.de>
 <s5ha7wc3izq.wl-tiwai@suse.de>
 <d53f0519-d387-fd15-31e0-4fd6ab6bbfdb@fbihome.de>
 <s5hfu637vt9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironchief.h-da.de (ironchief.h-da.de [141.100.10.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F53A26773D
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 11:36:17 +0100 (CET)
In-Reply-To: <s5hfu637vt9.wl-tiwai@suse.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 14.02.2018 um 10:41 schrieb Takashi Iwai:
> On Wed, 14 Feb 2018 10:36:21 +0100,
> Jan-Marek Glogowski wrote:
>>
>> From: Jan-Marek Glogowski <jan-marek.glogowski@muenchen.de>
> 
> This is different from your sign-off address.  Is it intentional?
> Just to be sure.
No - just updated my kernel .git/config with the correct address.
Thanks for catching that.
I'm just wondering, why this changed, because I didn't use --reset-author for amending the patch...

Jan-Marek

----

>From 7900f8a4892db1bfddec8af8f662ca47ef75bd53 Mon Sep 17 00:00:00 2001
From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Wed, 14 Feb 2018 11:29:15 +0100
Subject: [PATCH] ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

These laptops have a combined jack to attach headsets, the U727 on
the left, the U757 on the right, but a headsets microphone doesn't
work. Using hdajacksensetest I found that pin 0x19 changed the
present state when plugging the headset, in addition to 0x21, but
didn't have the correct configuration (shown as "Not connected").

So this sets the configuration to the same values as the headphone
pin 0x21 except for the device type microphone, which makes it
work correctly. With the patch the configured pins for U727 are

Pin 0x12 (Internal Mic, Mobile-In): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x19 (Black Mic, Left side): present = No
Pin 0x1d (Internal Aux): present = No
Pin 0x21 (Black Headphone, Left side): present = No

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
---
 sound/pci/hda/patch_realtek.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2347588..3086759 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3465,6 +3465,19 @@ static void alc269_fixup_pincfg_no_hp_to_lineout(struct hda_codec *codec,
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 }
 
+static void alc269_fixup_pincfg_U7x7_headset_mic(struct hda_codec *codec,
+						 const struct hda_fixup *fix,
+						 int action)
+{
+	unsigned int cfg_headphone = snd_hda_codec_get_pincfg(codec, 0x21);
+	unsigned int cfg_headset_mic = snd_hda_codec_get_pincfg(codec, 0x19);
+
+	if (cfg_headphone && cfg_headset_mic == 0x411111f0)
+		snd_hda_codec_set_pincfg(codec, 0x19,
+			(cfg_headphone & ~AC_DEFCFG_DEVICE) |
+			(AC_JACK_MIC_IN << AC_DEFCFG_DEVICE_SHIFT));
+}
+
 static void alc269_fixup_hweq(struct hda_codec *codec,
 			       const struct hda_fixup *fix, int action)
 {
@@ -5351,6 +5364,7 @@ enum {
 	ALC269_FIXUP_LIFEBOOK_EXTMIC,
 	ALC269_FIXUP_LIFEBOOK_HP_PIN,
 	ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT,
+	ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC,
 	ALC269_FIXUP_AMIC,
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
@@ -5556,6 +5570,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
+	[ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
+	},
 	[ALC269_FIXUP_AMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6422,6 +6440,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x159f, "Lifebook E780", ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT),
 	SND_PCI_QUIRK(0x10cf, 0x15dc, "Lifebook T731", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
+	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
-- 
2.1.4
