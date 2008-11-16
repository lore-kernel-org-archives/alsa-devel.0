From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC_DELL_M6 EAPD
Date: Sun, 16 Nov 2008 11:42:34 -0500
Message-ID: <49204D7A.6050507@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 30184243B9
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 17:42:48 +0100 (CET)
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

Add support for EAPD on system suspend and disabling EAPD on headphone jack
detection for STAC_DELL_M6 laptops.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index ec8f5ab..e0298df 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -147,6 +147,7 @@ struct sigmatel_spec {
 	unsigned int num_mixers;

 	int board_config;
+	unsigned int eapd_switch: 1;
 	unsigned int surr_switch: 1;
 	unsigned int line_switch: 1;
 	unsigned int mic_switch: 1;
@@ -3944,7 +3945,7 @@ static void stac92xx_hp_detect(struct hda_codec *codec,
unsigned int res)
 		for (i = 0; i < cfg->speaker_outs; i++)
 			stac92xx_reset_pinctl(codec, cfg->speaker_pins[i],
 						AC_PINCTL_OUT_EN);
-		if (spec->eapd_mask)
+		if (spec->eapd_mask && spec->eapd_switch)
 			stac_gpio_set(codec, spec->gpio_mask,
 				spec->gpio_dir, spec->gpio_data &
 				~spec->eapd_mask);
@@ -3959,7 +3960,7 @@ static void stac92xx_hp_detect(struct hda_codec *codec,
unsigned int res)
 		for (i = 0; i < cfg->speaker_outs; i++)
 			stac92xx_set_pinctl(codec, cfg->speaker_pins[i],
 						AC_PINCTL_OUT_EN);
-		if (spec->eapd_mask)
+		if (spec->eapd_mask && spec->eapd_switch)
 			stac_gpio_set(codec, spec->gpio_mask,
 				spec->gpio_dir, spec->gpio_data |
 				spec->eapd_mask);
@@ -4319,6 +4320,7 @@ again:
 		spec->num_smuxes = 0;
 		spec->mixer = &stac92hd73xx_6ch_mixer[DELL_M6_MIXER];
 		spec->amp_nids = &stac92hd73xx_amp_nids[DELL_M6_AMP];
+		spec->eapd_switch = 0;
 		spec->num_amps = 1;

 		if (!spec->init)
@@ -4350,6 +4352,7 @@ again:
 	default:
 		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
 		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
+		spec->eapd_switch = 1;
 	}
 	if (spec->board_config > STAC_92HD73XX_REF) {
 		/* GPIO0 High = Enable EAPD */
@@ -4495,7 +4498,13 @@ static int stac92hd71xx_resume(struct hda_codec *codec)

 static int stac92hd71xx_suspend(struct hda_codec *codec, pm_message_t state)
 {
+	struct sigmatel_spec *spec = codec->spec;
+
 	stac92hd71xx_set_power_state(codec, AC_PWRST_D3);
+	if (spec->eapd_mask)
+		stac_gpio_set(codec, spec->gpio_mask,
+				spec->gpio_dir, spec->gpio_data &
+				~spec->eapd_mask);
 	return 0;
 };

@@ -4885,6 +4894,7 @@ static int patch_stac927x(struct hda_codec *codec)
 	spec->num_pwrs = 0;
 	spec->aloopback_mask = 0x40;
 	spec->aloopback_shift = 0;
+	spec->eapd_switch = 1;

 	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);
 	if (!err) {
@@ -4965,6 +4975,7 @@ static int patch_stac9205(struct hda_codec *codec)

 	spec->aloopback_mask = 0x40;
 	spec->aloopback_shift = 0;
+	spec->eapd_switch = 1;
 	spec->multiout.dac_nids = spec->dac_nids;
 	
 	switch (spec->board_config){
