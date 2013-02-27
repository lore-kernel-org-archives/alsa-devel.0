From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/5 v7][RFC] ASoC: add .of_xlate_dai_name on
 snd_soc_cpu_cpu/codec_driver
Date: Wed, 27 Feb 2013 15:56:50 -0700
Message-ID: <512E8F32.9090501@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <87halw7sij.wl%kuninori.morimoto.gx@renesas.com>
 <5110349D.3050308@wwwdotorg.org>
 <87ehgvrs1h.wl%kuninori.morimoto.gx@renesas.com>
 <87bobzrry6.wl%kuninori.morimoto.gx@renesas.com>
 <511963F8.5020107@wwwdotorg.org>
 <87bobqf5yq.wl%kuninori.morimoto.gx@renesas.com>
 <511C22E2.60701@wwwdotorg.org>
 <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
 <511C6A1B.9000507@wwwdotorg.org>
 <874nhfv5mb.wl%kuninori.morimoto.gx@renesas.com>
 <8738wzuu9g.wl%kuninori.morimoto.gx@renesas.com>
 <87a9qsg4lp.wl%kuninori.morimoto.gx@renesas.com>
 <877glwg4fb.wl%kuninori.morimoto.gx@renes as.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <877glwg4fb.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/25/2013 01:53 AM, Kuninori Morimoto wrote:
> ASoC sound driver requires CPU/CODEC drivers for probing,
> and each CPU/CODEC has some DAI on it.
> Then, "dai name matching" have been used to identify
> CPU-CODEC DAI pair on ASoC.
> 
> But, the "dai port number matching" is now required from DeviceTree.
> The solution of this issue is to replace the dai port number into dai name,
> and it needs some kind of .of_xlate function on each driver.
> 
> This patch adds .of_xlate_dai_name callback interface
> on each struct snd_soc_cpu/codec_driver,
> and snd_soc_of_get_cpu/codec_dai_name() which is using .of_xlate_dai_name.
> 
> Then, #sound-dai-cells which enables DAI specifier is required
> on CPU/CODEC device tree properties.

> diff --git a/include/sound/soc.h b/include/sound/soc.h

>  struct snd_soc_cpu_driver {
> +	/* DT */
> +	int (*of_xlate_dai_name)(struct snd_soc_cpu *codec,

s/codec/cpu/

> +int snd_soc_of_get_codec_dai_name(struct device_node *of_node,
> +				  const char **dai_name);
> +int snd_soc_of_get_cpu_dai_name(struct device_node *of_node,
> +				const char **dai_name);

I think you need to return the CODEC and CPU object or name here too.
That'll be needed to fill in the machine driver's {codec,cpu}_of_node
DAI link fields.

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c

> +#define SND_SOC_OF_GET_DAI_NAME(contents) \
> +int snd_soc_of_get_ ## contents ## _dai_name(struct device_node *of_node,\

I would personally leave out the spaces around the ##; seems more
readable to me, but maybe you'd disagree.

s/contents/type/?

...
> +	mutex_lock(&client_mutex);					\
> +	list_for_each_entry(pos, &contents ## _list, list) {		\
> +		if (pos->dev->of_node != args.np)			\
> +			continue;					\
> +									\
> +		if (!pos->driver->of_xlate_dai_name) {			\
> +			ret = -EIO;					\

-ENOSYS seems more appropriate. Even if not, EIO doesn't seem right.

> +EXPORT_SYMBOL_GPL(snd_soc_of_get_codec_dai_name);

I think you can put that macro call into SND_SOC_OF_GET_DAI_NAME().
