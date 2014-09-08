From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: simle-card DT style for DPCM
Date: Mon, 08 Sep 2014 09:39:23 +0200
Message-ID: <540D5D2B.5080504@metafoo.de>
References: <877g1o18ka.wl%kuninori.morimoto.gx@gmail.com>	<20140901143047.GX29327@sirena.org.uk>	<87mwaikdzx.wl%kuninori.morimoto.gx@gmail.com>	<20140902113407.GV29327@sirena.org.uk>	<87fvg97ecd.wl%kuninori.morimoto.gx@gmail.com>	<20140905155513.GE29327@sirena.org.uk>
 <877g1fotdd.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-029.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D252617BB
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 09:39:20 +0200 (CEST)
In-Reply-To: <877g1fotdd.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 09/08/2014 02:20 AM, Kuninori Morimoto wrote:
>
> Hi Mark
>
>>> I wonder how to know it in driver ?
>>> (How to switch normal <-> FE/BE ?, and how to know FE or BE ?)
>>> Can you show me objectivization example / idea ?
>>
>> Surely we can just put a data table or two in there with all the routing
>> inside the IP in the same way that we handle routing within CODECs?  It
>> doesn't seem like a fundamentally different problem.
>
> We can use this idea inside C code,
> then, we need decide to use it or not use it somehow ?
> We can do everything in C code, I have no concern about it.
> But, my main concern is that how to decide this switching from DT file.
> How to decide to use this "data table" ?
> Does this mean you can accept new compatible ?
>
>       compatible = "simple-audio-card"; # normal simple-card
>
>       compatible = "soc-audio-card";    # special sound card
>                                         # we use DPCM this time

If there is no difference in hardware there shouldn't be any difference in 
the hardware description.

Lets try to get to the bottom of the problem. Why do you want to enable DPCM 
on some cards and not enable it on others?

- Lars
