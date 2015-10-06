From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 11/18] ALSA: hda: move to use hdac helpers
Date: Tue,  6 Oct 2015 16:07:48 +0100
Message-ID: <1444144075-28963-12-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2830926574A
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:10:33 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move to use newly moved snd_hdac_write_codec()
API

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_conexant.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ca03c40609fc..c6cdfae01cc0 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -147,9 +147,9 @@ static void cx_auto_turn_eapd(struct hda_codec *codec, int num_pins,
 	int i;
 	for (i = 0; i < num_pins; i++) {
 		if (snd_hda_query_pin_caps(codec, pins[i]) & AC_PINCAP_EAPD)
-			snd_hda_codec_write(codec, pins[i], 0,
-					    AC_VERB_SET_EAPD_BTLENABLE,
-					    on ? 0x02 : 0);
+			snd_hdac_codec_write(&codec->core, pins[i], 0,
+					     AC_VERB_SET_EAPD_BTLENABLE,
+					     on ? 0x02 : 0);
 	}
 }
 
@@ -168,9 +168,9 @@ static void cx_auto_vmaster_hook_mute_led(void *private_data, int enabled)
 	struct hda_codec *codec = private_data;
 	struct conexant_spec *spec = codec->spec;
 
-	snd_hda_codec_write(codec, spec->mute_led_eapd, 0,
-			    AC_VERB_SET_EAPD_BTLENABLE,
-			    enabled ? 0x00 : 0x02);
+	snd_hdac_codec_write(&codec->core, spec->mute_led_eapd, 0,
+			     AC_VERB_SET_EAPD_BTLENABLE,
+			     enabled ? 0x00 : 0x02);
 }
 
 static int cx_auto_build_controls(struct hda_codec *codec)
@@ -212,8 +212,8 @@ static void cx_auto_reboot_notify(struct hda_codec *codec)
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
 
 	snd_hda_codec_set_power_to_all(codec, codec->core.afg, AC_PWRST_D3);
-	snd_hda_codec_write(codec, codec->core.afg, 0,
-			    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+	snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+			     AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 }
 
 static void cx_auto_free(struct hda_codec *codec)
@@ -367,8 +367,8 @@ static void olpc_xo_update_mic_boost(struct hda_codec *codec)
 			(ch ? AC_AMP_SET_RIGHT : AC_AMP_SET_LEFT);
 		if (!spec->dc_enable)
 			val |= snd_hda_codec_amp_read(codec, 0x17, ch, HDA_OUTPUT, 0);
-		snd_hda_codec_write(codec, 0x17, 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE, val);
+		snd_hdac_codec_write(&codec->core, 0x17, 0,
+				     AC_VERB_SET_AMP_GAIN_MUTE, val);
 	}
 }
 
-- 
2.4.3
