From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Mic as output fix
Date: Fri, 22 Feb 2008 10:28:47 -0500
Message-ID: <47BEEA2F.3080207@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp100.biz.mail.mud.yahoo.com (smtp100.biz.mail.mud.yahoo.com
	[68.142.201.176]) by alsa0.perex.cz (Postfix) with SMTP id DC73C245D4
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 16:28:55 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

Added logic to check if AUTO_PIN_FRONT_MIC is available for output switch, if AUTO_PIN_MIC isn't.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r a5754a5e8133 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Feb 21 14:11:09 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Fri Feb 22 08:19:47 2008 -0700
@@ -2307,6 +2307,29 @@ static int create_controls(struct sigmat
 	return 0;
 }
 
+static int add_spec_dacs(struct sigmatel_spec *spec, hda_nid_t nid)
+{
+	if (!spec->multiout.hp_nid)
+		spec->multiout.hp_nid = nid;
+	else if (spec->multiout.num_dacs > 4) {
+		printk(KERN_WARNING "stac92xx: No space for DAC 0x%x\n", nid);
+		return 1;
+	} else {
+		spec->multiout.dac_nids[spec->multiout.num_dacs] = nid;
+		spec->multiout.num_dacs++;
+	}
+	return 0;
+}
+
+static int check_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
+{
+	if (is_in_dac_nids(spec, nid))
+		return 1;
+	if (spec->multiout.hp_nid == nid)
+		return 1;
+	return 0;
+}
+
 /* add playback controls from the parsed DAC table */
 static int stac92xx_auto_create_multi_out_ctls(struct hda_codec *codec,
 					       const struct auto_pin_cfg *cfg)
@@ -2369,10 +2392,11 @@ static int stac92xx_auto_create_multi_ou
 
 	if (spec->mic_switch) {
 		unsigned int def_conf;
-		nid = cfg->input_pins[AUTO_PIN_MIC];
+		unsigned int mic_pin = AUTO_PIN_MIC;
+again:
+		nid = cfg->input_pins[mic_pin];
 		def_conf = snd_hda_codec_read(codec, nid, 0,
 						AC_VERB_GET_CONFIG_DEFAULT, 0);
-
 		/* some laptops have an internal analog microphone
 		 * which can't be used as a output */
 		if (get_defcfg_connect(def_conf) != AC_JACK_PORT_FIXED) {
@@ -2382,35 +2406,19 @@ static int stac92xx_auto_create_multi_ou
 				err = stac92xx_add_control(spec,
 					STAC_CTL_WIDGET_IO_SWITCH,
 					"Mic as Output Switch", (nid << 8) | 1);
+				nid = snd_hda_codec_read(codec, nid, 0,
+					 AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
+				if (!check_in_dac_nids(spec, nid))
+					add_spec_dacs(spec, nid);
 				if (err < 0)
 					return err;
 			}
+		} else if (mic_pin == AUTO_PIN_MIC) {
+			mic_pin = AUTO_PIN_FRONT_MIC;
+			goto again;
 		}
 	}
 
-	return 0;
-}
-
-static int check_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
-{
-	if (is_in_dac_nids(spec, nid))
-		return 1;
-	if (spec->multiout.hp_nid == nid)
-		return 1;
-	return 0;
-}
-
-static int add_spec_dacs(struct sigmatel_spec *spec, hda_nid_t nid)
-{
-	if (!spec->multiout.hp_nid)
-		spec->multiout.hp_nid = nid;
-	else if (spec->multiout.num_dacs > 4) {
-		printk(KERN_WARNING "stac92xx: No space for DAC 0x%x\n", nid);
-		return 1;
-	} else {
-		spec->multiout.dac_nids[spec->multiout.num_dacs] = nid;
-		spec->multiout.num_dacs++;
-	}
 	return 0;
 }
