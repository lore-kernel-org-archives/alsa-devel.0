From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Mon, 7 Jul 2014 17:23:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407071721270.4757@hadrien>
References: <20140706070800.GA2927@himangi-Dell> <20140707144832.GL30458@sirena.org.uk> <alpine.DEB.2.10.1407071655171.4757@hadrien> <CAOMZO5AiFCnfTzo4TyB5e5c+xiHQiHUbhRVY7z=AbjOWZDX3NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5AiFCnfTzo4TyB5e5c+xiHQiHUbhRVY7z=AbjOWZDX3NA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Himangi Saraogi <himangi774@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 7 Jul 2014, Fabio Estevam wrote:

> On Mon, Jul 7, 2014 at 11:58 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > Nevertheless, there is already a call to devm_regulator_bulk_get in
> > sgtl5000_enable_regulators which calls sgtl5000_replace_vddd_with_ldo
> > which calls ldo_regulator_register.  That call was introduced by
> >
> > commit 63e54cd9caa3ce03635810608519e2b37d8bc706
> > Author: Fabio Estevam <fabio.estevam@freescale.com>
> > Date:   Thu Apr 24 14:13:08 2014 -0300
> >
> > It seems that that patch should be reverted?
>
> I think so. Russell also reported a kernel oops when unbinding this
> module, so I will prepare a patch reverting it.

There is documentation about what kinds of devm functions exist, but it is
too bad that there is no documentation about where they can be used.
Often there are several levels of function pointers involved, so it can be
hard to figure out whether they can be used just by looking at the code.
I have only taken the strategy of using them in kinds of functions where
someone else has alreadyy figured out that they can be used.

julia
