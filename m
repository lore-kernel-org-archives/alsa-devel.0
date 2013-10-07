From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH v2] ALSA: hda - hdmi: Fix channel map switch not taking effect
Date: Mon,  7 Oct 2013 19:24:52 +0300
Message-ID: <1381163092-19484-1-git-send-email-anssi.hannula@iki.fi>
References: <884f0056bbbc27a2f35c581de11a07d9@mail.onse.fi>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <884f0056bbbc27a2f35c581de11a07d9@mail.onse.fi>
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

Fix that by always programming the channel map in
hdmi_setup_audio_infoframe(). Tested on Intel HDMI.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: <stable@vger.kernel.org>
---

Here is a simpler version of the map switch fix.

 sound/pci/hda/patch_hdmi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7ea0245..50173d4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -937,6 +937,14 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	}
 
 	/*
+	 * always configure channel mapping, it may have been changed by the
+	 * user in the meantime
+	 */
+	hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
+				   channels, per_pin->chmap,
+				   per_pin->chmap_set);
+
+	/*
 	 * sizeof(ai) is used instead of sizeof(*hdmi_ai) or
 	 * sizeof(*dp_ai) to avoid partial match/update problems when
 	 * the user switches between HDMI/DP monitors.
@@ -947,20 +955,10 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 			    "pin=%d channels=%d\n",
 			    pin_nid,
 			    channels);
-		hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
-					   channels, per_pin->chmap,
-					   per_pin->chmap_set);
 		hdmi_stop_infoframe_trans(codec, pin_nid);
 		hdmi_fill_audio_infoframe(codec, pin_nid,
 					    ai.bytes, sizeof(ai));
 		hdmi_start_infoframe_trans(codec, pin_nid);
-	} else {
-		/* For non-pcm audio switch, setup new channel mapping
-		 * accordingly */
-		if (per_pin->non_pcm != non_pcm)
-			hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
-						   channels, per_pin->chmap,
-						   per_pin->chmap_set);
 	}
 
 	per_pin->non_pcm = non_pcm;
-- 
1.8.1.5
