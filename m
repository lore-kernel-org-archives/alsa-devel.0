From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v3] ALSA: hda - Turn on PIN_OUT from hdmi
	playback prepare.
Date: Thu, 19 Jul 2012 17:52:58 -0700
Message-ID: <1342745578-8535-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f201.google.com (mail-yx0-f201.google.com
 [209.85.213.201])
 by alsa0.perex.cz (Postfix) with ESMTP id CB9042652AF
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 02:53:22 +0200 (CEST)
Received: by yenl11 with SMTP id l11so393789yen.2
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 17:53:24 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

Turn on the pin widget's PIN_OUT bit from playback prepare. The pin is
enabled in open, but is disabled in hdmi_init_pin which is called during
system resume.  This causes a system suspend/resume during playback to
mute HDMI/DP. Enabling the pin in prepare instead of open allows calling
snd_pcm_prepare after a system resume to restore audio.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_hdmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0b4a1ea..641408d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -876,7 +876,6 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	struct hdmi_spec_per_pin *per_pin;
 	struct hdmi_eld *eld;
 	struct hdmi_spec_per_cvt *per_cvt = NULL;
-	int pinctl;
 
 	/* Validate hinfo */
 	pin_idx = hinfo_to_pin_index(spec, hinfo);
@@ -912,11 +911,6 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	snd_hda_codec_write(codec, per_pin->pin_nid, 0,
 			    AC_VERB_SET_CONNECT_SEL,
 			    mux_idx);
-	pinctl = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
-				    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-	snd_hda_codec_write(codec, per_pin->pin_nid, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    pinctl | PIN_OUT);
 	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
 
 	/* Initially set the converter's capabilities */
@@ -1153,11 +1147,17 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx = hinfo_to_pin_index(spec, hinfo);
 	hda_nid_t pin_nid = spec->pins[pin_idx].pin_nid;
+	int pinctl;
 
 	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
 
 	hdmi_setup_audio_infoframe(codec, pin_idx, substream);
 
+	pinctl = snd_hda_codec_read(codec, pin_nid, 0,
+				    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	snd_hda_codec_write(codec, pin_nid, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, pinctl | PIN_OUT);
+
 	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
 }
 
-- 
1.7.11.2.138.g2b53359
