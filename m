From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: Re: [PATCH] ALSA: pcm: fix a memory leak bug
Date: Wed, 7 Aug 2019 02:35:49 -0400
Message-ID: <CAAa=b7fRWjusR8y8DZze7NOW+P4w0O-HLK+5fcpZV8mcTeV37w@mail.gmail.com>
References: <CAAa=b7ffFNc4zuQfXEwsS363=kX_ZOx0+jhg4WM3JQ-d7n-LMA@mail.gmail.com>
 <s5h8ss5o569.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h8ss5o569.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>, Wenwen Wang <wenwen@cs.uga.edu>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 7, 2019 at 2:33 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 07 Aug 2019 08:15:17 +0200,
> Wenwen Wang wrote:
> >
> > In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
> > on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'.
> > However, if the initialization fails, 'rt' is not deallocated, leading to a
> > memory leak bug.
> >
> > To fix the above issue, free 'rt' before returning the error.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  sound/usb/hiface/pcm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
> > index 14fc1e1..5dbcd0d 100644
> > --- a/sound/usb/hiface/pcm.c
> > +++ b/sound/usb/hiface/pcm.c
> > @@ -599,8 +599,10 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
> > extra_freq)
> >         for (i = 0; i < PCM_N_URBS; i++) {
> >                 ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
> >                                     hiface_pcm_out_urb_handler);
> > -               if (ret < 0)
> > +               if (ret < 0) {
> > +                       kfree(rt);
> >                         return ret;
> > +               }
>
> Unfortunately this still leaves some memory.  We need to release
> rt->out_urbs[], too.  The relevant code is already in
> hiface_pcm_destroy(), so factor out the looped kfree() there and call
> it from both places.
>
> Care to resubmit with more fixes?

Thanks for your comments! I also found this issue, and am working on
another patch to fix it.

Wenwen
