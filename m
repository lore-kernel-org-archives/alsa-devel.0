From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/53] ASoC: switch over to
	use	snd_soc_register_component()
Date: Tue, 19 Mar 2013 09:35:55 +0100
Message-ID: <5148236B.8050405@metafoo.de>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <51473657.5000104@metafoo.de>
 <87vc8ofcuo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C8A5261639
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 09:33:41 +0100 (CET)
In-Reply-To: <87vc8ofcuo.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/19/2013 01:32 AM, Kuninori Morimoto wrote:
> 
> Hi Lars
> 
>>> These patches switch over to use snd_soc_register_component()
>>> instead of snd_soc_register_dai[s]() on all drivers
>>> Last patch moves snd_soc_[un]register_dai[s]() to non global function.
>>>
>>> I could compile test on some of them, but couldn't for all drivers
>>>
>>> These patches are based on asoc/topic/component branch
>>>
>>
>> Hi,
>>
>> quite a few drivers use snd_soc_register_dai(), while
>> snd_soc_register_component() uses snd_soc_register_dais().
>> snd_soc_register_dai() uses fmt_single_name(), while snd_soc_register_dais()
>> uses fmt_multiple_name() to create the name for the device. So for all
>> drivers using snd_soc_register_dai() the name of the DAI is different now,
>> which will break the name based matching of the dai link.
> 
> Thank you for pointing it.
> I understand about this.
> 
> I think if snd_soc_register_component() can use propely
> snd_soc_register_dai() and snd_soc_register_dais(),
> this issue is solved ?

This will fix it for most drivers, but there are a couple of drivers which use
snd_soc_register_dais with 1 dai.

E.g. tegra/tegra20_ac97.c, sh/siu_dai.c, sh/hac.c, sh.ssi.c

- Lars
