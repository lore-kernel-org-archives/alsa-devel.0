From: zhejiang <zhe.jiang@intel.com>
Subject: patch for Dell 1210 which using stac9221 codec
Date: Thu, 18 Oct 2007 10:49:16 +0800
Message-ID: <1192675756.3701.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id A5BB924504
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 04:50:58 +0200 (CEST)
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

Dell 1210 have three jacks on the front.
Two of them serve as output jack and one serve as microphone.
The microphone can be switched to output model too.

There are some problems with current dell 1210 driver:
1.Unable to use the front microphone
2.Unable to switch the microphone
3.If plug the left hp,another hp will be muted,so it's impossible to
work as 6-channel

According to the issue 0003427 on alsa-bugzilla,
I wrote a patch and the reporter helped me to test it on his machine.
It can support the front microphone. When switch the microphone to
output model, it can mute/unmute the internal speaker with jack-sensing.


diff -Nur a/alsa-driver-hg20071017/alsa-kernel/pci/hda/patch_sigmatel.c
b/alsa-driver-hg20071017/alsa-kernel/pci/hda/patch_sigmatel.c
--- a/alsa-driver-hg20071017/alsa-kernel/pci/hda/patch_sigmatel.c
2007-10-17 08:00:08.000000000 +0800
+++ b/alsa-driver-hg20071017/alsa-kernel/pci/hda/patch_sigmatel.c
2007-10-17 17:07:27.000000000 +0800
@@ -171,6 +171,10 @@
         0x02,
 };
 
+static hda_nid_t dell_m82_1210_dac_nids[3] = {
+        0x02, 0x05, 0x03,
+};
+
 static hda_nid_t stac925x_adc_nids[1] = {
         0x03,
 };
@@ -874,10 +878,10 @@
     102801D7 (Dell XPS M1210)
 */
 static unsigned int dell_922x_m82_pin_configs[10] = {
-	0x0221121f, 0x408103ff, 0x02111212, 0x90100310, 
-	0x408003f1, 0x02111211, 0x03451340, 0x40c003f2, 
+	0x02211211, 0x408103ff, 0x02a1123e, 0x90100310, 
+	0x408003f1, 0x0221121f, 0x03451340, 0x40c003f2, 
 	0x508003f3, 0x405003f4, 
-};
+};	
 
 static unsigned int d945gtp3_pin_configs[10] = {
 	0x0221401f, 0x01a19022, 0x01813021, 0x01014010,
@@ -1512,6 +1516,15 @@
 				  AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
 }
 
+static void enable_pin_detect(struct hda_codec *codec, hda_nid_t nid,
+			      unsigned int event)
+{
+	if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP)
+		snd_hda_codec_write_cache(codec, nid, 0,
+					  AC_VERB_SET_UNSOLICITED_ENABLE,
+					  (AC_USRSP_EN | event));
+}
+
 #define stac92xx_io_switch_info		snd_ctl_boolean_mono_info
 
 static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
@@ -1542,6 +1555,18 @@
 			pinctl |= stac92xx_get_vref(codec, nid);
 		stac92xx_auto_set_pinctl(codec, nid, pinctl);
 	}
+
+	if (spec->board_config == STAC_922X_DELL_M82) {
+		if (val) {
+			/*If front mic serves as output,let it mute the internal speaker*/
+			spec->autocfg.hp_outs = 3;
+			spec->autocfg.hp_pins[2] = 0x0c;
+			enable_pin_detect(codec, 0x0c, STAC_HP_EVENT);
+		} else {
+			spec->autocfg.hp_outs = 2;	
+		}
+		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
+	}
         return 1;
 }
 
@@ -1811,9 +1836,15 @@
 
 	struct sigmatel_spec *spec = codec->spec;
 	unsigned int wid_caps;
+	int max_controls;
 
+	if (spec->board_config == STAC_922X_DELL_M82) {
+		max_controls = spec->multiout.num_dacs;
+	} else {
+		max_controls = cfg->line_outs;
+	}
 
-	for (i = 0; i < cfg->line_outs; i++) {
+	for (i = 0; i < max_controls; i++) {
 		if (!spec->multiout.dac_nids[i])
 			continue;
 
@@ -2268,15 +2299,6 @@
 			    AC_VERB_SET_GPIO_DATA, gpiostate);
 }
 
-static void enable_pin_detect(struct hda_codec *codec, hda_nid_t nid,
-			      unsigned int event)
-{
-	if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP)
-		snd_hda_codec_write_cache(codec, nid, 0,
-					  AC_VERB_SET_UNSOLICITED_ENABLE,
-					  (AC_USRSP_EN | event));
-}
-
 static int stac92xx_init(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -2677,6 +2699,11 @@
 
 	spec->multiout.dac_nids = spec->dac_nids;
 	
+	if (spec->board_config == STAC_922X_DELL_M82) {
+		spec->multiout.num_dacs = 3;
+		spec->multiout.dac_nids = dell_m82_1210_dac_nids;
+	}
+
 	err = stac92xx_parse_auto_config(codec, 0x08, 0x09);
 	if (!err) {
 		if (spec->board_config < 0) {
@@ -2687,6 +2714,14 @@
 		}
 		err = -EINVAL;
 	}
+	
+	if ((err >= 0) && (spec->board_config == STAC_922X_DELL_M82)) {
+		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH, "Front
Mic as Output Switch", (spec->autocfg.input_pins[AUTO_PIN_FRONT_MIC] <<
8) | 1);
+		/*In case that add_controls realloc the spec->kctl_alloc*/
+		if ((err >= 0) && (spec->kctl_alloc != spec->mixers[spec->num_mixers
- 1]))
+			spec->mixers[spec->num_mixers - 1] = spec->kctl_alloc;
+	}
+
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
