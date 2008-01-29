From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Mic in as output changes
Date: Tue, 29 Jan 2008 17:41:18 -0500
Message-ID: <479FAB8E.7090602@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.biz.mail.mud.yahoo.com (smtp109.biz.mail.mud.yahoo.com
	[68.142.201.178])
	by alsa0.perex.cz (Postfix) with SMTP id 31B8810393D
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 23:41:19 +0100 (CET)
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

Some laptop has an internal analog microphone that is 'fixed'. This patch prevents creating a 'Mic In as Output' switch for
ports that can't be outputs.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r ec0316a4d108 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Jan 29 15:28:44 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Jan 29 17:33:58 2008 -0500
@@ -288,6 +288,10 @@ static hda_nid_t stac927x_adc_nids[3] = 
 
 static hda_nid_t stac927x_mux_nids[3] = {
         0x15, 0x16, 0x17
+};
+
+static hda_nid_t stac927x_dac_nids[5] = {
+	0x02, 0x03, 0x04, 0x05, 0x06
 };
 
 static hda_nid_t stac927x_dmux_nids[1] = {
@@ -2283,15 +2287,23 @@ static int stac92xx_auto_create_multi_ou
 	}
 
 	if (spec->mic_switch) {
+		unsigned int def_conf;
 		nid = cfg->input_pins[AUTO_PIN_MIC];
-		pincap = snd_hda_param_read(codec, nid,
-						AC_PAR_PIN_CAP);
-		if (pincap & AC_PINCAP_OUT) {
-			err = stac92xx_add_control(spec,
-				STAC_CTL_WIDGET_IO_SWITCH,
-				"Mic as Output Switch", (nid << 8) | 1);
-			if (err < 0)
-				return err;
+		def_conf = snd_hda_codec_read(codec, nid, 0,
+						AC_VERB_GET_CONFIG_DEFAULT, 0);
+
+		/* some laptops have an internal analog microphone
+ 		 * which can't be used as a output */
+		if (get_defcfg_connect(def_conf) != AC_JACK_PORT_FIXED) {
+			pincap = snd_hda_param_read(codec, nid,
+							AC_PAR_PIN_CAP);
+			if (pincap & AC_PINCAP_OUT) {
+				err = stac92xx_add_control(spec,
+					STAC_CTL_WIDGET_IO_SWITCH,
+					"Mic as Output Switch", (nid << 8) | 1);
+				if (err < 0)
+					return err;
+			}
 		}
 	}
