From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5 v7][RFC] ASoC: add
	snd_soc_register_cpu()
Date: Fri, 01 Mar 2013 21:50:07 +0100
Message-ID: <5131147F.5090901@metafoo.de>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
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
 <87mwuptgju.wl%kuninori.morimoto.gx@renes as.com>
 <512FACAC.1000808@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F742602AC
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 21:48:13 +0100 (CET)
In-Reply-To: <512FACAC.1000808@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/28/2013 08:14 PM, Stephen Warren wrote:
> On 02/27/2013 05:42 PM, Kuninori Morimoto wrote:
>>
>> Hi Stephen
>>
>>> On 02/25/2013 01:51 AM, Kuninori Morimoto wrote:
>>>> Current ASoC has register function for platform/codec/dai/card,
>>>> but doesn't have for cpu.
>>>> It often produces confusion and fault on ASoC.
>>>> This patch adds very basic register function for cpu
>>>
>>> This seems reasonable to me.
>>>
>>> I can't recall how much influence the existing CODEC objects have on the
>>> various routing/matching decisions inside the ASoC core. While this
>>> patch does register and unregister CPU objects, I wonder if it should
>>> have more impact on any of the existing core code? Certainly I'd expect
>>> the CPU objects to show up in ASoC's debugfs and any similar files...
>>
>> This patch doesn't have any impact to existing drivers.
>> It just added new cpu list.
> 
> Sure. My point was that now you've added the list, perhaps the core ASoC
> code might want to make use of it in the same way it makes use of CODEC
> objects, since it's logically equivalent.

In my opinion it makes sense to get rid of the distinction between CPU objects
and CODEC objects in this case and instead introduce some kind of DAI container
object. I mean the distinction is mostly for historic reasons from a time where
it was only possible to bind a the cpu_dai of a link to a CPU DAI and the
codec_dai to a CODEC DAI. But these dais both can for example be bound CODEC
DAIs. I think to have a common base here would allow us to do some cleanups to
the ASoC core and also avoid the duplication with snd_soc_of_get_cpu_dai_name
and snd_soc_of_get_codec_dai_name which was introduced in this series.

- Lars
