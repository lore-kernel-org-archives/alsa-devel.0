From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 44/54 v2] ASoC: switch over to use
 snd_soc_register_component() on sh4 siu
Date: Thu, 21 Mar 2013 22:39:29 -0600
Message-ID: <514BE081.2080409@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87boadca4t.wl%kuninori.morimoto.gx@renesas.com>
 <514B3CAE.9040400@wwwdotorg.org>
 <878v5gffo7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 79D192661AF
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 05:39:32 +0100 (CET)
In-Reply-To: <878v5gffo7.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2013 06:21 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> Thank you for your checking
> 
> 
>>>  static struct snd_soc_dai_link migor_dai = {
>>>  	.name = "wm8978",
>>>  	.stream_name = "WM8978",
>>> -	.cpu_dai_name = "siu-i2s-dai",
>>> +	.cpu_dai_name = "siu-pcm-audio",
>>
>> I'm not sure what that change is for. The need for it should be
>> described in the commit description.
>>
>>> diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
>>
>>> @@ -783,7 +787,8 @@ static int siu_probe(struct platform_device *pdev)
>>>  	dev_set_drvdata(&pdev->dev, info);
>>>  
>>>  	/* register using ARRAY version so we can keep dai name */
>>> -	ret = snd_soc_register_dais(&pdev->dev, &siu_i2s_dai, 1);
>>> +	ret = snd_soc_register_component(&pdev->dev, &siu_i2s_component,
>>> +					 &siu_i2s_dai, 1);
>>
>> That changes from snd_soc_register_dais() to snd_soc_register_dai().
>> Will that be a problem?
> 
> I think .cpu_dai_name will be "siu-i2s-dai" if it used dais(),
> and it will be "siu-pcm-audio" if it used dai()

Ah right, the difference between fmt_single_name() and
fmt_multiple_name() is dev_name() vs. dai_drv->name; I thought it was
just about including the device ID from dev_name(), or chopping it off.
So, I think this is fine.

A description of the change to migor_dai would be useful to explain this
though.
