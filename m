From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Trouble understanding ALSA's DMA buffers
Date: Tue, 12 Jun 2007 21:14:06 +0530
Message-ID: <61445c750706120844i266416d1p8041958ab90b58b5@mail.gmail.com>
References: <466DA941.40309@freescale.com>
	<8d6898730706111329y666c7abdv5b464cbe4e9bb3b@mail.gmail.com>
	<s5hsl8xv4qz.wl%tiwai@suse.de>
	<61445c750706120821p3d98e9a7nfec3754f5067ff82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E2F5103810
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 17:44:08 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1524359nzf
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2007 08:44:07 -0700 (PDT)
In-Reply-To: <61445c750706120821p3d98e9a7nfec3754f5067ff82@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Nobin Mathew <nobin.mathew@gmail.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

I found the following doc, it talks about periods in depth with a figure.

http://delivery.acm.org/10.1145/1020000/1017977/6735.html?key1=1017977&key2=0592661811&coll=GUIDE&dl=GUIDE&CFID=15151515&CFTOKEN=6184618

-pharaoh.

On 6/12/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> On 6/12/07, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > At Tue, 12 Jun 2007 01:59:45 +0530,
> > Nobin Mathew wrote:
> > >
> > > Hi,
> > >
> > > Now ALSA (audio ) buffer is divided into periods, i.e. a chain of small
> > packets.
> > >
> > > periods size is configurable. Data transfer to the codec starts only
> > > after reaching start_threshold point (start_threshold is in periods),
> > > this time DMA trigger is called.
> > >
> > > This trigger onwards application will get notification from the kernel
> > > saying that period buffer is empty you can write into it.Till the end
> > > of music file.
> >
> > Yes.  And the "ping-poing" is the case that you have two periods in a
> > ring buffer.
> >
> > Most hardwares support more periods practically.  That's why "periods"
> > (corresponds to "fragments" in OSS) was introduced, as more generic
> > abstraction.
> >
> >
> > Takashi
> >
> > >
> > > Nobin Mathew
> > >
> > >
> > >
> > > On 6/12/07, Timur Tabi <timur@freescale.com> wrote:
> > > > I'm writing an ALSA SOC driver for an I2S-based device, and I'm having
> > a really hard time
> > > > understanding how ALSA uses the DMA buffers.  And yes, I've read the
> > documentation and
> > > > studied some sample source code.
> > > >
> > > > I used to write audio drivers for a living, but that was many years
> > ago, and it wasn't for
> > > > Linux.  Perhaps the concepts in my head are outdated, but I just don't
> > see enough
> > > > explanation as to how DMA buffers are supposed to work.
> > > >
> > > > Back then, audio drivers used "ping pong" DMA buffers.  A single DMA
> > buffer is allocated,
> > > > and the audio hardware is programmed to read from that buffer in a
> > loop.  That is, it
> > > > would automatically restart reading from the beginning of the buffer
> > without any
> > > > reprogramming.  The hardware would also be programmed to issue an
> > interrupt when it got to
> > > > the end of the buffer, and when it got to the half-way point.
> > > >
> > > > To start playback, you first filled the whole buffer with audio data,
> > and then told the
> > > > hardware to start playing.  After the hardware got to the half-way
> > point, it would issue
> > > > an interrupt.  You would then tell the OS you need more data, and
> > you'd get it.  You then
> > > > copy that data into the first half of the buffer *while* the hardware
> > was playing the
> > > > second half.  Later, the hardware would interrupt you when it got to
> > the end of the
> > > > buffer.  You'd then copy more data to the 2nd half while the hardware
> > is playing the first
> > > > half.
> > > >
> > > > And so - hardware plays one half while you copy data to the other
> > half.  Hence, "ping pong".
> > > >
> > > > So how do I implement this in ALSA?  The "Writing an ALSA Driver"
> > document doesn't even
> > > > contain the words "ping" or "pong".
> > > >
> > > > --
> > > > Timur Tabi
> > > > Linux Kernel Developer @ Freescale
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
>
> Hi
>
> yet another newbie question about periods here:
>
> 1. AFAIK, the period size is closely dependent on the h/w, but after reading
> some docs I collected
> that,  they can be given values depending on how much we care about the
> latency. Does it mean
> that, I can vary it without paying any attention to what h/w manual says
> just because I want low or
> high latency? I hope this question is clear.
>
> 2. As periods correspond to fragment size from OSS world, what the other
> periods related fields
> correspond to i.e. what do the following fields mean?
>
> period_bytes_min,
> period_bytes_max,
> periods_min,
> periods_max,
>
> I know what they mean after looking at them but I want to know the
> relationship between various
> fields.
>
> For e.g.
>
> I have,
>
> buffer_bytes_max = 8192 * 8
> i.e. = AUDIO_FRAGSIZE_DEFAULT * AUDIO_NBFRAGS_DEFAULT
>
> here AUDIO_FRAGSIZE_DEFAULT is size of period right? Then to get the max
> buffer size we should multiply it
> by number of periods, is this correct? Also, these are default values of the
> period and no of periods, then do
> I need to see the h/w manual to decide the periods_min/periods_max and
> period_bytes_min/period_bytes_max
> fields?
>
