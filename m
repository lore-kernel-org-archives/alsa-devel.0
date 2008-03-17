From: Mark Hills <mark@pogo.org.uk>
Subject: Re: Buffer size/periods (Layla3G)
Date: Mon, 17 Mar 2008 00:21:06 +0000 (GMT)
Message-ID: <alpine.BSO.1.00.0803170005350.3035@metheny.ijneb.com>
References: <alpine.BSO.1.00.0803161126500.28063@metheny.ijneb.com>
	<20080316221239.ae934fe4.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id EBF18103817
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 01:21:06 +0100 (CET)
In-Reply-To: <20080316221239.ae934fe4.pochini@shiny.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Guiliano,

Thanks for the quick reply.

On Sun, 16 Mar 2008, Giuliano Pochini wrote:

> This is caused by the preallocation policy I applied. Since those cards 
> have a lot of channels I though it is a waste of non-swappable kernel 
> memory to preallocate memory for each one. So the driver preallocates 
> 128KiB for the first two channels of each device only, which are by far 
> the most used ones (see echoaudio.c::snd_echo_preallocate_pages()). ALSA 
> does not allow apps to use buffers bigger than the preallocated memory. 
> In your test: buffer_size=16384*2 channels*4 bytes/channel = 128KiB.
>
> For channels >=2 the memory hasn't been preallocated, thus it is 
> allocated upon request. Its limit is 256KiB (see echo3g.c), so your test 
> program gets proportionally longer buffers.

Thanks for the explanation. I'm glad that there is good reason and that 
it's not a bug.

>> If I try other buffer sizes, I can see is a limit to buffer size of 
>> 16384 samples on the ,0 subdevice, which is also affecting the chosen 
>> period size. But only on the first subdevice. Is there a reason, or is 
>> this a bug?
>
> All periods must have the same length and, on Echoaudio cards, it must 
> be a multiple of 32. ALSA computes the nearest buffer length to the 
> requested value and chooses the period length as it prefers because your 
> program doesn't set it.

When I do set it in my program, it is using the requested size in all 
cases. So I've found the period size to be working fine.

>> Also, there seem to be failures at certain buffer sizes:
>>
>>    $ ./test_buffers "hw:Layla3G,0,2" 429
>>    buffer_size=18912 period_size=96
>>
>>    $ ./test_buffers "hw:Layla3G,0,2" 430
>>    set_buffer_time_near: Invalid argument
>>
>>    $ ./test_buffers "hw:Layla3G,0,2" 431
>>    buffer_size=19008 period_size=96
>
> This shouldn't happen. I'll give it a look.

Thanks! I can do any testing you might need -- at the moment I have access 
to two Layla cards in different machines. I've had similar problems 
previously with allocating a buffer of 256 frames, but these problems 
mysteriously disappeared before I was able to produce a meaningful bug 
report, so perhaps they are intermittent.

>> The overall problem I'm investigating is snd_pcm_readi() returning 
>> incomplete buffers after running for long periods until another 
>> snd_pcm_prepare(). It seems possible that this is related.
>
> I don't think so. Btw I never really tried to record for long periods. 
> It may depend on the fact that the DMA counter has a limit of 4GiB and 
> then it overflows, but the driver should handle it nicely. Do you know 
> after how many bytes of audio data it fails ?

I don't, but I've noticed the problems take days to show themselves which 
is a lot larger than 4Gb. I'll do some more detailed investigation and let 
you know.

Thanks for the help, it's greatly appreciated.

Mark
