From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix silent output on ASUS W7J
	laptop
Date: Fri, 29 Nov 2013 16:20:16 +0100
Message-ID: <1385738416-4994-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ADFCB261676
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 16:20:18 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8B975A7D9D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 16:20:16 +0100 (CET)
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

The recent kernels got regressions on ASUS W7J with ALC660 codec where
no sound comes out.  After a long debugging session, we found out that
setting the pin control on the unused NID 0x10 is mandatory for the
outputs.  And, it was found out that another magic of NID 0x0f that is
required for other ASUS laptops isn't needed on this machine.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=66081
Reported-and-tested-by: Andrey Lipaev <lipaev@mail.ru>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6366a6683e22..a98f3296b891 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4494,6 +4494,7 @@ enum {
 	ALC861_FIXUP_AMP_VREF_0F,
 	ALC861_FIXUP_NO_JACK_DETECT,
 	ALC861_FIXUP_ASUS_A6RP,
+	ALC660_FIXUP_ASUS_W7J,
 };
 
 /* On some laptops, VREF of pin 0x0f is abused for controlling the main amp */
@@ -4543,10 +4544,21 @@ static const struct hda_fixup alc861_fixups[] = {
 		.v.func = alc861_fixup_asus_amp_vref_0f,
 		.chained = true,
 		.chain_id = ALC861_FIXUP_NO_JACK_DETECT,
+	},
+	[ALC660_FIXUP_ASUS_W7J] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* ASUS W7J needs a magic pin setup on unused NID 0x10
+			 * for enabling outputs
+			 */
+			{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},
+			{ }
+		},
 	}
 };
 
 static const struct snd_pci_quirk alc861_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1043, 0x1253, "ASUS W7J", ALC660_FIXUP_ASUS_W7J),
 	SND_PCI_QUIRK(0x1043, 0x1393, "ASUS A6Rp", ALC861_FIXUP_ASUS_A6RP),
 	SND_PCI_QUIRK_VENDOR(0x1043, "ASUS laptop", ALC861_FIXUP_AMP_VREF_0F),
 	SND_PCI_QUIRK(0x1462, 0x7254, "HP DX2200", ALC861_FIXUP_NO_JACK_DETECT),
-- 
1.8.4.4
