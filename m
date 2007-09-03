From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 3/6] add support for swapping center/LFE
	channels
Date: Mon, 3 Sep 2007 15:18:31 +0300
Message-ID: <200709031518.31823.maximlevitsky@gmail.com>
References: <200709031514.57875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id EA16D10391B
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:19:00 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1482999fka
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:19:00 -0700 (PDT)
In-Reply-To: <200709031514.57875.maximlevitsky@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

>From 3292af8a515804fa8ad7452a3384ea523511c16f Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Mon, 3 Sep 2007 14:12:56 +0300
Subject: [PATCH] add support for swapping center/LFE channels

Center\LFE channels are located on same jack, so it can be usefull to swap them

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 pci/hda/patch_sigmatel.c |   76 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b4a1d73..297f740 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -146,6 +146,7 @@ struct sigmatel_spec {
 
 	/* i/o switches */
 	unsigned int io_switch[2];
+	unsigned int clfe_swap;
 
 	struct hda_pcm pcm_rec[2];	/* PCM information */
 
@@ -1406,6 +1407,36 @@ static int stac92xx_io_switch_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
         return 1;
 }
 
+#define stac92xx_clfe_switch_info snd_ctl_boolean_mono_info
+
+static int stac92xx_clfe_switch_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.integer.value[0] = spec->clfe_swap;
+	return 0;
+}
+
+static int stac92xx_clfe_switch_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = kcontrol->private_value & 0xff;
+
+	if (spec->clfe_swap == ucontrol->value.integer.value[0])
+		return 0;
+
+	spec->clfe_swap = ucontrol->value.integer.value[0];
+
+	snd_hda_codec_write_cache(codec, nid, 0, AC_VERB_SET_EAPD_BTLENABLE,
+		spec->clfe_swap ? 0x4 : 0x0);
+
+	return 1;
+}
+
 #define STAC_CODEC_IO_SWITCH(xname, xpval) \
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 	  .name = xname, \
@@ -1416,17 +1447,28 @@ static int stac92xx_io_switch_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
           .private_value = xpval, \
 	}
 
+#define STAC_CODEC_CLFE_SWITCH(xname, xpval) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .index = 0, \
+	  .info = stac92xx_clfe_switch_info, \
+	  .get = stac92xx_clfe_switch_get, \
+	  .put = stac92xx_clfe_switch_put, \
+	  .private_value = xpval, \
+	}
 
 enum {
 	STAC_CTL_WIDGET_VOL,
 	STAC_CTL_WIDGET_MUTE,
 	STAC_CTL_WIDGET_IO_SWITCH,
+	STAC_CTL_WIDGET_CLFE_SWITCH
 };
 
 static struct snd_kcontrol_new stac92xx_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
 	STAC_CODEC_IO_SWITCH(NULL, 0),
+	STAC_CODEC_CLFE_SWITCH(NULL, 0),
 };
 
 /* add dynamic controls */
@@ -1620,7 +1662,7 @@ static int create_controls(struct sigmatel_spec *spec, const char *pfx, hda_nid_
 }
 
 /* add playback controls from the parsed DAC table */
-static int stac92xx_auto_create_multi_out_ctls(struct sigmatel_spec *spec,
+static int stac92xx_auto_create_multi_out_ctls(struct hda_codec *codec,
 					       const struct auto_pin_cfg *cfg)
 {
 	static const char *chname[4] = {
@@ -1629,6 +1671,10 @@ static int stac92xx_auto_create_multi_out_ctls(struct sigmatel_spec *spec,
 	hda_nid_t nid;
 	int i, err;
 
+	struct sigmatel_spec *spec = codec->spec;
+	unsigned int wid_caps;
+
+
 	for (i = 0; i < cfg->line_outs; i++) {
 		if (!spec->multiout.dac_nids[i])
 			continue;
@@ -1643,6 +1689,18 @@ static int stac92xx_auto_create_multi_out_ctls(struct sigmatel_spec *spec,
 			err = create_controls(spec, "LFE", nid, 2);
 			if (err < 0)
 				return err;
+
+			wid_caps = get_wcaps(codec, nid);
+
+			if (wid_caps & AC_WCAP_LR_SWAP) {
+				err = stac92xx_add_control(spec,
+					STAC_CTL_WIDGET_CLFE_SWITCH,
+					"Swap Center/LFE Playback Switch", nid);
+
+				if (err < 0)
+					return err;
+			}
+
 		} else {
 			err = create_controls(spec, chname[i], nid, 3);
 			if (err < 0)
@@ -1895,9 +1953,19 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 		if ((err = stac92xx_auto_fill_dac_nids(codec, &spec->autocfg)) < 0)
 			return err;
 
-	if ((err = stac92xx_auto_create_multi_out_ctls(spec, &spec->autocfg)) < 0 ||
-	    (err = stac92xx_auto_create_hp_ctls(codec, &spec->autocfg)) < 0 ||
-	    (err = stac92xx_auto_create_analog_input_ctls(codec, &spec->autocfg)) < 0)
+	err = stac92xx_auto_create_multi_out_ctls(codec, &spec->autocfg);
+
+	if (err < 0)
+		return err;
+
+	err = stac92xx_auto_create_hp_ctls(codec, &spec->autocfg);
+
+	if (err < 0)
+		return err;
+
+	err = stac92xx_auto_create_analog_input_ctls(codec, &spec->autocfg);
+
+	if (err < 0)
 		return err;
 
 	if (spec->num_dmics > 0)
-- 
1.5.2.3
