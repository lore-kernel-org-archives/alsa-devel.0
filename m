From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Audio quality issue - regular clicks are observed
Date: Fri, 24 Aug 2007 21:28:44 +0530
Message-ID: <61445c750708240858i31bc9e53s296c9b6b48065a74@mail.gmail.com>
References: <61445c750708220943k1c410147pa0dddf4d950eb08c@mail.gmail.com>
	<1187813792.16454.39.camel@localhost.localdomain>
	<61445c750708230240r3b3501f6la7b1ef91d28e4e70@mail.gmail.com>
	<61445c750708230738mba23b16ib213c6b337667cd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C4F22417B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Aug 2007 17:58:46 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so996936wag
	for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2007 08:58:45 -0700 (PDT)
In-Reply-To: <61445c750708230738mba23b16ib213c6b337667cd1@mail.gmail.com>
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/23/07, Pharaoh . <pharaoh137@gmail.com> wrote:
>
>
>
> On 8/23/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> >
> >
> >
> > On 8/23/07, Liam Girdwood < lg@opensource.wolfsonmicro.com > wrote:
> > >
> > > On Wed, 2007-08-22 at 22:13 +0530, Pharaoh . wrote:
> > > > Hi
> > > > While testing the audio driver using aplay in blocking mode, a
> > > periodic
> > > > murmur is observed, this increases with
> > > > the audio volume and occurs even when there are no issues like xrun
> > > etc.
> > > > Aplay was used in normal read/write mode
> > > > i.e. no mmap. The song can be heard properly i.e. with no noticable
> > > gaps aur
> > > > hisses but the clicks are audible.
> > >
> > > Clock domain mismatch issues cause periodic ticks that increase in
> > > frequency with increasing sample rate. It's possible your clocking the
> > > codec and controller in two different clock domains. i.e. I2S
> > > controller
> > > (bitclk and frame) clocked from CPU and codec clocked from separate
> > > crystal.
> > >
> > > It's best to make sure that only one clock is clocking both the codec
> > > and digital audio interface.
> > >
> > > Liam
> > >
> > >
> > I tried playing /dev/zero at the same sampling rate as a wav file, but
> > /dev/zero played without any clicks i.e absolutely no sound heard, but
> > while playing a wav file using same parameters clicks occur. I am thinking
> > it is not about clocks mis-match, since I have checked it several times. I
> > was thinking whether junk data is being processed at end of buffer size, but
> > since /dev/zero plays well, I am ruling out that possibility also.
> >
> > What else could explain the latencies at buffer ending as shown in the
> > log in previous mail.
> >
> > -Pharaoh.
> >
> >
> >
> >
> >
> >
> Further debug reveals that the pointer callback is called multiple times
> at the beginning of buffer . Could it be cause of latency? I am playing the
> same .wav file with using aplay with 16K buffer size and 4K period size .
>
> Here is the log, audio_get_dma_pos is my pointer function. In period 0 it
> is called 4 times, while in period 1,2 and 3 it is called only once. Does it
> mean that first time pointer is called it is not getting  correct value and
> it keeps retrying till it gets some sensible value?
>
> [ 1013.037107] current period = 0  current offset = c000
> [ 1013.044950] audio_get_dma_pos
> [ 1013.051770] audio_get_dma_pos
> [ 1013.056944] audio_get_dma_pos
> [ 1013.063780] audio_get_dma_pos
> [ 1013.135178 ] audio_get_dma_pos
> [ 1013.138445] current period = 1  current offset = 0
> [ 1013.236261] audio_get_dma_pos
> [ 1013.239453] current period = 2  current offset = 4000
> [ 1013.337485] audio_get_dma_pos
> [ 1013.340640 ] current period = 3  current offset = 8000
> [ 1013.438684] audio_get_dma_pos
> [ 1013.441886] current period = 0  current offset = c000
> [ 1013.449263] audio_get_dma_pos
> [ 1013.454452] audio_get_dma_pos
> [ 1013.461301 ] audio_get_dma_pos
> [ 1013.466879] audio_get_dma_pos
> [ 1013.539984] audio_get_dma_pos
> [ 1013.543208] current period = 1  current offset = 0
> [ 1013.641070] audio_get_dma_pos
> [ 1013.644283] current period = 2  current offset = 4000
> [ 1013.742383] audio_get_dma_pos
> [ 1013.745553] current period = 3  current offset = 8000
> [ 1013.843631] audio_get_dma_pos
> [ 1013.846833] current period = 0  current offset = c000
> [ 1013.854221] audio_get_dma_pos
> [ 1013.861027] audio_get_dma_pos
> [ 1013.866227] audio_get_dma_pos
> [ 1013.873090] audio_get_dma_pos
> [ 1013.944925] audio_get_dma_pos
> [ 1013.948187] current period = 1  current offset = 0
> [ 1014.045988 ] audio_get_dma_pos
> [ 1014.049177] current period = 2  current offset = 4000
> [ 1014.147209] audio_get_dma_pos
> [ 1014.150370] current period = 3  current offset = 8000
>
>
> -pharaoh.



xrun debug revealed following

ALSA sound/core/pcm_lib.c:209: Unexpected hw_pointer value [1] (stream = 0,
delta: -1024, max jitter = 8192): wrong interrupt acknowledge?

This means that my pointer function is not working correctly.
