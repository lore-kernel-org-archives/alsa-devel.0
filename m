From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/20] ALSA: hda/realtek - Fix the timing for
	some fixups
Date: Tue, 15 Jan 2013 12:05:43 +0100
Message-ID: <1358247947-13992-17-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D8C5726532D
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A5701A5234
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Some fixups such as setting the flags influencing on the parser
behavior should be applied before actually parsing the tree.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 42fc05c..eb889d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2666,7 +2666,7 @@ static void alc269_fixup_mic1_mute(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == HDA_FIXUP_ACT_PROBE) {
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic1_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
 	}
@@ -2684,7 +2684,7 @@ static void alc269_fixup_mic2_mute(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == HDA_FIXUP_ACT_PROBE) {
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic2_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
 	}
@@ -3373,7 +3373,7 @@ static int alc662_parse_auto_config(struct hda_codec *codec)
 static void alc272_fixup_mario(struct hda_codec *codec,
 			       const struct hda_fixup *fix, int action)
 {
-	if (action != HDA_FIXUP_ACT_PROBE)
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
 		return;
 	if (snd_hda_override_amp_caps(codec, 0x2, HDA_OUTPUT,
 				      (0x3b << AC_AMPCAP_OFFSET_SHIFT) |
-- 
1.8.1
