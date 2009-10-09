From: <LoganLi@viatech.com.cn>
Subject: [PATCH 30/30] ALSA: HDA VIA: Only cosmetic changes
Date: Fri, 9 Oct 2009 18:41:30 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C4B@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B14E103ABE
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:41:24 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Only cosmetic changes

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |   64
++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -22,26 +22,26 @@
  */
 
 /* * * * * * * * * * * * * * Release History * * * * * * * * * * * * *
* * * */
-/*
*/
+/*
*/
 /* 2006-03-03  Lydia Wang  Create the basic patch to support VT1708
codec    */
-/* 2006-03-14  Lydia Wang  Modify hard code for some pin widget nid
*/
-/* 2006-08-02  Lydia Wang  Add support to VT1709 codec
*/
+/* 2006-03-14  Lydia Wang  Modify hard code for some pin widget nid
*/
+/* 2006-08-02  Lydia Wang  Add support to VT1709 codec
*/
 /* 2006-09-08  Lydia Wang  Fix internal loopback recording source
select bug */
-/* 2007-09-12  Lydia Wang  Add EAPD enable during driver initialization
*/
-/* 2007-09-17  Lydia Wang  Add VT1708B codec support
*/
+/* 2007-09-12  Lydia Wang  Add EAPD enable during driver initialization
*/
+/* 2007-09-17  Lydia Wang  Add VT1708B codec support
*/
 /* 2007-11-14  Lydia Wang  Add VT1708A codec HP and CD pin connect
config    */
 /* 2008-02-03  Lydia Wang  Fix Rear channels and Back channels inverse
issue */
-/* 2008-03-06  Lydia Wang  Add VT1702 codec and VT1708S codec support
*/
-/* 2008-04-09  Lydia Wang  Add mute front speaker when HP plugin
*/
-/* 2008-04-09  Lydia Wang  Add Independent HP feature
*/
+/* 2008-03-06  Lydia Wang  Add VT1702 codec and VT1708S codec support
*/
+/* 2008-04-09  Lydia Wang  Add mute front speaker when HP plugin
*/
+/* 2008-04-09  Lydia Wang  Add Independent HP feature
*/
 /* 2008-05-28  Lydia Wang  Add second S/PDIF Out support for VT1702
*/
-/* 2008-09-15  Logan Li    Add VT1708S Mic Boost workaround/backdoor
*/
+/* 2008-09-15  Logan Li	   Add VT1708S Mic Boost
workaround/backdoor	     */
 /* 2009-02-16  Logan Li	   Add support for VT1718S
*/
 /* 2009-03-13  Logan Li	   Add support for VT1716S
*/
 /* 2009-04-14  Lydai Wang  Add support for VT1828S and VT2020
*/
 /* 2009-07-08  Lydia Wang  Add support for VT2002P
*/
 /* 2009-07-21  Lydia Wang  Add support for VT1812
*/
-/*
*/
+/*
*/
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * */
 
 
@@ -486,7 +486,7 @@
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
 			    AMP_OUT_UNMUTE);
 	if (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD)
-		snd_hda_codec_write(codec, nid, 0, 
+		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
 }
 
@@ -1545,7 +1545,7 @@
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	
+
 	/* Setup default input MW0 to PW4 */
 	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
@@ -1887,8 +1887,10 @@
 	codec->pcm_info = info;
 
 	info->name = spec->stream_name_analog;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
*(spec->stream_analog_playback);
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
spec->multiout.dac_nids[0];
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
+		*(spec->stream_analog_playback);
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
+		spec->multiout.dac_nids[0];
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] =
*(spec->stream_analog_capture);
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
 
@@ -2133,7 +2135,7 @@
 	} else /* enable SPDIF-input pin */
 		snd_hda_codec_write(codec, spec->autocfg.dig_in_pin, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL,
PIN_IN);
- 	return 0;
+	return 0;
 }
 
 #ifdef SND_HDA_NEEDS_RESUME
@@ -2178,8 +2180,8 @@
 	spec->multiout.num_dacs = cfg->line_outs;
 
 	spec->multiout.dac_nids = spec->private_dac_nids;
- 	
-	for(i = 0; i < 4; i++) {
+
+	for (i = 0; i < 4; i++) {
 		nid = cfg->line_out_pins[i];
 		if (nid) {
 			/* config dac list */
@@ -2217,7 +2219,7 @@
 
 		if (!nid)
 			continue;
-		
+
 		nid_vol = nid_vols[i];
 
 		if (i == AUTO_SEQ_CENLFE) {
@@ -2246,7 +2248,7 @@
 
HDA_OUTPUT));
 			if (err < 0)
 				return err;
-		} else if (i == AUTO_SEQ_FRONT){
+		} else if (i == AUTO_SEQ_FRONT) {
 			/* add control to mixer index 0 */
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 					      "Master Front Playback
Volume",
@@ -2260,7 +2262,7 @@
 
HDA_INPUT));
 			if (err < 0)
 				return err;
-			
+
 			/* add control to PW3 */
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
name,
@@ -2360,7 +2362,7 @@
 		case 0x1d: /* Mic */
 			idx = 2;
 			break;
-				
+
 		case 0x1e: /* Line In */
 			idx = 3;
 			break;
@@ -2593,7 +2595,7 @@
 		       "from BIOS.  Using genenic mode...\n");
 	}
 
-	
+
 	spec->stream_name_analog = "VT1708 Analog";
 	spec->stream_analog_playback = &vt1708_pcm_analog_playback;
 	/* disable 32bit format on VT1708 */
@@ -2605,7 +2607,7 @@
 	spec->stream_digital_playback = &vt1708_pcm_digital_playback;
 	spec->stream_digital_capture = &vt1708_pcm_digital_capture;
 
-	
+
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1708_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1708_adc_nids);
@@ -2791,11 +2793,11 @@
 		spec->multiout.dac_nids[cfg->line_outs] = 0x28; /* AOW4
*/
 
 	} else if (cfg->line_outs == 3) { /* 6 channels */
-		for(i = 0; i < cfg->line_outs; i++) {
+		for (i = 0; i < cfg->line_outs; i++) {
 			nid = cfg->line_out_pins[i];
 			if (nid) {
 				/* config dac list */
-				switch(i) {
+				switch (i) {
 				case AUTO_SEQ_FRONT:
 					/* AOW0 */
 					spec->multiout.dac_nids[i] =
0x10;
@@ -2830,7 +2832,7 @@
 	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
 		nid = cfg->line_out_pins[i];
 
-		if (!nid)	
+		if (!nid)
 			continue;
 
 		nid_vol = nid_vols[i];
@@ -2861,7 +2863,7 @@
 
HDA_OUTPUT));
 			if (err < 0)
 				return err;
-		} else if (i == AUTO_SEQ_FRONT){
+		} else if (i == AUTO_SEQ_FRONT) {
 			/* ADD control to mixer index 0 */
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 					      "Master Front Playback
Volume",
@@ -2875,7 +2877,7 @@
 
HDA_INPUT));
 			if (err < 0)
 				return err;
-			
+
 			/* add control to PW3 */
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
name,
@@ -2971,7 +2973,7 @@
 		case 0x1d: /* Mic */
 			idx = 2;
 			break;
-				
+
 		case 0x1e: /* Line In */
 			idx = 3;
 			break;
@@ -3080,7 +3082,7 @@
 	spec->stream_digital_playback = &vt1709_pcm_digital_playback;
 	spec->stream_digital_capture = &vt1709_pcm_digital_capture;
 
-	
+
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1709_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1709_adc_nids);
@@ -3174,7 +3176,7 @@
 	spec->stream_digital_playback = &vt1709_pcm_digital_playback;
 	spec->stream_digital_capture = &vt1709_pcm_digital_capture;
 
-	
+
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1709_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1709_adc_nids);
