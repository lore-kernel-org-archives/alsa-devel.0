From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
 although poll returns POLLIN event
Date: Mon, 26 Apr 2010 10:19:36 +0200
Message-ID: <4BD54C98.9050806@gmail.com>
References: <4BCEE140.5060704@gmail.com>
	<4BCF24AC.3000301@gmail.com>	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>	<4BD02061.2010204@gmail.com>	<k2i4f3252891004231832kcd722592hac37a667da424742@mail.gmail.com>	<4BD3025D.1060207@gmail.com>
	<u2r4f3252891004251846t4606dbf1pd83fd9df9cf916f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F0251037FC
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 10:19:38 +0200 (CEST)
In-Reply-To: <u2r4f3252891004251846t4606dbf1pd83fd9df9cf916f1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> Are you sure that you really need pulseaudio since your request latency is
> quite low ?

You mean the small period_size of 160 frames or rather the buffer size
of 2*period_size?

In fact at 8kHz sampling rate a period_size of 160 equals a full 20ms of
sound:

duration of one frame: 1000ms / 8000Hz = 0.125ms = 125 us
160 frames * 125us = 20000us = 20ms

This is by far more than a large period size holds at a higher sampling
rate (e.g. 44.1 kHz).

To the question whether pulseaudio is needed:
On the embedded target PA will not be used, but since development takes
place on a PC, I need a soundcard that supports the mentioned audio
format contraints.
And at the moment this is pulseaudio which is the reason why I really
need it for application development.


However, we should try to not drift away from the actual problem which
is that *poll() returns an event even if far less than avail_min frames
are available*.


> You have to ask PA developer whether PA support such low latecny ?
> 
> PA (tsched=0 ) configure your sound card 1792 frames per period but your
> application request for 160 frames per period
> 
> You will need the PA expert to answer how PA server capture 1792 frames from
> sound card and send it to your application
> 
> : module-alsa-source.c: Using 2 fragments of size 7168 bytes, buffer
> time is 81.27ms
> 
> D: alsa-util.c: Its setup is:
> D: alsa-util.c:   stream       : CAPTURE
> D: alsa-util.c:   access       : MMAP_INTERLEAVED
> D: alsa-util.c:   format       : S16_LE
> D: alsa-util.c:   subformat    : STD
> D: alsa-util.c:   channels     : 2
> D: alsa-util.c:   rate         : 44100
> D: alsa-util.c:   exact rate   : 44100 (44100/1)
> D: alsa-util.c:   msbits       : 16
> D: alsa-util.c:   buffer_size  : 3584
> D: alsa-util.c:   period_size  : 1792
> D: alsa-util.c:   period_time  : 40634
> D: alsa-util.c:   tstamp_mode  : ENABLE
> D: alsa-util.c:   period_step  : 1
> D: alsa-util.c:   avail_min    : 1792
> D: alsa-util.c:   period_event : 0
> D: alsa-util.c:   start_threshold  : -1
> D: alsa-util.c:   stop_threshold   : 8070450532247928832
> D: alsa-util.c:   silence_threshold: 0
> D: alsa-util.c:   silence_size : 0
> D: alsa-util.c:   boundary     : 8070450532247928832

This is how pulseaudio works *internally*.
Hence it opens my hardware sound card "hw" with the above format.
If sound it recorded/played back at a different sampling rate, PA
converts it.
If you play a prerecorded audio file that has been recorded at a
different sampling rate, you can see that behavior.

What happens is:

[sound application (e.g.. aplay)] ---(audio format of sound file)---> [
PA plugin] --> [PA daemon] ---(audio format of PA)--> [soundcard]

cheers,
stefan
