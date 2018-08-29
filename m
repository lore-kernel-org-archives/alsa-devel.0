From: Prashant Malani <pmalani@chromium.org>
Subject: Re: Suspected heap overflow in
	snd_midi_event_encode_byte()
Date: Tue, 28 Aug 2018 21:57:10 -0700
Message-ID: <CACeCKafHtdRePYeqiwjosLSuvuZx=0=BQVquEZvhZPmUHKJZLA@mail.gmail.com>
References: <CACeCKacfLn8FEVU1VK8vBXM11membOOPe_4GAHeX6CAAXzD8Rg@mail.gmail.com>
 <s5hbm9uet3q.wl-tiwai@suse.de>
 <CACeCKaeHqkzm1e5dqrLeohUCsze-4kijqNPKwcReef7KU_s0gg@mail.gmail.com>
 <s5hbm9td1h4.wl-tiwai@suse.de>
 <CACeCKacyN7R3hq-8=p_QkZiX0WUWTTdQJkW3XbvS-o-x1ZLvJg@mail.gmail.com>
 <s5ha7p87zvd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 3629926781F
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 06:57:12 +0200 (CEST)
Received: by mail-qk0-f182.google.com with SMTP id c126-v6so2570412qkd.7
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 21:57:12 -0700 (PDT)
In-Reply-To: <s5ha7p87zvd.wl-tiwai@suse.de>
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
Cc: Dylan Reid <dgreid@chromium.org>, Mike Frysinger <vapier@chromium.org>, Manoj Gupta <manojgupta@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Got it. Thanks!

On Mon, Aug 27, 2018 at 5:33 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Thu, 23 Aug 2018 22:41:15 +0200,
> Prashant Malani wrote:
> >
> > Thanks.
> >
> > Curious to know: Whats the URL for alsa-lib git tree? I'd love to be able
> > to check it out.
>
> You can get it from git.alsa-project.org
>
>
> Takashi
>
> >
> > On Wed, Aug 22, 2018 at 11:46 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > On Wed, 22 Aug 2018 23:32:35 +0200,
> > > Prashant Malani wrote:
> > > >
> > > > Thanks Takashi,
> > > >
> > > > I can confirm that this patch fixes the heap overflow issue.
> > > > Could you kindly submit this patch into the alsa-lib tree?
> > >
> > > Now applied the following patch to git tree.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > -- 8< --
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Subject: [PATCH] seq: Fix signedness in MIDI encoder/decoder
> > >
> > > The qlen field of struct snd_midi_event was declared as size_t while
> > > status_events[] assigns the qlen to -1 indicating to skip.  This leads
> > > to the misinterpretation since size_t is unsigned, hence it passes the
> > > check "dev.qlen > 0" incorrectly in snd_midi_event_encode_byte(),
> > > which eventually results in a memory corruption.
> > >
> > > Also, snd_midi_event_decode() doesn't consider about a negative qlen
> > > value and tries to copy the size as is.
> > >
> > > This patch fixes these issues: the first one is addressed by simply
> > > replacing size_t with ssize_t in snd_midi_event struct.  For the
> > > latter, a check "qlen <= 0" is added to bail out; this is also good as
> > > a slight optimization.
> > >
> > > Reported-by: Prashant Malani <pmalani@chromium.org>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  src/seq/seq_midi_event.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/src/seq/seq_midi_event.c b/src/seq/seq_midi_event.c
> > > index 2e7d1035442a..5a12a18ce781 100644
> > > --- a/src/seq/seq_midi_event.c
> > > +++ b/src/seq/seq_midi_event.c
> > > @@ -35,7 +35,7 @@
> > >
> > >  /* midi status */
> > >  struct snd_midi_event {
> > > -       size_t qlen;    /* queue length */
> > > +       ssize_t qlen;   /* queue length */
> > >         size_t read;    /* chars read */
> > >         int type;       /* current event type */
> > >         unsigned char lastcmd;
> > > @@ -606,6 +606,8 @@ long snd_midi_event_decode(snd_midi_event_t *dev,
> > > unsigned char *buf, long count
> > >                                 status_event[type].decode(ev, xbuf +
> 0);
> > >                         qlen = status_event[type].qlen;
> > >                 }
> > > +               if (qlen <= 0)
> > > +                       return 0;
> > >                 if (count < qlen)
> > >                         return -ENOMEM;
> > >                 memcpy(buf, xbuf, qlen);
> > > --
> > > 2.18.0
> > >
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
