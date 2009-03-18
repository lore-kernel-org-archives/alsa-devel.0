From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/3] snd-usb-caiaq: drop bogus iso packets
Date: Wed, 18 Mar 2009 11:03:54 +0100
Message-ID: <1237370635-27728-3-git-send-email-daniel@caiaq.de>
References: <1237370635-27728-1-git-send-email-daniel@caiaq.de>
	<1237370635-27728-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DE5C1038D8
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 11:04:07 +0100 (CET)
In-Reply-To: <1237370635-27728-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Drop inbound packets that are smaller than expected. This has been
observed at the very beginning of the streaming transaction.

And when the hardware is in panic mode (which can only very rarely
happen in case of massive EMI chaos), mute the input channels.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Tested-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/caiaq/caiaq-audio.c  |    6 ++++++
 sound/usb/caiaq/caiaq-device.c |    2 ++
 sound/usb/caiaq/caiaq-device.h |    2 +-
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index 577b112..08d51e0 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -377,6 +377,9 @@ static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
 
 		for (stream = 0; stream < dev->n_streams; stream++, i++) {
 			sub = dev->sub_capture[stream];
+			if (dev->input_panic)
+				usb_buf[i] = 0;
+
 			if (sub) {
 				struct snd_pcm_runtime *rt = sub->runtime;
 				char *audio_buf = rt->dma_area;
@@ -398,6 +401,9 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 	if (!dev->streaming)
 		return;
 
+	if (iso->actual_length < dev->bpp)
+		return;
+
 	switch (dev->spec.data_alignment) {
 	case 0:
 		read_in_urb_mode0(dev, urb, iso);
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 5cf841e..8af47c2 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -251,6 +251,8 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev,
 		
 	if (dev->audio_parm_answer != 1) 
 		debug("unable to set the device's audio params\n");
+	else
+		dev->bpp = bpp;
 
 	return dev->audio_parm_answer == 1 ? 0 : -EINVAL;
 }
diff --git a/sound/usb/caiaq/caiaq-device.h b/sound/usb/caiaq/caiaq-device.h
index 4aa8631..1a2a21d 100644
--- a/sound/usb/caiaq/caiaq-device.h
+++ b/sound/usb/caiaq/caiaq-device.h
@@ -92,7 +92,7 @@ struct snd_usb_caiaqdev {
 	int period_out_count[MAX_STREAMS];
 	int input_panic, output_panic, warned;
 	char *audio_in_buf, *audio_out_buf;
-	unsigned int samplerates;
+	unsigned int samplerates, bpp;
 
 	struct snd_pcm_substream *sub_playback[MAX_STREAMS];
 	struct snd_pcm_substream *sub_capture[MAX_STREAMS];
-- 
1.6.2
