From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/11] ALSA: hda - Add Stereo Downmix control
	for AD1986A
Date: Tue, 28 Jan 2014 11:06:30 +0100
Message-ID: <1390903600-22772-2-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2E72651AB
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:42 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F3E3AAC7B
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:42 +0000 (UTC)
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

The stereo downmix control was dropped during the transition to the
generic parser.  Let's re-add it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 7a426ed491f2..11ec27a60276 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -349,6 +349,12 @@ static int patch_ad1986a(struct hda_codec *codec)
 		0x1e, 0x03,
 		0
 	};
+	static const struct hda_verb downmix_verbs[] = {
+		{ 0x09, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080 }, /* downmix off */
+		{}
+	};
+	static const struct snd_kcontrol_new downmix_mixer =
+		HDA_CODEC_MUTE("Stereo Downmix Switch", 0x09, 0x0, HDA_OUTPUT);
 
 	err = alloc_ad_spec(codec);
 	if (err < 0)
@@ -380,14 +386,27 @@ static int patch_ad1986a(struct hda_codec *codec)
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	err = ad198x_parse_auto_config(codec, false);
-	if (err < 0) {
-		snd_hda_gen_free(codec);
-		return err;
+	if (err < 0)
+		goto error;
+
+	/* stereo downmix control */
+	err = snd_hda_add_verbs(codec, downmix_verbs);
+	if (err < 0)
+		goto error;
+	if (spec->gen.multiout.num_dacs > 1) {
+		if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &downmix_mixer)) {
+			err = -ENOMEM;
+			goto error;
+		}
 	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
+
+ error:
+	snd_hda_gen_free(codec);
+	return err;
 }
 
 
-- 
1.8.5.2
