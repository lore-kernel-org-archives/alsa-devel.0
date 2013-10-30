From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add extra chmap for 2.1 outputs on
	ASUS laptops
Date: Wed, 30 Oct 2013 17:44:56 +0100
Message-ID: <1383151496-31684-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 399BC26546B
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 17:42:08 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 14413A59A8
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 17:42:08 +0100 (CET)
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

ASUS N56VZ and N76VZ laptops have a bass speaker but its output comes
only from the right channel.  This patch adds the extra chmap specific
to these models.

Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=846531
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 13ad49ca9357..2d7c86d81196 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4426,6 +4426,25 @@ static void alc272_fixup_mario(struct hda_codec *codec,
 		       "hda_codec: failed to override amp caps for NID 0x2\n");
 }
 
+static const struct snd_pcm_chmap_elem asus_pcm_2_1_chmaps[] = {
+	{ .channels = 2,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
+	{ .channels = 4,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+		   SNDRV_CHMAP_NA, SNDRV_CHMAP_LFE } }, /* LFE only on right */
+	{ }
+};
+
+/* override the 2.1 chmap */
+static void alc662_fixup_bass_chmap(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_BUILD) {
+		struct alc_spec *spec = codec->spec;
+		spec->gen.pcm_rec[0].stream[0].chmap = asus_pcm_2_1_chmaps;
+	}
+}
+
 enum {
 	ALC662_FIXUP_ASPIRE,
 	ALC662_FIXUP_IDEAPAD,
@@ -4446,6 +4465,7 @@ enum {
 	ALC662_FIXUP_INV_DMIC,
 	ALC668_FIXUP_DELL_MIC_NO_PRESENCE,
 	ALC668_FIXUP_HEADSET_MODE,
+	ALC662_FIXUP_BASS_CHMAP,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -4620,6 +4640,12 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode_alc668,
 	},
+	[ALC662_FIXUP_BASS_CHMAP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc662_fixup_bass_chmap,
+		.chained = true,
+		.chain_id = ALC662_FIXUP_ASUS_MODE4
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -4633,8 +4659,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
-	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_ASUS_MODE4),
-	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_ASUS_MODE4),
+	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_BASS_CHMAP),
+	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_BASS_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x8469, "ASUS mobo", ALC662_FIXUP_NO_JACK_DETECT),
 	SND_PCI_QUIRK(0x105b, 0x0cd6, "Foxconn", ALC662_FIXUP_ASUS_MODE2),
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
-- 
1.8.4.1
