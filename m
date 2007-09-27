From: "Brian Hinz" <bphinz@hotmail.com>
Subject: [PATCH] stac9200 eapd fixes
Date: Wed, 26 Sep 2007 21:39:47 -0400
Message-ID: <BLU115-F1BA99DBF1BC0B0EA74D92C8B10@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s39.bay0.hotmail.com (bay0-omc3-s39.bay0.hotmail.com
	[65.54.246.239]) by alsa0.perex.cz (Postfix) with ESMTP id E214C244F3
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 03:39:53 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

The following patch addresses alsa bug #0002948 and it's (many) duplicates.  
Please consider it for inclusion in the next release.

Thanks,
-brian

--- alsa-kernel/pci/hda/hda_codec.c	2007-09-24 21:46:11.000000000 -0400
+++ alsa-kernel/pci/hda/hda_codec.c	2007-09-24 22:00:15.000000000 -0400
@@ -1629,11 +1629,30 @@
			    power_state);

	nid = codec->start_nid;
+	unsigned int pincap;
	for (i = 0; i < codec->num_nodes; i++, nid++) {
-		if (get_wcaps(codec, nid) & AC_WCAP_POWER)
-			snd_hda_codec_write(codec, nid, 0,
+		if (get_wcaps(codec, nid) & AC_WCAP_POWER) {
+			pincap = snd_hda_param_read(codec, nid,
+				AC_PAR_PIN_CAP);
+			/*
+ 			 * don't power down the widget if it controls eapd
+ 			 * and EAPD_BTLENABLE is set.
+ 			 */
+			if (pincap & AC_PINCAP_EAPD) {
+				int eapd = snd_hda_codec_read(codec, nid,
+					0, AC_VERB_GET_EAPD_BTLENABLE, 0);
+				eapd &= 0x02;
+				if (power_state != AC_PWRST_D3 || !eapd) {
+					snd_hda_codec_write(codec, nid, 0,
+						AC_VERB_SET_POWER_STATE,
+					    	power_state);
+				}
+			} else {
+				snd_hda_codec_write(codec, nid, 0,
					    AC_VERB_SET_POWER_STATE,
					    power_state);
+			}
+		}
	}

	if (power_state == AC_PWRST_D0) {
--- alsa-kernel/pci/hda/patch_sigmatel.c	2007-09-24 21:46:12.000000000 -0400
+++ alsa-kernel/pci/hda/patch_sigmatel.c	2007-09-26 20:57:55.000000000 -0400
@@ -378,6 +378,13 @@
	{}
};

+static struct hda_verb stac9200_eapd_init[] = {
+	/* set dac0mux for dac converter */
+	{ 0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ 0x08, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	{}
+};
+
static struct hda_verb stac925x_core_init[] = {
	/* set dac0mux for dac converter */
	{ 0x06, AC_VERB_SET_CONNECT_SEL, 0x00},
@@ -2492,7 +2499,23 @@
	spec->num_dmics = 0;
	spec->num_adcs = 1;

-	spec->init = stac9200_core_init;
+	/*
+ 	 * EAPD needs to be set on resume
+ 	 */
+	switch (codec->subsystem_id) {
+	case 0x107b0205: /* Gateway S-7110M */
+		spec->init = stac9200_eapd_init;
+		break;
+	case 0x107b0317: /* Gateway MT3423, MX3412, MX3410, MX3414 */
+		spec->init = stac9200_eapd_init;
+		break;
+	case 0x107b0318: /* Gateway ML3109, MT3707 */
+		spec->init = stac9200_eapd_init;
+		break;
+	default:
+		spec->init = stac9200_core_init;
+		break;
+	}
	spec->mixer = stac9200_mixer;

	err = stac9200_parse_auto_config(codec);
