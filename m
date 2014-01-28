From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/11] ALSA: hda - Add fixup name lookup for
	CX5051 and 5066 codecs
Date: Tue, 28 Jan 2014 11:06:31 +0100
Message-ID: <1390903600-22772-3-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ECC7D2651BE
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:42 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 01BF9AC80
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:43 +0000 (UTC)
In-Reply-To: <1390903600-22772-1-git-send-email-tiwai@suse.de>
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

Like other codecs, apply a specific fixup given by a model string.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 4e0ec146553d..b103908c63d7 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3407,6 +3407,11 @@ static const struct snd_pci_quirk cxt5051_fixups[] = {
 	{}
 };
 
+static const struct hda_model_fixup cxt5051_fixup_models[] = {
+	{ .id = CXT_PINCFG_LENOVO_X200, .name = "lenovo-x200" },
+	{}
+};
+
 static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x1025, 0x0543, "Acer Aspire One 522", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_GPIO1),
@@ -3427,6 +3432,16 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	{}
 };
 
+static const struct hda_model_fixup cxt5066_fixup_models[] = {
+	{ .id = CXT_FIXUP_STEREO_DMIC, .name = "stereo-dmic" },
+	{ .id = CXT_FIXUP_GPIO1, .name = "gpio1" },
+	{ .id = CXT_FIXUP_HEADPHONE_MIC_PIN, .name = "headphone-mic-pin" },
+	{ .id = CXT_PINCFG_LENOVO_TP410, .name = "tp410" },
+	{ .id = CXT_FIXUP_THINKPAD_ACPI, .name = "thinkpad" },
+	{ .id = CXT_PINCFG_LEMOTE_A1004, .name = "lemote-a1004" },
+	{}
+};
+
 /* add "fake" mute amp-caps to DACs on cx5051 so that mixer mute switches
  * can be created (bko#42825)
  */
@@ -3474,11 +3489,13 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f15051:
 		add_cx5051_fake_mutes(codec);
 		codec->pin_amp_workaround = 1;
-		snd_hda_pick_fixup(codec, NULL, cxt5051_fixups, cxt_fixups);
+		snd_hda_pick_fixup(codec, cxt5051_fixup_models,
+				   cxt5051_fixups, cxt_fixups);
 		break;
 	default:
 		codec->pin_amp_workaround = 1;
-		snd_hda_pick_fixup(codec, NULL, cxt5066_fixups, cxt_fixups);
+		snd_hda_pick_fixup(codec, cxt5066_fixup_models,
+				   cxt5066_fixups, cxt_fixups);
 		break;
 	}
 
-- 
1.8.5.2
