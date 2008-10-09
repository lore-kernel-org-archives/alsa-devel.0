From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC_HP_M4
Date: Thu, 09 Oct 2008 08:37:28 -0400
Message-ID: <48EDFB08.1000504@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 5F09024476
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 14:37:56 +0200 (CEST)
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

Set the third microphone to a default config of a 'Line In' to be added the Input Source Mux's.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b5c1449..5557116 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -3605,7 +3605,12 @@ static int stac92xx_init(struct hda_codec *codec)
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
 		hda_nid_t nid = cfg->input_pins[i];
 		if (nid) {
-			unsigned int pinctl = AC_PINCTL_IN_EN;
+			unsigned int pinctl = snd_hda_codec_read(codec, nid,
+				0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+			/* if PINCTL already set then skip */
+			if (pinctl & AC_PINCAP_IN)
+				continue;
+			pinctl = AC_PINCTL_IN_EN;
 			if (i == AUTO_PIN_MIC || i == AUTO_PIN_FRONT_MIC)
 				pinctl |= stac92xx_get_vref(codec, nid);
 			stac92xx_auto_set_pinctl(codec, nid, pinctl);
@@ -4375,12 +4380,13 @@ again:
 	switch (spec->board_config) {
 	case STAC_HP_M4:
 		spec->num_dmics = 0;
-		spec->num_smuxes = 1;
+		spec->num_smuxes = 0;
 		spec->num_dmuxes = 0;

 		/* enable internal microphone */
-		snd_hda_codec_write_cache(codec, 0x0e, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80);
+		stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
+		stac92xx_auto_set_pinctl(codec, 0x0e,
+			AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
 		break;
 	default:
 		spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
