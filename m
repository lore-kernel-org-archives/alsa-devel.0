From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: About snd_dmaengine_pcm_trigger()
Date: Tue, 11 Mar 2014 10:47:32 +0100
Message-ID: <531EDBB4.1080008@metafoo.de>
References: <87eh2hql03.wl%kuninori.morimoto.gx@gmail.com>
 <5316D562.3010901@metafoo.de> <874n3dqc4j.wl%kuninori.morimoto.gx@gmail.com>
 <5316EC79.4090202@metafoo.de> <87pplttk8d.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-057.synserver.de
 [212.40.185.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BAAD261680
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 10:46:57 +0100 (CET)
In-Reply-To: <87pplttk8d.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/11/2014 05:47 AM, Kuninori Morimoto wrote:
>
> Hi Lars, Mark
>
>> Make them ASoC components ;) I don't know the hardware, but looking at the
>> code it doesn't seem to be that different from other modern host side audio
>> processing units. But one step at a time, first maybe try and see if you can
>> switch over to using the dmaengine PCM helper functions. Then later thing
>> about how this all can be better integrated into the ASoC framework.
>
> In my quick check,
> I guess, my drivers (FSI/rcar) can use
> ${LINUX}/sound/core/pcm_dmaengine.c methods as 1st step.
>
> OTOH, these drivers has PIO transfer too.
> So, if ALSA has PIO method like pcm_pio.c (?) which has similar method,
> it seems easy to switch over.
> But what do you think ?

If there are other platforms that also do PIO in a very similar way it might 
make sense to factor this out.

The reason why we factored out the dmaengine DMA stuff is because there is a 
standard API that hides the implementation details and is supposed to behave 
the same for each system. For PIO you do not have such a abstraction layer 
that hides the details, so I'm not sure how similar PIO between different 
platforms will actually be.

- Lars
