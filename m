From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5 v7][RFC] ASoC: simple-card DT support
Date: Thu, 11 Jul 2013 16:57:21 +0200
Message-ID: <51DEC7D1.3060001@gmail.com>
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
 <87a9qsg4lp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f178.google.com (mail-ea0-f178.google.com
 [209.85.215.178])
 by alsa0.perex.cz (Postfix) with ESMTP id E9E5C265071
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 16:56:52 +0200 (CEST)
Received: by mail-ea0-f178.google.com with SMTP id l15so5817974eak.9
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 07:56:52 -0700 (PDT)
In-Reply-To: <87a9qsg4lp.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

On 25.02.2013 09:49, Kuninori Morimoto wrote:
> 
> Hi Mark, Stephen, Lars
> 
> These are v7 of simple-card DT support.
> I well considered your comments/advices.
> Then, I noticed that creating snd_soc_register_cpu() is better solution.
> It is very basic/simple version at this point, and I added [RFC] on these patches.
> I hope it is accepted by you, and updated to be more useful.
> Now, snd_soc_codec, and snd_soc_cpu has .of_xlate_dai_name() callback.
> 
> Kuninori Morimoto (5):
>       ASoC: add snd_soc_register_cpu()
>       ASoC: add .of_xlate_dai_name on snd_soc_cpu_cpu/codec_driver
>       ASoC: simple-card: add Device Tree support
>       ASoC: ak4642: add .of_xlate_dai_name support
>       ASoC: fsi: add .of_xlate_dai_name support

May I ask what happened to this approach and the patch set?


Thanks,
Daniel


> 
>  Documentation/devicetree/bindings/sound/ak4642.txt |    5 +
>  .../devicetree/bindings/sound/renesas,fsi.txt      |    9 ++
>  .../devicetree/bindings/sound/simple-card.txt      |   75 +++++++++++
>  include/sound/soc.h                                |   33 +++++
>  sound/soc/codecs/ak4642.c                          |   11 ++
>  sound/soc/generic/simple-card.c                    |  139 +++++++++++++++++++-
>  sound/soc/sh/fsi.c                                 |   22 +++-
>  sound/soc/soc-core.c                               |  118 +++++++++++++++++
>  8 files changed, 405 insertions(+), 7 deletions(-)
> 
> 
> 
> 
> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
