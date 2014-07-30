From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fsl_asrc: Select
	SND_SOC_GENERIC_DMAENGINE_PCM
Date: Wed, 30 Jul 2014 23:08:07 +0800
Message-ID: <CAGoOwPSUrsfLYv8+Tda_2wsCjR4DwD3H0HQUa_jM-fRbZ38h2g@mail.gmail.com>
References: <1406730426-11023-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E4DD260851
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 17:08:09 +0200 (CEST)
Received: by mail-ie0-f182.google.com with SMTP id y20so1735359ier.13
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 08:08:08 -0700 (PDT)
In-Reply-To: <1406730426-11023-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Oops
....I just found that all kbuild mails were sent to this
mailbox
as I changed the address
 for recent patches...

Fabio, thank you for covering me

.
Nicolin

On Wed, Jul 30, 2014 at 10:27 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Building a kernel with SND_SOC_GENERIC_DMAENGINE_PCM=n leads to the
following
> error:
>
> ERROR: "snd_dmaengine_pcm_prepare_slave_config"
[sound/soc/fsl/snd-soc-fsl-asrc.ko] undefined!
>
> Let SND_SOC_FSL_ASRC select SND_SOC_GENERIC_DMAENGINE_PCM in order to fix
such
> error.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/fsl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 2fb8a43..f54a8fc 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -5,6 +5,7 @@ comment "Common SoC Audio options for Freescale CPUs:"
>  config SND_SOC_FSL_ASRC
>         tristate "Asynchronous Sample Rate Converter (ASRC) module
support"
>         select REGMAP_MMIO
> +       select SND_SOC_GENERIC_DMAENGINE_PCM
>         help
>           Say Y if you want to add Asynchronous Sample Rate Converter
(ASRC)
>           support for the Freescale CPUs.
> --
> 1.9.1
>
