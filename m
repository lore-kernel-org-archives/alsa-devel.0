From: Ernesto Torres <skullmate@gmail.com>
Subject: Re: Output frequency configuration for I2S in
	beagleboard? (underrun problem)
Date: Fri, 15 May 2009 09:43:00 -0500
Message-ID: <fb44c3530905150743i3409d809ldf22ccc903d56144@mail.gmail.com>
References: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
	<200905140916.22937.peter.ujfalusi@nokia.com>
	<fb44c3530905140812u33906301x5e8c46e7258cbb51@mail.gmail.com>
	<200905150923.14187.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id C399D24490
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 16:43:01 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2077582bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2009 07:43:01 -0700 (PDT)
In-Reply-To: <200905150923.14187.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the information, I'll try this approach and see how it goes

BR,
Ernesto

On Fri, May 15, 2009 at 1:23 AM, Peter Ujfalusi <peter.ujfalusi@nokia.com>w=
rote:

> On Thursday 14 May 2009 18:12:54 ext Ernesto Torres wrote:
> > Hi,
> >
> > The external codec is connected to McBSP3, it has been pinmuxed to use
> the
> > pins on the expansion.
> >
> > The code from the TWL4030 has been erased and replaced by the code for
> the
> > external codec. The files remain the same for now. Board still believes
> is
> > twl4030 but sends info via other addresses.(I2C2 & McBSP3)
> >
> > External codec has 12.288 Mhz clock
> > Beagle has 26Mhz
>
> To be precise:
> TWL4030 codec on Beagle board has 26MHz MCLK.
> This has nothing to do with the McBSP clocking at all.
>
> >
> > From your code:
> > case 48000: /* 48.032 */
> >        div =3D 54;
> >        clk_id =3D OMAP_MCBSP_SYSCLK_CLK;
> >        freq =3D 83000000;
> >        break;
> >
> > If I understand correctly, 48.032 will be the result of the mclk
> division.
> > *
> > (input clock frequency)/(CLKGDV + 1)*=3D 48.032
>
> Not really, with the clkdiv you get the bitclock.
>
> >
> > *input clock frequency*=3DOMAP_MCBSP_SYSCLK_CLK
> > *CLKGDV*=3Ddiv=3D53(according to : * regs->srgr1    |=3D CLKGDV(div - 1=
);)*
> >
> > Doing some math:
> > CLKGDV=3Ddiv-1=3D54-1=3D53
> > 48032*54=3Dinput clock frequency=3D2593728?
>
> This is how you are calculating it:
> 48032*16*2*54=3D82999296
>
> If we want to have the clocks for 48KHz 16bit stereo playback, and we goi=
ng
> to
> use OMAP as master:
> Select the clock source for McBSP as OMAP_MCBSP_SYSCLK_CLK, which means
> that
> we are using McBSPi_ICLK for the SRG divider source
> In my HW the McBSPi_ICLK is 83MHz
> Than:
> 83000000 / 16 / 2 / div =3D 48000
> div =3D 83000000 / 16 / 2 / 48000
> div =3D 54.0364 ~=3D 54
>
> --
> P=E9ter
>



-- =

___________
EhTd
