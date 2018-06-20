From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 8/9] ALSA: usx2y: usbusx2yaudio: use
	usb_fill_int_urb()
Date: Wed, 20 Jun 2018 16:39:22 +0200
Message-ID: <20180620143922.nkcazvbcrmkyvm2c@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-9-bigeasy@linutronix.de>
 <s5hr2l1mxj3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C13C2673CB
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 16:39:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr2l1mxj3.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

On 2018-06-20 14:51:12 [+0200], Takashi Iwai wrote:
> On Tue, 19 Jun 2018 23:55:20 +0200,
> Sebastian Andrzej Siewior wrote:
> > -			(*purb)->transfer_buffer =
> > -				kmalloc_array(subs->maxpacksize,
> > -					      nr_of_packs(), GFP_KERNEL);
> > -			if (NULL == (*purb)->transfer_buffer) {
> > +			len = subs->maxpacksize * nr_of_packs();
> > +			buf = kmalloc(len, GFP_KERNEL);
> 
> I'd keep kmalloc_array() as is, and just put subs->maxpacksize *
> nr_of_packs() in usb_fill_int_urb().  Otherwise it's a step backward.

but then we end up with two multiplications. What about pulling the
overflow-mul macro out of malloc_array() and doing this instead:

----------- >8

Subject: [PATCH 8/9 v2] ALSA: usx2y: usbusx2yaudio: use usb_fill_int_urb()

Using usb_fill_int_urb() helps to find code which initializes an
URB. A grep for members of the struct (like ->complete) reveal lots
of other things, too.

The "&& !(*purb)->transfer_buffer" check has been removed because the
URB has been freshly allocated a few lines above so ->transfer_buffer
has to be NULL here.
The `dev' and `transfer_size' assignments have been moved from
usX2Y_urbs_start() to usX2Y_urbs_allocate() because they don't change
overtime.
The multiplication via check_mul_overflow() has been extracted from
kmalloc_array() to avoid two multiplication (one with overflow check and
one without for the length argument). This requires to change the type
`maxpacksize' to int so there is only one type involved in the
multiplication.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/usb/usx2y/usbusx2y.h      |  2 +-
 sound/usb/usx2y/usbusx2yaudio.c | 38 ++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index e0f77172ce8f..2bec412589b4 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -56,7 +56,7 @@ struct snd_usX2Y_substream {
 	struct snd_pcm_substream *pcm_substream;
 
 	int			endpoint;		
-	unsigned int		maxpacksize;		/* max packet size in bytes */
+	int			maxpacksize;		/* max packet size in bytes */
 
 	atomic_t		state;
 #define state_STOPPED	0
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 2b833054e3b0..e5580cb59858 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -425,33 +425,35 @@ static int usX2Y_urbs_allocate(struct snd_usX2Y_substream *subs)
 	/* allocate and initialize data urbs */
 	for (i = 0; i < NRURBS; i++) {
 		struct urb **purb = subs->urb + i;
+		void *buf = NULL;
+		int len = 0;
+
 		if (*purb) {
 			usb_kill_urb(*purb);
 			continue;
 		}
 		*purb = usb_alloc_urb(nr_of_packs(), GFP_KERNEL);
-		if (NULL == *purb) {
-			usX2Y_urbs_release(subs);
-			return -ENOMEM;
-		}
-		if (!is_playback && !(*purb)->transfer_buffer) {
+		if (NULL == *purb)
+			goto err_free;
+
+		if (!is_playback) {
 			/* allocate a capture buffer per urb */
-			(*purb)->transfer_buffer =
-				kmalloc_array(subs->maxpacksize,
-					      nr_of_packs(), GFP_KERNEL);
-			if (NULL == (*purb)->transfer_buffer) {
-				usX2Y_urbs_release(subs);
-				return -ENOMEM;
-			}
+			if (check_mul_overflow(subs->maxpacksize,
+					       nr_of_packs(),
+					       &len))
+				goto err_free;
+			buf = kmalloc(len, GFP_KERNEL);
+			if (!buf)
+				goto err_free;
 		}
-		(*purb)->dev = dev;
-		(*purb)->pipe = pipe;
+		usb_fill_int_urb(*purb, dev, pipe, buf, len,
+				 i_usX2Y_subs_startup, subs, 1);
 		(*purb)->number_of_packets = nr_of_packs();
-		(*purb)->context = subs;
-		(*purb)->interval = 1;
-		(*purb)->complete = i_usX2Y_subs_startup;
 	}
 	return 0;
+err_free:
+	usX2Y_urbs_release(subs);
+	return -ENOMEM;
 }
 
 static void usX2Y_subs_startup(struct snd_usX2Y_substream *subs)
@@ -485,12 +487,10 @@ static int usX2Y_urbs_start(struct snd_usX2Y_substream *subs)
 			unsigned long pack;
 			if (0 == i)
 				atomic_set(&subs->state, state_STARTING3);
-			urb->dev = usX2Y->dev;
 			for (pack = 0; pack < nr_of_packs(); pack++) {
 				urb->iso_frame_desc[pack].offset = subs->maxpacksize * pack;
 				urb->iso_frame_desc[pack].length = subs->maxpacksize;
 			}
-			urb->transfer_buffer_length = subs->maxpacksize * nr_of_packs(); 
 			if ((err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
 				snd_printk (KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
 				err = -EPIPE;
-- 
2.17.1
