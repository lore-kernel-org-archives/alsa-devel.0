From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 1/2] ALSA: hda - hdmi: Set converter channel count even without sink
Date: Mon,  5 May 2014 02:38:43 +0300
Message-ID: <1399246724-16611-1-git-send-email-anssi.hannula@iki.fi>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Stephan Raue <stephan@openelec.tv>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since commit 1df5a06a ("ALSA: hda - hdmi: Fix programmed active channel
count") channel count is no longer being set if monitor_present is 0.
This is because setting the count was moved after the CA value is
determined, which is only after the monitor_present check in
hdmi_setup_audio_infoframe().

Unfortunately, in some cases, such as with a non-spec-compliant codec or
with a problematic video driver, monitor_present is always 0. As a
specific example, this seems to happen with gen1 ATV (SiI1390 codec),
causing left-channel-only stereo playback (multi-channel playback has
apparently never worked with this codec despite it reporting 8 channels,
reason unknown).

Simply setting converter channel count without setting the pin infoframe
and channel mapping as well does not theoretically make much sense as
this will just mean they are out-of-sync and multichannel playback will
have a wrong channel mapping.

However, adding back just setting the converter channel count even in
no-monitor case is the safest change which at least fixes the stereo
playback regression on SiI1390 codec. Do that.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Reported-by: Stephan Raue <stephan@openelec.tv>
Tested-by: Stephan Raue <stephan@openelec.tv>
Cc: <stable@vger.kernel.org> # 3.12+
---
 sound/pci/hda/patch_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0cb5b89cd0c8..1edbb9c47c2d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1127,8 +1127,10 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 					    AMP_OUT_UNMUTE);
 
 	eld = &per_pin->sink_eld;
-	if (!eld->monitor_present)
+	if (!eld->monitor_present) {
+		hdmi_set_channel_count(codec, per_pin->cvt_nid, channels);
 		return;
+	}
 
 	if (!non_pcm && per_pin->chmap_set)
 		ca = hdmi_manual_channel_allocation(channels, per_pin->chmap);
-- 
1.8.4.5
