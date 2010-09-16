From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/4] ASoC: fsi: Add fsi_dma_soft_push/pop
	function
Date: Thu, 16 Sep 2010 14:28:02 +0100
Message-ID: <1284643682.21170.30.camel@vega>
References: <w3p8w32wbmv.wl%kuninori.morimoto.gx@renesas.com>
	<w3p62y6wblb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id CCC18243AE
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 15:28:18 +0200 (CEST)
Received: by pwi4 with SMTP id 4so596442pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2010 06:28:17 -0700 (PDT)
In-Reply-To: <w3p62y6wblb.wl%kuninori.morimoto.gx@renesas.com>
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

On Thu, 2010-09-16 at 13:34 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/fsi.c |   75 +++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 57 insertions(+), 18 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 44a2b6e..156c73b 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -357,11 +357,62 @@ static int fsi_get_fifo_residue(struct fsi_priv *fsi, int is_play)
>  	return residue;
>  }
>  
> +/************************************************************************
> +
> +
> +		dma function
> +
> +
> +************************************************************************/

Btw, is there any need for such a large empty comment here.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
