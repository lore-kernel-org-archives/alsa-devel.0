From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda - Fix possible races in HDMI
	driver
Date: Thu, 17 Oct 2013 18:32:33 +0200
Message-ID: <1382027554-12370-2-git-send-email-tiwai@suse.de>
References: <1382027554-12370-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DF29026030F
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 18:29:36 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AF7A9A59BA
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 18:29:36 +0200 (CEST)
In-Reply-To: <1382027554-12370-1-git-send-email-tiwai@suse.de>
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

Some per_pin fields and ELD contents might be changed dynamically in
multiple ways where the concurrent accesses are still opened in the
current code.  This patch fixes such possible races by using eld->lock
in appropriate places.

Reported-by: Anssi Hannula <anssi.hannula@iki.fi>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b899eba..c2bad95 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1342,6 +1342,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	bool update_eld = false;
 	bool eld_changed = false;
 
+	mutex_lock(&pin_eld->lock);
 	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
 	if (pin_eld->monitor_present)
 		eld->eld_valid  = !!(present & AC_PINSENSE_ELDV);
@@ -1371,11 +1372,10 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 			queue_delayed_work(codec->bus->workq,
 					   &per_pin->work,
 					   msecs_to_jiffies(300));
-			return;
+			goto unlock;
 		}
 	}
 
-	mutex_lock(&pin_eld->lock);
 	if (pin_eld->eld_valid && !eld->eld_valid) {
 		update_eld = true;
 		eld_changed = true;
@@ -1400,12 +1400,13 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 			hdmi_setup_audio_infoframe(codec, per_pin,
 						   per_pin->non_pcm);
 	}
-	mutex_unlock(&pin_eld->lock);
 
 	if (eld_changed)
 		snd_ctl_notify(codec->bus->card,
 			       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
 			       &per_pin->eld_ctl->id);
+ unlock:
+	mutex_unlock(&pin_eld->lock);
 }
 
 static void hdmi_repoll_eld(struct work_struct *work)
@@ -1576,10 +1577,12 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	bool non_pcm;
 
 	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
+	mutex_lock(&per_pin->sink_eld.lock);
 	per_pin->channels = substream->runtime->channels;
 	per_pin->setup = true;
 
 	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
+	mutex_unlock(&per_pin->sink_eld.lock);
 
 	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
 }
@@ -1617,11 +1620,14 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		per_pin = get_pin(spec, pin_idx);
 
 		snd_hda_spdif_ctls_unassign(codec, pin_idx);
+
+		mutex_lock(&per_pin->sink_eld.lock);
 		per_pin->chmap_set = false;
 		memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
 
 		per_pin->setup = false;
 		per_pin->channels = 0;
+		mutex_unlock(&per_pin->sink_eld.lock);
 	}
 
 	return 0;
@@ -1750,10 +1756,12 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	ca = hdmi_manual_channel_allocation(ARRAY_SIZE(chmap), chmap);
 	if (ca < 0)
 		return -EINVAL;
+	mutex_lock(&per_pin->sink_eld.lock);
 	per_pin->chmap_set = true;
 	memcpy(per_pin->chmap, chmap, sizeof(chmap));
 	if (prepared)
 		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
+	mutex_unlock(&per_pin->sink_eld.lock);
 
 	return 0;
 }
-- 
1.8.4
