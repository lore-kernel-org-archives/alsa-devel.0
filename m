From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Immediate underrun with PulseAudio ALSA plugin
 when PA and ALSA buffer sizes differ
Date: Tue, 17 Jul 2012 08:22:20 +0200
Message-ID: <5005049C.5000806@canonical.com>
References: <20120716213855.GE7462@flim.org>
 <1342502963.14027.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 55A39264F21
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 08:22:20 +0200 (CEST)
In-Reply-To: <1342502963.14027.24.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org, Matthew Gregan <kinetik@flim.org>
List-Id: alsa-devel@alsa-project.org

On 07/17/2012 07:29 AM, Arun Raghavan wrote:
> [x-posting back to pulseaudio-discuss since it's relevant to both lists]
>
> On Tue, 2012-07-17 at 09:38 +1200, Matthew Gregan wrote:
>> I'm investigating an issue in Firefox's audio code when the PulseAudio ALSA
>> plugin is in use.  I posted about this on pulseaudio-discuss last week
>> (http://lists.freedesktop.org/archives/pulseaudio-discuss/2012-July/014091.html),
>> but I hoped I might have more success here.
>>
>> Firefox requests a particular latency (100ms, 4410 frames at 44.1kHz) via
>> snd_pcm_set_params.  Inside the plugin (pcm_pulse.c:pulse_hw_params), that
>> value is used to set up buffer_attr.  When the PA stream is connected in
>> pcm_pulse.c:pulse_prepare, PA may configure the stream with larger
>> buffer_attr values (e.g. because the minimum sink latency has increased over
>> time due to underruns on the server, or because the sink hardware doesn't
>> support lower latency), but this isn't reflected in pcm->buffer_attr or
>> higher layers in ALSA (i.e. pcm->buffer_size is not updated).

100 ms of latency is a lot, even for PulseAudio - is this some special 
hardware?

>> The problem I'm faced with is that there doesn't appear to be a way to
>> detect and handle this issue at the ALSA API level, and requesting a too low
>> latency results in broken audio playback rather than a PCM setup failure or
>> a larger buffer than requested being used.
>>
>> In the case of the PA server's minimum latency increasing over time, this
>> also means that a stream that was configured and running correctly may break
>> while running if PA increases the minimum latency above what the PCM was
>> originally configured with.
>>
>> I've attached a simple testcase that uses snd_pcm_wait,
>> snd_pcm_avail_update, and snd_pcm_writei.  Run it with a latency argument
>> specified in milliseconds on the command line.  For my local machine, 55ms
>> works and 54ms fails immediately like so:
>>
>> snd_pcm_wait wakes
>> snd_pcm_avail_update returns 4410
>> snd_pcm_writei writes 4410
>> snd_pcm_wait wakes immediately
>> snd_pcm_avail_update returns -EPIPE

Could you clarify what versions of PulseAudio and alsa-plugins you're 
using? The latest improvement to this handling was done less than a year 
ago and might require the latest versions of these components.

>> (Note that when I reported this on pulseaudio-discuss, my server's minimum
>> latency was 45ms, and now pacmd list-sinks | grep configured\ latency
>> reports a minimum latency of 56ms)
>>
>> I'd expect to see one of the following behaviours instead:
>> 1. PCM setup fails due to requesting a too small buffer.
>> 2. Buffer is silently raised during setup and snd_pcm_avail_update requests
>>     the correct number of frames.

I think the better solution would be nr 2 in this case. Nr 1 won't solve 
the case where the sink's latency is increased dynamically - because the 
stream is moved, for example.

>> Presumably this could be achieved by having the PA plugin report valid
>> values from pcm_pulse.c:pulse_hw_constraint, but I'm not sure how to query
>> the necessary values from the server.  This also wouldn't address the
>> problem where the buffer_attr changes over time, and I'm not sure what to do
>> about that case.
>
> The necessary values are available via pa_stream_get_buffer_attr().
> Potentially we could use this in the pulse_pointer() function to update
> the corresponding snd_pcm_t's period/buffer sizes, but I don't know if
> this is kosher with regards to what alsa-lib expects plugins to be
> doing.
>
> If this is not sufficient for the initial update, from what I can see,
> snd_pcm_set_params() first sets period/buffer sizes, queries them for
> later calculations, and then commits them with snd_pcm_hw_params(). If
> we could move the querying to after the params are committed (and in
> this case, the stream is connected and buffer attributes are
> negotiated), that would solve your problem. Again, I'm not sure what
> side-effects this might have, but I've attached a draft untested patch
> for it.

I don't know either - and it also does not seem to solve the case where 
the sink's latency is suddenly increased (e g, when the sink input is 
moved to another sink).


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
