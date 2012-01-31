From: public-hk <public-hk@ind.rwth-aachen.de>
Subject: Re: Some questions related to ALSA based duplex audio
 processing
Date: Tue, 31 Jan 2012 12:39:55 +0100
Message-ID: <4F27D30B.6010607@ind.rwth-aachen.de>
References: <4F259BD1.4030001@ind.rwth-aachen.de> <4F27C51F.1000202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-2.ms.rz.rwth-aachen.de (mta-2.ms.rz.RWTH-Aachen.DE
	[134.130.7.73]) by alsa0.perex.cz (Postfix) with ESMTP id 6B65B103A6A
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 12:39:54 +0100 (CET)
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.186])
	by mta-2.ms.rz.RWTH-Aachen.de
	(Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
	with ESMTP id <0LYN0066IV2IGH30@mta-2.ms.rz.RWTH-Aachen.de> for
	alsa-devel@alsa-project.org; Tue, 31 Jan 2012 12:39:54 +0100 (CET)
In-reply-to: <4F27C51F.1000202@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
thank you very much for your comments!

>> So, here is what I did on my Ubuntu laptop:
>>
>> 1) Setup of device/soundcard "hw:0,0" for processing at a samplerate of 44.1 kHz, buffersize 128 samples.
> Please note that not every hardware might support these specific
> parameters.
>
Yes, in the future, I will use the core functionality of audio 
processing within a GUI based application so that other devices with 
different setups have to be setup by the user.
>> 2) I created one input PCM device and one output PCM device handle
>> 3) I use the function "snd_async_add_pcm_handler" to install a callback function (ASYNC mode), one for input,
>> one for output.
>> 4) I use "snd_pcm_link" to synchronize both pcm handles.
>> 5) I use the mmap'ed area access
>>
>> My motivation to work the way I do is to maximize the control of processing behavior and to
>> minimize the latency. E.g., I have understood from the docs that the snd_pcm_read/snd_pcm_write
>> functions do nothing else than addressing the memory mapped areas. As a conclusion, I realize
>> this access myself to have more control about it.
> Why do you want to duplicate snd_pcm_read/write?  What do you "control"
> there, i.e., what are you doing differently?
>
The additional degree of freedom is that I see the amount of samples 
which are available in the mmap'ed buffer whereas with read and write, I 
only get the notification that
a specific amount of samples has been available (based on the number of 
samples to be read/written specified when calling the function).
I had the feeling that I can react in a more flexible way using mmap'ed 
buffers.
>> And by using the async callbacks, I do not have to deal with blocking or non-blocking read functions or polling related issues.
> But instead you have to deal with signal delivery.  Besides being
> nonportable, you are not allowed to do anything useful inside a signal
> handler.
>
Why is this nonportable? The sound APIs that I dealt with before more or 
less by definition work based on callback mechanisms (ASIO, CoreAudio).
What is the restriction considering the processing that I plan within 
the signal handler? Is that a documented restriction? My understanding 
is that
unless my code is too slow to be in time for the next delivery,  there 
should be no problem.

A possible alternative realization would be to start a thread in which I do
1) pcm_read
2) process audio samples
3) pcm_write
in an infinite loop. In this case, however, the "read" would also block 
the "write" for a specific
time. This architecture would
a) introduce additional delay if I miss the next required "write" due to 
the blocking "read".
b) might reduce the available processing time (operation "process audio 
samples")  since I have "wasted" time in the blocking "read".

And using two distinct threads for input and output, one looping over 
"pcm_read" and the other looping over
"process audio samples" followed by "pcm_write" would be a third option. 
This, however, would not be so different from my approach but would increase
the programming effort from my point of view (effort to start threads).

>
>
>> c) The function "snd_pcm_info_get_sync" is supposed to return a description of the synchronization
>> behavior of a soundcard. In my case, I called this function for two soundcards (one USB and the laptop integrated soundcard).
>> In both cases, the returned content is all zeros. Should not this be different for both devices?
> These functions return useful values only if snd_pcm_hw_params_can_sync_start().
>
Ah, ok, I will test that.

>> d) By default, it seems that the callbacks for audio frames come within a thread with normal priority.
> Please don't mix signals and threads.
>
Maybe I should be more precise at this point: I assume that the 
asynchronous callback handler functions are triggered repeatedly from 
within one thread
which is started by the ALSA Lib on processing startup (that is: one 
thread for input callbacks, one for output callbacks). I would want to 
raise the
priority of these two threads. Maybe my assumption is wrong?

>
>
>> However, what does this means for audio processing on the frame
>> level: If I use two callbacks for signal processing for input and output
>> respectively installed based on the
>> function "snd_async_add_pcm_handler", will these callbacks occur
>> simultaneously?
> This depends.  If both buffers are configured with the same parameters,
> and if both devices run from the same sample clock, then both devices
> should be ready at approximately the same time.  (A playback device
> needs to fill it FIFO before playing these samples, while a capture
> device needs to write its FIFO to memory after recording the samples,
> so you could expect the capture notification to be a little bit later,
> unless the hardware specifically avoids this.)
>
> I have no clue how two simultaneous signals behave.  You should use
> poll() so that you can wait for both devices being ready.
>
>
So, the conclusion is that it is not really defined and I have to deal 
with synchronization of
input and output myself, is that the right interpretation?

Thank you again and best regards

HK
