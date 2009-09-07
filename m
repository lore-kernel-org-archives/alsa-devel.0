From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Minor WM8580 enhancements.
Date: Mon, 7 Sep 2009 12:58:20 +0100
Message-ID: <20090907115820.GD29898@rakim.wolfsonmicro.main>
References: <1b68c6790909051709k600c8ecdv5bc457ae8e1242c1@mail.gmail.com>
	<20090906012232.GA4239@sirena.org.uk>
	<1b68c6790909051850y2386addhae71898ada96954@mail.gmail.com>
	<20090906111133.GA26748@opensource.wolfsonmicro.com>
	<1b68c6790909060513v4f315f93uf4203408ba5baeab@mail.gmail.com>
	<20090906134207.GA9009@sirena.org.uk>
	<1b68c6790909061935p4611208csf75f4802c669f28a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D121C103839
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 13:58:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909061935p4611208csf75f4802c669f28a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 07, 2009 at 11:35:08AM +0900, jassi brar wrote:
> On Sun, Sep 6, 2009 at 10:42 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> >> =A0 =A0 Codec recommends =A0- BCLK=3D{32, 48} =A0 RFS=3D{384}

> > I'm not sure where these CODEC recommendations come from?

> Well, my example was inspired from one recommendation/constraint i
> found at Page-23, of WM8580A manual Rev-4.7 March-2009.
> It indicates that we can't have BCLK as 16fs if RFS(MCLK/LRCLK) is
> either 128fs or 192fs.

That's not a recommendation, that's a hardware limit.  Though I still
don't see how we get to a 48fs BCLK (which could only be generated with
a 48fs system clock) or a recommendation for a 384fs MCLK in particular.
This is all a bit of a sidetrack anyway.

> In WM8580-Master mode and 8-bits/sample playback, where the
> attached SoC(Slave) takes in MCLK too and supports 192fs but not
> 128fs mclk/lrclk and support 16fs and 128fs as bclk/lrclk.
> Who decides what MCLK and BCLK ratio shud be?

The CODEC driver, though to be frank I'd be astonished to see a CPU
that was limited to 128fs BCLK.  This is what I was saying about about
allowing an override from the machine driver for special cases.

> Btw, without the patch there is no way to set MCLK and BCLK ratios.
> How and where are they taken care of?

They aren't currently, this is why I'm saying that for the time being
you should run the CODEC as slave; it will work well enough to test most
of the CPU support.

> > It looks like by "RFS" you mean the MCLK/sample rate ratio? =A0As
> > mentioned in my previous e-mail this is fixed by those two paameters.

> Further to my above stated situation, there is no way of knowing the
> MCLK value for the WM8580 driver, if its MCLK pin is directly input
> 8.4672MHz clock.
> There I think we need to set the MCLK-Ratio explicitly.

This is what the set_sysclk() operation is for - specifying the input
clocks to the device.

> Just as WM8580 has a constraint on BCLK(128fs) at MCLK=3D128,192fs, some
> SoC may have a constraint of using BCLK=3D48fs for MCLK=3D384fs
> @16-bits/sample.

Like I say, I'd be very surprised to see any such constraint - the
restriction on not having any extra BCLKs with I2S is fairly common
with the CPUs that simulate I2S with a generic synchronous serial
controller but it would be very unusual to see anything that actually
implements I2S caring either way about extra clocks when running as
slave.  The CPUs that do care generally work a lot better if you use one
of the DSP modes since those have no gap between the two data samples.

The goal is that the only machine drivers that should have to worry
about unusual clocking restrictions are those who are affected by them.
The majority of systems won't be affected so there is no gain from
forcing each machine driver to deal with it.  Having to do this manually
just makes things harder to use since it means users have to learn about
more of the details of audio hardware configuration.

> > =A0I will then try to get the updates
> > for the CODEC which would allow the machine driver to be finished off
> > done as quickly as possible. =A0Does that sound like a reasonable plan -
> > it should allow us both to work on this without much duplication?

> Fine.

OK, sounds like we have a good plan here.
