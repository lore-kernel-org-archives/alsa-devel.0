From: Philip Spencer <pspencer@fields.utoronto.ca>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Thu, 16 Feb 2012 23:25:09 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1202162248280.21549@fields.fields.utoronto.ca>
References: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
	<4F3DAC41.4000602@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fileserver.fields.utoronto.ca (fileserver.fields.utoronto.ca
	[128.100.216.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 56563244FA
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 05:25:13 +0100 (CET)
In-Reply-To: <4F3DAC41.4000602@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the reply!

>> In our case, the IO buffer is 500ms long, the IO period length is 20ms
>> (for 16KHz Speex soud packets), and the application requests that playback
>> start immediately (by setting the start_threshold software parameter very
>> low).
>
> Hmm, if you want ~20 ms of latency, why have a 500 ms long buffer in the
> first place?

It seems to be hardcoded into Flash Player, not under control of the Flash 
Player app, and Flash Player is closed source so I can't say why for sure 
(I'm merely observing what it does).

However, I imagine the intent is to be reslient against a wide variety of 
network conditions.

If audio arrives in uniformly spaced 20ms packets, then it should be 
rendered with only 20ms latency. But if there's a lot of network 
congestion and high jitter, several hundred ms could arrive at once.
If Flash Player used a short buffer, these audio samples would get lost. 
By using a 500ms buffer, playback is smooth, with only as much latency as 
is necessitated by the network jitter.

So: short buffer, short latency request --> samples get lost if they
                                             arrive with high jitter

      long buffer, long latency request --> long undesired latency

     long buffer, short latency request --> smooth playback always, with
                                            short latency when possible,
                                            longer latency only when
                                            necessitated by high jitter


>> but this does not work: playback STARTS sooner, but when dropouts and
>> underruns occur pulseaudio increases the latency to match the target
>> buffer length.
>
> Just a quick question: Are you saying there is an immediate change from
> 20 to 500 ms at the first underrun, or that things gradually adapts up
> to a stable level?

It's fairly immediate (within the first half-second, anyway).

>> It is necessary to lower the target buffer length too.
>
> I think this part requires more investigation though. First, I'm
> assuming you are talking about underruns between the client and
> PulseAudio, rather than underruns between PulseAudio and the hardware.

I'm actually not entirely sure which is happening. But whichever one it 
is, pulseaudio very quickly adjusts things and pauses playback until the 
buffer fills up to its target length. Perhaps a pulseaudio developer could 
comment on whether that is indeed pulseaudio's intended behaviour.

> Setting a tlength of 500 ms will have PulseAudio believe you intend to
> have latency in the range of 250 - 500 ms, so you're starting with the
> buffer almost empty, and if I understand it correctly, things continue
> that way? This is usually bad and a recipe for underruns. Anyway, this
> is probably why lowering the tlength works for your particular use case.

Yes, it does not seem to be right to set PulseAudio's tlength to 500ms 
just because ALSA's IO buffer is 500ms -- I think ALSA's IO buffer length 
corresponds better to PulseAudio's *maxlength* than to tlength. And the 
PulseAudio docs, though being a little ambiguous on the exact working of 
tlength and prebuf, do recommend setting prebuf to be the same as tlength.

> Note though that I'm sceptic to the tlength part of the patch not mainly
> for philosophical reasons (hey, I want things to just work too!) but
> because I'm afraid it will fix some applications and break others.
> Emulating ALSA over PulseAudio is not easy due to the asynchronous
> nature of PulseAudio (among other things), and applications use and
> expect ALSA to do different things.

The patch will only affect applications which
    (a) Set an explicit start threshold requesting playback to begin
        before the buffer is filled, AND
    (b) Specify a low value for IO period

If an app specifically requests both an early playback start and a small 
IO period, then I think it's reasonable to honour that request and ask 
pulseaudio to maintain low latency.

Your comment, though, about "500 ms tlength means pulseaudio thinks you 
want a latency between 250ms and 500ms" -- if that really is the case, and
tlength=n means pulseaudio thinks latency should be between n/2 and n,
then perhaps it would be safer to only lower tlength to

2 * (larger of start threshold, IO period)

instead of 1 * (larger of start threshold, IO period) as in my patch.

- Philip

--------------------------------------------+-------------------------------
Philip Spencer  pspencer@fields.utoronto.ca | Director of Computing Services
Room 336        (416)-348-9710  ext3036     | The Fields Institute for
222 College St, Toronto ON M5T 3J1 Canada   | Research in Mathematical Sciences
