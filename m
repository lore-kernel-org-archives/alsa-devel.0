From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Mon, 26 Apr 2010 19:10:06 +0800
Message-ID: <x2r4f3252891004260410gdd6f9f5ehc386c17d45aa9792@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>
	<4BD02061.2010204@gmail.com>
	<k2i4f3252891004231832kcd722592hac37a667da424742@mail.gmail.com>
	<4BD3025D.1060207@gmail.com>
	<u2r4f3252891004251846t4606dbf1pd83fd9df9cf916f1@mail.gmail.com>
	<4BD54C98.9050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f193.google.com (mail-pz0-f193.google.com
	[209.85.222.193])
	by alsa0.perex.cz (Postfix) with ESMTP id EFC291037F1
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 13:10:07 +0200 (CEST)
Received: by pzk31 with SMTP id 31so2598076pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 04:10:06 -0700 (PDT)
In-Reply-To: <4BD54C98.9050806@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/26 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Raymond Yau wrote:
> > Are you sure that you really need pulseaudio since your request latency
> is
> > quite low ?
>
> You mean the small period_size of 160 frames or rather the buffer size
> of 2*period_size?
>
> In fact at 8kHz sampling rate a period_size of 160 equals a full 20ms of
> sound:
>
> duration of one frame: 1000ms / 8000Hz = 0.125ms = 125 us
> 160 frames * 125us = 20000us = 20ms
>
> This is by far more than a large period size holds at a higher sampling
> rate (e.g. 44.1 kHz).
>

But the period time of your sound card is 40.634ms which is more than double
of your requested 20ms

D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 3584
D: alsa-util.c:   period_size  : 1792
D: alsa-util.c:   period_time  : 40634


>
> To the question whether pulseaudio is needed:
> On the embedded target PA will not be used, but since development takes
> place on a PC, I need a soundcard that supports the mentioned audio
> format contraints.
> And at the moment this is pulseaudio which is the reason why I really
> need it for application development.
>
>
> However, we should try to not drift away from the actual problem which
> is that *poll() returns an event even if far less than avail_min frames
> are available*.
>
>
> > You have to ask PA developer whether PA support such low latecny ?
> >
> > PA (tsched=0 ) configure your sound card 1792 frames per period but your
> > application request for 160 frames per period
> >
> > You will need the PA expert to answer how PA server capture 1792 frames
> from
> > sound card and send it to your application
> >
> > : module-alsa-source.c: Using 2 fragments of size 7168 bytes, buffer
> > time is 81.27ms
> >
> > D: alsa-util.c: Its setup is:
> > D: alsa-util.c:   stream       : CAPTURE
> > D: alsa-util.c:   access       : MMAP_INTERLEAVED
> > D: alsa-util.c:   format       : S16_LE
> > D: alsa-util.c:   subformat    : STD
> > D: alsa-util.c:   channels     : 2
> > D: alsa-util.c:   rate         : 44100
> > D: alsa-util.c:   exact rate   : 44100 (44100/1)
> > D: alsa-util.c:   msbits       : 16
> > D: alsa-util.c:   buffer_size  : 3584
> > D: alsa-util.c:   period_size  : 1792
> > D: alsa-util.c:   period_time  : 40634
> > D: alsa-util.c:   tstamp_mode  : ENABLE
> > D: alsa-util.c:   period_step  : 1
> > D: alsa-util.c:   avail_min    : 1792
> > D: alsa-util.c:   period_event : 0
> > D: alsa-util.c:   start_threshold  : -1
> > D: alsa-util.c:   stop_threshold   : 8070450532247928832
> > D: alsa-util.c:   silence_threshold: 0
> > D: alsa-util.c:   silence_size : 0
> > D: alsa-util.c:   boundary     : 8070450532247928832
>
> This is how pulseaudio works *internally*.
> Hence it opens my hardware sound card "hw" with the above format.
> If sound it recorded/played back at a different sampling rate, PA
> converts it.
> If you play a prerecorded audio file that has been recorded at a
> different sampling rate, you can see that behavior.
>

After the sound driver capture  40.634 ms of audio , PA have to convert the
44100Hz stereo to 8000Hz mono

seem just add left + right to mono without halve the sum , you may hear
clipping if you are using line in instead of mic or PA clamp the output

D: resampler.c: Channel matrix:
D: resampler.c:        I00   I01
D: resampler.c:     +------------
D: resampler.c: O00 | 1.000 1.000



> What happens is:
>
> [sound application (e.g.. aplay)] ---(audio format of sound file)---> [
> PA plugin] --> [PA daemon] ---(audio format of PA)--> [soundcard]
>
> cheers,
> stefan
>
