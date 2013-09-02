From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2][RFC] snd_soc_codec include
	snd_soc_component
Date: Mon, 02 Sep 2013 10:23:45 +0200
Message-ID: <52244B11.10207@metafoo.de>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 26D992608D8
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 10:22:17 +0200 (CEST)
In-Reply-To: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/02/2013 08:02 AM, Kuninori Morimoto wrote:
> 
> Hi Mark, Lars
> 
> These are very rough patch for
> merging snd_soc_codec <-> snd_soc_component.
> As Lars idea, "codec" includes "component" on this patch,
> but it doesn't care about "platform" here,
> since "platform" doesn't have "dai".
> Current component is caring "dai", but... ?
> (and what about "card" ?)
> 
> Anyway, this patch focus only codec <-> component.
> The "driver code" was not big difference,
> since current component is very small at this point.
> 
> Attached 1st patch is rough version of ASoC core code.
> the main topic on this patch is that snd_soc_register_dai[s]
> will be called via component.
> 
> But, we will need many "codec dai name exchange", becouse
>  1) the dai name rule on 1-dai / multi-dai are different,
>     it was depend on snd_soc_register_dai[s].
>  1) component is using both snd_soc_register_dai[s] inside
>     (this was for "cpu" side limit)
>  2) codec have been used snd_soc_register_dais even though
>     it was not multi-dai
> 

We only added the distinction between components with one DAIs and multiple
DAIs since most of the CPU DAI drivers with only one DAI used
snd_soc_register_dai() and we wanted to avoid having to update all the DAI
links. How about adding a boolean flag to __snd_soc_register_component()
which if set causes the function to always use snd_soc_register_dais(). This
will allow us to keep the existing naming for CODEC dai.


> 2nd patch is rough version of "code dai name exchange" for it.
> Of course we need more and more codec driver patches,
> but it is wm8978 only as trial now.
> 
> I guess "codec driver" should have "component driver" pointer too ?
> (it has .name only at this point, and 2nd patch includes it)

In my opinion it is better to embed the component_driver struct into the
codec_driver struct just like the component struct is embedded in the codec
struct. Otherwise your patch looks fine to me. Maybe move
__snd_soc_register_component() up, so the forward declaration is not needed
anymore.

> 
> We can move some feature from codec to component
> after this step ?
> 

Yes. I think most of the fields managed by the core which are not touched by
any drivers can be moved easily.

- Lars
