From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Fri, 25 Sep 2009 12:12:37 +0300
Message-ID: <200909251212.37233.peter.ujfalusi@nokia.com>
References: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
	<200909250903.06874.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id DFE781038C6
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 11:12:49 +0200 (CEST)
In-Reply-To: <200909250903.06874.peter.ujfalusi@nokia.com>
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
Cc: ext Rick Bronson <rick@efn.org>
List-Id: alsa-devel@alsa-project.org

On Friday 25 September 2009 09:03:06 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Hello,
> =

> On Thursday 24 September 2009 20:06:07 ext Rick Bronson wrote:
> > Hi,
> >
> >   I'm working on getting a WM8731 (in SLAVE) working using I2S on
> > omap3 McBSP2 (in MASTER).
> >
> >
> > static int omap3csb740_hw_params(struct snd_pcm_substream *substream,
> > ...
> >  ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> >   SND_SOC_DAIFMT_NB_NF |  SND_SOC_DAIFMT_CBS_CFS);
> >  ret =3D snd_soc_dai_set_fmt(cpu_dai,  SND_SOC_DAIFMT_I2S |
> >   SND_SOC_DAIFMT_NB_NF |  SND_SOC_DAIFMT_CBS_CFS);
> >  ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 12288000,  =

> > SND_SOC_CLOCK_IN); ret =3D snd_soc_dai_set_sysclk(cpu_dai,
> > OMAP_MCBSP_SYSCLK_CLKS_EXT, 0, SND_SOC_CLOCK_IN);
> =

> I think the problem is here.
> The MCBSP_CLKS pin is connected to CLK256FS pin of TWL4030 (or TPA).

This applies for the Beagle board, which I thought that you are using that =
from =

this line:
> 4 beagle:~# aplay test48000.wav

Can you check that the clock is running between
CLKOUT (WM8731) -> McBSP_CLKS (OMAP3) pins?

If the clock is missing, than the functional clock is not running.

> Since you are not using the TWL codec, there will be no clock on the
>  MCBSP_CLKS pin, thus no functional clock for McBSP, thus no bits are
>  shifted in or out. You can try to use the internal functional clock:
> =

>   ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK, 0,
>     SND_SOC_CLOCK_IN);
> =

> Than set the correct divider, which depends on the frequency you would li=
ke
>  to play. The source for the CLKS_FCLK is (in case of McBSP2) PER_96M_FCL=
K,
>  so 96MHz. Now you have to divide this to get the correct value, as I
>  recall quite a long time ago there were some discussion about this here,
>  and I have sent some 'formula' to calculate it, but I can not find it now
>  :(
> =

> >  ret =3D snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 256);
> >
> >   Any help is greatly appreciated.
> >
> >   Rick Bronson
> =


-- =

P=E9ter
