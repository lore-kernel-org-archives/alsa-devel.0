From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] ALSA: hda - hdmi: Fix channel map switch not taking effect
Date: Wed,  2 Oct 2013 21:13:32 +0300
Message-ID: <1380737612-16512-1-git-send-email-anssi.hannula@iki.fi>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently hdmi_setup_audio_infoframe() reprograms the HDA channel
mapping only when the infoframe is not up-to-date or the non-PCM flag
has changed.

However, when just the channel map has been changed, the infoframe may
still be up-to-date and non-PCM flag may not have changed, so the new
channel map is not actually programmed into the HDA codec.

Notably, this failing case is also always triggered when the device is
already in a prepared state and a new channel map is configured while
changing only the channel positions (for example, plain
"speaker-test -c2 -m FR,FL").

Fix that by keeping track of the last programmed channel map and making
hdmi_setup_audio_infoframe() always update the hardware mapping if the
channel map has changed.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: <stable@vger.kernel.org>
---

BTW, is there some mechanism preventing hdmi_chmap_ctl_put() to be called
at the same time with generic_hdmi_playback_pcm_prepare() that I didn't
see with a quick look?
Both of them call hdmi_setup_audio_infoframe() which is not thread-safe.

 sound/pci/hda/patch_hdmi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7ea0245..09f38a1 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -74,6 +74,8 @@ struct hdmi_spec_per_pin {
 	bool non_pcm;
 	bool chmap_set;		/* channel-map override by ALSA API? */
 	unsigned char chmap[8]; /* ALSA API channel-map */
+	bool last_chmap_set;	/* channel-map override programmed? */
+	unsigned char last_chmap[8]; /* last programmed channel-map */
 	char pcm_name[8];	/* filled in build_pcm callbacks */
 };
 
@@ -955,15 +957,21 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 					    ai.bytes, sizeof(ai));
 		hdmi_start_infoframe_trans(codec, pin_nid);
 	} else {
-		/* For non-pcm audio switch, setup new channel mapping
-		 * accordingly */
-		if (per_pin->non_pcm != non_pcm)
+		/* For non-pcm audio switch or channel-map switch,
+		 * setup new channel mapping accordingly */
+		if (per_pin->non_pcm != non_pcm
+		    || per_pin->chmap_set != per_pin->last_chmap_set
+		    || (per_pin->chmap_set && memcmp(per_pin->chmap, per_pin->last_chmap,
+						     ARRAY_SIZE(per_pin->chmap)) != 0))
 			hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
 						   channels, per_pin->chmap,
 						   per_pin->chmap_set);
 	}
 
 	per_pin->non_pcm = non_pcm;
+	per_pin->last_chmap_set = per_pin->chmap_set;
+	if (per_pin->chmap_set)
+		memcpy(per_pin->last_chmap, per_pin->chmap, ARRAY_SIZE(per_pin->chmap));
 }
 
 
-- 
1.8.1.5
