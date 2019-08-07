From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Subject: Re: [PATCH v2 25/25] ASoC: soc-topology: use
 for_each_component_dais() at remove_dai()
Date: Tue, 6 Aug 2019 20:20:56 -0700
Message-ID: <CAFQqKeWU0az5o6XRe1Ro40BiVtQ5JFL6PK83+wKMwjb4kdSwUw@mail.gmail.com>
References: <87pnlhahr6.wl-kuninori.morimoto.gx@renesas.com>
 <87pnlh9320.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1625EF800F4
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 05:21:09 +0200 (CEST)
Received: by mail-yw1-xc44.google.com with SMTP id g19so31060800ywe.2
 for <alsa-devel@alsa-project.org>; Tue, 06 Aug 2019 20:21:09 -0700 (PDT)
In-Reply-To: <87pnlh9320.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 6, 2019 at 6:48 PM Kuninori Morimoto <
kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> commit 52abe6cc1866a ("ASoC: topology: fix oops/use-after-free case
> with dai driver") fixups remove_dai() error, but it is using
> list_for_each_entry() for component->dai_list.
>
> We already have for_each_component_dais() macro for it.
> Let's use exising method.
>
The series looks good now. Thanks for the quick turnaround, Morimoto-san.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
>         - no change
>
>  sound/soc/soc-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index dc463f1..b869071 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -530,7 +530,7 @@ static void remove_dai(struct snd_soc_component *comp,
>         if (dobj->ops && dobj->ops->dai_unload)
>                 dobj->ops->dai_unload(comp, dobj);
>
> -       list_for_each_entry(dai, &comp->dai_list, list)
> +       for_each_component_dais(comp, dai)
>                 if (dai->driver == dai_drv)
>                         dai->driver = NULL;
>
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
