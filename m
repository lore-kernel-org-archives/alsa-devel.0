From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 2/3 v2] ALSA: usb-audio: avoid setting of sample rate multiple times on bus
Date: Wed, 30 Nov 2016 16:59:22 +0900
Message-ID: <20161130075923.15205-3-jiada_wang@mentor.com>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161130075923.15205-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

From: Daniel Girnus <dgirnus@de.adit-jv.com>

ALSA usually calls the prepare function twice before starting the playback:
1. On hw_params call from userland and
2. internally when starting the stream.
Some device are not able to manage this and they will stop playback
if the sample rate will be configured several times over USB protocol.

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
