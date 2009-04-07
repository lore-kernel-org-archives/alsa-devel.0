From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Tue, 7 Apr 2009 08:19:11 +0300
Message-ID: <200904070819.12019.peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090406122232.GA8585@rakim.wolfsonmicro.main>
	<200904061537.59067.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id AB1002442B
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 07:19:17 +0200 (CEST)
In-Reply-To: <200904061537.59067.peter.ujfalusi@nokia.com>
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
To: alsa-devel@alsa-project.org
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Monday 06 April 2009 15:37:58 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On Monday 06 April 2009 15:22:33 ext Mark Brown wrote:
> > On Mon, Apr 06, 2009 at 03:19:27PM +0300, Peter Ujfalusi wrote:
> > > Add SND_SOC_DAIFMT_DSP_A support for omap-mcbsp.
> > > The configuration for DSP_A and DSP_B is the same.
> >
> > That doesn't sound right - the two formats do differ on the wire.  In
> > mode B the MSB of data is transmitted along with the LRC pulse while in
> > mode A it is transmitted after the trailing edge of the LRC pulse.
>
> That is why I have asked previously about these... I'm still a bit
> confused, but at the end (I think) the configuration in omap-mcbsp is rig=
ht
> for the twl4030:
> regs->srgr2	|=3D FPER(wlen * channels - 1);
> regs->srgr1	|=3D FWID(wlen * channels - 2);
> and
> /* 0-bit data delay */
> regs->rcr2      |=3D RDATDLY(0);
> regs->xcr2      |=3D XDATDLY(0);
>
> I'll revisit this.

I have taken a look about the DSP_A and DSP_B modes in omap-mcbsp.
The only board uses the DSP_B mode is the osk5912 with the tlv320aic23 code=
c.
I have downloaded the data sheet for the tlv320aic23 and I think that the D=
SP =

mode in tlv320aic23 is identical to the TDM mode in twl4030 except for the =

clock polarity
twl4030: Samples the data on falling edge, shifts data out (and changes the =

FS) on rising edge
tlv320aic23: Samples the data on rising, shifts data out (and changes the F=
S) =

on falling edge

This difference is taken care with the SND_SOC_DAIFMT_NB_IF (osk5912) and =

SND_SOC_DAIFMT_IB_NF (beagle).

I would say, that I'm still confused over this...

References:
tlv320aic23:
http://focus.ti.com/lit/ds/slws106d/slws106d.pdf
Page 28 (3-8)
twl4030:
http://focus.tij.co.jp/jp/lit/ug/swcu050b/swcu050b.pdf
Page 712 (TDM mode, Sample length 16 bits; Word length 16 bits)


-- =

P=E9ter
