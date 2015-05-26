From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/2] ASoC: atmel: compile pcm driver in
	snd-soc-atmel_ssc_dai
Date: Tue, 26 May 2015 12:14:06 +0200
Message-ID: <5564476E.5000505@atmel.com>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D320265146
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:15:03 +0200 (CEST)
In-Reply-To: <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Le 26/05/2015 00:04, Alexandre Belloni a =E9crit :
> It is currently possible to have CONFIG_SND_ATMEL_SOC_SSC=3Dy with either
> CONFIG_SND_ATMEL_SOC_PDC=3Dm or CONFIG_SND_ATMEL_SOC_DMA=3Dm. This result=
s in a
> driver that compiles but does not link with this kind of error:
> =

> sound/built-in.o: In function `atmel_ssc_set_audio':
> (.text+0x87d90): undefined reference to `atmel_pcm_pdc_platform_register'
> sound/built-in.o: In function `atmel_ssc_put_audio':
> (.text+0x8879a): undefined reference to `atmel_pcm_pdc_platform_unregiste=
r'
> =

> Solve that by compiling the selected PCM driver (PDC, DMA or both) in the
> Atmel SSC DAI driver.
> =

> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> =

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

For the record:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  sound/soc/atmel/Kconfig  | 4 ++--
>  sound/soc/atmel/Makefile | 8 +++-----
>  2 files changed, 5 insertions(+), 7 deletions(-)
> =

> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index 93abe4e6d596..c3152072d682 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -9,10 +9,10 @@ config SND_ATMEL_SOC
>  if SND_ATMEL_SOC
>  =

>  config SND_ATMEL_SOC_PDC
> -	tristate
> +	bool
>  =

>  config SND_ATMEL_SOC_DMA
> -	tristate
> +	bool
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  =

>  config SND_ATMEL_SOC_SSC
> diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
> index b327e5cc8de3..4fa7ac91f972 100644
> --- a/sound/soc/atmel/Makefile
> +++ b/sound/soc/atmel/Makefile
> @@ -1,10 +1,8 @@
>  # AT91 Platform Support
> -snd-soc-atmel-pcm-pdc-objs :=3D atmel-pcm-pdc.o
> -snd-soc-atmel-pcm-dma-objs :=3D atmel-pcm-dma.o
> -snd-soc-atmel_ssc_dai-objs :=3D atmel_ssc_dai.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_PDC) :=3D atmel-pcm-pdc.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_DMA) +=3D atmel-pcm-dma.o
> +snd-soc-atmel_ssc_dai-objs :=3D atmel_ssc_dai.o $(snd-soc-atmel-pcm-y)
>  =

> -obj-$(CONFIG_SND_ATMEL_SOC_PDC) +=3D snd-soc-atmel-pcm-pdc.o
> -obj-$(CONFIG_SND_ATMEL_SOC_DMA) +=3D snd-soc-atmel-pcm-dma.o
>  obj-$(CONFIG_SND_ATMEL_SOC_SSC) +=3D snd-soc-atmel_ssc_dai.o
>  =

>  # AT91 Machine Support
> =



-- =

Nicolas Ferre
