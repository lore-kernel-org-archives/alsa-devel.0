From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 116/146] ASoC: sof: use modern dai_link
 style
Date: Thu, 27 Jun 2019 11:47:20 +0000
Message-ID: <817b8d146a2a4444b5061e9eac3f01d58f8e5aa4.camel@nxp.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87sgsnfjge.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZBnvfuZDbnvbmqAavh9DAbA_EeRc6OuH6OOiR1WB4zUrg@mail.gmail.com>
 <8761d853-2b3f-7b26-0073-05d0c3ce1362@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F5B3F806F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 13:47:21 +0200 (CEST)
In-Reply-To: <8761d853-2b3f-7b26-0073-05d0c3ce1362@linux.intel.com>
Content-Language: en-US
Content-ID: <E7A7534DACCE524D97A111F4E4991A55@eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
Cc: Paul Olaru <paul.olaru@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "ranjani.sridharan@intel.com" <ranjani.sridharan@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-06-26 at 22:58 +0200, Pierre-Louis Bossart wrote:
> > diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> > index f485f7f751a1..ee73318135fc 100644
> > --- a/sound/soc/soc-topology.c
> > +++ b/sound/soc/soc-topology.c
> > @@ -1883,7 +1883,7 @@ static int soc_tplg_fe_link_create(struct
> > soc_tplg *tplg,
> >          int ret;
> > 
> >          /* link + cpu + codec */
> > -       link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)),
> > GFP_KERNEL);
> > +       link = kzalloc(sizeof(*link) + (3 * sizeof(*dlc)),
> > GFP_KERNEL);
> >          if (link == NULL)
> >                  return -ENOMEM;
> > 
> > @@ -1891,9 +1891,11 @@ static int soc_tplg_fe_link_create(struct
> > soc_tplg *tplg,
> > 
> >          link->cpus      = &dlc[0];
> >          link->codecs    = &dlc[1];
> > +       link->platforms = &dlc[2];
> > 
> >          link->num_cpus   = 1;
> >          link->num_codecs = 1;
> > +       link->num_platforms = 1;
> > 
> > Can you please help me figure this out?
> 
> Isn't this fixed by my patch "ASoC: soc-topology: fix modern dai
> link 
> style" applied on 6/13? Looks like the same issue to me.

Yes, this is the same thing. My tree with all NXP i.MX8QXP patches
is a little bit older and did not contain your patch.

Sorry for the noise, everything is looking good now! :)
