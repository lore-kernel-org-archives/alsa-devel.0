From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Fri, 25 Sep 2009 09:03:06 +0300
Message-ID: <200909250903.06874.peter.ujfalusi@nokia.com>
References: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B8F910380F
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 08:03:23 +0200 (CEST)
In-Reply-To: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Rick Bronson <rick@efn.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

On Thursday 24 September 2009 20:06:07 ext Rick Bronson wrote:
> Hi,
> =

>   I'm working on getting a WM8731 (in SLAVE) working using I2S on
> omap3 McBSP2 (in MASTER).

 =

> static int omap3csb740_hw_params(struct snd_pcm_substream *substream,
> ...
>  ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
>   SND_SOC_DAIFMT_NB_NF |  SND_SOC_DAIFMT_CBS_CFS);
>  ret =3D snd_soc_dai_set_fmt(cpu_dai,  SND_SOC_DAIFMT_I2S |
>   SND_SOC_DAIFMT_NB_NF |  SND_SOC_DAIFMT_CBS_CFS);
>  ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 12288000,   SND_SOC_CLOCK_I=
N);
>  ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT, 0,
>    SND_SOC_CLOCK_IN);

I think the problem is here.
The MCBSP_CLKS pin is connected to CLK256FS pin of TWL4030 (or TPA).
Since you are not using the TWL codec, there will be no clock on the MCBSP_=
CLKS =

pin, thus no functional clock for McBSP, thus no bits are shifted in or out.
You can try to use the internal functional clock:

  ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK, 0,
    SND_SOC_CLOCK_IN);

Than set the correct divider, which depends on the frequency you would like=
 to =

play. The source for the CLKS_FCLK is (in case of McBSP2) PER_96M_FCLK, so =

96MHz. Now you have to divide this to get the correct value, as I recall qu=
ite a =

long time ago there were some discussion about this here, and I have sent s=
ome =

'formula' to calculate it, but I can not find it now :(

>  ret =3D snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 256);
> =

>   Any help is greatly appreciated.
> =

>   Rick Bronson
> =


-- =

P=E9ter
