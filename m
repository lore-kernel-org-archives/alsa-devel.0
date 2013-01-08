From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 068/112] ALSA: hda - Clear unsol enable bits on
	unused pins in generic parser
Date: Tue,  8 Jan 2013 12:39:01 +0100
Message-ID: <1357645185-7645-69-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ED2D265205
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 654D2A5305
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

For preliminary works to migrate the generic parser for Conexant
codecs: the same function is ported to hda_generic.c.
But now it looks through the jack detect table so that it can cover
better.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index a5c4bc0..b7b8d7e 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3532,6 +3532,23 @@ static void init_digital(struct hda_codec *codec)
 		snd_hda_set_pin_ctl(codec, pin, PIN_IN);
 }
 
+/* clear unsol-event tags on unused pins; Conexant codecs seem to leave
+ * invalid unsol tags by some reason
+ */
+static void clear_unsol_on_unused_pins(struct hda_codec *codec)
+{
+	int i;
+
+	for (i = 0; i < codec->init_pins.used; i++) {
+		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
+		hda_nid_t nid = pin->nid;
+		if (is_jack_detectable(codec, nid) &&
+		    !snd_hda_jack_tbl_get(codec, nid))
+			snd_hda_codec_update_cache(codec, nid, 0,
+					AC_VERB_SET_UNSOLICITED_ENABLE, 0);
+	}
+}
+
 int snd_hda_gen_init(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -3550,6 +3567,8 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	init_input_src(codec);
 	init_digital(codec);
 
+	clear_unsol_on_unused_pins(codec);
+
 	/* call init functions of standard auto-mute helpers */
 	snd_hda_gen_hp_automute(codec, NULL);
 	snd_hda_gen_line_automute(codec, NULL);
-- 
1.8.0.1
