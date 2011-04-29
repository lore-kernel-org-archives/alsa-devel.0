From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/10] ALSA: hda - Minor update for
	alc662-parser functions
Date: Fri, 29 Apr 2011 19:18:27 +0200
Message-ID: <1304097516-7258-2-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 916F9103A3D
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:12 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id E14198738D
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:09 +0200 (CEST)
In-Reply-To: <1304097516-7258-1-git-send-email-tiwai@suse.de>
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

Allow alc662_dac_to_mix() and alc662_look_for_dac() to parse
down the selector widget that is found in ALC880-type codecs,
and rename them to alc_auto_*() accordingly.
This is for the next coming multi-io extensions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e631874..0ed95dd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -19135,9 +19135,9 @@ static struct alc_config_preset alc662_presets[] = {
  */
 
 /* convert from MIX nid to DAC */
-static hda_nid_t alc662_mix_to_dac(struct hda_codec *codec, hda_nid_t nid)
+static hda_nid_t alc_auto_mix_to_dac(struct hda_codec *codec, hda_nid_t nid)
 {
-	hda_nid_t list[4];
+	hda_nid_t list[5];
 	int i, num;
 
 	num = snd_hda_get_connections(codec, nid, list, ARRAY_SIZE(list));
@@ -19148,33 +19148,45 @@ static hda_nid_t alc662_mix_to_dac(struct hda_codec *codec, hda_nid_t nid)
 	return 0;
 }
 
+/* go down to the selector widget before the mixer */
+static hda_nid_t alc_go_down_to_selector(struct hda_codec *codec, hda_nid_t pin)
+{
+	hda_nid_t srcs[5];
+	int num = snd_hda_get_connections(codec, pin, srcs,
+					  ARRAY_SIZE(srcs));
+	if (num != 1 ||
+	    get_wcaps_type(get_wcaps(codec, srcs[0])) != AC_WID_AUD_SEL)
+		return pin;
+	return srcs[0];
+}
+
 /* get MIX nid connected to the given pin targeted to DAC */
-static hda_nid_t alc662_dac_to_mix(struct hda_codec *codec, hda_nid_t pin,
+static hda_nid_t alc_auto_dac_to_mix(struct hda_codec *codec, hda_nid_t pin,
 				   hda_nid_t dac)
 {
 	hda_nid_t mix[5];
 	int i, num;
 
+	pin = alc_go_down_to_selector(codec, pin);
 	num = snd_hda_get_connections(codec, pin, mix, ARRAY_SIZE(mix));
 	for (i = 0; i < num; i++) {
-		if (alc662_mix_to_dac(codec, mix[i]) == dac)
+		if (alc_auto_mix_to_dac(codec, mix[i]) == dac)
 			return mix[i];
 	}
 	return 0;
 }
 
 /* look for an empty DAC slot */
-static hda_nid_t alc662_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
+static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 {
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t srcs[5];
 	int i, j, num;
 
+	pin = alc_go_down_to_selector(codec, pin);
 	num = snd_hda_get_connections(codec, pin, srcs, ARRAY_SIZE(srcs));
-	if (num < 0)
-		return 0;
 	for (i = 0; i < num; i++) {
-		hda_nid_t nid = alc662_mix_to_dac(codec, srcs[i]);
+		hda_nid_t nid = alc_auto_mix_to_dac(codec, srcs[i]);
 		if (!nid)
 			continue;
 		for (j = 0; j < spec->multiout.num_dacs; j++)
@@ -19196,7 +19208,7 @@ static int alc662_auto_fill_dac_nids(struct hda_codec *codec,
 
 	spec->multiout.dac_nids = spec->private_dac_nids;
 	for (i = 0; i < cfg->line_outs; i++) {
-		dac = alc662_look_for_dac(codec, cfg->line_out_pins[i]);
+		dac = alc_auto_look_for_dac(codec, cfg->line_out_pins[i]);
 		if (!dac)
 			continue;
 		spec->multiout.dac_nids[spec->multiout.num_dacs++] = dac;
@@ -19243,7 +19255,7 @@ static int alc662_auto_create_multi_out_ctls(struct hda_codec *codec,
 		nid = spec->multiout.dac_nids[i];
 		if (!nid)
 			continue;
-		mix = alc662_dac_to_mix(codec, cfg->line_out_pins[i], nid);
+		mix = alc_auto_dac_to_mix(codec, cfg->line_out_pins[i], nid);
 		if (!mix)
 			continue;
 		if (!pfx && i == 2) {
@@ -19289,7 +19301,7 @@ static int alc662_auto_create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 
 	if (!pin)
 		return 0;
-	nid = alc662_look_for_dac(codec, pin);
+	nid = alc_auto_look_for_dac(codec, pin);
 	if (!nid) {
 		/* the corresponding DAC is already occupied */
 		if (!(get_wcaps(codec, pin) & AC_WCAP_OUT_AMP))
@@ -19299,7 +19311,7 @@ static int alc662_auto_create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 				   HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_OUTPUT));
 	}
 
-	mix = alc662_dac_to_mix(codec, pin, nid);
+	mix = alc_auto_dac_to_mix(codec, pin, nid);
 	if (!mix)
 		return 0;
 	err = alc662_add_vol_ctl(spec, pfx, nid, 3);
@@ -19325,7 +19337,7 @@ static void alc662_auto_set_output_and_unmute(struct hda_codec *codec,
 	alc_set_pin_output(codec, nid, pin_type);
 	num = snd_hda_get_connections(codec, nid, srcs, ARRAY_SIZE(srcs));
 	for (i = 0; i < num; i++) {
-		if (alc662_mix_to_dac(codec, srcs[i]) != dac)
+		if (alc_auto_mix_to_dac(codec, srcs[i]) != dac)
 			continue;
 		/* need the manual connection? */
 		if (num > 1)
-- 
1.7.4.2
