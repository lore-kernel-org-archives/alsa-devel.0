From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 025/112] ALSA: hda/realtek - Initialize
	loopback paths properly
Date: Tue,  8 Jan 2013 12:38:18 +0100
Message-ID: <1357645185-7645-26-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E73472651AB
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 84F35A520F
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

Now we have a complete list of loopback paths, thus we can initialize
the paths more completely based on it, instead of assuming a direct
connection from pin to mixer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eadf326d..a41f048 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2639,6 +2639,7 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 {
 	struct alc_spec *spec = codec->spec;
 	struct nid_path *path;
+	unsigned int val;
 	int err, idx;
 
 	if (!nid_has_volume(codec, mix_nid, HDA_INPUT) &&
@@ -2654,19 +2655,22 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 
 	idx = path->idx[path->depth - 1];
 	if (nid_has_volume(codec, mix_nid, HDA_INPUT)) {
-		err = __add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL, ctlname, ctlidx,
-			  HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT));
+		val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
+		err = __add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL, ctlname, ctlidx, val);
 		if (err < 0)
 			return err;
+		path->ctls[NID_PATH_VOL_CTL] = val;
 	}
 
 	if (nid_has_mute(codec, mix_nid, HDA_INPUT)) {
-		err = __add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_MUTE, ctlname, ctlidx,
-			  HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT));
+		val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
+		err = __add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_MUTE, ctlname, ctlidx, val);
 		if (err < 0)
 			return err;
+		path->ctls[NID_PATH_MUTE_CTL] = val;
 	}
 
+	path->active = true;
 	add_loopback_list(spec, mix_nid, idx);
 	return 0;
 }
@@ -2848,6 +2852,11 @@ static int alc_auto_create_shared_input(struct hda_codec *codec)
 	return 0;
 }
 
+static struct nid_path *
+get_nid_path(struct hda_codec *codec, hda_nid_t from_nid, hda_nid_t to_nid);
+static void activate_path(struct hda_codec *codec, struct nid_path *path,
+			  bool enable);
+
 static int get_pin_type(int line_out_type)
 {
 	if (line_out_type == AUTO_PIN_HP_OUT)
@@ -2871,15 +2880,14 @@ static void alc_auto_init_analog_input(struct hda_codec *codec)
 						    AC_VERB_SET_AMP_GAIN_MUTE,
 						    AMP_OUT_MUTE);
 		}
-	}
 
-	/* mute all loopback inputs */
-	if (spec->mixer_nid) {
-		int nums = snd_hda_get_num_conns(codec, spec->mixer_nid);
-		for (i = 0; i < nums; i++)
-			snd_hda_codec_write(codec, spec->mixer_nid, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_IN_MUTE(i));
+		/* mute loopback inputs */
+		if (spec->mixer_nid) {
+			struct nid_path *path;
+			path = get_nid_path(codec, nid, spec->mixer_nid);
+			if (path)
+				activate_path(codec, path, path->active);
+		}
 	}
 }
 
-- 
1.8.0.1
