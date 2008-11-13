From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: S24_BLE does not play using aplay.
Date: Thu, 13 Nov 2008 15:54:06 -0500
Message-ID: <74eb1fe20811131254o1000b7bci859676e43cfb6d2e@mail.gmail.com>
References: <aceb60a00811061659o11eec5f4s6c5b6c4ba470b873@mail.gmail.com>
	<49144BD2.3070400@ladisch.de>
	<aceb60a00811131044o47c6c616ndf79ae68082aeeb@mail.gmail.com>
	<74eb1fe20811131104t4b3e5b37uc75f94973449f39a@mail.gmail.com>
	<aceb60a00811131107g10a46012v1220b66218546ca4@mail.gmail.com>
	<74eb1fe20811131110p650ca56fj84ef5049f379f7ff@mail.gmail.com>
	<aceb60a00811131113o2493ec85n8822fc66506f3a55@mail.gmail.com>
	<aceb60a00811131114q75f8a42dv8a2069cd17b9340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 80D232435F
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 21:54:08 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so553238waf.16
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 12:54:06 -0800 (PST)
In-Reply-To: <aceb60a00811131114q75f8a42dv8a2069cd17b9340@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Baek Chang <baeksan@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

>>> On Thu, Nov 13, 2008 at 2:07 PM, Baek Chang <baeksan@ccrma.stanford.edu>
>>> wrote:
>>> > Thanks for the reply.  I get the following error when trying your
>>> > suggestion
>>> >
>>> > aplay --device=plug:pulse LPCM_48khz_ST_24bit.wav
>>> >
>>> > Playing WAVE 'LPCM_48khz_ST_24bit.wav' : Signed 24 bit Little Endian in
>>> > 3bytes, Rate 48000 Hz, Stereo
>>> > aplay: set_params:1022: Unable to install hw params:
>>> > ACCESS:  RW_INTERLEAVED
>>> > FORMAT:  S24_3LE
>>> > SUBFORMAT:  STD
>>> > SAMPLE_BITS: 24
>>> > FRAME_BITS: 48
>>> > CHANNELS: 2
>>> > RATE: 48000
>>> > PERIOD_TIME: 125000
>>> > PERIOD_SIZE: 6000
>>> > PERIOD_BYTES: 36000
>>> > PERIODS: 4
>>> > BUFFER_TIME: 500000
>>> > BUFFER_SIZE: 24000
>>> > BUFFER_BYTES: 144000
>>> > TICK_TIME: 0
>>> >
>>> >
>>> > Any ideas?
>>> >
>>> > Thanks
>>> > Baek
>>> >

Some initial debugging shows:

1. It's not in alsa-plugins/pulse, because if you send it 24-bit
anything, it won't recognize that format and error out with a
different message (rather than just throwing error back at aplay).
Things fall down before pcm_pulse.c ever evaluates the sample format.
2. It's not in alsa-lib/pcm/pcm_plug.c, because plug intelligently
works with other (non-pulse) devices:

Works:
aplay --device=plug:hw:0 LPCM_48khz_ST_24bit.wav
and
aplay --device=plug:dmix:0 LPCM_48khz_ST_24bit.wav

In theory, these statements should be both true:
My hw doesn't support S24_3LE, but plug converts it for me.
My pulse doesn't support S24_3LE, but plug converts it for me.

But there is one more layer between plug and the actual pulse plugin
code: ioplug!

It's non-trivial to figure out the guts of functions such as
snd_pcm_ioplug_hw_refine when you have refine math going on. The
refine code goes through a lot of contortions trying to get ioplug to
accept a conversion, but no joy.... it appears pcm_extplug.c, the
"External Filter Plugin SDK" is unhappy.

So basically, the problem occurs before alsa-plugins/pulse even gets a
chance to detect and deal with the problem. pcm_ioplug.c does
something similar to what pcm_plug.c does with refines, just more
cryptically. Since it was developed so long ago, it may not have been
tested with S24_3LE, or with S24 at all.

One possible ugliness is that there is no cmpxchg instruction for
24-bit values, so you'd have to do something else for synchronization.
Maybe that's why it's not supported?

It sounds like pulse (or any ioplug-user, in general) is not going to
support S24_3LE until someone really digs in and finds out why this is
erroring out.

Keep in mind that there are two code paths that both hit the same
problem, namely plug:pulse and pulse alone. The error returned is
different, and it seems simpler to figure out why you get an error
with plain pulse, rather than complicating things with plug.

HTH,

Sean



>>> >
>>> > On Thu, Nov 13, 2008 at 11:04 AM, Sean McNamara <smcnam@gmail.com>
>>> > wrote:
>>> >>
>>> >> Hmm, sounds like the ALSA<->Pulse bindings don't support this sample
>>> >> format. Have you tried
>>> >>
>>> >> aplay --device=plug:pulse foo.wav
>>> >>
>>> >> Maybe the ALSA plug layer can convert it to a sample format that the
>>> >> pulse plugin will accept. I don't have a file like this so I can't
>>> >> test.
>>> >>
>>> >> Sean
>>> >>
>>> >> On Thu, Nov 13, 2008 at 1:44 PM, Baek Chang
>>> >> <baeksan@ccrma.stanford.edu>
>>> >> wrote:
>>> >> > I am using pulseaudio as the sound server in conjunction with alsa.
>>> >> >  My
>>> >> > alsa
>>> >> > sinks are mapped to pulseaudio in asound.conf.  Using paplay with a
>>> >> > 24
>>> >> > bit
>>> >> > file seems to work fine, because pulseaudio just converts the S24
>>> >> > bit
>>> >> > data
>>> >> > to 32 bit float.  Is there a way to bypass using plughw with alsa,
>>> >> > so
>>> >> > that
>>> >> > alsa can just send the 24 bit pcm data to pulseaudio, then have
>>> >> > pulseaudio
>>> >> > do the neccessary conversion?
>>> >> >
>>> >> > Thanks
>>> >> > Baek
>>> >> >
>>> >> > On Fri, Nov 7, 2008 at 6:08 AM, Clemens Ladisch <clemens@ladisch.de>
>>> >> > wrote:
>>> >> >
>>> >> >> Baek Chang wrote:
>>> >> >> > Playing WAVE 'sine_24_48k.wav' : Signed 24 bit Little Endian in
>>> >> >> > 3bytes,
>>> >> >> Rate 48000 Hz, Stereo
>>> >> >> > aplay: set_params:961: Sample format non available
>>> >> >>
>>> >> >> This error message indicates that the device does not support the
>>> >> >> sample
>>> >> >> format.
>>> >> >>
>>> >> >> You didn't show the aplay command line, but I'd guess that you used
>>> >> >> a
>>> >> >> "hw" device.  Try "plughw" or "default" to get automatic sample
>>> >> >> format
>>> >> >> conversion.
>>> >> >>
>>> >> >>
>>> >> >> HTH
>>> >> >> Clemens
>>> >> >>
>>> >> >>
>>> >> >
>>> >> >
>>> >> > --
>>> >> > Baek Chang
>>> >> > baeksan@ccrma.stanford.edu
>>> >> > 407-267-6701
>>> >> > _______________________________________________
>>> >> > Alsa-devel mailing list
>>> >> > Alsa-devel@alsa-project.org
>>> >> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>> >> >
>>> >>
>>> >
>>> >
>>> >
>>> > --
>>> > Baek Chang
>>> > baeksan@ccrma.stanford.edu
>>> > 407-267-6701
>>> >
>>
>>
>>
>> --
>> Baek Chang
>> baeksan@ccrma.stanford.edu
>> 407-267-6701
>
>
>
> --
> Baek Chang
> baeksan@ccrma.stanford.edu
> 407-267-6701
>
