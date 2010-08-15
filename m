From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate
	clock	ratio for WM8580
Date: Sun, 15 Aug 2010 12:09:24 +0100
Message-ID: <20100815110924.GA25723@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9C9624505
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 13:09:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 15, 2010 at 06:00:50PM +0900, Seungwhan Youn wrote:
> On Sat, Aug 14, 2010 at 4:35 AM, Mark Brown

> > +
> > + =A0 =A0 =A0 switch (dai->driver->id) {
> > + =A0 =A0 =A0 case WM8580_DAI_PAIFTX:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sel_mask =3D 0x3;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sel_shift =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +
> > + =A0 =A0 =A0 case WM8580_DAI_PAIFRX:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sel_mask =3D 0xc;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sel_shift =3D 3;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;

> These CLKSEL settings looks different with my WM8580 datasheet
> (released March 2009, Rev 4.7).
> I think these codes look...
> +       case WM8580_DAI_PAIFRX:
> +               sel_mask =3D 0x3;
> +               sel_shift =3D 0;
> +               break;

This one is exactly what's above as far as I can tell?....

> +       case WM8580_DAI_PAIFTX:
> +               sel_mask =3D 0xc;
> +               sel_shift =3D 2;
> +               break;

...but the shift is typoed here, yes.

> > + =A0 =A0 =A0 switch (clk_id) {
> > + =A0 =A0 =A0 case WM8580_CLKSRC_ADCMCLK:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dai->id !=3D WM8580_DAI_PAIFTX)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sel =3D 0 << sel_shift;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;

> During my test case with smdk6410 board, clock source of ADC should be
> set by ADCMCLK, if we want to hear a correct sound on playback and
> capture. And when ADC select MCLK or PLLA, source clock was broken
> both of playback and capture.
> Can you verify this(set source clock of ADC set to ADCMCLK) is right
> or is there something missing on other settings?

This should not be required in general.  Without knowing anything about
the tests you did, the problems you observed or why you believe this
configuration helps it's a bit hard to comment in detail.  I did test
briefly since I remembered the use of this from your code.

My best guess would be that this is related to the issue I mentioned in
the cover mail with multiple DAI links on one physical DAI.  Since the
DAIs are cross wired we really shouldn't have both CODEC interfaces
driving the audio interface simultaneously.  =


What would be much more straightforward for this configuration is to run
the PLL output from the CODEC into the CPU and then have the CPU master
the actual audio interface but Jassi was fairly insistent on having the
CODEC master the bus and I'd need to verify again with the schematic if
the appropriate clock lines are run.  Actually, I think I'll just do
that if the hardware allows.
