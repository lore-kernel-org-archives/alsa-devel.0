From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Buffer size/periods (Layla3G)
Date: Sun, 16 Mar 2008 22:12:39 +0000
Message-ID: <20080316221239.ae934fe4.pochini@shiny.it>
References: <alpine.BSO.1.00.0803161126500.28063@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out112.alice.it (smtp-out112.alice.it [85.37.17.112])
	by alsa0.perex.cz (Postfix) with ESMTP id A24B224694
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 22:10:41 +0100 (CET)
In-Reply-To: <alpine.BSO.1.00.0803161126500.28063@metheny.ijneb.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@pogo.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 16 Mar 2008 12:02:58 +0000 (GMT)
Mark Hills <mark@pogo.org.uk> wrote:

> Hello,
>
> I am investigating problems I'm having with recording over long periods.
> I'm using a Layla3G and tested various ALSA versions including 1.0.14 and
> 1.0.16 on different machines.
>
> I've noticed that when I open the first pair of subdevices, my request for
> 1000ms buffer size is handled differently to other devices:
>
>    $ ./test_buffers "hw:Layla3G,0,0" 1000
>    buffer_size=16384 period_size=128
>
>    $ ./test_buffers "hw:Layla3G,0,2" 1000
>    buffer_size=32768 period_size=256

This is caused by the preallocation policy I applied. Since those cards
have a lot of channels I though it is a waste of non-swappable
kernel memory to preallocate memory for each one. So the driver preallocates
128KiB for the first two channels of each device only, which are by far the
most used ones (see echoaudio.c::snd_echo_preallocate_pages()). ALSA does
not allow apps to use buffers bigger than the preallocated memory. In your
test: buffer_size=16384*2 channels*4 bytes/channel = 128KiB.

For channels >=2 the memory hasn't been preallocated, thus it is allocated
upon request. Its limit is 256KiB (see echo3g.c), so your test program gets
proportionally longer buffers.

You can set the amount of preallocated memory from userspace by writing
into the files listed by:

find /proc/asound/ -name prealloc\*


> If I try other buffer sizes, I can see is a limit to buffer size of 16384
> samples on the ,0 subdevice, which is also affecting the chosen period
> size. But only on the first subdevice. Is there a reason, or is this a
> bug?

All periods must have the same length and, on Echoaudio cards, it must be a
multiple of 32. ALSA computes the nearest buffer length to the requested
value and chooses the period length as it prefers because your program
doesn't set it.


> Also, there seem to be failures at certain buffer sizes:
>
>    $ ./test_buffers "hw:Layla3G,0,2" 429
>    buffer_size=18912 period_size=96
>
>    $ ./test_buffers "hw:Layla3G,0,2" 430
>    set_buffer_time_near: Invalid argument
>
>    $ ./test_buffers "hw:Layla3G,0,2" 431
>    buffer_size=19008 period_size=96

This shouldn't happen. I'll give it a look.


> The overall problem I'm investigating is snd_pcm_readi() returning
> incomplete buffers after running for long periods until another
> snd_pcm_prepare(). It seems possible that this is related.

I don't think so. Btw I never really tried to record for long periods. It
may depend on the fact that the DMA counter has a limit of 4GiB and then it
overflows, but the driver should handle it nicely. Do you know after how
many bytes of audio data it fails ?



--
Giuliano.
