From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Immediate underrun with PulseAudio ALSA plugin
 when PA and ALSA buffer sizes differ
Date: Thu, 19 Jul 2012 10:56:09 +0200
Message-ID: <5007CBA9.5050808@canonical.com>
References: <20120718221439.GA2875@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E9492651F4
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 10:56:08 +0200 (CEST)
In-Reply-To: <20120718221439.GA2875@flim.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>, Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On 07/19/2012 12:14 AM, Matthew Gregan wrote:
> At 2012-07-17T08:22:20+0200, David Henningsson wrote:
>> 100 ms of latency is a lot, even for PulseAudio - is this some
>> special hardware?
>
> No, it's just a random value for media playback.

What I meant was that I can successfully run your latency test with 10 
ms here - when I go down to 5 I start to get xruns. In that context, 
getting problems around 50 - 100 ms of latency is quite a lot.

Anyway, I've dived a bit deeper here. I've run your latency test with 5 
ms (i e 221 frames), and here's what I believe happens:

1) At the first write, 221 frames of data is written.

2) Now the stream is started. This is done by PulseAudio because the 
prebuf is reached. (And should we short-cut this, there is also 
something in snd_pcm_write_areas that would start it due to 
start_threshold being reached.) We then wait for PulseAudio, because we 
call pa_stream_writable_size right after write.

3) PulseAudio, on its side, starts the stream, quickly consumes the 221 
frames of data from the client buffer, and sends out an underrun.

4) In fact, this underrun reaches alsa-plugins even while waiting for 
pulse_start to finish.

5) At the next call to snd_pcm_avail_update / pulse_pointer, the XRUN is 
returned to the client application.

6) snd_pcm_recover / pulse_prepare resets the stream, and then the same 
thing happens over and over again.

So how do we solve this? Well, I believe the best fix would be to fix 
PulseAudio to give back underruns later, i e, not until we know for sure 
that the 221 frames have been played back. Right now we send it out when 
the client buffer is emptied, which is too early. Deferring the underrun 
on the PulseAudio side would give the client side a fair chance to fill 
up PulseAudio's big buffer and thus avoid the underrun.
I remember VLC having some trouble with this behaviour as well.
This would, however, be some work in PulseAudio to get right. :-/

Meanwhile, you could make a workaround like this in ~/.asoundrc:

pcm.pulse_no_underrun {
   type pulse
   handle_underrun 0
}

and then open the device "pulse_no_underrun". With that workaround I can 
run with 1 ms without problem in your latency test. (We can't ignore 
underruns for everyone though, as that would break applications 
depending on these being delivered as well. Been there, done that.)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
