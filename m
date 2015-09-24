From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable power_save_node for
	Thinkpads
Date: Thu, 24 Sep 2015 17:40:39 +0200
Message-ID: <1443109239-27822-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C41F265AFC
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 17:40:41 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6D5EAABA2
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 15:40:40 +0000 (UTC)
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

Lenovo Thinkpads with recent Realtek codecs seem suffering from click
noises at power transition since the introduction of widget power
saving in 4.1 kernel.  Although this might be solved by some delays in
appropriate points, as a quick workaround, just disable the
power_save_node feature for now.  The gain it gives is relatively
small, and this makes the situation back to pre 4.1 time.

This patch ended up with a bit more code changes than usual because
the existing fixup for Thinkpads is highly chained.  Instead of adding
yet another chain, combine a few of them into a single fixup entry, as
a gratis cleanup.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=943982
Cc: <stable@vger.kernel.org> # v4.1+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a75b5611d1e4..afec6dc9f91f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4188,6 +4188,24 @@ static void alc_fixup_disable_aamix(struct hda_codec *codec,
 	}
 }
 
+/* fixup for Thinkpad docks: add dock pins, avoid HP parser fixup */
+static void alc_fixup_tpt440_dock(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x16, 0x21211010 }, /* dock headphone */
+		{ 0x19, 0x21a11010 }, /* dock mic */
+		{ }
+	};
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
+		codec->power_save_node = 0; /* avoid click noises */
+		snd_hda_apply_pincfgs(codec, pincfgs);
+	}
+}
+
 static void alc_shutup_dell_xps13(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -4562,7 +4580,6 @@ enum {
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC292_FIXUP_TPT440_DOCK,
-	ALC292_FIXUP_TPT440_DOCK2,
 	ALC283_FIXUP_BXBT2807_MIC,
 	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
 	ALC282_FIXUP_ASPIRE_V5_PINS,
@@ -5029,17 +5046,7 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC292_FIXUP_TPT440_DOCK] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
-		.chained = true,
-		.chain_id = ALC292_FIXUP_TPT440_DOCK2
-	},
-	[ALC292_FIXUP_TPT440_DOCK2] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x16, 0x21211010 }, /* dock headphone */
-			{ 0x19, 0x21a11010 }, /* dock mic */
-			{ }
-		},
+		.v.func = alc_fixup_tpt440_dock,
 		.chained = true,
 		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
 	},
-- 
2.5.3
