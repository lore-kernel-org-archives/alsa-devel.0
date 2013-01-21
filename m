From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/12] ALSA: hda - Add amix NID to AD codecs
Date: Mon, 21 Jan 2013 17:06:16 +0100
Message-ID: <1358784377-26102-12-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9700D262606
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 310F6A51F7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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

The aamix NIDs are also missing for AD codecs.  All AD codecs seem to
have a (more or less) working aamix widget.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 162bc2f..ad79abd 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1187,6 +1187,7 @@ static int ad1986a_parse_auto_config(struct hda_codec *codec)
 	/* AD1986A has the inverted EAPD implementation */
 	codec->inv_eapd = 1;
 
+	spec->gen.mixer_nid = 0x07;
 	spec->beep_dev_nid = 0x19;
 	set_beep_amp(spec, 0x18, 0, HDA_OUTPUT);
 
@@ -1950,6 +1951,7 @@ static int ad1981_parse_auto_config(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec = codec->spec;
 
+	spec->gen.mixer_nid = 0x0e;
 	spec->beep_dev_nid = 0x10;
 	set_beep_amp(spec, 0x0d, 0, HDA_OUTPUT);
 	return ad198x_parse_auto_config(codec);
@@ -2825,6 +2827,7 @@ static int ad1988_parse_auto_config(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec = codec->spec;
 
+	spec->gen.mixer_nid = 0x20;
 	spec->beep_dev_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
 	return ad198x_parse_auto_config(codec);
@@ -3172,6 +3175,7 @@ static int ad1884_parse_auto_config(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec = codec->spec;
 
+	spec->gen.mixer_nid = 0x20;
 	spec->beep_dev_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
 	return ad198x_parse_auto_config(codec);
@@ -4632,7 +4636,7 @@ static int ad1882_parse_auto_config(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec = codec->spec;
 
-	spec->beep_dev_nid = 0x10;
+	spec->beep_dev_nid = 0x20;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
 	return ad198x_parse_auto_config(codec);
 }
-- 
1.8.1.1
