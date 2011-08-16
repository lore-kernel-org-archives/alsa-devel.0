From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to pair Wine with ALSA? part2: buffer&period
 size / blocking / mmap (long)
Date: Tue, 16 Aug 2011 09:16:14 +0200
Message-ID: <4E4A193E.9030601@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB4724E@HE113481.emea1.cds.t-internal.com>	<4E47BE26.7060705@ladisch.de>
	<8E4C156DA5797D418DBFADFD8CE655A41392BAD31D@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 73261245F1
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 09:16:17 +0200 (CEST)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A41392BAD31D@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
> Clemens Ladisch wrote:
> >This was designed for hardware that is reprogrammed after each buffer
> >anyway (ISA DMA) or that allows dynamic buffers (e.g. ICH AC'97, which
> >was designed for WinMM).
> 
> You mean that HW can be told: "play N1 frames at address X1, to be
> followed without glitch with N2 frames at address X2"?  And
> afterwards, "after you'll be done with X2, play N3 at address X3"?

Yes.

> >Can't you hand out a pointer to ALSA's buffer?
> 
> I am not aware of any way outside snd_pcm_mmap_begin to obtain a
> pointer from ALSA.

Well, you could hand out that pointer.

>>What exactly gets optimized with mmap?  Please note that snd_pcm_write*
>>copies the data from the supplied buffer into ALSA's buffer; if your
>>code does the same, it is not the slightest bit faster.
> 
> I'm not sure I understand what you mean.

In practice, almost every program ends up with a function like this:

my_pcm_write(buffer, count)
{
	snd_pcm_mmap_begin();
	memcpy(mmap_buffer, buffer, count);
	/* and handle wraparound */
	snd_pcm_mmap_commit();
}

This would be no optimization over snd_pcm_writei().

> What's expected to happen in Wine without mmap is:
> 1. app copies/writes data into Wine-managed GetBuffer pool
> 1.b because of ring-buffer management, there's even a little
>     more copying in case of wrap-around.
> 2. ALSA pcm_write* copies from Wine's pool into HW buffer.
> 
> The optimization is:
> 0. app gets pointer from Wine's GetBuffer, which
>    in turn gets it from ALSA's snd_pcm_mmap_begin.
> 1. app copies/writes data into ALSA's HW buffer.

That would indeed be an optimization.

> I'm not sure PA or dmix support mmap.

There are devices that don't have 'real' memory.  However, the default
device then uses the "plug" plugin that supports mmap emulation (with
a timer that then writes data with the normal write call).

>  - How is waveOutGetPosition defined in the presence of huge
>    latencies, i.e. is it implicitly based on a ~0 latency assumption?
>  - When are buffers submitted to waveOutWrite returned to the app?
>    a) After the front-end processed them (sent them to the next stage)?
>    b) After the back-end (speaker) played the last sample in it?
>    The difference matters only as non-zero latencies are introduced into
>    the audio chain, i.e. with networking, USB or simply PA's 2s buffers.

In the bad old times, there was not software processing, buffers were
returned immediately after the hardware was finished with them, and
there was no significant latency.

> >You can call nonblock(0) immediately after open.
> >But if your code never actually blocks, why bother to set it?
> 
> Somebody reported and I've verified that snd_pcm_drain would always
> fail (with -11 IIRC) in non-blocking mode.

Well, if you do want to block, you indeed need blocking mode.  :)


Regards,
Clemens
