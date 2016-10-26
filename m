From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4] ASoC: rt286: rt286_mic_detect() uses
 component
Date: Wed, 26 Oct 2016 08:56:15 +0200
Message-ID: <08be64ec-236a-dcc2-5936-9edec930629a@metafoo.de>
References: <87eg3a2v32.wl%kuninori.morimoto.gx@renesas.com>
 <87d1iu2v1j.wl%kuninori.morimoto.gx@renesas.com>
 <s5hshrmnsj2.wl-tiwai@suse.de>
 <e615912f-f6e7-a696-31f2-009c927838ec@metafoo.de>
 <87insi2obs.wl%kuninori.morimoto.gx@renesas.com>
 <5a1187a2-521a-0cd7-856a-ffdc69a045ed@metafoo.de>
 <20161026035045.GB3000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id F064D26663B
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 08:56:27 +0200 (CEST)
In-Reply-To: <20161026035045.GB3000@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jin Yao <yao.jin@linux.intel.co>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 10/26/2016 05:50 AM, Vinod Koul wrote:
> On Mon, Oct 24, 2016 at 11:19:17AM +0200, Lars-Peter Clausen wrote:
>> On 10/24/2016 09:43 AM, Kuninori Morimoto wrote:
>>> Hi
>>>
>>>>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>>>>
>>>>>> Intel broadwell is using card->codec_dev_list, but it will be
>>>>>> replaced to component list soon. Then, it will not be able to use
>>>>>> "codec".
>>>>>
>>>>> Can't it be deduced by a simple container_of()?
>>>>
>>>> There is the snd_soc_component_to_codec() helper for this.
>>>
>>> The points are
>>>  1) We would like to remove "codec" related functions
>>
>> The focus at the moment is to remove all special handling of CODECs from the
>> ASoC core. And trying to do this without being too invasive and causing too
>> many changes all over the place.
>>
>>>  2) We can get "codec" pointer by above function/macro,
>>>     but "codec" function/macro is using codec->component inside.
>>>
>>
>> That's not a problem though.
>>
>> This is slightly unrelated to this series, but these drivers should not be
>> poking the internal data structures of snd_soc_card in the first place. The
>> best way to get the pointer to the CODEC is by using the DAI link init
>> callback. This also means that there is no need to run a lookup each time
>> the CODEC is needed. An alternative is to add a helper function in the core
>> that allows to lookup a component by name.
>>
>> Maybe somebody from the Intel side can look into fixing this. The affected
>> boards are cht_bsw_rt5672 and broadwell, which both access the cards
>> codec_dev_list field.
> 
> This also exists in some customer SKL machines.
> 
> I agree that this may not be best implementation so I can send a patch for
> this.
> 
> As Lars suggested we can use DAI link init callback, but then I dont feel it
> is right to use rtd->codec to get codec pointer, again we will be looking
> into rtd internals. So would make sense to combine two suggestion and add an
> API:
> 
> struct snd_soc_codec *snd_soc_get_codec(struct snd_soc_pcm_runtime *rtd)
> {
> 	return rtd->codec;
> }

I've started working on this series[1] a while ago with the intention of
eventually removing the CODEC field from the rtd struct. Maybe you can use
it as a base.

- Lars

[1]
http://git.metafoo.de/?p=linux-2.6;a=shortlog;h=refs/heads/asoc-remove-pcm-codec
