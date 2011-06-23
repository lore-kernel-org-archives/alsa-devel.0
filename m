From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: PCM DMA only can fire ISR when it receives 4
	samples more than the period, from McBSP port?
Date: Thu, 23 Jun 2011 16:16:32 +0300
Message-ID: <4046693.ZFp2Bv0v9N@barack>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D531@EDPREX01.logicpd.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE042818D93C@EDPREX01.logicpd.com>
	<20110623095013.6210474d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A2E8F243A6
	for <Alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 15:16:35 +0200 (CEST)
In-Reply-To: <20110623095013.6210474d.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>, Philip Chu <Philip.Chu@logicpd.com>
List-Id: alsa-devel@alsa-project.org

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
