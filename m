From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH] The alc268 input_mux should be a selector
	instead of mixer
Date: Thu, 20 Dec 2007 10:38:23 +0800
Message-ID: <1198118303.22429.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 0147924700
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 03:39:57 +0100 (CET)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

According to the [0003659], the node 0x23,0x24 is a selector.
I checked the alc268 spec on the REALTEK website and it showed that they
were selectors indeed.
However, current code implement the alc268 input_mux in a mixer way.

Signed-off-by: Jiang Zhe <zhe.jiang@intel.com>

--- alsa-driver-hg20071219/alsa-kernel/pci/hda/patch_realtek.c
2007-12-18 09:00:08.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2007-12-20 10:09:11.000000000
+0800
@@ -9196,19 +9196,13 @@ static struct hda_verb alc268_base_init_
 	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
 	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x00 << 8))},
 
-	/* FIXME: use matrix-type input source selection */
-	/* Mixer elements: 0x18, 19, 1a, 1c, 14, 15, 0b */
-	/* Input mixer1: unmute Mic, F-Mic, Line, CD inputs */
-	/* Input mixer2 */
-	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x00 << 8))},
-	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8))},
-	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x02 << 8))},
-	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x03 << 8))},
-
-	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x00 << 8))},
-	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8))},
-	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x02 << 8))},
-	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x03 << 8))},
+	/* Unmute Selector 23h,24h and set the default input to mic-in */
+	
+	{0x23, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x24, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+
 	{ }
 };
 
@@ -9253,29 +9247,14 @@ static int alc268_mux_enum_put(struct sn
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	const struct hda_input_mux *imux = spec->input_mux;
+
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	static hda_nid_t capture_mixers[3] = { 0x23, 0x24 };
 	hda_nid_t nid = capture_mixers[adc_idx];
-	unsigned int *cur_val = &spec->cur_mux[adc_idx];
-	unsigned int i, idx;
 
-	idx = ucontrol->value.enumerated.item[0];
-	if (idx >= imux->num_items)
-		idx = imux->num_items - 1;
-	if (*cur_val == idx)
-		return 0;
-	for (i = 0; i < imux->num_items; i++) {
-		unsigned int v = (i == idx) ? 0 : HDA_AMP_MUTE;
-		snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT,
-					 imux->items[i].index,
-					 HDA_AMP_MUTE, v);
-                snd_hda_codec_write_cache(codec, nid, 0,
-					  AC_VERB_SET_CONNECT_SEL,
-					  idx );
-	}
-	*cur_val = idx;
-	return 1;
+	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
+				     nid,
+				     &spec->cur_mux[adc_idx]);
 }
 
 static struct snd_kcontrol_new alc268_capture_alt_mixer[] = {
