From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/16] ALSA: hda/cirrus - Simplify creation of
	new controls
Date: Fri, 22 Jun 2018 11:53:49 +0200
Message-ID: <20180622095352.19451-14-tiwai@suse.de>
References: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF4B26770A
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D23C0AFAB
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:53:54 +0000 (UTC)
In-Reply-To: <20180622095352.19451-1-tiwai@suse.de>
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

This patch moves the mixer creation code in Cirrus codec driver from
its own build_controls callback to snd_hda_gen_add_kctl() for
simplification.

As a bonus, this allows us to remove the cs421x_build_controls as it
becomes identical with snd_hda_gen_build_controls().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cirrus.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index d6e079f4ec09..a7f91be45194 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1096,25 +1096,6 @@ static int cs421x_init(struct hda_codec *codec)
 	return 0;
 }
 
-static int cs421x_build_controls(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	int err;
-
-	err = snd_hda_gen_build_controls(codec);
-	if (err < 0)
-		return err;
-
-	if (spec->gen.autocfg.speaker_outs &&
-	    spec->vendor_nid == CS4210_VENDOR_NID) {
-		err = snd_hda_ctl_add(codec, 0,
-			snd_ctl_new1(&cs421x_speaker_boost_ctl, codec));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
 static void fix_volume_caps(struct hda_codec *codec, hda_nid_t dac)
 {
 	unsigned int caps;
@@ -1144,6 +1125,14 @@ static int cs421x_parse_auto_config(struct hda_codec *codec)
 		return err;
 
 	parse_cs421x_digital(codec);
+
+	if (spec->gen.autocfg.speaker_outs &&
+	    spec->vendor_nid == CS4210_VENDOR_NID) {
+		if (!snd_hda_gen_add_kctl(&spec->gen, NULL,
+					  &cs421x_speaker_boost_ctl))
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -1175,7 +1164,7 @@ static int cs421x_suspend(struct hda_codec *codec)
 #endif
 
 static const struct hda_codec_ops cs421x_patch_ops = {
-	.build_controls = cs421x_build_controls,
+	.build_controls = snd_hda_gen_build_controls,
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cs421x_init,
 	.free = cs_free,
-- 
2.17.1
