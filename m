From: Ernesto Torres <skullmate@gmail.com>
Subject: Re: Output frequency configuration for I2S in
	beagleboard? (underrun problem)
Date: Thu, 14 May 2009 10:12:54 -0500
Message-ID: <fb44c3530905140812u33906301x5e8c46e7258cbb51@mail.gmail.com>
References: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
	<200905131341.57717.peter.ujfalusi@nokia.com>
	<fb44c3530905131108x20d309b7k244f5e26de711502@mail.gmail.com>
	<200905140916.22937.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id B57BE24421
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 17:12:56 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1436378bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 08:12:55 -0700 (PDT)
In-Reply-To: <200905140916.22937.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The external codec is connected to McBSP3, it has been pinmuxed to use the
pins on the expansion.

The code from the TWL4030 has been erased and replaced by the code for the
external codec. The files remain the same for now. Board still believes is
twl4030 but sends info via other addresses.(I2C2 & McBSP3)

External codec has 12.288 Mhz clock
Beagle has 26Mhz

>From your code:
case 48000: /* 48.032 */
       div =3D 54;
       clk_id =3D OMAP_MCBSP_SYSCLK_CLK;
       freq =3D 83000000;
       break;

If I understand correctly, 48.032 will be the result of the mclk division.
*
(input clock frequency)/(CLKGDV + 1)*=3D 48.032

*input clock frequency*=3DOMAP_MCBSP_SYSCLK_CLK
*CLKGDV*=3Ddiv=3D53(according to : * regs->srgr1    |=3D CLKGDV(div - 1);)*

Doing some math:
CLKGDV=3Ddiv-1=3D54-1=3D53
48032*54=3Dinput clock frequency=3D2593728?

What should be the value for OMAP_MCBSP_SYSCLK_CLK?

BR,
Ernesto


On Thu, May 14, 2009 at 1:16 AM, Peter Ujfalusi <peter.ujfalusi@nokia.com>w=
rote:

> On Wednesday 13 May 2009 21:08:20 ext Ernesto Torres wrote:
> > Hi,
> > thanks for your replies, unfortunately, the codec has to be slave, it
> > doesn't support yet to send clock via i2s.
>
> Too bad.
>
> > I have another question, it
> > might be seem simple but it will clarify some of my thoughts.
> >
> > From omap3beagle.c hw_params:
> >
> >     /* Set the codec system clock for DAC and ADC */
> >     ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
> >                      SND_SOC_CLOCK_IN);
> >
> > The sysclk is set to 26Mhz and it is coming from the TWL which acts as
> > master.
>
> 26MHz is the MCLK, which is used by the TWL4030 codec's APLL as a master
> clock.
>
> >
> > I had it configured to 12288000(info from datasheet) which was suppose =
to
> > work until I knew the codec I'm using can't be master. (It is still is =
on
> > 12288000)
>
> So you modified the omap3beagle.c file to use your codec, which is not the
> TWL4030, and it is not on the McBSP2 bus, right? Or have you written a new
> board file for your codec and removed the twl4030 codec from the kernel?
>
> >
> > How should it be configured to make the OMAP Master? Should I leave it =
as
> > 26Mhz and do manually all the divisions? I'm using SND_SOC_DAIFMT_CBS_C=
FS
> > for the Beagle.
>
> You seams to be confusing things here...
>
> In order to use the OMAP as master:
> In the hw_param function (on my custom board with twl4030 codec as slave):
>
> /* codec is slave */
> ret =3D snd_soc_dai_set_fmt(codec_dai,
>                          SND_SOC_DAIFMT_I2S |
>                          SND_SOC_DAIFMT_NB_NF |
>                          SND_SOC_DAIFMT_CBS_CFS);
> /* OMAP is master */
> ret =3D snd_soc_dai_set_fmt(cpu_dai,
>                          SND_SOC_DAIFMT_I2S |
>                          SND_SOC_DAIFMT_NB_NF |
>                          SND_SOC_DAIFMT_CBS_CFS);
> /* codec MCLK is 19.2MHz in my board, 26 MHz on beagle */
> ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 19200000,
>                                    SND_SOC_CLOCK_IN);
> /* McBSP clock settings for my custom board.
>  * Note that the freq is there for reference, it is not
>  * used by the McBSP code. Only the divider is used.
>  * You need to figure out the correct frequencies and dividers
>  * for beagle. You can try these also values, but I would not
>  * count on that these are correct for beagle...
>  *
>  * The important things in here:
>  * div: divider
>  * clk_id: Master clock used for the divider */
> div =3D clk_id =3D freq =3D 0;
> switch (params_rate(params)) {
> case 44100: /* 44.117 */
>        div =3D 68;
>        clk_id =3D OMAP_MCBSP_SYSCLK_CLKS_FCLK;
>        freq =3D 96000000;
>        break;
> case 48000: /* 48.032 */
>        div =3D 54;
>        clk_id =3D OMAP_MCBSP_SYSCLK_CLK;
>        freq =3D 83000000;
>        break;
> default:
>        printk(KERN_ERR "hw params: unknown rate %d\n",
>                params_rate(params));
>        return -EINVAL;
> }
>
> ret =3D snd_soc_dai_set_sysclk(cpu_dai, clk_id, freq, SND_SOC_CLOCK_IN);
> ret =3D cpu_dai->dai_ops.set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, div);
>
>
> Since you want OMAP as master you need to configure the cpu_dai correctly
> to
> provide the clocks for the codec.
>
> Does this clear things for you?
> --
> P=E9ter
>



-- =

___________
EhTd
