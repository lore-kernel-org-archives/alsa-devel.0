From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: About ALSA SoC cpu/codec asymmetry
Date: Mon, 10 Mar 2014 08:14:22 +0100
Message-ID: <531D664E.705@metafoo.de>
References: <8738iqst0t.wl%kuninori.morimoto.gx@gmail.com>
 <531D5ED4.4090208@metafoo.de> <8761nmsffx.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D3A6264F02
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 08:13:47 +0100 (CET)
In-Reply-To: <8761nmsffx.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 08:03 AM, Kuninori Morimoto wrote:
>
> Hi Lars
>
>> There is already a cpu_name field for the DAI link struct and it is ignored
>> when it is NULL. See
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/soc/soc-core.c#n870
>
> indeed
> Thanks
>
>> I have a patch that makes using cpu_name mandatory for new component
>> drivers. And then we can slowly start to convert old platforms.
>
> Nice !
>
> Basically, my worry is cpu/codec "asymmetry" data structure.
> (Maybe it came from "historical" reason?)

Yep.

>
> I would like to have new "struct snd_soc_cpu" and "snd_soc_register_cpu()"
> instead of current "component" if possible.
> It is understandable.

The patchset I'm working goes the other direction. The idea is to eventually 
remove snd_soc_codec and only have snd_soc_component. With modern SoCs the 
CPU side isn't just a dumb DAI anymore, but you often have signal routing 
and mixing capabilities, sample rate converters, sometimes even a full DSP. 
And then there are also those SoCs which have a DAC and/or ADC directly 
built-in. This makes them complexity wise similar to the CODEC side and 
having things like DAPM and our set of standard predefined kcontrols makes 
it easier to manage them.

- Lars
