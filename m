From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: hda - Apply click noise workaround
	for Thinkpads generically
Date: Tue, 15 Dec 2015 15:14:08 +0100
Message-ID: <1450188850-22441-2-git-send-email-tiwai@suse.de>
References: <1450188850-22441-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FA1226262A
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 15:14:10 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 52C4AADAE
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 14:14:10 +0000 (UTC)
In-Reply-To: <1450188850-22441-1-git-send-email-tiwai@suse.de>
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

It seems that a workaround for Thinkpad T440s crackling noise can be
applied generically to all Thinkpad models: namely, disabling the
default alc269 shutup callback.  This patch moves it to the existing
alc_fixup_tpt440_dock() while also replacing the rest code with
another existing alc_fixup_disable_aamix().  It resulted in a good
code reduction.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=958439
Reported-and-tested-by: Benjamin Poirier <bpoirier@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b745a721c363..531065eaac1b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4198,24 +4198,13 @@ static void alc_fixup_tpt440_dock(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->shutup = alc_no_shutup; /* reduce click noise */
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 		codec->power_save_node = 0; /* avoid click noises */
 		snd_hda_apply_pincfgs(codec, pincfgs);
 	}
 }
 
-/* additional fixup for Thinkpad T440s noise problem */
-static void alc_fixup_tpt440(struct hda_codec *codec,
-				  const struct hda_fixup *fix, int action)
-{
-	struct alc_spec *spec = codec->spec;
-
-	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->shutup = alc_no_shutup; /* reduce click noise */
-		spec->gen.mixer_nid = 0; /* reduce background noise */
-	}
-}
-
 static void alc_shutup_dell_xps13(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -5067,7 +5056,7 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC292_FIXUP_TPT440] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_tpt440,
+		.v.func = alc_fixup_disable_aamix,
 		.chained = true,
 		.chain_id = ALC292_FIXUP_TPT440_DOCK,
 	},
-- 
2.6.4
