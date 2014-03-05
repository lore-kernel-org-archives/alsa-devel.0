From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: About snd_dmaengine_pcm_trigger()
Date: Wed, 05 Mar 2014 08:42:26 +0100
Message-ID: <5316D562.3010901@metafoo.de>
References: <87eh2hql03.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 509E126500A
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 08:41:57 +0100 (CET)
In-Reply-To: <87eh2hql03.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Simon <horms@verge.net.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 03/05/2014 06:20 AM, Kuninori Morimoto wrote:
> Hi Mark, Lars and all
>
> I need your opinion
>
> Now, I'm working for ${LINUX}/sound/soc/sh/fsi and ${LINUX}/sound/soc/sh/rcar drirvers.
> These drivers are supporting DMAEngine transfer,
> but it is using original DMAEngine method,
> not using snd_dmaengine_pcm_trigger() or snd_dmaengine_pcm_register().
> I was requested to use it from Mark.
>
> The reason why I couldn't use it was our DMAEngine
> didn't have "cyclic" tranfer support which is used on
> dmaengine_pcm_prepare_and_submit()
> But now, I created cyclic support on our DMA driver (on my local PC at this point)
>
> Then, I noticed our drivers still can't use snd_dmaengine_pcm_xxx() method.
>
> 1st, our device needs PIO tranfer support too.
> Current PIO/DMA transfer are sharing many methods/functions.
> Code will become difficult to read if it is separated forcibly.
> (to using snd_dmaengine_pcm_xxx())

Ideally from a high level abstraction point of few PIO and DMA would be two 
completely separate components that can be used interchangeably. There might 
be hardware restrictions though that do not allow this.

>
> 2nd, our device DMA ON/OFF timing has relation ship to other register settings.
> Unfortunately, our device is picky, it needs like this
>
>                 HW init setting -> DMA ON -> HW start setting

What kind of HW init is this?

>
> It can be solved if snd_dmaengine_pcm_xxx() has callbacks,
> but many callbacks are needed...

You can wrap the snd_dmaengine_pcm functions in your pcm_ops callbacks, like 
this:

int sh_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
{
	init hw ...
	
	snd_dmaengine_pcm_trigger(substream, cmd);

	start hw ...
}

Each of the snd_dmaengine_pcm functions does pretty much one specific task. 
There is not much room for inserting callbacks.

>
> 3rd, our device needs special method on snd_pcm_ops
> int the future.
>

What kind of special ops?

>  From my point of view,
> our driver can replace to use "cyclic" DMA transfer
> instead of current original DMAEngine method.
> I guess, it is not difficult.
> But, using snd_dmaengine_pcm_xxx() is difficult.
>

I don't think using the snd_dmaengine_pcm helpers should be difficult, 
since, as I said, each of them perform one very specific task. If you'd 
directly call the dmaengine API you'd end up with pretty much the same code 
as the dmaengine PCM helpers. What's more of a challenge would be to use the 
generic dmaengine PCM driver.

I think the issue with the sound/soc/sh/ code is that there never was a 
clean separation between the DMA/PIO and the DAI configuration code. And 
especially with rcar you seem to be reimplementing a ASoC-like framework 
on-top of ASoC. Which makes it rather hard to reused generic code, since the 
generic code doesn't know about all the custom hooks and callbacks. The ASoC 
framework is not set in stone, if there is something missing to properly 
support your hardware you should try to extend the framework to support this 
rather than working around it in your drivers.

- Lars
