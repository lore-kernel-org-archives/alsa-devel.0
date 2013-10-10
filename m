From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Distinguish between the headset
	mic pin and the TRS mic
Date: Thu, 10 Oct 2013 15:26:52 +0200
Message-ID: <1381411612-7455-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E3BD62610A0
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 15:26:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, nathanael@gnat.ca
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On the Acer AO722, pin 0x1a represents the mic part of the TRRS
headset jack, and pin 0x1b represents the TRS mic jack.

Mark pin 0x1a as headset mic will help us know which one is which.

Reported-by: Nathanael D. Noblet <nathanael@gnat.ca>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ec68eae..7f30c9f 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3231,6 +3231,8 @@ enum {
 	CXT_FIXUP_INC_MIC_BOOST,
 	CXT_FIXUP_HEADPHONE_MIC_PIN,
 	CXT_FIXUP_HEADPHONE_MIC,
+	CXT_FIXUP_HEADSET_MIC_PIN,
+	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_GPIO1,
 };
 
@@ -3306,6 +3308,15 @@ static void cxt_fixup_headphone_mic(struct hda_codec *codec,
 	}
 }
 
+static void cxt_fixup_headset_mic(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+}
+
 
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
@@ -3376,6 +3387,19 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_headphone_mic,
 	},
+	[CXT_FIXUP_HEADSET_MIC_PIN] = {
+		.type = HDA_FIXUP_PINS,
+		.chained = true,
+		.chain_id = CXT_FIXUP_HEADSET_MIC,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x03a1903c }, /* use as headset mic, with jack detect */
+			{ }
+		}
+	},
+	[CXT_FIXUP_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_headset_mic,
+	},
 	[CXT_FIXUP_GPIO1] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -3395,6 +3419,7 @@ static const struct snd_pci_quirk cxt5051_fixups[] = {
 static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x1025, 0x0543, "Acer Aspire One 522", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_GPIO1),
+	SND_PCI_QUIRK(0x1025, 0x0598, "Acer AO722", CXT_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo T410", CXT_PINCFG_LENOVO_TP410),
-- 
1.7.9.5
