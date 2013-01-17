From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/9] ALSA: hda - Properly call automute/switch
	hooks at init
Date: Thu, 17 Jan 2013 17:54:46 +0100
Message-ID: <1358441694-32004-2-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 079CD26514E
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D2DBFA4F01
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:54:59 +0100 (CET)
In-Reply-To: <1358441694-32004-1-git-send-email-tiwai@suse.de>
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

... and a little bit of code refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 73900d9..0d6c4f7 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1826,6 +1826,8 @@ get_multiio_path(struct hda_codec *codec, int idx)
 		spec->out_paths[spec->autocfg.line_outs + idx]);
 }
 
+static void update_automute_all(struct hda_codec *codec);
+
 static int set_multi_io(struct hda_codec *codec, int idx, bool output)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -1850,9 +1852,7 @@ static int set_multi_io(struct hda_codec *codec, int idx, bool output)
 	}
 
 	/* update jack retasking in case it modifies any of them */
-	snd_hda_gen_hp_automute(codec, NULL);
-	snd_hda_gen_line_automute(codec, NULL);
-	snd_hda_gen_mic_autoswitch(codec, NULL);
+	update_automute_all(codec);
 
 	return 0;
 }
@@ -3131,6 +3131,25 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *ja
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_mic_autoswitch);
 
+/* update jack retasking */
+static void update_automute_all(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (spec->hp_automute_hook)
+		spec->hp_automute_hook(codec, NULL);
+	else
+		snd_hda_gen_hp_automute(codec, NULL);
+	if (spec->line_automute_hook)
+		spec->line_automute_hook(codec, NULL);
+	else
+		snd_hda_gen_line_automute(codec, NULL);
+	if (spec->mic_autoswitch_hook)
+		spec->mic_autoswitch_hook(codec, NULL);
+	else
+		snd_hda_gen_mic_autoswitch(codec, NULL);
+}
+
 /*
  * Auto-Mute mode mixer enum support
  */
@@ -4281,9 +4300,7 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	clear_unsol_on_unused_pins(codec);
 
 	/* call init functions of standard auto-mute helpers */
-	snd_hda_gen_hp_automute(codec, NULL);
-	snd_hda_gen_line_automute(codec, NULL);
-	snd_hda_gen_mic_autoswitch(codec, NULL);
+	update_automute_all(codec);
 
 	snd_hda_codec_flush_amp_cache(codec);
 	snd_hda_codec_flush_cmd_cache(codec);
-- 
1.8.1
