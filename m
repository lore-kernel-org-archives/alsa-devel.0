From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 3 Feb 2010 16:57:18 -0600
Message-ID: <6160a5131002031457h3b6f6ccev4acbd412841b25c8@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
	<6160a5131002011440p52fb1b2dv9d077681544adb8c@mail.gmail.com>
	<alpine.DEB.1.10.1002032005330.3125@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 96824103827
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 23:57:19 +0100 (CET)
Received: by pzk1 with SMTP id 1so426816pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Feb 2010 14:57:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1002032005330.3125@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kai Vehmanen <kvehmanen@eca.cx>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> - the 'only' change is to make sure the hw_ptr reported in .pointer is
>> NOT the number of samples pushed out to the interface. hw_ptr should
>
> although, I'm not entirely sure this still makes rewinds fully safe. After
> driver has called period elapsed and hw_ptr jumps ahead one period worth of
> samples, the DMA for the next burst/batch is already programmed and possibly
> ongoing. And with some drivers the burst size (of a single DMA transaction)
> may be fairly large, while some transfer sample at a time, at codec rate.
>
> This might lead to undefined behaviour when application rewinds upto hw_ptr
> and starts to refill the segment of the ringbuffer just after hw_ptr, while
> at the same time DMA engine is already transferring data out of that same
> ringbuffer segment.
>
> So a safer bet would be to limit rewinds to hw_ptr+X, where X is highly
> driver/hw specific. At the minimum, 'X >= dma_get_cache_alignment()' (see
> linux/Documentation/DMA-API.txt) to get deterministic results on different
> platforms. A sane convervative assumption is 'X >= period-size'.

Well, we went from my interpretation that was completely broken to
something that can still be broken at times...
 If you really want to be safe, you'd need a means to specify this X
value for your system. Actually it would make a lot of sense to do so.
On most embedded systems the DMA bursts and buffering in FIFOs can be
programmed. It'd be nice to have the ability to set different values
for DMA bursts and delay depending on the mode (low-power,
low-latency, etc).
