From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix noise problems on Thinkpad
	T440s
Date: Wed,  9 Dec 2015 15:36:34 +0100
Message-ID: <1449671794-24490-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D2E2605B7
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 15:36:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EB7A5ACA5
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 14:36:36 +0000 (UTC)
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

Lenovo Thinkpad T440s suffers from constant background noises, and it
seems to be a generic hardware issue on this model:
  https://forums.lenovo.com/t5/ThinkPad-T400-T500-and-newer-T/T440s-speaker-noise/td-p/1339883

As the noise comes from the analog loopback path, disabling the path
is the easy workaround.

Also, the machine gives significant cracking noises at PM suspend.  A
workaround found by trial-and-error is to disable the shutup callback
currently used for ALC269-variant.

This patch addresses these noise issues by introducing a new fixup
chain.  Although the same workaround might be applicable to other
Thinkpad models, it's applied only to T440s (17aa:220c) in this patch,
so far, just to be safe (you chicken!).  As a compromise, a new model
option string "tp440" is provided now, though, so that owners of other
Thinkpad models can test it more easily.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=958504
Reported-and-tested-by: Tim Hardeck <thardeck@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 49b1d366f82a..8dd2ac13b3af 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4204,6 +4204,18 @@ static void alc_fixup_tpt440_dock(struct hda_codec *codec,
 	}
 }
 
+/* additional fixup for Thinkpad T440s noise problem */
+static void alc_fixup_tpt440(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->shutup = alc_no_shutup; /* reduce click noise */
+		spec->gen.mixer_nid = 0; /* reduce background noise */
+	}
+}
+
 static void alc_shutup_dell_xps13(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -4578,6 +4590,7 @@ enum {
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC292_FIXUP_TPT440_DOCK,
+	ALC292_FIXUP_TPT440,
 	ALC283_FIXUP_BXBT2807_MIC,
 	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
 	ALC282_FIXUP_ASPIRE_V5_PINS,
@@ -5051,6 +5064,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
 	},
+	[ALC292_FIXUP_TPT440] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_tpt440,
+		.chained = true,
+		.chain_id = ALC292_FIXUP_TPT440_DOCK,
+	},
 	[ALC283_FIXUP_BXBT2807_MIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5332,7 +5351,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21fb, "Thinkpad T430s", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2208, "Thinkpad T431s", ALC269_FIXUP_LENOVO_DOCK),
-	SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad T440s", ALC292_FIXUP_TPT440_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad T440s", ALC292_FIXUP_TPT440),
 	SND_PCI_QUIRK(0x17aa, 0x220e, "Thinkpad T440p", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2210, "Thinkpad T540p", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2211, "Thinkpad W541", ALC292_FIXUP_TPT440_DOCK),
@@ -5432,6 +5451,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC283_FIXUP_CHROME_BOOK, .name = "alc283-dac-wcaps"},
 	{.id = ALC283_FIXUP_SENSE_COMBO_JACK, .name = "alc283-sense-combo"},
 	{.id = ALC292_FIXUP_TPT440_DOCK, .name = "tpt440-dock"},
+	{.id = ALC292_FIXUP_TPT440, .name = "tpt440"},
 	{}
 };
 
-- 
2.6.3
