From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Re: PCM DMA only can fire ISR when it receives 4
 samples more than the period, from McBSP port?
Date: Fri, 1 Jul 2011 10:39:05 -0500
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE04286BB488@EDPREX01.logicpd.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D531@EDPREX01.logicpd.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE042818D93C@EDPREX01.logicpd.com>
	<20110623095013.6210474d.jhnikula@gmail.com>
	<4046693.ZFp2Bv0v9N@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 794A324789
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 17:39:10 +0200 (CEST)
In-Reply-To: <4046693.ZFp2Bv0v9N@barack>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks very much for both of your reply.

I got our customer to provide extra bit clocks before Frame Sync signal kic=
ks in and also after the data signal ends. In both ends an extra frame of b=
it clocks are added, then McBSP is seeing all data without missing any bit.

So I guess the DMA is moving forward with every frame coming out of MCBSP, =
but the latest DMA pointer will not be valid until the very first period IS=
R happens. Thus when missing sample happens, DMA may not get anything is Mc=
BSP is =

receiving fewer than one period of frames.


Thanks,
Philip


-----Original Message-----
From: P=E9ter Ujfalusi [mailto:peter.ujfalusi@ti.com] =

Sent: Thursday, June 23, 2011 9:17 AM
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula; Philip Chu; Alsa-devel@alsa-project.org
Subject: Re: Re: [alsa-devel] PCM DMA only can fire ISR when it receives 4 =
samples more than the period, from McBSP port?

On Thursday 23 June 2011 08:50:13 Jarkko Nikula wrote:
> On Wed, 22 Jun 2011 10:26:28 -0500
> =

> Philip Chu <Philip.Chu@logicpd.com> wrote:
> > Thanks for your help.
> > =

> > How big is the chance that McBSP will have samples remaining in its
> > shift registers, not to its FIFO until next time it receives new data
> > samples?
> =

> I suppose none if McBSP framesize (wlen * channels) number of bitclock
> cycles (+ possible 1-bit data delay) are received after framesync.

Should not IMHO either.
Could you provide information on your configuration, like number of channel=
s, =

sample size, format (I2S, DSP_A/B, etc).
If you can, probably a dump of McBSP register content might help as well.

Is it possible to check for you the place of the missing 4 samples, when yo=
u =

send 4 sample more? Is it missing from the start or from the end of the blo=
ck?
 =

> > My PCM DMA is running in element mode so it sets up FIFO threshold as 1
> > (0 in the register). That means FIFO should pass the data as long as it
> > sees them coming.
> > =

> > Before the very first DMA ISR (completed a period of data transfer by
> > DMA), the DMA pointer is a void number, I think it means DMA has not
> > ever completed one entire period transfer yet. My suspection is, does
> > DMA need some time to be ready for receiving data from McBSP's DMA
> > event? If it does need some time, then the very first a couple of
> > sample(s) from McBSP could be missed.
> =

> Indeed, this is actually strange that DMA pointer is not updated. How
> big is your period size? Is it smaller than DMA burst size which is set
> to 64 bytes in sound/soc/omap/omap-pcm.c? I'm not sure does the DMA use
> burst transfer in element mode but non-updating pointer is kind of
> indicating that there is neither DMA transfer going on until enough
> data is received.

Yeah, the DMA pointer should move, even if you do not receive the period =

interrupt, since you are in element mode, so you should be reading from McB=
SP =

FIFO word by word.

McBSP is looking for start condition to shift in or out bits, so it could b=
e =

that you might need to have bit clock running before you start the transfer =

(with asserting the FS). Just to be sure, that McBSP recognizes the change =
on =

the FS line.

-- =

P=E9ter
