From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] ALSA: hda - hdmi: Re-setup pin and infoframe
	on plug-in on all codecs
Date: Fri, 25 Oct 2013 01:45:18 +0300
Message-ID: <1382654718-23424-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA4A2615A6
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 00:45:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hdmi_setup_audio_infoframe() does not set up pin and infoframe if there
is no connected sink. If a sink is connected while audio playback is
already in progress, the pin and infoframe will not be properly set up,
causing no audio or wrongly mapped audio.

On Intel Haswell codecs the hdmi_setup_audio_infoframe() is already
called again from hdmi_present_sense() when an ELD appears because
transcoder:port mapping may have changed.

Make the call non-Haswell-specific so that audio will be properly set up
if the playback was started before a sink was connected.

Tested on non-Haswell Intel HDMI codec by plugging sink in during
playback.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 804adb8..a1fe4bb 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1462,11 +1462,12 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		pin_eld->eld_size = eld->eld_size;
 		pin_eld->info = eld->info;
 
-		/* Haswell-specific workaround: re-setup when the transcoder is
-		 * changed during the stream playback
+		/*
+		 * Re-setup pin and infoframe. This is needed e.g. when
+		 * - sink is first plugged-in (infoframe is not set up if !monitor_present)
+		 * - transcoder can change during stream playback on Haswell
 		 */
-		if (is_haswell(codec) &&
-		    eld->eld_valid && !old_eld_valid && per_pin->setup)
+		if (eld->eld_valid && !old_eld_valid && per_pin->setup)
 			hdmi_setup_audio_infoframe(codec, per_pin,
 						   per_pin->non_pcm);
 	}
-- 
1.8.1.5
