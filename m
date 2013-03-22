From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 19/54 v2] ASoC: switch over to use
 snd_soc_register_component() on mpc5200 i2s
Date: Thu, 21 Mar 2013 23:04:05 -0600
Message-ID: <514BE645.2050409@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87boaddox7.wl%kuninori.morimoto.gx@renesas.com>
 <514B3B07.4030309@wwwdotorg.org>
 <87620kfcy4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F8402661C2
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 06:04:08 +0100 (CET)
In-Reply-To: <87620kfcy4.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2013 07:19 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> Thank you for pointing it
> 
>>> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
>>
>>> @@ -163,7 +167,8 @@ static int psc_i2s_of_probe(struct platform_device *op)
>>>  	if (rc != 0)
>>>  		return rc;
>>>  
>>> -	rc = snd_soc_register_dais(&op->dev, psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
>>> +	rc = snd_soc_register_component(&op->dev, &psc_i2s_component,
>>> +					psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
>>
>> ARRAY_SIZE(psc_i2s_dai)==1, so this switches from
>> snd_soc_register_dais() to snd_soc_register_dai(). Will that be a problem?
> 
> I didn't notice about it.
> 
> arch/powerpc/boot/dts/lite5200.dts seems the user of this driver,
> but, it was comment-outed.
> And it is using DT, not name matching ?

This one required some more in-depth investigation.

Certainly, there don't appear to be any instance of the device-name or
DAI name string mpc5200-psc-i2s anywhere in the kernel.

However, I do see:

> ./mpc8610_hpcd.c:213:	machine_data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> ./p1022_ds.c:223:	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> ./p1022_rdk.c:226:	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
> ./imx-sgtl5000.c:151:	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);

That's a bit icky; DT-based systems should use .cpu_of_node, not
.cpu_dai_name...

Anyway, as far as I can tell from any of the in-kernel device trees,
this particular mpc5200-psc-i2s device isn't actually instantiated
anywhere. I guess the only users are removed or out-of-tree.

Equally, of those 4 files, the compatible value they're instantiated
from doesn't exist in any in-kernel DT files, except for imx-sgtl5000.c,
and in that case the CPU phandle points at something the definitely
isn't the MPC5200 PSC device.

So, I guess this if probably fine...
