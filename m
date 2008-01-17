From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] hda_proc - Add output of Vref, additional pcaps,
	and proccaps to proc output
Date: Thu, 17 Jan 2008 09:46:06 -0400
Message-ID: <8a9218bae32f110a1ca2.1200581166@am2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CC7C2437C
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 15:46:25 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so467637rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 06:46:24 -0800 (PST)
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

This adds additional pincaps which were not previously output. Also, Vref
capabilities are output per-pin along with the current Vref pinctl setting
if the NID supports Vref. Also added: processing widgets and proccaps, as
well as processing coefficient and coefficient index from the Realtek Define
Registers per the ALC883 datasheet.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r 1e5c4ccf093c -r 8a9218bae32f pci/hda/hda_proc.c
--- a/pci/hda/hda_proc.c	Sun Jan 13 12:03:53 2008 +0100
+++ b/pci/hda/hda_proc.c	Thu Jan 17 09:44:07 2008 -0500
@@ -202,7 +202,8 @@ static const char *get_jack_color(u32 cf
 }
 
 static void print_pin_caps(struct snd_info_buffer *buffer,
-			   struct hda_codec *codec, hda_nid_t nid)
+                           struct hda_codec *codec, hda_nid_t nid,
+                           int *supports_vref)
 {
 	static char *jack_conns[4] = { "Jack", "N/A", "Fixed", "Both" };
 	static char *jack_types[16] = {
@@ -226,7 +227,35 @@ static void print_pin_caps(struct snd_in
 		snd_iprintf(buffer, " EAPD");
 	if (caps & AC_PINCAP_PRES_DETECT)
 		snd_iprintf(buffer, " Detect");
-	snd_iprintf(buffer, "\n");
+        if (caps & AC_PINCAP_BALANCE)
+                snd_iprintf(buffer, " Balanced");
+        if (caps & AC_PINCAP_LR_SWAP)
+                snd_iprintf(buffer, " R/L");
+        if (caps & AC_PINCAP_TRIG_REQ)
+                snd_iprintf(buffer, " Trigger");
+        if (caps & AC_PINCAP_IMP_SENSE)
+                snd_iprintf(buffer, " ImpSense");
+	snd_iprintf(buffer, "\n");
+        if (caps & AC_PINCAP_VREF) {
+                unsigned int vref =
+                        (caps & AC_PINCAP_VREF) >> AC_PINCAP_VREF_SHIFT;
+                snd_iprintf(buffer, "    Vref:");
+                if (vref & AC_PINCAP_VREF_HIZ)
+                        snd_iprintf(buffer, " HIZ");
+                if (vref & AC_PINCAP_VREF_50)
+                        snd_iprintf(buffer, " 50");
+                if (vref & AC_PINCAP_VREF_GRD)
+                        snd_iprintf(buffer, " GRD");
+                if (vref & AC_PINCAP_VREF_80)
+                        snd_iprintf(buffer, " 80");
+                if (vref & AC_PINCAP_VREF_100)
+                        snd_iprintf(buffer, " 100");
+                snd_iprintf(buffer, "\n");
+                *supports_vref = 1;
+        }
+        else {
+                *supports_vref = 0;
+        }
 	caps = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONFIG_DEFAULT, 0);
 	snd_iprintf(buffer, "  Pin Default 0x%08x: [%s] %s at %s %s\n", caps,
 		    jack_conns[(caps & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT],
@@ -330,8 +359,9 @@ static void print_codec_info(struct snd_
 		}
 
 		switch (wid_type) {
-		case AC_WID_PIN:
-			print_pin_caps(buffer, codec, nid);
+		case AC_WID_PIN: {
+                        int supports_vref;
+			print_pin_caps(buffer, codec, nid, &supports_vref);
 			pinctls = snd_hda_codec_read(codec, nid, 0,
 					     AC_VERB_GET_PIN_WIDGET_CONTROL,
 						     0);
@@ -342,8 +372,29 @@ static void print_codec_info(struct snd_
 				snd_iprintf(buffer, " OUT");
 			if (pinctls & AC_PINCTL_HP_EN)
 				snd_iprintf(buffer, " HP");
+                        if (supports_vref) {
+                                int vref = pinctls & AC_PINCTL_VREFEN;
+                                switch (vref) {
+                                case AC_PINCTL_VREF_HIZ:
+                                        snd_iprintf(buffer, " VREF_HIZ");
+                                        break;
+                                case AC_PINCTL_VREF_50:
+                                        snd_iprintf(buffer, " VREF_50");
+                                        break;
+                                case AC_PINCTL_VREF_GRD:
+                                        snd_iprintf(buffer, " VREF_GRD");
+                                        break;
+                                case AC_PINCTL_VREF_80:
+                                        snd_iprintf(buffer, " VREF_80");
+                                        break;
+                                case AC_PINCTL_VREF_100:
+                                        snd_iprintf(buffer, " VREF_100");
+                                        break;
+                                }
+                        }
 			snd_iprintf(buffer, "\n");
 			break;
+                }
 		case AC_WID_VOL_KNB:
 			pinctls = snd_hda_param_read(codec, nid,
 						     AC_PAR_VOL_KNB_CAP);
@@ -386,6 +437,31 @@ static void print_codec_info(struct snd_
 				snd_iprintf(buffer, "\n");
 			}
 		}
+
+                if (wid_caps & AC_WCAP_PROC_WID) {
+                        unsigned int proc_caps =
+                                snd_hda_param_read(codec, nid,
+                                                   AC_PAR_PROC_CAP);
+                        snd_iprintf(buffer,
+                                    "  Processing Caps: benign=%d ncoeff=%d\n",
+                                    proc_caps & AC_PCAP_BENIGN,
+                                    (proc_caps & AC_PCAP_NUM_COEF) >>
+                                    AC_PCAP_NUM_COEF_SHIFT);
+                }
+
+                /* NID 0x20 == Realtek Define Registers */
+                if (codec->vendor_id == 0x10ec && nid == 0x20) {
+                        int coeff =
+                                snd_hda_codec_read(codec, nid, 0,
+                                                   AC_VERB_GET_PROC_COEF, 0);
+                        snd_iprintf(buffer,
+                                    "  Processing Coefficient: 0x%02x\n",
+                                    coeff);
+                        coeff = snd_hda_codec_read(codec, nid, 0,
+                                                   AC_VERB_GET_COEF_INDEX, 0);
+                        snd_iprintf(buffer,
+                                    "  Coefficient Index: 0x%02x\n", coeff);
+                }
 	}
 	snd_hda_power_down(codec);
 }
