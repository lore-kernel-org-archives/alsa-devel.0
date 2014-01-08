From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 08/11] ASoC: twl4030: Remove local reg cache
Date: Wed, 8 Jan 2014 11:18:16 +0000
Message-ID: <20140108111816.GH19974@lee--X1>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
 <1388755676-16036-9-git-send-email-peter.ujfalusi@ti.com>
 <20140108080535.GA19974@lee--X1>
 <52CD318E.3090706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52CD318E.3090706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> >> Depend on the regmap reg cache implementation for register caching=
 done in
> >> the twl-core driver.
> >> The local register cache can be removed and we can keep only shado=
w copies
> >> of certain ctl registers for pop noise reduction.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  sound/soc/codecs/twl4030.c | 207 ++++++++++++++------------------=
-------------
> >>  1 file changed, 63 insertions(+), 144 deletions(-)
> >=20
> > Which commit is the patch-set based on? This patch doesn't apply.
>=20
> When I have sent it it was mainline 3.13-rc6, Now I rebased my series=
 on
> 3.13-rc7 locally.
>=20
> > At a guess I'd say it's becuase this commit is applied on my tree:
> >=20
> >   mfd: twl6040: reg_defaults support for regmap
>=20
> I also have the twl6040 series underneath the twl4030 patches in my w=
orking
> branch and the two series does not touch the same files.
>=20
> > Would you mind rebasing on my ASoC branch please?
> >=20
> >   git://git.linaro.org/people/lee.jones/mfd.git  ib-asoc
>=20
> I have applied this twl4030 series on this branch and all patches (fr=
om 01 to
> 11) applied w/o issue, not even offset difference.
>=20
> Not sure what is going on since the sound/soc/codecs/twl4030.c file i=
s
> identical in 3.13-rc7 and in your ib-asoc branch so the series should=
 apply
> cleanly for you.

Now that is strange. I just attempted to apply them again and they did
so cleanly. I'm not sure what happened, but they're find now.

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
