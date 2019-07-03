From: nick83ola <nick83ola@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix Line6 Helix audio
 format rates
Date: Wed, 3 Jul 2019 08:41:00 +0100
Message-ID: <CABPh3UMttE1s7oNt0-JLNm2N3wxb-JXBTLzMYZM42ENiy9NC9Q@mail.gmail.com>
References: <20190702004439.30131-1-nick83ola@gmail.com>
 <s5hlfxg4i4r.wl-tiwai@suse.de>
 <4181a467-5332-c256-5124-513a0343ec70@linux.intel.com>
 <s5ha7dw4egd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EA04F800C5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 09:41:13 +0200 (CEST)
Received: by mail-lf1-x141.google.com with SMTP id b29so1047641lfq.1
 for <alsa-devel@alsa-project.org>; Wed, 03 Jul 2019 00:41:13 -0700 (PDT)
In-Reply-To: <s5ha7dw4egd.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, info@jensverwiebe.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Richard Fontana <rfontana@redhat.com>, "Wasko,
 Michal" <michal.wasko@linux.intel.com>, Jussi Laako <jussi@sonarnerd.net>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

On Tue 2 Jul 2019, 16:57 Takashi Iwai, <tiwai@suse.de> wrote:

> On Tue, 02 Jul 2019 17:52:01 +0200,
> Wasko, Michal wrote:
> >
> > On 7/2/2019 4:37 PM, Takashi Iwai wrote:
> > > On Tue, 02 Jul 2019 02:43:14 +0200,
> > > Nicola Lunghi wrote:
> > >> Line6 Helix and HX stomp don't support retrieving
> > >> the number of clock sample rate.
> > >>
> > >> Add a quirk to return the default value of 48Khz.
> > >>
> > >> Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
> > > It's not particularly good place to put a quirk, but there seems no
> > > other better place, unfortunately.


If you prefer I can add a function to quirk.c

Is this specific to certain unit
> > > or all I/Os on the device suffer from this problem?
>

This is specific to the helix line of line6
There are currently 4 devices in that line that I think shared their
firmware more or less.
Unfortunately I have only one device to test here (but maybe someone else
can add the others)

> >
> > > In anyway, if the behavior is expected, we don't need to use
> > > dev_warn() to annoy users unnecessarily.  Replace it with dev_info().
> > >


Ok


> > Also, the code that creates a single 48k entry would be better to be
> > > put into a function for readability.
> > >
> > > Could you resubmit with that change?
> > >
>

Yes (in quirks.c or here?)

Also I suspect that there' s a way to get the clock rates because windows
driver supports getting the rates and switching (and in Mac the device has
the same problem without a custom driver only supports 48khz)

> >
> > > Thanks!
> > >
> > > Takashi
> >
>

Thank you

> If the listed USB devices do not support sample rate format retrieval
> > then maybe it would be a better idea to perform below check before
> > sending message?
>
> Yes, if we know that it always fails, we don't need to query.
>

Sorry I don't understand this :-)

My idea is that if line6 in the future fixes their code (they are quite
active on the helix line) the call will not fail and we get a proper device
without quirks.
But If the driver fail to get the clock this settings works as a "failsafe"
and get the device working.
I also tried to contact their support but they don't care a lot about Linux
for now :-(

I will clean this better and resubmit
Thank you
Nick

>
> > Have you also considered new function or macro that check device
> > support? This would separate formatfunctionality code from routine
> > that identifies applicable devices- in case if in future more devices
> > will require quirk.
>
> The split can be done later.  It's always hard to know what kind of
> quirk would be needed in future.  If any more devices show the same
> problem, we can reorganize the quirk in a saner way.
>
>
> thanks,
>
> Takashi
>
>
>
>
> >
> > Michal W.
> >
> > >> ---
> > >>   sound/usb/format.c | 28 +++++++++++++++++++++++++---
> > >>   1 file changed, 25 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/sound/usb/format.c b/sound/usb/format.c
> > >> index c02b51a82775..05442f6ada62 100644
> > >> --- a/sound/usb/format.c
> > >> +++ b/sound/usb/format.c
> > >> @@ -313,10 +313,32 @@ static int parse_audio_format_rates_v2v3(struct
> snd_usb_audio *chip,
> > >>                          tmp, sizeof(tmp));
> > >>            if (ret < 0) {
> > >> -          dev_err(&dev->dev,
> > >> -                  "%s(): unable to retrieve number of sample rates
> (clock %d)\n",
> > >> +          switch (chip->usb_id) {
> > >> +          /* LINE 6 HX pedals don't support getting the clock sample
> rate.
> > >> +           * Set the framerate to 48khz by default
> > >> +           */
> > >> +          case USB_ID(0x0E41, 0x4244): /* HELIX */
> > >> +          case USB_ID(0x0E41, 0x4246): /* HX STOMP */
> > >> +                  dev_warn(&dev->dev,
> > >> +                          "%s(): line6 helix: unable to retrieve
> number of sample rates. Set it to default value (clock %d).\n",
> > >>                            __func__, clock);
> > >> -          goto err;
> > >> +                  fp->nr_rates = 1;
> > >> +                  fp->rate_min = 48000;
> > >> +                  fp->rate_max = 48000;
> > >> +                  fp->rates = SNDRV_PCM_RATE_48000;
> > >> +                  fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
> > >> +                  if (!fp->rate_table) {
> > >> +                          ret = -ENOMEM;
> > >> +                          goto err_free;
> > >> +                  }
> > >> +                  fp->rate_table[0] = 48000;
> > >> +                  return 0;
> > >> +          default:
> > >> +                  dev_err(&dev->dev,
> > >> +                          "%s(): unable to retrieve number of sample
> rates (clock %d)\n",
> > >> +                                  __func__, clock);
> > >> +                  goto err;
> > >> +          }
> > >>    }
> > >>            nr_triplets = (tmp[1] << 8) | tmp[0];
> > >> --
> > >> 2.19.1
> > >>
> > >>
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
> >
>
