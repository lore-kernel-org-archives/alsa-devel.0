From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/4 v6] ASoC: fsi: enable
 .of_xlate_dai_name on struct snd_soc_dai_driver
Date: Wed, 20 Feb 2013 13:03:56 +0100
Message-ID: <5124BBAC.30309@metafoo.de>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
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
 <87liaj94nc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-212.synserver.de (smtp-out-212.synserver.de
 [212.40.185.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 19EA5261729
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 13:02:24 +0100 (CET)
In-Reply-To: <87liaj94nc.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/20/2013 02:04 AM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
>> Hmm. I think that the .of_xlate_dai_name should be something related to
>> the object (e.g. CODEC) that contains the DAIs, rather than the DAIs
>> themselves. The intent is to ask some object (e.g. CODEC) which of its
>> DAIs is represented by the DT DAI specifier, not to ask each DAI whether
>> it is represented by that particular DT DAI specifier.
>>
>> Aside from that, I'd expect the patch above to be something more like:
>>
>> const char *fsi_xlate_dai_name(struct snd_soc_dai *dai,
>> 				const struct of_phandle_args *args)
>> {
>> 	switch (args[0]) {
>> 	case 0:
>> 		return fsi_soc_dai[0].name;
>> 	case 1:
>> 		return fsi_soc_dai[1].name;
>> 	default:
>> 		return NULL;
>> 	}
>> }
> 
> Thank you for pointing it.
> I use this style in next patch.

I don't think this makes any more sense than the current version. You still
iterate over all dai instances and call the xlate function for the first dai
where the _parent_ device's of_node matches. You also pass in the this dai
as the first parameter to the xlate function, which makes even less sense
since you can use it to lookup the correct name, which may either be the
dai's name or any of its siblings.

If you want to use the xlate paradigm you really need to keep track of the
cpu devices and make the xlate callback a property of the cpu device. Well
or use a match paradigm instead of xlate.

- Lars
