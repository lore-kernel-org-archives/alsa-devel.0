From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: SPDIF stream muting support
Date: Sat, 27 Sep 2008 18:13:47 -0400
Message-ID: <48DEB01B.2060701@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 73E2C24344
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Sep 2008 00:13:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added support for muting S/DPIF outs using the 'Digital Playback Source' muxs on
supporting codecs.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b5c1449..cb419a0 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -138,6 +138,7 @@ struct sigmatel_spec {
 	unsigned int mic_switch: 1;
 	unsigned int alt_switch: 1;
 	unsigned int hp_detect: 1;
+	unsigned int spdif_mute: 1;

 	/* gpio lines */
 	unsigned int eapd_mask;
@@ -547,10 +548,32 @@ static int stac92xx_smux_enum_put(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
+	struct hda_input_mux *smux = &spec->private_smux;
 	unsigned int smux_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	int err, val;
+	hda_nid_t nid;

-	return snd_hda_input_mux_put(codec, spec->sinput_mux, ucontrol,
+	err = snd_hda_input_mux_put(codec, spec->sinput_mux, ucontrol,
 			spec->smux_nids[smux_idx], &spec->cur_smux[smux_idx]);
+	if (err < 0)
+		return err;
+
+	if (spec->spdif_mute) {
+		if (smux_idx == 0)
+			nid = spec->multiout.dig_out_nid;
+		else
+			nid = codec->slave_dig_outs[smux_idx - 1];
+		if (spec->cur_smux[smux_idx] == smux->num_items - 1)
+			val = AMP_OUT_MUTE;
+		if (smux_idx == 0)
+			nid = spec->multiout.dig_out_nid;
+		else
+			nid = codec->slave_dig_outs[smux_idx - 1];
+		/* un/mute SPDIF out */
+		snd_hda_codec_write_cache(codec, nid, 0,
+			AC_VERB_SET_AMP_GAIN_MUTE, val);
+	}
+	return 0;
 }

 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
@@ -1228,6 +1251,15 @@ static int stac92xx_build_controls(struct hda_codec *codec)
 			return err;
 	}
 	if (spec->num_smuxes > 0) {
+		int wcaps = get_wcaps(codec, spec->multiout.dig_out_nid);
+		struct hda_input_mux *smux = &spec->private_smux;
+		/* check for mute support on SPDIF out */
+		if (wcaps & AC_WCAP_OUT_AMP) {
+			smux->items[smux->num_items].label = "Off";
+			smux->items[smux->num_items].index = 0;
+			smux->num_items++;
+			spec->spdif_mute = 1;
+		}
 		stac_smux_mixer.count = spec->num_smuxes;
 		err = snd_ctl_add(codec->bus->card,
 				  snd_ctl_new1(&stac_smux_mixer, codec));
@@ -4370,7 +4402,6 @@ again:

 	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
-	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);

 	switch (spec->board_config) {
 	case STAC_HP_M4:
