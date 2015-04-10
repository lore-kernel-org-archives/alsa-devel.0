From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] ASoC: simple-card: Remove support for
 setting differing DAI formats
Date: Fri, 10 Apr 2015 10:52:40 +0200
Message-ID: <55278F58.6030909@metafoo.de>
References: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>	<87bnjj431h.wl%kuninori.morimoto.gx@renesas.com>
 <878ue08ngb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-032.synserver.de
 [212.40.185.32])
 by alsa0.perex.cz (Postfix) with ESMTP id E7FCD266097
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 10:52:47 +0200 (CEST)
In-Reply-To: <878ue08ngb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

[...]
> But, I noticed it breaks set_fmt() and pcm_new() timing.
> Before: set_fmt -> pcm_new
> After:  pcm_new -> set_fmt
>
> My driver adds kctrl on pcm_new timing, and it refers
> set_fmt's settings. but now, set_fmt happen *after* pcm_new.
> (it adds new kctrl if it has SND_SOC_DAIFMT_CBS_CFS)

What does that control do? This seems to be a bit of a layering violation to 
create a control in the PCM driver based on the configuration of the DAI link.

>
> My solution is these 2
>   pattern1) exchange set_fmt/pcm_new timing. see below
>   pattern2) exchange kctrl assumption (always set kctrl)
>
> Maybe I should try pattern2 ?
>
> ---------------------------------------
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 76bfff2..24d6733 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1604,6 +1604,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>                  }
>          }
>
> +       for (i = 0; i < card->num_links; i++) {
> +               if (card->dai_link[i].dai_fmt)
> +                       snd_soc_runtime_set_dai_fmt(&card->rtd[i],
> +                                                   card->dai_link[i].dai_fmt);
> +       }
> +

This seems to be to early, the DAI's should at least have been probed. I 
think we should put it in soc_probe_link_dais() after the the dai_link->init 
section.
