From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 116/146] ASoC: sof: use modern dai_link
	style
Date: Thu, 27 Jun 2019 09:57:52 +0300
Message-ID: <CAEnQRZChF-L5t4iVY_ZCS+q-VfeAjRfL+y9OrmEdm5BZzys6dQ@mail.gmail.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87sgsnfjge.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZBnvfuZDbnvbmqAavh9DAbA_EeRc6OuH6OOiR1WB4zUrg@mail.gmail.com>
 <874l4bkg16.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77BA4F806F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 08:58:03 +0200 (CEST)
Received: by mail-wm1-x341.google.com with SMTP id 207so4532054wma.1
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 23:58:03 -0700 (PDT)
In-Reply-To: <874l4bkg16.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, paul.olaru@nxp.com, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

<replying again now also including all Cc's>

On Thu, Jun 27, 2019 at 3:52 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Daniel
>
> Thank you for feedback and sorry for bother you
>
> > > @@ -2708,7 +2705,11 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
> > >         int ret;
> > >         int i = 0;
> > >
> > > -       link->platform_name = dev_name(sdev->dev);
> > > +       if (!link->platforms) {
> > > +               dev_err(sdev->dev, "error: no platforms\n");
> > > +               return -EINVAL;
> >
> > Why do we need this check? With linux-next this check fails for me.
>
> I don't remember but some sof might use without platform it I thought.
> But, current ALSA SoC can handle NULL platform today.
> Maybe/Maybe not support timing issue ?
>
> > diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> > index f485f7f751a1..ee73318135fc 100644
> > --- a/sound/soc/soc-topology.c
> > +++ b/sound/soc/soc-topology.c
> > @@ -1883,7 +1883,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
> >         int ret;
> >
> >         /* link + cpu + codec */
> > -       link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)), GFP_KERNEL);
> > +       link = kzalloc(sizeof(*link) + (3 * sizeof(*dlc)), GFP_KERNEL);
> >         if (link == NULL)
> >                 return -ENOMEM;
> >
> > @@ -1891,9 +1891,11 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
> >
> >         link->cpus      = &dlc[0];
> >         link->codecs    = &dlc[1];
> > +       link->platforms = &dlc[2];
> >
> >         link->num_cpus   = 1;
> >         link->num_codecs = 1;
> > +       link->num_platforms = 1;
> >
> > Can you please help me figure this out?
>
> I think this is same as
>
>         3e6de89409bf7ad149bfb05dd0dce6c5678ea0a8
>         ("ASoC: soc-topology: fix modern dai link style")
>

Yes, it is! Sorry, I'm doing development on 5.2-rc3 - not latest
sources.

> Above one is also OK, but now we can use NULL platform.
> I'm not familiar with SOF, but maybe like this code instead
> of having dummy platform can salve your issue ?
>
>         if (link->platforms) {
>                 link->platforms->name = dev_name(sdev->dev);
>         }
>
Yes, this also seems to work.
