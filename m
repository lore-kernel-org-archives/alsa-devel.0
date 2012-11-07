From: tiwai@suse.de
Subject: [PATCH 3/3] ALSA: hda - Add pin fixups for ASUS G75
Date: Wed,  7 Nov 2012 12:52:20 +0100
Message-ID: <1352289140-30731-4-git-send-email-tiwai@suse.de>
References: <1352289140-30731-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 91EC8264FF6
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 12:52:28 +0100 (CET)
In-Reply-To: <1352289140-30731-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Del Fedele <max@veneto.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

To parse properly the subwoofer outputs on ASUS G75 laptop with VT1802
codec, correct the default configurations of speaker pins 0x24 and
0x33.

Reported-by: Massimo Del Fedele <max@veneto.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 34b7f2a..0fad5b0 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -3628,6 +3628,7 @@ static void set_widgets_power_state_vt2002P(struct hda_codec *codec)
  */
 enum {
 	VIA_FIXUP_INTMIC_BOOST,
+	VIA_FIXUP_ASUS_G75,
 };
 
 static void via_fixup_intmic_boost(struct hda_codec *codec,
@@ -3642,9 +3643,19 @@ static const struct hda_fixup via_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = via_fixup_intmic_boost,
 	},
+	[VIA_FIXUP_ASUS_G75] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			/* set 0x24 and 0x33 as speakers */
+			{ 0x24, 0x991301f0 },
+			{ 0x33, 0x991301f1 }, /* subwoofer */
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk vt2002p_fixups[] = {
+	SND_PCI_QUIRK(0x1043, 0x1487, "Asus G75", VIA_FIXUP_ASUS_G75),
 	SND_PCI_QUIRK(0x1043, 0x8532, "Asus X202E", VIA_FIXUP_INTMIC_BOOST),
 	{}
 };
-- 
1.8.0
