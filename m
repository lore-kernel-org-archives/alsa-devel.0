From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Improving wine support for alsa.
Date: Fri, 07 May 2004 12:35:11 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <409B827F.30102@superbug.demon.co.uk>
References: <200405070149.i471nV1F021337@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA29706
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 14:33:26 +0200
In-Reply-To: <200405070149.i471nV1F021337@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>Kernel people: is poll() less effective than using SND_PCM_ASYNC and a
>>signal handler for low-latency sound?  I'm guessing it is, but there
> 
> 
> at the risk of endlessly repeating myself, SIGIO is basically
> useless. your handler executes in signal-handling context, and can do
> very, very little. not even all system calls are legal in this context.
> SIGIO is basically a "poor man's thread system", and not much more.
> 
> also, poll wakes a task quicker than a signal. this is easy to
> establish empirically. from a theoretical perspective, signal handling
> is a much more complex situation that simply continuing on with
> whatever function was blocked.
> 
> --p
> 

According to the alsa documentation, SND_PCM_ASYNC handlers use SIGIO.
It is just as easy for me to create a thread and do poll, so I could do 
that.

I think the best approach will probably be to re-write the wine 
DirectSound routines, so that when they wish to write to a particular 
place in the sound buffer, they do a call to the alsa driver to do the 
actual positioning of the write pointer (snd_pcm_rewind/forward), 
followed by a write.
All I then do is turn off XRUN detection on the hardware buffer and let 
it freerun. "snd_pcm_sw_params_set_stop_threshold(pcm, sw_params, -1 )" 
turns off xruns.
Maybe I won't get that information from directsound.

I might need to find out how to control when the poll() returns.
If the period size is 1000, It would be nice if I could get it to return 
at say sample 800, so the mmap copying can happen just in time, before 
the DAC reaches the next period. This would give me sub-period latency, 
but I doubt that will work due to scheduling latencies etc.

I probably have to initially write 2 periods to the buffer, so that when 
the poll() returns, I will be writing to period 3, when the DAC is just 
reaching the start of period 2.
Due to scheduling latencies, I think I will write 2 periods on each 
poll() and then do a period rewind, so that if there is a scheduling 
latency, the sound card will be playing fairly accurate samples.

I just wish DirectSound would be able to tell us if it has changed the 
sound buffer at all. I hope this will be possible. It might not if the 
application does memcopies directly into the sound buffer without 
telling direct sound what it did.
If I can get Direct Sound to tell us when it writes to the sound buffer 
and what it changes, I could get the poll() to only memcpy the sections 
of the buffer that Direct Sound changes.

The way DirectSound works, is it calles "GetPosition" evert 10ms and 
gets returned 2 pointers.
1) Playback Position (The Sample currently at the speakers, or more 
accurately, in the DAC.)
2) Write Position. (The sample with the lowest latency that DirectSound 
could still re-write to now and it would reach the speakers.)
Normally this equals the start of the next period's position.

These pointers are pointers into the ring buffer using an offset from 
the beginning of the ring buffer.

I just hope the application tells direct sound what it is doing with the 
ring buffer.  I will just have to investigate more.

I have already found out that Direct Sound tries to do multi open on the 
sound card, so we will be having multiple channels to mmap copy over on 
each poll if we use a sound card that handles multiopen. This could 
start to get quite complicated. :-)

Summary: -
I think I will work on the simple poll() approach first, instead of 
SND_PCM_ASYNC, with it outputting one period at a time.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
