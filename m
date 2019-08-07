From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: Re: [PATCH v2] ALSA: pcm: fix multiple memory leak bugs
Date: Wed, 7 Aug 2019 03:24:08 -0400
Message-ID: <CAAa=b7d-vxsrzk=B+Qcg1Fp6JgUJ1FOAXbJLU-SL_v-+nKVzaQ@mail.gmail.com>
References: <CAAa=b7dkPm4JqF4_cPwJo_6_aoobr6OyezCb2A9-aAFHNWffeQ@mail.gmail.com>
 <s5hv9v9moir.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hv9v9moir.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>, Wenwen Wang <wenwen@cs.uga.edu>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 7, 2019 at 3:18 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 07 Aug 2019 09:09:59 +0200,
> Wenwen Wang wrote:
> >
> > In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
> > on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'. In
> > hiface_pcm_init_urb(), 'rt->out_urbs[i].buffer' is allocated through
> > kzalloc().  However, if hiface_pcm_init_urb() fails, both 'rt' and
> > 'rt->out_urbs[i].buffer' are not deallocated, leading to memory leak bugs.
> > Also, 'rt->out_urbs[i].buffer' is not deallocated if snd_pcm_new() fails.
> >
> > To fix the above issues, free 'rt' and 'rt->out_urbs[i].buffer'.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  sound/usb/hiface/pcm.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
> > index 14fc1e1..9b132aa 100644
> > --- a/sound/usb/hiface/pcm.c
> > +++ b/sound/usb/hiface/pcm.c
> > @@ -599,12 +599,18 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
> > extra_freq)
> >         for (i = 0; i < PCM_N_URBS; i++) {
> >                 ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
> >                                     hiface_pcm_out_urb_handler);
> > -               if (ret < 0)
> > +               if (ret < 0) {
> > +                       for (; i >= 0; i--)
> > +                               kfree(rt->out_urbs[i].buffer);
> > +                       kfree(rt);
> >                         return ret;
> > +               }
> >         }
> >
> >         ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
> >         if (ret < 0) {
> > +               for (i = 0; i < PCM_N_URBS; i++)
> > +                       kfree(rt->out_urbs[i].buffer);
> >                 kfree(rt);
> >                 dev_err(&chip->dev->dev, "Cannot create pcm instance\n");
> >                 return ret;
>
> The fixes look correct, but since we can unconditionally call kfree()
> for NULL, both error paths can be unified as:
>
>         for (i = 0; i < PCM_N_URBS; i++)
>                 kfree(rt->out_urbs[i].buffer);
>         kfree(rt);
>
> and this would be better to be put in the common path at the end and
> do "goto error" or such from both places.

I will rework the patch and revise the subject line.

> BTW, your patch doesn't seem cleanly applicable in anyway because the
> tabs are converted to spaces.  Please check the mail setup.
>
> Also, please try to make the subject line more unique.  This is about
> hiface driver, so "ALSA: hiface: xxx" should be more appropriate.

I will also check my mail setup. Thanks!

Wenwen
