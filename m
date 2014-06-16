From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [alsa-devel] [PATCH 1/3] sound: Add a quirk to enforce period_bytes
Date: Mon, 16 Jun 2014 16:22:10 -0300
Message-ID: <20140616162210.5d2da8d9.m.chehab@samsung.com>
References: <1402762571-6316-1-git-send-email-m.chehab@samsung.com>
 <1402762571-6316-2-git-send-email-m.chehab@samsung.com>
 <539E9F25.7030504@ladisch.de> <20140616112110.3f509262.m.chehab@samsung.com>
 <539F017C.90408@gmail.com> <20140616132428.78edf63c.m.chehab@samsung.com>
 <539F2652.8030201@gmail.com> <20140616155909.20acc269.m.chehab@samsung.com>
 <CAGoCfiyFu++gpBkz3EZF5zGnD8pdqS-XROh2UWEfzgBnxk2kaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-reply-to: <CAGoCfiyFu++gpBkz3EZF5zGnD8pdqS-XROh2UWEfzgBnxk2kaA@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Devin Heitmueller <dheitmueller@kernellabs.com>
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Em Mon, 16 Jun 2014 15:04:44 -0400
Devin Heitmueller <dheitmueller@kernellabs.com> escreveu:

> >> The official TV playback application, found on the CD with drivers,
> >> captures samples from the card into its buffer, and plays from the other
> >> end of the buffer concurrently. If there are, on average for a few
> >> seconds, too few samples in the buffer, it means that they are consumed
> >> faster than they arrive, and so the SAA chip is told to produce them a
> >> bit faster. If they accumulate too much, the SAA chip is told to produce
> >> them slower. That's it.
> >
> > Ok. Well, xc5000 (with does the audio sampling) doesn't have it, AFAIKT.
> >
> >> >
> >> > The xc5000 tuner used on this TV device doesn't provide any mechanism
> >> > to control audio PLL. It just sends the audio samples to au0828 via a
> >> > I2S bus. All the audio control is done by the USB bridge at au0828,
> >> > and that is pretty much limited. The only control that au0828 accepts
> >> > is the control of the URB buffers (e. g., number of URB packets and
> >> > URB size).
> 
> It's probably worth noting that Mauro's explanation here is incorrect
> - the xc5000 does *not* put out I2S.  It outputs an SIF which is fed
> to the au8522.  The au8522 has the audio decoder, and it's responsible
> for putting out I2S to the au0828.
> 
> Hence the xc5000's PLL would have no role here.
> 

Ah, OK. I didn't notice that hvr950q was using SIF. In this case,
then maybe au8522 may have some PLL fine tune register to adjust the
sampling rate.

> In fact, you should see the exact same behavior on the A/V input,
> since the au8522 is responsible for the I2S clock which drives the
> cs5503 (the 5503 is in slave mode).

I suspect that the best is to use a resampling code to avoid the
frequency drift clock issue, as it is generic enough to cover both
cases, and won't require hardware-assisted support.

Yet, as I posted on my previous email, this is not yet the kind of
bug that we're facing right now. If I'm doing the calculus correct,
a -10Hz difference at a 48 kHz sampling rate would take ~150 seconds
to cause an underrun (a 16 ms period_bytes lost).

Regards,
Mauro
