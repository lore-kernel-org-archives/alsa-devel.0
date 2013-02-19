From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/4 v6] ASoC: add .of_xlate_dai_name callback on struct
 snd_soc_dai_driver
Date: Tue, 19 Feb 2013 14:06:58 -0700
Message-ID: <5123E972.40307@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
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
 <871ucjuu7g.wl%kuninori.morimoto.gx@renesas.com>
 <5123E664.7090107@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5123E664.7090107-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/19/2013 01:53 PM, Stephen Warren wrote:
> On 02/14/2013 02:21 AM, Kuninori Morimoto wrote:
>> ASoC sound driver requires CPU/CODEC drivers for probing,
>> and each CPU/CODEC has some DAI on it.
>> Then, "dai name matching" have been used to identify
>> CPU-CODEC DAI pair on ASoC.
>>
>> But, the "dai port number matching" is now required from DeviceTree.
>> The solution of this issue is to replace the dai port number into dai name,
>> and it needs some kind of .of_xlate function on each driver.
>>
>> This patch adds .of_xlate_dai_name callback interface
>> on struct snd_soc_dai_driver,
>> very basic/common snd_soc_common_of_xlate_dai_name()
>> which replace the dai port number into dai name,
>> and snd_soc_of_get_port_dai_name() which is using .of_xlate_dai_name.
>>
>> Then, #sound-dai-cells which enables DAI specifier is required
>> on CPU/CODEC device tree properties.
...
>> +const char *snd_soc_of_get_port_dai_name(struct device_node *of_node,
>> +					 const char *prop)
>> +{
>> +	struct snd_soc_dai *dai;
>> +	struct of_phandle_args args;
>> +	const char *name;
>> +	int ret;
>> +
>> +	ret = of_parse_phandle_with_args(of_node, prop,
>> +					 "#sound-dai-cells", 0, &args);
>> +	if (ret)
>> +		return NULL;
>> +	of_node_put(args.np);
>> +
>> +	list_for_each_entry(dai, &dai_list, list) {
> 
> I think this should iterate over the list of CODEC drivers that are
> registered, and then ask the driver to translate from the args to the
> DAI name. Here, you're iterating over the list of registered DAIs, which
> is something entirely different.

Ah. I guess here is the issue:

For CODECs, ASoC actually knows about a CODEC object, so you can imagine
asking the CODEC object to translate from some a DT DAI specifier to a
DAI name, and then look up the DAI using the combination of CODEC plus
DAI name.

However, the CPU DAIs, there is no object that contains the DAIs; only
the DAIs exist. Thus, there's nothing to ask "which of your DAIs does
this DT DAI specifier correspond to?".

Now presumably there is a platform device for the FSI device, just like
there's a platform device for the AK4642 CODEC. Can we create an ASoC
"CPU" device for the FSI device too, to act as the DAI container? Or can
we alter this patch series to query the platform device rather than some
ASoC device in order to do the DT DAI specifier to DAI name translation?

As an aside, I now recall this lack of symmetry from when I was working
on enhancing the Tegra30 ASoC driver to support DPCM and similar; I
ended up pretending that the CPU I2S interface was actually a CODEC with
1 DAI in order to model the CPU DAIs and real CODEC DAIs in a more
similar fashion.
