From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply MacBook fixups for CS4208
	correctly
Date: Fri,  8 Nov 2013 13:52:40 +0100
Message-ID: <1383915160-23607-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EE272656D9
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 13:52:41 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 040EAA60D1
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 13:52:40 +0100 (CET)
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

The commit [8fe7b65ab465: ALSA: hda - Apply GPIO setup for MacBooks
with CS4208] added a fixup entry matching with the vendor id 0x106b.
This broke the fixups for previous MBA6,1 and 6,2, since the PCI SSID
vendor id matches before evaluating the codec SSIDs.

We had a similar issue on Mac with Sigmatel codecs, and solve this
problem again similarly, by introducing a skeleton entry matching with
the all MacBooks, then remap to the right one.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=64401
Fixes: 8fe7b65ab465 ('ALSA: hda - Apply GPIO setup for MacBooks with CS4208')
Cc: <stable@vger.kernel.org> [v3.12+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cirrus.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 1ce1f4067b15..072755c8289c 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -597,6 +597,7 @@ static int patch_cs420x(struct hda_codec *codec)
  * Its layout is no longer compatible with CS4206/CS4207
  */
 enum {
+	CS4208_MAC_AUTO,
 	CS4208_MBA6,
 	CS4208_GPIO0,
 };
@@ -608,10 +609,14 @@ static const struct hda_model_fixup cs4208_models[] = {
 };
 
 static const struct snd_pci_quirk cs4208_fixup_tbl[] = {
-	/* codec SSID */
+	SND_PCI_QUIRK_VENDOR(0x106b, "Apple", CS4208_MAC_AUTO),
+	{} /* terminator */
+};
+
+/* codec SSID matching */
+static const struct snd_pci_quirk cs4208_mac_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x7100, "MacBookAir 6,1", CS4208_MBA6),
 	SND_PCI_QUIRK(0x106b, 0x7200, "MacBookAir 6,2", CS4208_MBA6),
-	SND_PCI_QUIRK_VENDOR(0x106b, "Apple", CS4208_GPIO0),
 	{} /* terminator */
 };
 
@@ -627,6 +632,20 @@ static void cs4208_fixup_gpio0(struct hda_codec *codec,
 	}
 }
 
+static const struct hda_fixup cs4208_fixups[];
+
+/* remap the fixup from codec SSID and apply it */
+static void cs4208_fixup_mac(struct hda_codec *codec,
+			     const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	snd_hda_pick_fixup(codec, NULL, cs4208_mac_fixup_tbl, cs4208_fixups);
+	if (codec->fixup_id < 0 || codec->fixup_id == CS4208_MAC_AUTO)
+		codec->fixup_id = CS4208_GPIO0; /* default fixup */
+	snd_hda_apply_fixup(codec, action);
+}
+
 static const struct hda_fixup cs4208_fixups[] = {
 	[CS4208_MBA6] = {
 		.type = HDA_FIXUP_PINS,
@@ -638,6 +657,10 @@ static const struct hda_fixup cs4208_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs4208_fixup_gpio0,
 	},
+	[CS4208_MAC_AUTO] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs4208_fixup_mac,
+	},
 };
 
 /* correct the 0dB offset of input pins */
-- 
1.8.4.2
