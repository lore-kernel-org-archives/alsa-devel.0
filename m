From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: use last DAC defined for hp_pin
Date: Tue, 23 Sep 2008 21:46:30 -0400
Message-ID: <48D99BF6.5090103@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id F00822434B
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 03:46:42 +0200 (CEST)
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

Patch allows the last DAC in the dac_nids for the hp_nid if there is an
available one this isn't in use by a line_out entry or if hp_nid isn't already
defined. This solves the issues with the 'Headphone Playback' mixer
controls on the 92hd73xxx branch and possibly others.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b5c1449..01f5475 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -2817,6 +2817,10 @@ static int stac92xx_auto_create_multi_out_ctls(struct hda_codec *codec,
 		}
 	}

+	if ((spec->multiout.num_dacs - cfg->line_outs) > 0 &&
+			cfg->hp_outs && !spec->multiout.hp_nid)
+		spec->multiout.hp_nid = nid;
+
 	if (cfg->hp_outs > 1) {
 		err = stac92xx_add_control(spec,
 			STAC_CTL_WIDGET_HP_SWITCH,
@@ -4083,8 +4087,6 @@ again:
 	case STAC_DELL_M6:
 		spec->init = dell_eq_core_init;
 		spec->num_smuxes = 0;
-		spec->multiout.hp_nid =
-			spec->multiout.dac_nids[spec->multiout.num_dacs - 1];
 		spec->mixer = &stac92hd73xx_6ch_mixer[DELL_M6_MIXER];
 		spec->amp_nids = &stac92hd73xx_amp_nids[DELL_M6_AMP];
 		spec->num_amps = 1;
