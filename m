From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 2/3] ALSA: hda - hdmi: Skip out-of-range
	latency values in AMD ELD generator
Date: Sun, 10 Nov 2013 20:56:11 +0200
Message-ID: <1384109772-7614-3-git-send-email-anssi.hannula@iki.fi>
References: <1384109772-7614-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id EEDF1261B23
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 19:56:24 +0100 (CET)
In-Reply-To: <1384109772-7614-1-git-send-email-anssi.hannula@iki.fi>
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

The ATI/AMD video/audio latencies are specified in apparent HDMI VSDB
format. In this format values above 251 are not valid (or stream
component is not supported - 255), but no checking is performed since
this was not mentioned in the AMD HDA verbs specification.

Check that the latencies are valid before using them, and add a comment
describing the formats.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/hda_eld.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index e8c55f5a34ff..9b697a28cf53 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -768,13 +768,28 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 		return -EINVAL;
 	}
 
+	/*
+	 * HDMI VSDB latency format:
+	 * separately for both audio and video:
+	 *  0          field not valid or unknown latency
+	 *  [1..251]   msecs = (x-1)*2  (max 500ms with x = 251 = 0xfb)
+	 *  255        audio/video not supported
+	 *
+	 * HDA latency format:
+	 * single value indicating video latency relative to audio:
+	 *  0          unknown or 0ms
+	 *  [1..250]   msecs = x*2  (max 500ms with x = 250 = 0xfa)
+	 *  [251..255] reserved
+	 */
 	aud_synch = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_AUDIO_VIDEO_DELAY, 0);
 	if ((aud_synch & ATI_DELAY_VIDEO_LATENCY) && (aud_synch & ATI_DELAY_AUDIO_LATENCY)) {
-		int video_latency = (aud_synch & ATI_DELAY_VIDEO_LATENCY) - 1;
-		int audio_latency = ((aud_synch & ATI_DELAY_AUDIO_LATENCY) >> 8) - 1;
+		int video_latency_hdmi = (aud_synch & ATI_DELAY_VIDEO_LATENCY);
+		int audio_latency_hdmi = (aud_synch & ATI_DELAY_AUDIO_LATENCY) >> 8;
 
-		if (video_latency > audio_latency)
-			buf[6] = min(video_latency - audio_latency, 0xfa);
+		if (video_latency_hdmi <= 0xfb && audio_latency_hdmi <= 0xfb &&
+		    video_latency_hdmi > audio_latency_hdmi)
+			buf[6] = video_latency_hdmi - audio_latency_hdmi;
+		/* else unknown/invalid or 0ms or video ahead of audio, so use zero */
 	}
 
 	/* Baseline length */
-- 
1.8.1.5
