From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] ASoC: fsi: Add new funtion for SPDIF
Date: Wed, 28 Jul 2010 11:16:10 +0100
Message-ID: <1280312170.3085.544.camel@odin>
References: <w3pd3u8gvpw.wl%kuninori.morimoto.gx@renesas.com>
	<w3p8w4wgvny.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BD87624414
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 12:16:13 +0200 (CEST)
Received: by wyb42 with SMTP id 42so3815917wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2010 03:16:13 -0700 (PDT)
In-Reply-To: <w3p8w4wgvny.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-07-28 at 11:57 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/sh_fsi.h |    2 +
>  sound/soc/sh/fsi.c     |   60 ++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/sh_fsi.h b/include/sound/sh_fsi.h
> index 6ac7186..9d51d6f 100644
> --- a/include/sound/sh_fsi.h
> +++ b/include/sound/sh_fsi.h
> @@ -64,6 +64,8 @@
>  #define SH_FSI_FMT_I2S		3
>  #define SH_FSI_FMT_TDM		4
>  #define SH_FSI_FMT_TDM_DELAY	5
> +#define SH_FSI_FMT_SPDIF	6
> +
>  
>  #define SH_FSI_IFMT_TDM_CH(x) \
>  	(SH_FSI_IFMT(TDM)	| SH_FSI_SET_CH_I(x))
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 4b09b3d..0bcdfcc 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -30,9 +30,11 @@
>  #define DIDT		0x0020
>  #define DODT		0x0024
>  #define MUTE_ST		0x0028
> -#define REG_END		MUTE_ST
> -
> +#define OUT_SEL		0x0030
> +#define REG_END		OUT_SEL
>  
> +#define A_MST_CTLR	0x0180
> +#define B_MST_CTLR	0x01A0
>  #define CPU_INT_ST	0x01F4
>  #define CPU_IEMSK	0x01F8
>  #define CPU_IMSK	0x01FC
> @@ -43,7 +45,7 @@
>  #define CLK_RST		0x0210
>  #define SOFT_RST	0x0214
>  #define FIFO_SZ		0x0218
> -#define MREG_START	CPU_INT_ST
> +#define MREG_START	A_MST_CTLR
>  #define MREG_END	FIFO_SZ
>  
>  /* DO_FMT */
> @@ -54,6 +56,7 @@
>  #define CR_I2S		(0x3 << 4)
>  #define CR_TDM		(0x4 << 4)
>  #define CR_TDM_D	(0x5 << 4)
> +#define CR_SPDIF	(0x00100120)

Parenthesis not required here.


All Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
