From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/3 v1] ALSA: usb-audio: more tolerant packetsize
Date: Wed, 30 Nov 2016 16:59:21 +0900
Message-ID: <20161130075923.15205-2-jiada_wang@mentor.com>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161130075923.15205-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

since commit 57e6dae1087bbaa6b33d3dd8a8e90b63888939a3 the expected packetsize is always limited to
nominal + 25%. It was discovered, that some devices have a much higher jitter
in used packetsizes than 25% which would result in BABBLE condition and dropping of packets.
A better solution is so assume the jitter to be the nominal packetsize:
-one nearly empty packet followed by a almost double sized one.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/usb/endpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index c470251..2f592dd 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -632,8 +632,8 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 	ep->stride = frame_bits >> 3;
 	ep->silence_value = pcm_format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
 
-	/* assume max. frequency is 25% higher than nominal */
-	ep->freqmax = ep->freqn + (ep->freqn >> 2);
+	/* assume max. frequency is double than nominal */
+	ep->freqmax = ep->freqn * 2;
 	/* Round up freqmax to nearest integer in order to calculate maximum
 	 * packet size, which must represent a whole number of frames.
 	 * This is accomplished by adding 0x0.ffff before converting the
-- 
2.9.3
