From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Re-setup HDMI pin and audio
	infoframe on stream switches
Date: Tue,  3 Sep 2013 11:57:59 +0200
Message-ID: <1378202279-14990-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75CF7261671
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 11:56:24 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

When the transcoder:port mapping on Haswell HDMI/DP audio is changed
during the stream playback, the sound gets lost.  Typically this
problem is seen when the user switches the graphics mode from eDP+DP
to DP-only configuration, where CRTC 1 is used for DP in the former
while CRTC 0 is used for the latter.

The graphics controller notifies the change via the normal ELD update
procedure, so we get the intrinsic event.  For enabling the sound
again, the HDMI audio driver needs to reset the pin and set up the
audio infoframe again.

This patch achieves it by:
- keep the current status of channels and info frame setup in per_pin
  struct,
- check the reconnection in the intrinsic event handler,
- reset the pin and the re-invoke hdmi_setup_audio_infoframe()
  accordingly.

The hdmi_setup_audio_infoframe() function has been changed, too, so
that it can be invoked without passing the substream instance.

The patch is mostly based on the work by Mengdong Lin.

Cc: Mengdong Lin <mengdong.lin@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b83b14f..22b5089 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -67,6 +67,8 @@ struct hdmi_spec_per_pin {
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
 	int repoll_count;
+	bool setup; /* the stream has been set up by prepare callback */
+	int channels; /* current number of channels */
 	bool non_pcm;
 	bool chmap_set;		/* channel-map override by ALSA API? */
 	unsigned char chmap[8]; /* ALSA API channel-map */
@@ -879,18 +881,19 @@ static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
 	return true;
 }
 
-static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
-				       bool non_pcm,
-				       struct snd_pcm_substream *substream)
+static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
+				       struct hdmi_spec_per_pin *per_pin,
+				       bool non_pcm)
 {
-	struct hdmi_spec *spec = codec->spec;
-	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
 	hda_nid_t pin_nid = per_pin->pin_nid;
-	int channels = substream->runtime->channels;
+	int channels = per_pin->channels;
 	struct hdmi_eld *eld;
 	int ca;
 	union audio_infoframe ai;
 
+	if (!channels)
+		return;
+
 	eld = &per_pin->sink_eld;
 	if (!eld->monitor_present)
 		return;
@@ -1341,6 +1344,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		eld_changed = true;
 	}
 	if (update_eld) {
+		bool old_eld_valid = pin_eld->eld_valid;
 		pin_eld->eld_valid = eld->eld_valid;
 		eld_changed = pin_eld->eld_size != eld->eld_size ||
 			      memcmp(pin_eld->eld_buffer, eld->eld_buffer,
@@ -1350,6 +1354,18 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 			       eld->eld_size);
 		pin_eld->eld_size = eld->eld_size;
 		pin_eld->info = eld->info;
+
+		/* Haswell-specific workaround: re-setup when the transcoder is
+		 * changed during the stream playback
+		 */
+		if (codec->vendor_id == 0x80862807 &&
+		    eld->eld_valid && !old_eld_valid && per_pin->setup) {
+			snd_hda_codec_write(codec, pin_nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_OUT_UNMUTE);
+			hdmi_setup_audio_infoframe(codec, per_pin,
+						   per_pin->non_pcm);
+		}
 	}
 	mutex_unlock(&pin_eld->lock);
 
@@ -1522,14 +1538,17 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	hda_nid_t cvt_nid = hinfo->nid;
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx = hinfo_to_pin_index(spec, hinfo);
-	hda_nid_t pin_nid = get_pin(spec, pin_idx)->pin_nid;
+	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
+	hda_nid_t pin_nid = per_pin->pin_nid;
 	bool non_pcm;
 
 	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
+	per_pin->channels = substream->runtime->channels;
+	per_pin->setup = true;
 
 	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
 
-	hdmi_setup_audio_infoframe(codec, pin_idx, non_pcm, substream);
+	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
 
 	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
 }
@@ -1569,6 +1588,9 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		snd_hda_spdif_ctls_unassign(codec, pin_idx);
 		per_pin->chmap_set = false;
 		memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
+
+		per_pin->setup = false;
+		per_pin->channels = 0;
 	}
 
 	return 0;
@@ -1704,8 +1726,7 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	per_pin->chmap_set = true;
 	memcpy(per_pin->chmap, chmap, sizeof(chmap));
 	if (prepared)
-		hdmi_setup_audio_infoframe(codec, pin_idx, per_pin->non_pcm,
-					   substream);
+		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
 
 	return 0;
 }
-- 
1.8.3.4
