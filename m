From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 9/9] ALSA: usx2y: usx2yhwdeppcm: use
	usb_fill_int_urb()
Date: Tue, 19 Jun 2018 23:55:21 +0200
Message-ID: <20180619215521.13688-10-bigeasy@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id AFCBF2675FA
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 23:55:34 +0200 (CEST)
In-Reply-To: <20180619215521.13688-1-bigeasy@linutronix.de>
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
Cc: tglx@linutronix.de, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: alsa-devel@alsa-project.org

Using usb_fill_int_urb() helps to find code which initializes an
URB. A grep for members of the struct (like ->complete) reveal lots
of other things, too.
I'm keeping the transfer-length initialisation in
usX2Y_usbpcm_urbs_start() because I am not certain if this does not
change over time.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/usb/usx2y/usx2yhwdeppcm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 4fd9276b8e50..0a14612f2178 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -325,6 +325,8 @@ static int usX2Y_usbpcm_urbs_allocate(struct snd_usX2Y_substream *subs)
 	/* allocate and initialize data urbs */
 	for (i = 0; i < NRURBS; i++) {
 		struct urb **purb = subs->urb + i;
+		void *buf;
+
 		if (*purb) {
 			usb_kill_urb(*purb);
 			continue;
@@ -334,18 +336,19 @@ static int usX2Y_usbpcm_urbs_allocate(struct snd_usX2Y_substream *subs)
 			usX2Y_usbpcm_urbs_release(subs);
 			return -ENOMEM;
 		}
-		(*purb)->transfer_buffer = is_playback ?
-			subs->usX2Y->hwdep_pcm_shm->playback : (
-				subs->endpoint == 0x8 ?
-				subs->usX2Y->hwdep_pcm_shm->capture0x8 :
-				subs->usX2Y->hwdep_pcm_shm->capture0xA);
+		if (is_playback) {
+			buf = subs->usX2Y->hwdep_pcm_shm->playback;
+		} else {
+			if (subs->endpoint == 0x8)
+				buf = subs->usX2Y->hwdep_pcm_shm->capture0x8;
+			else
+				buf = subs->usX2Y->hwdep_pcm_shm->capture0xA;
+		}
+		usb_fill_int_urb(*purb, dev, pipe, buf,
+				 subs->maxpacksize * nr_of_packs(),
+				 i_usX2Y_usbpcm_subs_startup, subs, 1);
 
-		(*purb)->dev = dev;
-		(*purb)->pipe = pipe;
 		(*purb)->number_of_packets = nr_of_packs();
-		(*purb)->context = subs;
-		(*purb)->interval = 1;
-		(*purb)->complete = i_usX2Y_usbpcm_subs_startup;
 	}
 	return 0;
 }
-- 
2.17.1
