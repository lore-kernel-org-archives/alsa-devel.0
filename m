From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Fri, 17 Feb 2012 02:24:17 +0100
Message-ID: <4F3DAC41.4000602@canonical.com>
References: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 92EC1243C4
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 02:24:14 +0100 (CET)
In-Reply-To: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philip Spencer <pspencer@fields.utoronto.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/16/2012 04:48 PM, Philip Spencer wrote:
> When Adobe Flash player is playing a live stream in "live" (no internal
> latency) mode[1], through alsa's pulseaudio plugin, the audio is a
> half-second out of sync with the video. This is with alsa-plugins version
> 1.0.25.[2]

Hi and thanks for investigating!

> I see the problem is one already reported on the bug tracker several years
> ago (issue #3944). The plugin sets pulseaudio's target buffer length to
> match the IO buffer length, and sets the prebuffering attribute to match
> the IO buffer length less one period.
>
> In our case, the IO buffer is 500ms long, the IO period length is 20ms
> (for 16KHz Speex soud packets), and the application requests that playback
> start immediately (by setting the start_threshold software parameter very
> low).

Hmm, if you want ~20 ms of latency, why have a 500 ms long buffer in the 
first place?

> However, the plugin ignores start_threshold and sets the pulseaudio target
> buffer length to 500ms, meaning pulseaudio plays the sound with a
> half-second delay.
>
> The fix initially suggested in the bug report was to implement the
> start_threshold parameter and use it to lower the prebuffering attribute

This sounds like a reasonable thing to do.

> but this does not work: playback STARTS sooner, but when dropouts and
> underruns occur pulseaudio increases the latency to match the target
> buffer length.

Just a quick question: Are you saying there is an immediate change from 
20 to 500 ms at the first underrun, or that things gradually adapts up 
to a stable level?

> It is necessary to lower the target buffer length too.

I think this part requires more investigation though. First, I'm 
assuming you are talking about underruns between the client and 
PulseAudio, rather than underruns between PulseAudio and the hardware.

Setting a tlength of 500 ms will have PulseAudio believe you intend to 
have latency in the range of 250 - 500 ms, so you're starting with the 
buffer almost empty, and if I understand it correctly, things continue 
that way? This is usually bad and a recipe for underruns. Anyway, this 
is probably why lowering the tlength works for your particular use case.

Note though that I'm sceptic to the tlength part of the patch not mainly 
for philosophical reasons (hey, I want things to just work too!) but 
because I'm afraid it will fix some applications and break others. 
Emulating ALSA over PulseAudio is not easy due to the asynchronous 
nature of PulseAudio (among other things), and applications use and 
expect ALSA to do different things.

> [2] In 1.0.23 with low-sample-rate streams there was no sync problem but
> each sound sample was truncated, resulting in distorted and crackly sound;
> this problem has been fixed in 1.0.25 -- thanks!

Hmm, I wonder why this could be. Probably because we have changed the 
underrun handling a few times, but it always seems to improve one 
application and at the same time break another :-(

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
