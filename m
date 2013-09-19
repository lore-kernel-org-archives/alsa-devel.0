From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 06/11] ASoC: davinci: Add support for AM33xx SoC Audio
Date: Thu, 19 Sep 2013 12:31:48 +0300
Message-ID: <523AC484.3010206@ti.com>
References: <cover.1379409268.git.jsarha@ti.com> <c59efc1524b19f50dc37606bfa246dde9c20d312.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c59efc1524b19f50dc37606bfa246dde9c20d312.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jsarha-l0cyMroinI0@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 09/17/2013 12:26 PM, jsarha-l0cyMroinI0@public.gmane.org wrote:
> From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
>=20
> AM33xx uses same McASP IP as the Davinci Platform. This patch updates
> Kconfig and makefile to enable build for McASP, PCM & Codec drivers.
>=20
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
> ---
>  sound/soc/davinci/Kconfig  |   18 +++++++++++++++---
>  sound/soc/davinci/Makefile |    1 +
>  2 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
> index c82f89c..6c8e687 100644
> --- a/sound/soc/davinci/Kconfig
> +++ b/sound/soc/davinci/Kconfig
> @@ -1,9 +1,10 @@
>  config SND_DAVINCI_SOC
> -	tristate "SoC Audio for the TI DAVINCI chip"
> -	depends on ARCH_DAVINCI
> +	tristate "SoC Audio for the TI DAVINCI or AM33XX chip"
> +	depends on ARCH_DAVINCI || SOC_AM33XX
>  	help
> +	  Machine driver for DAVINCI audio.

Should be:
+	Platform driver for daVinci or AM33xx

But I would just remove the help section as such, the prompt gives enou=
gh
information what is this.

>  	  Say Y or M if you want to add support for codecs attached to
> -	  the DAVINCI AC97 or I2S interface. You will also need
> +	  the DAVINCI AC97, I2S, or McASP interface. You will also need
>  	  to select the audio interfaces to support below.
> =20
>  config SND_DAVINCI_SOC_I2S
> @@ -15,6 +16,17 @@ config SND_DAVINCI_SOC_MCASP
>  config SND_DAVINCI_SOC_VCIF
>  	tristate
> =20
> +config SND_AM33XX_SOC_EVM
> +	tristate "SoC Audio for the AM33XX chip based boards"

+	depneds on SND_DAVINCI_SOC && SOC_AM33XX

> +	select SND_DAVINCI_SOC

Do not select the platform support from here.

> +	select SND_SOC_TLV320AIC3X
> +	select SND_DAVINCI_SOC_MCASP
> +	help
> +	  Say Y or M if you want to add support for SoC audio on AM33XX
> +	  boards using McASP and TLV320AIC3X codec. For example AM335X-EVM,
> +	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
> +	  setup.
> +
>  config SND_DAVINCI_SOC_EVM
>  	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
>  	depends on SND_DAVINCI_SOC
> diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
> index a396ab6..bc81e79 100644
> --- a/sound/soc/davinci/Makefile
> +++ b/sound/soc/davinci/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) +=3D snd-soc-dav=
inci-vcif.o
>  snd-soc-evm-objs :=3D davinci-evm.o
> =20
>  obj-$(CONFIG_SND_DAVINCI_SOC_EVM) +=3D snd-soc-evm.o
> +obj-$(CONFIG_SND_AM33XX_SOC_EVM) +=3D snd-soc-evm.o
>  obj-$(CONFIG_SND_DM6467_SOC_EVM) +=3D snd-soc-evm.o
>  obj-$(CONFIG_SND_DA830_SOC_EVM) +=3D snd-soc-evm.o
>  obj-$(CONFIG_SND_DA850_SOC_EVM) +=3D snd-soc-evm.o
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
