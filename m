From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 1/xx][sample] ASoC: add COMPONENT_FUNC()
 macro for snd_soc_component_driver
Date: Wed, 3 Aug 2016 21:16:33 +0200
Message-ID: <7de0934c-6d6a-ad51-7d5a-693bcf999a56@metafoo.de>
References: <87k2fy8xy5.wl%kuninori.morimoto.gx@renesas.com>
 <87invi8xwc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87invi8xwc.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/03/2016 03:13 AM, Kuninori Morimoto wrote:
> snd_soc_component_driver requests some struct xxx, and int num_xxx.
> To make initialize easy, this patch adds COMPONENT_FUNC() macro.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 6144882..41c21f9 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -795,6 +795,9 @@ struct snd_soc_component_driver {
>  	int probe_order;
>  	int remove_order;
>  };
> +#define COMPONENT_FUNC(name, func)		\
> +	.name		= func,			\
> +	.num_##name	= ARRAY_SIZE(func)

I'd avoid like to a void this kind of macro. Sure it slightly reduces
boilerplate code, but it is difficult to parse for both humans as well as
machines. Makes the code much less intuitive to understand and also breaks
automated scripts.
