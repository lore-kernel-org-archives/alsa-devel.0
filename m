From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Add LFE chmap to ASUS ET2700
Date: Thu, 28 Nov 2013 15:26:39 +0100
Message-ID: <1385648799-9212-2-git-send-email-tiwai@suse.de>
References: <1385648799-9212-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 47AB2265283
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 15:26:41 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 40A98A7DA1
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 15:26:40 +0100 (CET)
In-Reply-To: <1385648799-9212-1-git-send-email-tiwai@suse.de>
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

As the previous commit 1f0bbf03cb82 added the pin config for the bass
speaker, this patch adds the corresponding LFE-only channel map on
ASUS ET2700.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=65961
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fd835c52618e..c770bdba6531 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1783,6 +1783,7 @@ enum {
 	ALC882_FIXUP_INV_DMIC,
 	ALC882_FIXUP_NO_PRIMARY_HP,
 	ALC887_FIXUP_ASUS_BASS,
+	ALC887_FIXUP_BASS_CHMAP,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -1916,6 +1917,9 @@ static void alc882_fixup_no_primary_hp(struct hda_codec *codec,
 	}
 }
 
+static void alc_fixup_bass_chmap(struct hda_codec *codec,
+				 const struct hda_fixup *fix, int action);
+
 static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
 		.type = HDA_FIXUP_PINS,
@@ -2112,6 +2116,12 @@ static const struct hda_fixup alc882_fixups[] = {
 			{0x16, 0x99130130}, /* bass speaker */
 			{}
 		},
+		.chained = true,
+		.chain_id = ALC887_FIXUP_BASS_CHMAP,
+	},
+	[ALC887_FIXUP_BASS_CHMAP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_bass_chmap,
 	},
 };
 
@@ -4731,7 +4741,7 @@ static const struct snd_pcm_chmap_elem asus_pcm_2_1_chmaps[] = {
 };
 
 /* override the 2.1 chmap */
-static void alc662_fixup_bass_chmap(struct hda_codec *codec,
+static void alc_fixup_bass_chmap(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 	if (action == HDA_FIXUP_ACT_BUILD) {
@@ -4939,7 +4949,7 @@ static const struct hda_fixup alc662_fixups[] = {
 	},
 	[ALC662_FIXUP_BASS_CHMAP] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc662_fixup_bass_chmap,
+		.v.func = alc_fixup_bass_chmap,
 		.chained = true,
 		.chain_id = ALC662_FIXUP_ASUS_MODE4
 	},
@@ -4952,7 +4962,7 @@ static const struct hda_fixup alc662_fixups[] = {
 	},
 	[ALC662_FIXUP_BASS_1A_CHMAP] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc662_fixup_bass_chmap,
+		.v.func = alc_fixup_bass_chmap,
 		.chained = true,
 		.chain_id = ALC662_FIXUP_BASS_1A,
 	},
-- 
1.8.4.4
