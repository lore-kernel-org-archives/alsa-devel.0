From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/9] ALSA: hiface: Add sanity checks for
	invalid EPs
Date: Tue, 10 Oct 2017 15:38:17 +0200
Message-ID: <20171010133819.10567-8-tiwai@suse.de>
References: <20171010133819.10567-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BF59266DE2
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 15:38:22 +0200 (CEST)
In-Reply-To: <20171010133819.10567-1-tiwai@suse.de>
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
Cc: Andrey Konovalov <andreyknvl@google.com>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

hiface usb-audio driver sets up URBs containing the fixed endpoints
without validation.  This may end up with an oops-like kernel warning
when submitted.

For avoiding it, this patch adds the calls of the new sanity-check
helper for URBs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/hiface/pcm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 175d8d6b7f59..396c317115b1 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -541,6 +541,8 @@ static int hiface_pcm_init_urb(struct pcm_urb *urb,
 	usb_fill_bulk_urb(&urb->instance, chip->dev,
 			  usb_sndbulkpipe(chip->dev, ep), (void *)urb->buffer,
 			  PCM_PACKET_SIZE, handler, urb);
+	if (usb_urb_ep_type_check(&urb->instance))
+		return -EINVAL;
 	init_usb_anchor(&urb->submitted);
 
 	return 0;
@@ -599,9 +601,12 @@ int hiface_pcm_init(struct hiface_chip *chip, u8 extra_freq)
 	mutex_init(&rt->stream_mutex);
 	spin_lock_init(&rt->playback.lock);
 
-	for (i = 0; i < PCM_N_URBS; i++)
-		hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
+	for (i = 0; i < PCM_N_URBS; i++) {
+		ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
 				    hiface_pcm_out_urb_handler);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
 	if (ret < 0) {
-- 
2.14.2
