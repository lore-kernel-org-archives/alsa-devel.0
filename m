From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: TWL4030 low-latency
Date: Fri, 14 Oct 2011 22:45:02 +0300
Message-ID: <CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73]) by alsa0.perex.cz (Postfix) with ESMTP id 53B91244A6
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 21:45:04 +0200 (CEST)
Received: by gyc15 with SMTP id 15so1862515gyc.34
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 12:45:02 -0700 (PDT)
In-Reply-To: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Edgar Berdahl <eberdahl@ccrma.stanford.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Edgar,

Please find my comments embedded.

On Fri, Oct 14, 2011 at 9:24 PM, Edgar Berdahl
<eberdahl@ccrma.stanford.edu> wrote:
> Dear Alsa Devel List,
>
> I would like to send some feedback on the TWL4030 driver when used on the=
 Beagle Board. We have tested it under Ubuntu and Angstrom, and we find it =
does not work well at low latencies (e.g. input-to-output in 5ms, 10ms, or =
20ms). Perhaps it was never tested extensively at these latencies. I though=
t I would send you this information in case you would look into it, or at l=
east pass it on to the relevant contact. I can also run further tests if so=
meone informs me what I should try.

As the first question: what is the kernel versions in these distros?
Just one clarification: the twl4030 driver itself is passive during
audio activity - we set it up,
and let it run. It needs no interaction.
omap-pcm, and omap-mcbsp is "running" during audio.
McBSP feeds the audio via I2S bus to twl4030, sDMA takes care of the samples
coming/going to SDRAM.

> 1) To get the drivers to run at particularly low latencies (e.g. 20ms), i=
t is necessary to operate the drivers in NON-realtime mode. It would intere=
st me to know whether this means that the realtime functionality of the Bea=
gle Board xM hardware or OS is hampered, or whether the TWL4030 driver is n=
ot operating up to specification. (If instead the TWL4030 driver is operati=
ng in realtime mode, then Jack stops running when an unrelated low-latency =
USB-serial device is opened.)

I'm not sure what you mean under realtime/non-realtime. Is it
something to do with jack?
It is possible that jack does not like if the pcm period interrupt has
been delayed.
This can hapen due to some driver disables the interrupts for a long
time, thus delaying the
DMA interrupt handler, etc.
Not easy to figure out what is happening.

> 2) Some audio software (e.g. Pure Data, ChucK, etc.) will not connect to =
the TWL4030 ALSA drivers directly, instead they will only start when jack i=
ntermediates between the audio software and the TWL4030 ALSA drivers.

No comment.
I have used mplayer, pulseaudio, ecasound on Beagle without issues.

> 3) In some situations, the TWL4030 drivers appear not to start using the =
requested settings. For example, when we start jack requesting two periods =
per buffer, it is apparently getting initialized at eight periods per buffe=
r, see the final lines below:
> Calling
> $ jackd -r -dalsa -dhw:0 -p128 -n2 -i2 -o2 -s -S -r
> on the Beagle under Ubuntu 10.10 and Angstrom demo image results in the f=
ollowing
>
> jackd 0.118.0
> Copyright 2001-2009 Paul Davis, Stephane Letz, Jack O'Quinn, Torben Hohn =
and ot.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
>
> JACK compiled with System V SHM support.
> loading driver ..
> apparent rate =3D 44100
> creating alsa driver ... hw:0|hw:0|128|2|44100|2|2|nomon|swmeter|soft-mod=
e|16bit
> control device hw:0
> configuring for 44100Hz, period =3D 128 frames (2.9 ms), buffer =3D 2 per=
iods
> ALSA: final selected sample format for capture: 16bit little-endian
> ALSA: use **8** periods for capture
> ALSA: final selected sample format for playback: 16bit little-endian
> ALSA: use **8** periods for playback

I think I can explain this:
McBSP2 has 1280 word long buffer.
We place constraint that the ALSA buffer must not be smaller than this, bec=
ause
if it is smaller we can end up spinning on the buffer at stream start:
sDMA will fill up the FIFO, and if the buffer is smaller than the
FIFO, it will copy
the buffer several times, or partially. Depending on the size you
would have chosen.

You are requesting 128 frames long period size, which occupy 256 words (I a=
ssume
stereo samples)
With that period size you will need at least 5 periods to cover the McBSP2 =
FIFO:
1280 / 256 =3D 5
It is another question, why jack selects 8 periods, while it could use
6, if it likes to
have even number of periods...

-- =

P=E9ter
