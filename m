From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda - Don't apply EAPD power filter
	as default
Date: Wed, 13 Mar 2013 17:42:39 +0100
Message-ID: <1363192959-11917-3-git-send-email-tiwai@suse.de>
References: <1363192959-11917-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75C1B2625CF
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:42:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 46888A51BB
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:42:39 +0100 (CET)
In-Reply-To: <1363192959-11917-1-git-send-email-tiwai@suse.de>
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

So far, the driver doesn't power down the widget at going down to D3
when the widget node has an EAPD capability and EAPD is actually set
on all codecs unless codec->power_filter is set explicitly.
This caused a problem on some Conexant codecs, leading to click
noises, and we set it as NULL there.  But it is very unlikely that the
problem hits only these codecs.

Looking back at the development history, this workaround for EAPD was
introduced just for some laptops with STAC9200 codec, then we applied
it blindly for all.  Now, since it's revealed to have an ill effect,
we should disable this workaround per default and apply only for the
known requiring systems.

The EAPD workaround is implemented now as snd_hda_codec_eapd_power_filter(),
and this has to be set explicitly by the codec driver when needed.
As of now, only patch_stac9200() sets this one.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 13 ++++++-------
 sound/pci/hda/hda_local.h      |  4 ++++
 sound/pci/hda/patch_conexant.c |  1 -
 sound/pci/hda/patch_sigmatel.c |  1 +
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index a1c5053..8cca987 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1296,8 +1296,6 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
 
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 				unsigned int power_state);
-static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
-					 unsigned int power_state);
 
 /**
  * snd_hda_codec_new - create a HDA codec
@@ -1418,7 +1416,6 @@ int snd_hda_codec_new(struct hda_bus *bus,
 #endif
 	codec->epss = snd_hda_codec_get_supported_ps(codec, fg,
 					AC_PWRST_EPSS);
-	codec->power_filter = default_power_filter;
 
 	/* power-up all before initialization */
 	hda_set_power_state(codec, AC_PWRST_D0);
@@ -3759,8 +3756,9 @@ static unsigned int hda_sync_power_state(struct hda_codec *codec,
 }
 
 /* don't power down the widget if it controls eapd and EAPD_BTLENABLE is set */
-static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
-					 unsigned int power_state)
+unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
+					     hda_nid_t nid,
+					     unsigned int power_state)
 {
 	if (power_state == AC_PWRST_D3 &&
 	    get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN &&
@@ -3772,6 +3770,7 @@ static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
 	}
 	return power_state;
 }
+EXPORT_SYMBOL_HDA(snd_hda_codec_eapd_power_filter);
 
 /*
  * set power state of the codec, and return the power state
@@ -3816,8 +3815,8 @@ static void sync_power_up_states(struct hda_codec *codec)
 	hda_nid_t nid = codec->start_nid;
 	int i;
 
-	/* don't care if no or standard filter is used */
-	if (!codec->power_filter || codec->power_filter == default_power_filter)
+	/* don't care if no filter is used */
+	if (!codec->power_filter)
 		return;
 
 	for (i = 0; i < codec->num_nodes; i++, nid++) {
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 83b7486..e0bf753 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -670,6 +670,10 @@ snd_hda_check_power_state(struct hda_codec *codec, hda_nid_t nid,
 	return (state != target_state);
 }
 
+unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
+					     hda_nid_t nid,
+					     unsigned int power_state);
+
 /*
  * AMP control callbacks
  */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 941bf6c..7d941ef 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3350,7 +3350,6 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	switch (codec->vendor_id) {
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
-		codec->power_filter = NULL; /* Needs speaker amp to D3 to avoid click */
 		break;
 	case 0x14f15047:
 		codec->pin_amp_workaround = 1;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 83d5335..d57c81e 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3774,6 +3774,7 @@ static int patch_stac9200(struct hda_codec *codec)
 	spec->gen.own_eapd_ctl = 1;
 
 	codec->patch_ops = stac_patch_ops;
+	codec->power_filter = snd_hda_codec_eapd_power_filter;
 
 	snd_hda_add_verbs(codec, stac9200_eapd_init);
 
-- 
1.8.1.4
