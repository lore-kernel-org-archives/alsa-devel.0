From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/4 v6] ASoC: add .of_xlate_dai_name
 callback on struct snd_soc_dai_driver
Date: Wed, 20 Feb 2013 11:13:27 -0700
Message-ID: <51251247.7060704@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
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
 <871ucjuu7g.wl%kuninori.morimoto.gx@renesas.com>
 <5123E664.7090107@wwwdotorg.org> <5123E972.40307@wwwdotorg.org>
 <87mwuz94vo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id F17612616F1
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 19:13:30 +0100 (CET)
In-Reply-To: <87mwuz94vo.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/19/2013 05:59 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
>>>> +const char *snd_soc_of_get_port_dai_name(struct device_node *of_node,
>>>> +					 const char *prop)
>>>> +{
>>>> +	struct snd_soc_dai *dai;
>>>> +	struct of_phandle_args args;
>>>> +	const char *name;
>>>> +	int ret;
>>>> +
>>>> +	ret = of_parse_phandle_with_args(of_node, prop,
>>>> +					 "#sound-dai-cells", 0, &args);
>>>> +	if (ret)
>>>> +		return NULL;
>>>> +	of_node_put(args.np);
>>>> +
>>>> +	list_for_each_entry(dai, &dai_list, list) {
>>>
>>> I think this should iterate over the list of CODEC drivers that are
>>> registered, and then ask the driver to translate from the args to the
>>> DAI name. Here, you're iterating over the list of registered DAIs, which
>>> is something entirely different.
>>
>> Ah. I guess here is the issue:
>>
>> For CODECs, ASoC actually knows about a CODEC object, so you can imagine
>> asking the CODEC object to translate from some a DT DAI specifier to a
>> DAI name, and then look up the DAI using the combination of CODEC plus
>> DAI name.
>>
>> However, the CPU DAIs, there is no object that contains the DAIs; only
>> the DAIs exist. Thus, there's nothing to ask "which of your DAIs does
>> this DT DAI specifier correspond to?".
>>
>> Now presumably there is a platform device for the FSI device, just like
>> there's a platform device for the AK4642 CODEC. Can we create an ASoC
>> "CPU" device for the FSI device too, to act as the DAI container? Or can
>> we alter this patch series to query the platform device rather than some
>> ASoC device in order to do the DT DAI specifier to DAI name translation?
>>
>> As an aside, I now recall this lack of symmetry from when I was working
>> on enhancing the Tegra30 ASoC driver to support DPCM and similar; I
>> ended up pretending that the CPU I2S interface was actually a CODEC with
>> 1 DAI in order to model the CPU DAIs and real CODEC DAIs in a more
>> similar fashion.
> 
> Thank you for understanding my last resort :)
> 
> I don't want to create new feature (= snd_soc_register_cpu)
> on ASoC only for simple-card.
> But now, simple-card is assuming CPU device and Platform device is same one.
> 
> If my understanding was correct,
> struct snd_soc_platform_driver

I don't think a platform device would want an of_xlate_dai_name
function; a platform device is not what provides the DAI and hence it
shouldn't be involved in translating a DT DAI specifier into a DAI name.

> struct snd_soc_codec_driver
> will have new ".of_xlate_dai_name".

Yes, putting the function into the CODEC driver makes sense.

I guess that snd_soc_register_dai() and snd_soc_register_dais() already
are the equivalent of snd_soc_register_cpu(); they are already passed
the struct device that implements the DAIs, and hence if you pass that
struct back to the DAI driver's of_xlate_dai_name function, it should
have enough information to do the mapping: the dev contains the platform
data the DAI driver can use to perform the mapping.

I guess the algorithm should be:

* Find a CODEC device that was instantiated from the DT node referenced
by the phandle.

* If found, ask the CODEC to translate, and use the result. This
function would be passed the CODEC pointer and phandle args.

* Find any DAI, that is not part of a CODEC, that was instantiated from
the DT node referenced by the phandle.

* If found, ask the driver of the DAI to translate. This function would
probably have to be passed the DT node as well as the first DAI you
found, plus the phandle args.

* If nothing found above, fail.
