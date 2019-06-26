From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 116/146] ASoC: sof: use modern dai_link
 style
Date: Wed, 26 Jun 2019 22:58:19 +0200
Message-ID: <8761d853-2b3f-7b26-0073-05d0c3ce1362@linux.intel.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87sgsnfjge.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZBnvfuZDbnvbmqAavh9DAbA_EeRc6OuH6OOiR1WB4zUrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36533F80C0B
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 13:44:30 +0200 (CEST)
In-Reply-To: <CAEnQRZBnvfuZDbnvbmqAavh9DAbA_EeRc6OuH6OOiR1WB4zUrg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, paul.olaru@nxp.com, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index f485f7f751a1..ee73318135fc 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1883,7 +1883,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
>          int ret;
> 
>          /* link + cpu + codec */
> -       link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)), GFP_KERNEL);
> +       link = kzalloc(sizeof(*link) + (3 * sizeof(*dlc)), GFP_KERNEL);
>          if (link == NULL)
>                  return -ENOMEM;
> 
> @@ -1891,9 +1891,11 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
> 
>          link->cpus      = &dlc[0];
>          link->codecs    = &dlc[1];
> +       link->platforms = &dlc[2];
> 
>          link->num_cpus   = 1;
>          link->num_codecs = 1;
> +       link->num_platforms = 1;
> 
> Can you please help me figure this out?

Isn't this fixed by my patch "ASoC: soc-topology: fix modern dai link 
style" applied on 6/13? Looks like the same issue to me.
