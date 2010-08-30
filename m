From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/4] ASoC: fsi-codec: Add FSI - HDMI support
Date: Mon, 30 Aug 2010 10:10:03 +0100
Message-ID: <1283159403.3055.5.camel@odin>
References: <w3p8w3olmgx.wl%kuninori.morimoto.gx@renesas.com>
	<w3p4oeclmg1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F67A243C1
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 11:10:07 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2967598eyd.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 02:10:06 -0700 (PDT)
In-Reply-To: <w3p4oeclmg1.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-30 at 14:05 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/Kconfig    |    7 +++++
>  sound/soc/sh/Makefile   |    2 +
>  sound/soc/sh/fsi-hdmi.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/sh/fsi-hdmi.c
> 
> diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
> index 52d7e8e..6b224d2 100644
> --- a/sound/soc/sh/Kconfig
> +++ b/sound/soc/sh/Kconfig
> @@ -62,6 +62,13 @@ config SND_FSI_DA7210
>  	  This option enables generic sound support for the
>  	  FSI - DA7210 unit
>  
> +config SND_FSI_HDMI
> +	bool "FSI-HDMI sound support"
> +	depends on SND_SOC_SH4_FSI && FB_SH_MOBILE_HDMI
> +	help
> +	  This option enables generic sound support for the
> +	  FSI - HDMI unit
> +
>  config SND_SIU_MIGOR
>  	tristate "SIU sound support on Migo-R"
>  	depends on SH_MIGOR
> diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile
> index 8a5a192..94476d4 100644
> --- a/sound/soc/sh/Makefile
> +++ b/sound/soc/sh/Makefile
> @@ -16,9 +16,11 @@ obj-$(CONFIG_SND_SOC_SH4_SIU)	+= snd-soc-siu.o
>  snd-soc-sh7760-ac97-objs	:= sh7760-ac97.o
>  snd-soc-fsi-ak4642-objs		:= fsi-ak4642.o
>  snd-soc-fsi-da7210-objs		:= fsi-da7210.o
> +snd-soc-fsi-hdmi-objs		:= fsi-hdmi.o
>  snd-soc-migor-objs		:= migor.o
>  
>  obj-$(CONFIG_SND_SH7760_AC97)	+= snd-soc-sh7760-ac97.o
>  obj-$(CONFIG_SND_FSI_AK4642)	+= snd-soc-fsi-ak4642.o
>  obj-$(CONFIG_SND_FSI_DA7210)	+= snd-soc-fsi-da7210.o
> +obj-$(CONFIG_SND_FSI_HDMI)	+= snd-soc-fsi-hdmi.o
>  obj-$(CONFIG_SND_SIU_MIGOR)	+= snd-soc-migor.o
> diff --git a/sound/soc/sh/fsi-hdmi.c b/sound/soc/sh/fsi-hdmi.c
> new file mode 100644
> index 0000000..cb81b8c
> --- /dev/null
> +++ b/sound/soc/sh/fsi-hdmi.c
> @@ -0,0 +1,67 @@
> +/*
> + * FSI - HDMI sound support
> + *
> + * Copyright (C) 2010 Renesas Solutions Corp.
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <sound/sh_fsi.h>
> +#include <video/sh_mobile_hdmi.h>
> +
> +static struct snd_soc_dai_link fsi_dai_link = {
> +	.name		= "HDMI",
> +	.stream_name	= "HDMI",
> +	.cpu_dai	= &fsi_soc_dai[FSI_PORT_B],
> +	.codec_dai	= &sh_hdmi_dai,
> +};
> +
> +static struct snd_soc_card fsi_soc_card  = {
> +	.name		= "FSI",
> +	.platform	= &fsi_soc_platform,
> +	.dai_link	= &fsi_dai_link,
> +	.num_links	= 1,
> +};
> +
> +static struct snd_soc_device fsi_snd_devdata = {
> +	.card		= &fsi_soc_card,
> +	.codec_dev	= &soc_codec_dev_sh_hdmi,
> +};
> +

The DAI link construction has changed recently. Can you redo against
Mark's for-2.6.37 branch.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
