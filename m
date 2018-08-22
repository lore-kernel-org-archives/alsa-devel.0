From: Prashant Malani <pmalani@chromium.org>
Subject: Re: Suspected heap overflow in
	snd_midi_event_encode_byte()
Date: Wed, 22 Aug 2018 14:32:35 -0700
Message-ID: <CACeCKaeHqkzm1e5dqrLeohUCsze-4kijqNPKwcReef7KU_s0gg@mail.gmail.com>
References: <CACeCKacfLn8FEVU1VK8vBXM11membOOPe_4GAHeX6CAAXzD8Rg@mail.gmail.com>
 <s5hbm9uet3q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 86299267663
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 23:32:37 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id 130-v6so2281076qkd.10
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 14:32:37 -0700 (PDT)
In-Reply-To: <s5hbm9uet3q.wl-tiwai@suse.de>
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
Cc: Mike Frysinger <vapier@chromium.org>, alsa-devel@alsa-project.org, Manoj Gupta <manojgupta@chromium.org>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Thanks Takashi,

I can confirm that this patch fixes the heap overflow issue.
Could you kindly submit this patch into the alsa-lib tree?

Best regards.

On Wed, Aug 22, 2018 at 12:52 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 21 Aug 2018 23:24:14 +0200,
> Prashant Malani wrote:
> >
> > Hi,
> >
> > The Chromium fuzzers detected a potential heap overflow in
> > snd_midi_event_encode_byte() when attempting to encode an invalid data
> > sequence. The potential bug was observed in alsa-lib-1.1.5 (the source
> > seems similar to alsa-lib-1.1.6 so it is likely present there too).
> >
> > Code to reproduce (condensed to fit in an email):
> >
> > std::array<int, 4> arr{ {0x0A, 0x0B, 0x0C, 0x0D} };
> > snd_midi_event_t* encoder;
> > snd_midi_event_new(arr.size(), &encoder);
> > for (int i = 0; i < arr.size(); i++) {
> >   snd_seq_event_t event;
> >   int result = snd_midi_event_encode_byte(encoder, arr[i], &event);
> >   if (result < 0) {
> >     // Log error and return....
> >   }
> >   if ( result == 1) {
> >     // Send the completed message and return.
> >   }
> > }
> > ....
> >
> > The first call to snd_midi_event_encode_byte() using byte 0x0A causes the
> > |encoder->qlen| to underflow and become a large unsigned value, and
> > |encoder->read| to become 2.  Subsequent bytes processed will get written
> > to the |encoder->buf| buffer, with |dev->read| getting incremented after
> > every byte. As a result, by the time we get to byte 0x0D, |encoder->read|
> > is already 4, and this results in a heap overflow (relevant line in
> > alsa-lib is src/seq/seq_midi_event.c:425)
> >
> > I'm not sure if the above input array is a valid input to
> > snd_midi_event_encode_byte(), but I'm guessing we should be doing some
> > error checking to make sure we're not processing
> > incorrect/unexpected/invalid bytes.
> >
> > Any suggestions about how one can submit a fix for this?
>
> Does the patch below help?  The first hunk should suffice for your
> case.  The latter is a similar issue for decoding.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> diff --git a/src/seq/seq_midi_event.c b/src/seq/seq_midi_event.c
> index 2e7d1035442a..5a12a18ce781 100644
> --- a/src/seq/seq_midi_event.c
> +++ b/src/seq/seq_midi_event.c
> @@ -35,7 +35,7 @@
>
>  /* midi status */
>  struct snd_midi_event {
> -       size_t qlen;    /* queue length */
> +       ssize_t qlen;   /* queue length */
>         size_t read;    /* chars read */
>         int type;       /* current event type */
>         unsigned char lastcmd;
> @@ -606,6 +606,8 @@ long snd_midi_event_decode(snd_midi_event_t *dev,
> unsigned char *buf, long count
>                                 status_event[type].decode(ev, xbuf + 0);
>                         qlen = status_event[type].qlen;
>                 }
> +               if (qlen <= 0)
> +                       return 0;
>                 if (count < qlen)
>                         return -ENOMEM;
>                 memcpy(buf, xbuf, qlen);
>
