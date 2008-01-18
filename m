From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] hda_proc - Add a number of new settings to
	proc codec output
Date: Fri, 18 Jan 2008 01:54:38 -0400
Message-ID: <f343e1eb02f6a0c0ba5b.1200639278@am2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 70E7B247EB
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 07:54:39 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so653603rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 22:54:37 -0800 (PST)
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

This patch adds additional output to the /proc codec#X info.
The following pieces of information are added to the output:
-  Balanced, L/R swap, trigger, impedance sense pin capabilities
-  Vref pin capabilities
-  Current Vref pin widget control setting
-  Default configuration association, sequence, and misc bit test
-  EAPD/BTL bits conveying balanced mode, EAPD, and L/R swap
-  Power state modified to show state name as well as setting vs actual value
-  GPIO parameter output on Audio Function Group, including enumeration of IO
   pins which are indicated present (Any I and O pins are not output at this
   time)
-  Stripe and L/R swap widget capabilities
-  All digital converter bits: enable, validity, validity config, preemphasis,
   copyright, non-audio, professional, generation level, and content category
-  Converter stream and channel values for in/out widgets
-  SDI select value for in widgets
-  Unsolicited response widget capability tag and enabled bit
-  Delay widget capability value
-  Processing widget capability benign bit and number of coefficients
-  Realtek Define Registers: processing coefficient, coefficient index

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r 1e5c4ccf093c -r f343e1eb02f6 pci/hda/hda_codec.h
--- a/pci/hda/hda_codec.h	Sun Jan 13 12:03:53 2008 +0100
+++ b/pci/hda/hda_codec.h	Fri Jan 18 01:54:07 2008 -0500
@@ -84,7 +84,9 @@ enum {
 #define AC_VERB_GET_GPIO_DATA			0x0f15
 #define AC_VERB_GET_GPIO_MASK			0x0f16
 #define AC_VERB_GET_GPIO_DIRECTION		0x0f17
+#define AC_VERB_GET_GPIO_WAKE_MASK              0x0f18
 #define AC_VERB_GET_GPIO_UNSOLICITED_RSP_MASK	0x0f19
+#define AC_VERB_GET_GPIO_STICKY_MASK            0x0f1a
 #define AC_VERB_GET_CONFIG_DEFAULT		0x0f1c
 /* f20: AFG/MFG */
 #define AC_VERB_GET_SUBSYSTEM_ID		0x0f20
@@ -112,7 +114,9 @@ enum {
 #define AC_VERB_SET_GPIO_DATA			0x715
 #define AC_VERB_SET_GPIO_MASK			0x716
 #define AC_VERB_SET_GPIO_DIRECTION		0x717
+#define AC_VERB_SET_GPIO_WAKE_MASK              0x718
 #define AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK	0x719
+#define AC_VERB_SET_GPIO_STICKY_MASK            0x71a
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_0	0x71c
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_1	0x71d
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_2	0x71e
@@ -185,6 +189,27 @@ enum {
 #define AC_SUPFMT_FLOAT32		(1<<1)
 #define AC_SUPFMT_AC3			(1<<2)
 
+/* GP I/O count */
+#define AC_GPIO_IO_COUNT                (0xff<<0)
+#define AC_GPIO_O_COUNT                 (0xff<<8)
+#define AC_GPIO_O_COUNT_SHIFT           8
+#define AC_GPIO_I_COUNT                 (0xff<<16)
+#define AC_GPIO_I_COUNT_SHIFT           16
+#define AC_GPIO_UNSOLICITED             (1<<30)
+#define AC_GPIO_WAKE                    (1<<31)
+
+/* Converter stream, channel */
+#define AC_CONV_CHANNEL                 (0xf<<0)
+#define AC_CONV_STREAM                  (0xf<<4)
+#define AC_CONV_STREAM_SHIFT            4
+
+/* Input converter SDI select */
+#define AC_SDI_SELECT                   (0xf<<0)
+
+/* Unsolicited response */
+#define AC_UNSOL_TAG                    (0x3f<<0)
+#define AC_UNSOL_ENABLED                (1<<7)
+
 /* Pin widget capabilies */
 #define AC_PINCAP_IMP_SENSE		(1<<0)	/* impedance sense capable */
 #define AC_PINCAP_TRIG_REQ		(1<<1)	/* trigger required */
@@ -230,6 +255,9 @@ enum {
 #define AC_PWRST_D3SUP			(1<<3)
 
 /* Power state values */
+#define AC_PWRST_SETTING                (0xf<<0)
+#define AC_PWRST_ACTUAL                 (0xf<<4)
+#define AC_PWRST_ACTUAL_SHIFT           4
 #define AC_PWRST_D0			0x00
 #define AC_PWRST_D1			0x01
 #define AC_PWRST_D2			0x02
@@ -238,6 +266,7 @@ enum {
 /* Processing capabilies */
 #define AC_PCAP_BENIGN			(1<<0)
 #define AC_PCAP_NUM_COEF		(0xff<<8)
+#define AC_PCAP_NUM_COEF_SHIFT          8
 
 /* Volume knobs capabilities */
 #define AC_KNBCAP_NUM_STEPS		(0x7f<<0)
@@ -273,6 +302,9 @@ enum {
 #define AC_DIG1_NONAUDIO		(1<<5)
 #define AC_DIG1_PROFESSIONAL		(1<<6)
 #define AC_DIG1_LEVEL			(1<<7)
+
+/* DIGITAL2 bits */
+#define AC_DIG2_CC                      (0x7f<<0)
 
 /* Pin widget control - 8bit */
 #define AC_PINCTL_VREFEN		(0x7<<0)
@@ -288,12 +320,22 @@ enum {
 /* Unsolicited response - 8bit */
 #define AC_USRSP_EN			(1<<7)
 
+/* Pin sense - 32bit */
+#define AC_PINSENSE_IMPEDANCE_MASK      (0x7fffffff)
+#define AC_PINSENSE_PRESENCE            (1<<31)
+
+/* EAPD/BTL enable - 32bit */
+#define AC_EAPDBTL_BALANCED             (1<<0)
+#define AC_EAPDBTL_EAPD                 (1<<1)
+#define AC_EAPDBTL_LR_SWAP              (1<<2)
+
 /* configuration default - 32bit */
 #define AC_DEFCFG_SEQUENCE		(0xf<<0)
 #define AC_DEFCFG_DEF_ASSOC		(0xf<<4)
 #define AC_DEFCFG_ASSOC_SHIFT		4
 #define AC_DEFCFG_MISC			(0xf<<8)
 #define AC_DEFCFG_MISC_SHIFT		8
+#define AC_DEFCFG_MISC_NO_PRESENCE      (1<<0)
 #define AC_DEFCFG_COLOR			(0xf<<12)
 #define AC_DEFCFG_COLOR_SHIFT		12
 #define AC_DEFCFG_CONN_TYPE		(0xf<<16)
diff -r 1e5c4ccf093c -r f343e1eb02f6 pci/hda/hda_proc.c
--- a/pci/hda/hda_proc.c	Sun Jan 13 12:03:53 2008 +0100
+++ b/pci/hda/hda_proc.c	Fri Jan 18 01:54:07 2008 -0500
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
+        if (caps & AC_PINCAP_BALANCE)
+                snd_iprintf(buffer, " Balanced");
+        if (caps & AC_PINCAP_LR_SWAP)
+                snd_iprintf(buffer, " R/L");
+        if (caps & AC_PINCAP_TRIG_REQ)
+                snd_iprintf(buffer, " Trigger");
+        if (caps & AC_PINCAP_IMP_SENSE)
+                snd_iprintf(buffer, " ImpSense");
 	snd_iprintf(buffer, "\n");
+        if (caps & AC_PINCAP_VREF) {
+                unsigned int vref =
+                        (caps & AC_PINCAP_VREF) >> AC_PINCAP_VREF_SHIFT;
+                snd_iprintf(buffer, "    Vref caps:");
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
@@ -236,13 +265,83 @@ static void print_pin_caps(struct snd_in
 	snd_iprintf(buffer, "    Conn = %s, Color = %s\n",
 		    get_jack_connection(caps),
 		    get_jack_color(caps));
+        /* Default association and sequence values refer to default grouping
+         * of pin complexes and their sequence within the group. This is used
+         * for priority and resource allocation.
+         */
+        snd_iprintf(buffer, "    DefAssociation = 0x%x, Sequence = 0x%x\n",
+                    (caps & AC_DEFCFG_DEF_ASSOC) >> AC_DEFCFG_ASSOC_SHIFT,
+                    caps & AC_DEFCFG_SEQUENCE);
+        if (((caps & AC_DEFCFG_MISC) >> AC_DEFCFG_MISC_SHIFT) &
+            AC_DEFCFG_MISC_NO_PRESENCE) {
+                /* Miscellaneous bit indicates external hardware does not
+                 * support presence detection even if the pin complex
+                 * indicates it is supported.
+                 */
+                snd_iprintf(buffer, "    Misc = NO_PRESENCE\n");
+        }
 	if (caps & AC_PINCAP_EAPD) {
 		val = snd_hda_codec_read(codec, nid, 0,
 					 AC_VERB_GET_EAPD_BTLENABLE, 0);
-		snd_iprintf(buffer, "  EAPD: 0x%x\n", val);
-	}
-}
-
+		snd_iprintf(buffer, "  EAPD 0x%x:", val);
+                if (val & AC_EAPDBTL_BALANCED)
+                        snd_iprintf(buffer, " BALANCED");
+                if (val & AC_EAPDBTL_EAPD)
+                        snd_iprintf(buffer, " EAPD");
+                if (val & AC_EAPDBTL_LR_SWAP)
+                        snd_iprintf(buffer, " R/L");
+                snd_iprintf(buffer, "\n");
+	}
+}
+
+static const char *get_pwr_state(u32 state)
+{
+        static const char *buf[4] = {
+                "D0", "D1", "D2", "D3"
+        };
+        if (state < 4)
+            return buf[state];
+        return "UNKNOWN";
+}
+
+static void print_gpio(struct snd_info_buffer *buffer,
+                       struct hda_codec *codec, hda_nid_t nid)
+{
+        unsigned int gpio =
+                snd_hda_param_read(codec, codec->afg, AC_PAR_GPIO_CAP);
+        unsigned int enable, direction, wake, unsol, sticky, data;
+        int i, max;
+        snd_iprintf(buffer, "GPIO: io=%d, o=%d, i=%d, "
+                    "unsolicited=%d, wake=%d\n",
+                    gpio & AC_GPIO_IO_COUNT,
+                    (gpio & AC_GPIO_O_COUNT) >> AC_GPIO_O_COUNT_SHIFT,
+                    (gpio & AC_GPIO_I_COUNT) >> AC_GPIO_I_COUNT_SHIFT,
+                    (gpio & AC_GPIO_UNSOLICITED) ? 1 : 0,
+                    (gpio & AC_GPIO_WAKE) ? 1 : 0);
+        max = gpio & AC_GPIO_IO_COUNT;
+        enable = snd_hda_codec_read(codec, nid, 0,
+                                    AC_VERB_GET_GPIO_MASK, 0);
+        direction = snd_hda_codec_read(codec, nid, 0,
+                                       AC_VERB_GET_GPIO_DIRECTION, 0);
+        wake = snd_hda_codec_read(codec, nid, 0,
+                                  AC_VERB_GET_GPIO_WAKE_MASK, 0);
+        unsol  = snd_hda_codec_read(codec, nid, 0,
+                                    AC_VERB_GET_GPIO_UNSOLICITED_RSP_MASK, 0);
+        sticky = snd_hda_codec_read(codec, nid, 0,
+                                    AC_VERB_GET_GPIO_STICKY_MASK, 0);
+        data = snd_hda_codec_read(codec, nid, 0,
+                                  AC_VERB_GET_GPIO_DATA, 0);
+        for (i = 0; i < max; ++i)
+                snd_iprintf(buffer,
+                            "  IO[%d]: enable=%d, dir=%d, wake=%d, "
+                            "sticky=%d, data=%d\n", i,
+                            (enable & (1<<i)) ? 1 : 0,
+                            (direction & (1<<i)) ? 1 : 0,
+                            (wake & (1<<i)) ? 1 : 0,
+                            (sticky & (1<<i)) ? 1 : 0,
+                            (data & (1<<i)) ? 1 : 0);
+        /* FIXME: add GPO and GPI pin information */
+}
 
 static void print_codec_info(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
@@ -280,13 +379,16 @@ static void print_codec_info(struct snd_
 		snd_hda_power_down(codec);
 		return;
 	}
+
+        print_gpio(buffer, codec, codec->afg);
+
 	for (i = 0; i < nodes; i++, nid++) {
 		unsigned int wid_caps =
 			snd_hda_param_read(codec, nid,
 					   AC_PAR_AUDIO_WIDGET_CAP);
 		unsigned int wid_type =
 			(wid_caps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
-		int conn_len = 0; 
+		int conn_len = 0;
 		hda_nid_t conn[HDA_MAX_CONNECTIONS];
 		unsigned int pinctls;
 
@@ -302,6 +404,10 @@ static void print_codec_info(struct snd_
 			snd_iprintf(buffer, " Amp-In");
 		if (wid_caps & AC_WCAP_OUT_AMP)
 			snd_iprintf(buffer, " Amp-Out");
+                if (wid_caps & AC_WCAP_STRIPE)
+                        snd_iprintf(buffer, " Stripe");
+                if (wid_caps & AC_WCAP_LR_SWAP)
+                        snd_iprintf(buffer, " R/L");
 		snd_iprintf(buffer, "\n");
 
 		/* volume knob is a special widget that always have connection
@@ -330,8 +436,9 @@ static void print_codec_info(struct snd_
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
@@ -342,8 +449,29 @@ static void print_codec_info(struct snd_
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
@@ -356,19 +484,85 @@ static void print_codec_info(struct snd_
 				    (pinctls >> 7) & 1, pinctls & 0x7f);
 			break;
 		case AC_WID_AUD_OUT:
-		case AC_WID_AUD_IN:
+		case AC_WID_AUD_IN: {
+                        int conv = snd_hda_codec_read(codec, nid, 0,
+                                                      AC_VERB_GET_CONV, 0);
+                        snd_iprintf(buffer,
+                                    "  Converter: stream=%d, channel=%d\n",
+                                    (conv & AC_CONV_STREAM) >>
+                                    AC_CONV_STREAM_SHIFT,
+                                    conv & AC_CONV_CHANNEL);
+
+                        if (wid_type == AC_WID_AUD_IN &&
+                            (conv & AC_CONV_CHANNEL) == 0) {
+                                int sdi = snd_hda_codec_read(codec, nid, 0,
+                                                    AC_VERB_GET_SDI_SELECT,
+                                                             0);
+                                snd_iprintf(buffer, "  SDI-Select: %d\n",
+                                            sdi & AC_SDI_SELECT);
+                        }
+
+                        if (wid_caps & AC_WCAP_DIGITAL) {
+                                unsigned int digi1 =
+                                        snd_hda_codec_read(codec, nid, 0,
+                                                 AC_VERB_GET_DIGI_CONVERT_1, 0);
+                                unsigned int digi2 =
+                                        snd_hda_codec_read(codec, nid, 0,
+                                                 AC_VERB_GET_DIGI_CONVERT_2, 0);
+                                snd_iprintf(buffer, "  Digital:");
+                                if (digi1 & AC_DIG1_ENABLE)
+                                        snd_iprintf(buffer, " Enabled");
+                                if (digi1 & AC_DIG1_V)
+                                        snd_iprintf(buffer, " Validity");
+                                if (digi1 & AC_DIG1_VCFG)
+                                        snd_iprintf(buffer, " ValidityCfg");
+                                if (digi1 & AC_DIG1_EMPHASIS)
+                                        snd_iprintf(buffer, " Preemphasis");
+                                if (digi1 & AC_DIG1_COPYRIGHT)
+                                        snd_iprintf(buffer, " Copyright");
+                                if (digi1 & AC_DIG1_NONAUDIO)
+                                        snd_iprintf(buffer, " Non-Audio");
+                                if (digi1 & AC_DIG1_PROFESSIONAL)
+                                        snd_iprintf(buffer, " Pro");
+                                if (digi1 & AC_DIG1_LEVEL)
+                                        snd_iprintf(buffer, " GenLevel");
+                                snd_iprintf(buffer, "\n");
+                                snd_iprintf(buffer,
+                                            "  Digital category: 0x%x\n",
+                                            digi2 & AC_DIG2_CC);
+                        }
+
 			if (wid_caps & AC_WCAP_FORMAT_OVRD) {
 				snd_iprintf(buffer, "  PCM:\n");
 				print_pcm_caps(buffer, codec, nid);
 			}
 			break;
+                }
 		}
 
-		if (wid_caps & AC_WCAP_POWER)
-			snd_iprintf(buffer, "  Power: 0x%x\n",
-				    snd_hda_codec_read(codec, nid, 0,
-						       AC_VERB_GET_POWER_STATE,
-						       0));
+                if (wid_caps & AC_WCAP_UNSOL_CAP) {
+                        int unsol = snd_hda_codec_read(codec, nid, 0,
+                                          AC_VERB_GET_UNSOLICITED_RESPONSE, 0);
+                        snd_iprintf(buffer,
+                                    "  Unsolicited: tag=%02x, enabled=%d\n",
+                                    unsol & AC_UNSOL_TAG,
+                                    (unsol & AC_UNSOL_ENABLED) ? 1 : 0);
+                }
+
+		if (wid_caps & AC_WCAP_POWER) {
+                        int pwr =
+                                snd_hda_codec_read(codec, nid, 0,
+                                                   AC_VERB_GET_POWER_STATE, 0);
+                        snd_iprintf(buffer, "  Power: setting=%s, actual=%s\n",
+                                    get_pwr_state(pwr & AC_PWRST_SETTING),
+                                    get_pwr_state((pwr & AC_PWRST_ACTUAL) >>
+                                                  AC_PWRST_ACTUAL_SHIFT));
+                }
+
+                if (wid_caps & AC_WCAP_DELAY)
+                        snd_iprintf(buffer, "  Delay: %d samples\n",
+                                    (wid_caps & AC_WCAP_DELAY) >>
+                                    AC_WCAP_DELAY_SHIFT);
 
 		if (wid_caps & AC_WCAP_CONN_LIST) {
 			int c, curr = -1;
@@ -386,6 +580,31 @@ static void print_codec_info(struct snd_
 				snd_iprintf(buffer, "\n");
 			}
 		}
+
+                if (wid_caps & AC_WCAP_PROC_WID) {
+                        unsigned int proc_caps =
+                                snd_hda_param_read(codec, nid,
+                                                   AC_PAR_PROC_CAP);
+                        snd_iprintf(buffer,
+                                    "  Processing caps: benign=%d, ncoeff=%d\n",
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
