From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Mon, 8 Feb 2010 09:22:56 +0800
Message-ID: <4f3252891002071722g9055fe4s9602da49e7ab9d83@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
	<6160a5131002011440p52fb1b2dv9d077681544adb8c@mail.gmail.com>
	<alpine.DEB.1.10.1002032005330.3125@ecabase.localdomain>
	<6160a5131002031457h3b6f6ccev4acbd412841b25c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 413B1243C4
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 02:22:58 +0100 (CET)
Received: by pzk1 with SMTP id 1so2586467pzk.16
	for <alsa-devel@alsa-project.org>; Sun, 07 Feb 2010 17:22:57 -0800 (PST)
In-Reply-To: <6160a5131002031457h3b6f6ccev4acbd412841b25c8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/4 pl bossart <bossart.nospam@gmail.com>

> >> - the 'only' change is to make sure the hw_ptr reported in .pointer is
> >> NOT the number of samples pushed out to the interface. hw_ptr should
> >
> > although, I'm not entirely sure this still makes rewinds fully safe.
> After
> > driver has called period elapsed and hw_ptr jumps ahead one period worth
> of
> > samples, the DMA for the next burst/batch is already programmed and
> possibly
> > ongoing. And with some drivers the burst size (of a single DMA
> transaction)
> > may be fairly large, while some transfer sample at a time, at codec rate.
> >
> > This might lead to undefined behaviour when application rewinds upto
> hw_ptr
> > and starts to refill the segment of the ringbuffer just after hw_ptr,
> while
> > at the same time DMA engine is already transferring data out of that same
> > ringbuffer segment.
> >
> > So a safer bet would be to limit rewinds to hw_ptr+X, where X is highly
> > driver/hw specific. At the minimum, 'X >= dma_get_cache_alignment()' (see
> > linux/Documentation/DMA-API.txt) to get deterministic results on
> different
> > platforms. A sane convervative assumption is 'X >= period-size'.
>
> Well, we went from my interpretation that was completely broken to
> something that can still be broken at times...
>  If you really want to be safe, you'd need a means to specify this X
> value for your system. Actually it would make a lot of sense to do so.
> On most embedded systems the DMA bursts and buffering in FIFOs can be
> programmed. It'd be nice to have the ability to set different values
> for DMA bursts and delay depending on the mode (low-power,
> low-latency, etc).
>
>
will your propsed hw_ptr  move when underrun occur ?

>> if  the 'only' change is to make sure the hw_ptr reported in .pointer is
NOT the number of >> samples pushed out to the interface.

>> hw_ptr should really represent the next read position in the ring buffer,
this isn't
>> uniform across drivers. This means for example that the HDAudio
>> implementation needs to modified so that the LPIB value is increased
>> with runtime->delay.
