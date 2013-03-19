From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/53] ASoC: switch over to
	use	snd_soc_register_component()
Date: Tue, 19 Mar 2013 09:38:57 -0600
Message-ID: <51488691.2040508@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <51473657.5000104@metafoo.de>
 <87vc8ofcuo.wl%kuninori.morimoto.gx@renesas.com>
 <5148236B.8050405@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id CAA40260314
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 16:39:03 +0100 (CET)
In-Reply-To: <5148236B.8050405@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Lucas Stach <dev@lynxeye.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/19/2013 02:35 AM, Lars-Peter Clausen wrote:
> On 03/19/2013 01:32 AM, Kuninori Morimoto wrote:
>>
>> Hi Lars
>>
>>>> These patches switch over to use snd_soc_register_component()
>>>> instead of snd_soc_register_dai[s]() on all drivers
>>>> Last patch moves snd_soc_[un]register_dai[s]() to non global function.
>>>>
>>>> I could compile test on some of them, but couldn't for all drivers
>>>>
>>>> These patches are based on asoc/topic/component branch
>>>>
>>>
>>> Hi,
>>>
>>> quite a few drivers use snd_soc_register_dai(), while
>>> snd_soc_register_component() uses snd_soc_register_dais().
>>> snd_soc_register_dai() uses fmt_single_name(), while snd_soc_register_dais()
>>> uses fmt_multiple_name() to create the name for the device. So for all
>>> drivers using snd_soc_register_dai() the name of the DAI is different now,
>>> which will break the name based matching of the dai link.
>>
>> Thank you for pointing it.
>> I understand about this.
>>
>> I think if snd_soc_register_component() can use propely
>> snd_soc_register_dai() and snd_soc_register_dais(),
>> this issue is solved ?
> 
> This will fix it for most drivers, but there are a couple of drivers which use
> snd_soc_register_dais with 1 dai.
> 
> E.g. tegra/tegra20_ac97.c, sh/siu_dai.c, sh/hac.c, sh.ssi.c

I believe this can be fixed simply by adjusting the relevant machine
driver(s) to match whatever the new name is.

Any change to tegra20_ac97.c would only affect
sound/soc/tegra/tegra_wm9712.c's struct tegra_wm9712_dai .cpu_dai_name
field. I suspect the correct fix might be to just remove the assignment
to .cpu_dai_name in tegra_wm9712.c; I think that because the
.cpu_of_node field is always set by that driver, the value of
.cpu_dai_name is never used? Anyway, if you fix tegra_wm9712.c in your
patch, I hope that Lucas Stach can test it.
