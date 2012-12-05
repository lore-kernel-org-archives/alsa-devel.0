From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC][PATCH 1/2] ASoC: add
	snd_soc_of_parse_daifmt()
Date: Wed, 05 Dec 2012 13:42:05 -0700
Message-ID: <50BFB19D.40504@wwwdotorg.org>
References: <87txs9hvy7.wl%kuninori.morimoto.gx@renesas.com>
 <87sj7thvwy.wl%kuninori.morimoto.gx@renesas.com>
 <50B6F0F7.1050902@wwwdotorg.org>
 <87sj7snd0z.wl%kuninori.morimoto.gx@renesas.com>
 <50BE5A9B.1020500@wwwdotorg.org>
 <87wqwx7x1u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id AE85F2650E7
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 21:42:11 +0100 (CET)
In-Reply-To: <87wqwx7x1u.wl%kuninori.morimoto.gx@renesas.com>
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

On 12/05/2012 12:55 AM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> Cc  Mark
> 
> Thank you for your reply
> 
>>> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
>>> +					 "i2s", SND_SOC_DAIFMT_I2S);
>>> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
>>> +					 "right_j", SND_SOC_DAIFMT_RIGHT_J);
>>> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
>>> +					 "left_j", SND_SOC_DAIFMT_LEFT_J);
>>> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
>>> +					 "dsp_a", SND_SOC_DAIFMT_DSP_A);
>>> +	ret |= __snd_soc_of_parse_daifmt(np, prefix, fmt,
>>> +					 "dsp_b", SND_SOC_DAIFMT_DSP_B);
>>
>> I'd expect to see something more like:
>>
>> fmt = of_property_read_u32_array(np, "bit-format");
> 
> Ahh... I see.
> 
>> Well, once a DT binding is created, you can't change the numbers, or you
>> would break the ability for an old DT to work with a newer kernel.
> 
> OK. I understand.
> 
>>> How about to use string ?
>>>
>>>   snd.soc.daifmt.format      = "left_j"
>>>   snd.soc.daifmt.clock_gate  = "cont"
>>>   snd.soc.daifmt.inversion   = "ib_nf"
>>>   snd.soc.daifmt.hw_clock    = "cbs_cfm"
>>
>> That's probably the best we can do for now. Using a pre-processor would
>> be best:
>>
>> #define SND_SOC_DAIFMT_LEFT_J 3
>>
>> snd.soc.daifmt.format = <SND_SOC_DAIFMT_LEFT_J>;
>>
>> ... but we can't do that yet...
> 
> Thank you.
> 
> I tried v2 of snd_soc_of_parse_daifmt() which is using "string" and "array" style
> 
> 	[prefix]snd,soc,daifmt = "i2c", "nb_if", "cbm_cfm";

I assume you mean i2s not i2c there.

That seems to be overloading one property so that it contains a lot of
separate data items. I'd expect separate properties for the format, the
bitclock inversion, the frame inversion, the bitclock master, and the
frame master.
