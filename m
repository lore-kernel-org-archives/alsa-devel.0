From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v5 2/2] ASoC: da7210: Add support for ALC
 and Noise suppression
Date: Wed, 19 Oct 2011 14:13:30 +0530
Message-ID: <1319013810.7230.40.camel@matrix>
References: <1318945431.13721.52.camel@matrix>
	<CABS+qY3qw7YpeNwK2JJav4tR23uPCp19BPeE2E2KL3FnZ8zJ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 486EA2447A
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 10:33:31 +0200 (CEST)
In-Reply-To: <CABS+qY3qw7YpeNwK2JJav4tR23uPCp19BPeE2E2KL3FnZ8zJ=g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

> > +       if (ucontrol->value.integer.value[0]) {
> > +               /* Check if noise suppression is enabled */
> > +               if (snd_soc_read(codec, DA7210_CONTROL) & DA7210_NOISE_SUP_EN) {
> > +                       dev_dbg(codec->dev,
> > +                               "Disable noise suppression to enable ALC\n");
> > +                       return -EPERM;
> 
> -EINVAL
> 
> 
> > +               /* Check ZC for HP and AUX1 PGA */
> > +               if ((snd_soc_read(codec, DA7210_ZERO_CROSS) &
> > +                       (DA7210_AUX1_L_ZC | DA7210_AUX1_R_ZC | DA7210_HP_L_ZC |
> > +                       DA7210_HP_R_ZC)) != 0xc3)
> 
> It may be clearer if you don't use the magic number here and specify
> the bits you are checking.
> 
> > +       /* If all conditions are met or we are actually disabling Noise sup */
> > +       return snd_soc_put_volsw(kcontrol, ucontrol);
> > +
> > +err:
> > +       return -EPERM;
> 
> -EINVAL
> 

Thanks. Updating and reposting the patch set.
