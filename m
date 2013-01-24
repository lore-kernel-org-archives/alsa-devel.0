From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/13] ALSA: hda - Enable power down of unused
	widgets for IDT codecs
Date: Thu, 24 Jan 2013 18:38:02 +0100
Message-ID: <1359049082-5880-14-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B45902616FA
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0E544A51CB
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

IDT codecs can work well with this new feature, so let's enable it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 5895d8f..1c49861 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3609,14 +3609,6 @@ static int stac_init(struct hda_codec *codec)
 		}
 	}
 
-	/* power down unused DACs */
-	for (i = 0; i < spec->gen.num_all_dacs; i++) {
-		if (!snd_hda_get_nid_path(codec, spec->gen.all_dacs[i], 0))
-			snd_hda_codec_write(codec, spec->gen.all_dacs[i], 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
-	}
-
 	return 0;
 }
 
@@ -3871,6 +3863,7 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 	spec->pwr_nids = stac92hd73xx_pwr_nids;
 
 	spec->gen.own_eapd_ctl = 1;
+	spec->gen.power_down_unused = 1;
 
 	codec->patch_ops = stac_patch_ops;
 
@@ -3933,6 +3926,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
+	spec->gen.power_down_unused = 1;
 	spec->gen.mixer_nid = 0x1b;
 
 	spec->digbeep_nid = 0x21;
@@ -3976,6 +3970,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
+	spec->gen.power_down_unused = 1;
 	spec->gen.mixer_nid = 0x17;
 	spec->have_spdif_mux = 1;
 
-- 
1.8.1.1
