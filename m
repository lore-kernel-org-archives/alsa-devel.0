From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some questions related to ALSA based duplex audio
 processing
Date: Tue, 31 Jan 2012 11:40:31 +0100
Message-ID: <4F27C51F.1000202@ladisch.de>
References: <4F259BD1.4030001@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E53C01038F3
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 11:38:16 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 93C54207CE
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 05:38:12 -0500 (EST)
In-Reply-To: <4F259BD1.4030001@ind.rwth-aachen.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: public-hk <public-hk@ind.rwth-aachen.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

public-hk wrote:
> So, here is what I did on my Ubuntu laptop:
>
> 1) Setup of device/soundcard "hw:0,0" for processing at a samplerate of 44.1 kHz, buffersize 128 samples.

Please note that not every hardware might support these specific
parameters.

> 2) I created one input PCM device and one output PCM device handle
> 3) I use the function "snd_async_add_pcm_handler" to install a callback function (ASYNC mode), one for input,
> one for output.
> 4) I use "snd_pcm_link" to synchronize both pcm handles.
> 5) I use the mmap'ed area access
>
> My motivation to work the way I do is to maximize the control of processing behavior and to
> minimize the latency. E.g., I have understood from the docs that the snd_pcm_read/snd_pcm_write
> functions do nothing else than addressing the memory mapped areas. As a conclusion, I realize
> this access myself to have more control about it.

Why do you want to duplicate snd_pcm_read/write?  What do you "control"
there, i.e., what are you doing differently?

> And by using the async callbacks, I do not have to deal with blocking or non-blocking read functions or polling related issues.

But instead you have to deal with signal delivery.  Besides being
nonportable, you are not allowed to do anything useful inside a signal
handler.

> a) What is the most efficient way to realize duplex audio processing, the async way with mmap'ed read/write that I follow?

There isn't much difference in efficiency.  If you count programmer time,
these choices are the worst.

> c) The function "snd_pcm_info_get_sync" is supposed to return a description of the synchronization
> behavior of a soundcard. In my case, I called this function for two soundcards (one USB and the laptop integrated soundcard).
> In both cases, the returned content is all zeros. Should not this be different for both devices?

These functions return useful values only if snd_pcm_hw_params_can_sync_start().

> d) By default, it seems that the callbacks for audio frames come within a thread with normal priority.

Please don't mix signals and threads.

> What is the recommended way in Linux to achieve lower latencies?

Use a small buffer size.  Anything else doesn't really matter.

> I) If linking input and output with "snd_pcm_link", I have understood
> that the changes of state for input and
> output PCM handle will occur synchronously. That is, when doing the
> operation such as "snd_pcm_prepare" on one
> of the handles, both handles will be affected.

And if the hardware doesn't have special hardware support, ALSA will
just call both devices' start function one after the other.

> However, what does this means for audio processing on the frame
> level: If I use two callbacks for signal processing for input and output
> respectively installed based on the
> function "snd_async_add_pcm_handler", will these callbacks occur
> simultaneously?

This depends.  If both buffers are configured with the same parameters,
and if both devices run from the same sample clock, then both devices
should be ready at approximately the same time.  (A playback device
needs to fill it FIFO before playing these samples, while a capture
device needs to write its FIFO to memory after recording the samples,
so you could expect the capture notification to be a little bit later,
unless the hardware specifically avoids this.)

I have no clue how two simultaneous signals behave.  You should use
poll() so that you can wait for both devices being ready.


Regards,
Clemens
