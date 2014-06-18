From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 09/12] ASoC: rsnd: enable SRC setting via DT
Date: Wed, 18 Jun 2014 18:20:18 +0400
Message-ID: <53A1A022.1020801@cogentembedded.com>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
 <87zjhay4s6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 74AD7261A1D
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 16:20:13 +0200 (CEST)
Received: by mail-la0-f42.google.com with SMTP id pn19so582444lab.29
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 07:20:13 -0700 (PDT)
In-Reply-To: <87zjhay4s6.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sh@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello.

On 06/18/2014 12:56 PM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> some special board wants to exchange sampling rate by using SRC.
> This patch enables its settings.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[...]

> diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
> index 4d39505..93a5e58 100644
> --- a/sound/soc/sh/rcar/src.c
> +++ b/sound/soc/sh/rcar/src.c
[...]
> @@ -640,6 +640,16 @@ static void rsnd_of_parse_src(struct platform_device *pdev,
>   	info->src_info		= src_info;
>   	info->src_info_nr	= nr;
>
> +	i = 0;
> +	for_each_child_of_node(src_node, np) {
> +		src_info = info->src_info + i;
> +
> +		of_property_read_u32(src_node, "convert-rate",

    Are you sure it's 'src_node' here, not 'np'?

> +				     &src_info->convert_rate);
> +
> +		i++;
> +	}
> +

WBR, Sergei
