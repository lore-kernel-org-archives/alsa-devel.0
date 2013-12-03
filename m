From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add missing initialization of
	aamix paths
Date: Tue,  3 Dec 2013 10:53:14 +0100
Message-ID: <1386064394-10953-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EB5C26514A
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 10:53:14 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3189EA7CF5
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 10:53:14 +0100 (CET)
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

The loopback mixing paths aren't initialized correctly at init
callback.  Mostly this is harmless as codecs usually set the mute
state as default, but we still should make sure.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index c4671d00babd..28baeff99c62 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5138,6 +5138,23 @@ static void init_multi_io(struct hda_codec *codec)
 	}
 }
 
+static void init_aamix_paths(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (!spec->have_aamix_ctl)
+		return;
+	update_aamix_paths(codec, spec->aamix_mode, spec->out_paths[0],
+			   spec->aamix_out_paths[0],
+			   spec->autocfg.line_out_type);
+	update_aamix_paths(codec, spec->aamix_mode, spec->hp_paths[0],
+			   spec->aamix_out_paths[1],
+			   AUTO_PIN_HP_OUT);
+	update_aamix_paths(codec, spec->aamix_mode, spec->speaker_paths[0],
+			   spec->aamix_out_paths[2],
+			   AUTO_PIN_SPEAKER_OUT);
+}
+
 /* set up input pins and loopback paths */
 static void init_analog_input(struct hda_codec *codec)
 {
@@ -5240,6 +5257,7 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	init_multi_out(codec);
 	init_extra_out(codec);
 	init_multi_io(codec);
+	init_aamix_paths(codec);
 	init_analog_input(codec);
 	init_input_src(codec);
 	init_digital(codec);
-- 
1.8.5
