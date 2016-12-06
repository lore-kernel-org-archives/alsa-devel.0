From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 2/2] ALSA: usb-audio: avoid setting of sample rate multiple times on bus
Date: Tue, 6 Dec 2016 14:46:15 +0900
Message-ID: <20161206054615.29187-3-jiada_wang@mentor.com>
References: <20161206054615.29187-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206054615.29187-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

From: Daniel Girnus <dgirnus@de.adit-jv.com>

Some of userland applications call 'snd_pcm_hw_params()' and
'snd_pcm_hw_prepare()' sequentially, which means 'snd_pcm_hw_prepare()'
is called twice and the second 'snd_pcm_hw_prepare()' is called in
'SNDRV_PCM_STATE_PREPARED' state.

Some devices are not able to manage this and they will stop playback
if the sample rate will be configured several times over USB protocol.

V2: updated Changelog

Signed-off-by: Daniel Girnus <dgirnus@de.adit-jv.com>
Signed-off-by: Jens Lorenz <jlorenz@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/usb/pcm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 44d178e..a522c9a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -806,17 +806,18 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto unlock;
 
-	iface = usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
-	alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
-	ret = snd_usb_init_sample_rate(subs->stream->chip,
-				       subs->cur_audiofmt->iface,
-				       alts,
-				       subs->cur_audiofmt,
-				       subs->cur_rate);
-	if (ret < 0)
-		goto unlock;
-
 	if (subs->need_setup_ep) {
+
+		iface = usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
+		alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
+		ret = snd_usb_init_sample_rate(subs->stream->chip,
+					       subs->cur_audiofmt->iface,
+					       alts,
+					       subs->cur_audiofmt,
+					       subs->cur_rate);
+		if (ret < 0)
+			goto unlock;
+
 		ret = configure_endpoint(subs);
 		if (ret < 0)
 			goto unlock;
-- 
2.9.3
