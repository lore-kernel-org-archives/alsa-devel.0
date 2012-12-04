From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC][PATCH 1/2] ASoC: add
	snd_soc_of_parse_daifmt()
Date: Tue, 04 Dec 2012 13:18:35 -0700
Message-ID: <50BE5A9B.1020500@wwwdotorg.org>
References: <87txs9hvy7.wl%kuninori.morimoto.gx@renesas.com>
 <87sj7thvwy.wl%kuninori.morimoto.gx@renesas.com>
 <50B6F0F7.1050902@wwwdotorg.org>
 <87sj7snd0z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 14EA0264F40
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 21:18:41 +0100 (CET)
In-Reply-To: <87sj7snd0z.wl%kuninori.morimoto.gx@renesas.com>
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

On 11/29/2012 05:35 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
>> I think it'd be more typical to represent as a single integer property,
>> where the value is an enumeration indicating the type.
> 
> Sorry, I couldn't understand correctly this.
> Do you mean like this ?
>
>   snd.soc.daifmt.format      = <3> /* SND_SOC_DAIFMT_LEFT_J */
>   snd.soc.daifmt.clock_gate  = <1> /* SND_SOC_DAIFMT_CONT */
>   snd.soc.daifmt.inversion   = <3> /* SND_SOC_DAIFMT_IB_NF */
>   snd.soc.daifmt.hw_clock    = <2> /* SND_SOC_DAIFMT_CBS_CFM */

Sorry for the slow response.

What I meant was that rather than:

> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "i2s", SND_SOC_DAIFMT_I2S);
> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "right_j", SND_SOC_DAIFMT_RIGHT_J);
> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "left_j", SND_SOC_DAIFMT_LEFT_J);
> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "dsp_a", SND_SOC_DAIFMT_DSP_A);
> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
> +					 "dsp_b", SND_SOC_DAIFMT_DSP_B);

I'd expect to see something more like:

fmt = of_property_read_u32_array(np, "bit-format");

But perhaps your binding is representing the set of possible legal
formats? I had assumed it was attempting to represent the single
specific format to choose.

Related, I also wasn't suggesting combining format, clock-gate,
inversion, ... into a single property.

> I added SND_SOC_DAIFMT_xxx here,
> but this style is not readable/understandable for me.
> And it is difficult to keep compatible if the number was changed.
> (never happen ? I'm not sure)

Well, once a DT binding is created, you can't change the numbers, or you
would break the ability for an old DT to work with a newer kernel.

> How about to use string ?
> 
>   snd.soc.daifmt.format      = "left_j"
>   snd.soc.daifmt.clock_gate  = "cont"
>   snd.soc.daifmt.inversion   = "ib_nf"
>   snd.soc.daifmt.hw_clock    = "cbs_cfm"

That's probably the best we can do for now. Using a pre-processor would
be best:

#define SND_SOC_DAIFMT_LEFT_J 3

snd.soc.daifmt.format = <SND_SOC_DAIFMT_LEFT_J>;

... but we can't do that yet...
