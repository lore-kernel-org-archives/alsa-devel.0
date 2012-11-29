From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC][PATCH 1/2] ASoC: add
	snd_soc_of_parse_daifmt()
Date: Wed, 28 Nov 2012 22:21:59 -0700
Message-ID: <50B6F0F7.1050902@wwwdotorg.org>
References: <87txs9hvy7.wl%kuninori.morimoto.gx@renesas.com>
 <87sj7thvwy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D83C0264F1E
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 06:22:00 +0100 (CET)
In-Reply-To: <87sj7thvwy.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/28/2012 09:31 PM, Kuninori Morimoto wrote:
> ALSA SoC system is using SND_SOC_DAIFMT_xxx flags on each platform,
> and its value might be updated for some reason.
> This means that if platform is using Device Tree
> and if it gets parameter value directly,
> it is difficult to keep compatible on each platform Device Tree.
> This patch adds snd_soc_of_parse_daifmt() to solve this issue.
> Each platform can use [prefix]snd,soc,daifmt,xxx to set
> SND_SOC_DAIFMT_XXX on Device Tree.

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c

> +static int __snd_soc_of_parse_daifmt(struct device_node *np,
> +				     const char *prefix, unsigned int *fmt,
> +				     const char *propname, unsigned int val)
> +{
> +	char str[128];
> +	int ret;
> +
> +	snprintf(str, 128, "%ssnd,soc,daifmt,%s", prefix, propname);
> +	ret = of_property_read_bool(np, str);
> +	if (ret)
> +		*fmt |= val;
> +
> +	return ret;
> +}
> +
> +int snd_soc_of_parse_daifmt(struct device_node *np,
> +			    const char *prefix, unsigned int *fmt)
> +{
> +	int ret = 0;
> +	char pre[] = "";
> +
> +	if (!prefix)
> +		prefix = pre;
> +
> +	/*
> +	 * it will find "[prefix]snd,soc,daifmt,xxx" from device_node,
> +	 * and set SND_SOC_DAIFMT_XXX
> +	 */
> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "i2s", SND_SOC_DAIFMT_I2S);
> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "right_j", SND_SOC_DAIFMT_RIGHT_J);
> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "left_j", SND_SOC_DAIFMT_LEFT_J);
...

I think it'd be more typical to represent as a single integer property,
where the value is an enumeration indicating the type.

But isn't there a lot more to the DAI format than just the format enum
itself?
