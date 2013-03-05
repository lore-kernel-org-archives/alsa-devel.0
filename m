From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH v2] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Tue, 5 Mar 2013 11:26:16 +0100
Message-ID: <20130305102616.GB20417@pvv.ntnu.no>
References: <20130304223937.GI4452@pvv.ntnu.no>
 <CAOf5uwmf4L0bonZ=gJD+NkTpBY5=gL20JnVCfAP-AGskWo_Fkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1834426520A
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 11:26:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOf5uwmf4L0bonZ=gJD+NkTpBY5=gL20JnVCfAP-AGskWo_Fkg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 05, 2013 at 07:02:58AM +0100, Michael Trimarchi wrote:
> Hi
> 
> Some comments:
> 
> On 4 Mar 2013 23:40, "Torstein Hegge" <hegge@resisty.net> wrote:
> >
> > The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
> > sample rate while the interface is active.
> >
> > Reset the interface after setting the sampling frequency on sample rate
> > changes, to ensure that the sample rate set by snd_usb_init_sample_rate()
> is
> > used. Otherwise, the device will try to use the sample rate of the
> previous
> > stream, causing distorted sound on sample rate changes.
> >
> > Signed-off-by: Torstein Hegge <hegge@resisty.net>
> > ---
> >  sound/usb/clock.c |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> > index 5e634a2..d12a9c4 100644
> > --- a/sound/usb/clock.c
> > +++ b/sound/usb/clock.c
> > @@ -255,6 +255,7 @@ static int set_sample_rate_v2(struct snd_usb_audio
> *chip, int iface,
> >         unsigned char data[4];
> >         int err, crate;
> >         int clock = snd_usb_clock_find_source(chip, fmt->clock);
> > +       unsigned int previous_rate;
> >
> 
> crate and previous_rate are different types.
> Why don't call it prate or change both name?

How about int cur_rate, prev_rate; ?

> >         if (clock < 0)
> >                 return clock;
> > @@ -266,6 +267,18 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
> >                 return -ENXIO;
> >         }
> >
> > +       if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
> 
> Is it more clear to assign it and then test?

I agree that separate assign and test would be more readable, but this
is consistent with the four other calls to snd_usb_ctl_msg() in clock.c.

Torstein
