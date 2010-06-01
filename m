From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Tue, 1 Jun 2010 13:30:27 +1000
Message-ID: <20100601033023.GA24820@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<4BFF5AC7.3060409@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 29DD824689
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 05:30:33 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OJIBR-0003aX-Ec
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 13:30:29 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OJIBQ-0003aI-CI
	for alsa-devel@alsa-project.org; Tue, 01 Jun 2010 13:30:29 +1000
Content-Disposition: inline
In-Reply-To: <4BFF5AC7.3060409@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Eric,
On Fri, May 28, 2010 at 07:55:19AM +0200, Eric B=E9nard wrote:
> Hi Stuart,
> =

> Le 28/05/2010 04:06, Stuart Longland a =E9crit :
> > I'll have a look at the Eukrea CPUIMX27 and baseboard SoC support in a
> > moment, since it looks very similar to what we're doing (in that it's a
> > TI I=B2S CODEC hooked to an i.MX27 on SSI4) ... this might reveal clues
> > as to what I'm doing wrong.
> =

> we are using the TLV320AIC23B codec in master mode on the =

> CPUIMX27/MBIMX27 (and did the same on an other board using a TLV3204 as =

> a master with a 12MHz oscillator on its MCLK: for this one, it's =

> necessary to configure several dozens of registers through I2C to get it =

> running)
> =

> The TLV3204 is wired this way :
> - MCK =3D 12MHz ocillator
> - BCLK (pin2) =3D PC19 (SSI4_CLK) (TLV output / IMX in)
> - WCLK (pin3) =3D PC16 (SSI4_FS) (TLV output / IMX in)
> - DIN/MFP1 (pin4) =3D PC18 (SSI4_TXDAT) (TLV input / IMX out)
> - DOUT/MFP2 (pin5) =3D PC17 (SSI4_RXDAT) (TLV output / IMX in)
> - SPI_SELECT (pin12) =3D pull down to select I2C mode
> - SCL & SDA (pins 9 & 10) =3D I2C2
> all the interface between i.MX & TLV is powered in 1.8V.
> =

> I'll try to find our I2C init sequence and send it to you as this was =

> the hardest part of the thing to get the codec running.

Well, over the last few days I've been looking closely at the signals
generated.  Especially this morning... yesterday, I managed to get some
sound out of the CODEC when operating in I=B2S master mode (yes, I have a
patch that I need to clean up first).

What I observed is that despite being configured for I=B2S master, what I
infact saw, was more like DSP mode, with a 1-bit frame sync pulse.  The
remainder of my experimentation has been using the DSP modes of both MCU
and CODEC.

I'm using the following script to generate audio data for testing:

while true; do printf "\x55\xff\xaa\x00"; done > test.raw

This is then played to the CODEC; using aplay:
aplay -D hw:0,0 -f S16_LE -r 48000 -c 2 test.raw

I'm now using the SSI port in DSP SSI Slave mode; so single bit frame
pulse.  I'm not sure what format the CODEC expects its data to be in,
but what I observe is two things:

(1) Each sample is sign-extended to 32-bits.
(2) The data is then sent, least significant 16-bits first.
(3) The frame sync pulses are sent just before the start of each
(sign-extended) sample.

On the CRO; (again, appologies for ASCII art) it looks like this:
(Frame sync is top trace)
 .-.                                                            .-,
 | |                                                            | |
-' '------------------------------------------------------------' '->
----.              .-. .-. .-. .-.                                .->
    |              | | | | | | | |                                |
    '--------------' '-' '-' '-' '--------------------------------'
    |<---- MSB ----><---- LSB ----><----- Sign Extension??? ----->|
    |<------------------------ Channel 1 ------------------------>|

... diagram continues; second sync pulse is shown again...
  .-.                                                           .-.
  | |                                                           | |
<-' '-----------------------------------------------------------' '->
    .--------------. .-. .-. .-. .--------------------------------.
    |              | | | | | | | |                                |
<---'              '-' '-' '-' '-'                                '->
    |<---- MSB ----><---- LSB ----><----- Sign Extension??? ----->|
    |<------------------------ Channel 2 ------------------------>|

Now, my understanding is that the frame sync pulse indicates the start
of the frame, and that the frame consists of (in this case) 32 bits;
which is the concatenation of the two 16-bit samples.  In addition, the
documentation I see, AFAIK, suggests that this data should be
transmitted in big-endian (MSB first) order.  However, what I see here
is that each sample is being sent, followed by what appears to be a
sign-extend ... or what would be sign extend IFF we were using 32-bit
LSB.  I'm not sure that this looks right, and could explain why I just
get semi-random noise rather than the audio I'm expecting.

I'm happy to share with others the CODEC driver I've written thus far
... but a query, how is the best way to share this for collaborative
work?  It's not a finished driver, but it does at least initialise the
CODEC and get the bus working... it then allows manipulation of
registers from the I=B2C interface via two files in sysfs -- since loading
it prevents i2c-tools from working.  Otherwise, the driver does load,
and at least does some setup.

Regards,
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
