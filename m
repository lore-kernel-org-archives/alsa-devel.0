From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [RFC][PATCH] ASoC: simple-card: Add
 asoc_simple_card_data for the simple card driver data
Date: Tue, 14 Jan 2014 12:09:13 +0100
Message-ID: <20140114120913.19d883fe@armhf>
References: <1389678282-1097-1-git-send-email-Li.Xiubo@freescale.com>
	<871u0bgiai.wl%kuninori.morimoto.gx@gmail.com>
	<96cb876ff05c4062ab5a2c92fb7b3c41@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96cb876ff05c4062ab5a2c92fb7b3c41@BY2PR03MB505.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Jan 2014 07:56:32 +0000
"Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com> wrote:

>=20
> > > Whether the dt is used or not, almost all the simple card informa=
tion
> > > for the DAI link and sound card are initialized in the simple car=
d driver.
> > >
> > > And for the platform caller, the snd_link and snd_card are of no =
use, so
> > > move them from struct asoc_simple_card_info to struct asoc_simple=
_card_data.
> > >
> > > And now only one DAI link is supported for simple card.
> > >
> > > Suggested-by: Jean-Francois Moine <moinejf@free.fr>
> > > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > > ---
> >=20
> > This patch seems have many this kind of lines
> >   -	info->xxx
> >   +	sdata->info->xxx
> >=20
> > But, how about add this line to each function ?
> >=20
> >      struct asoc_simple_card_info *info =3D &sdata->info;
> >=20
> > Patch will be more readable
> >
>=20
> Yes, that's looks perfect.
>=20
> See the next version please.

Please, don't work on an other version. I am preparing an other patch w=
hich will do quite the same as yours, but which will be easier to exten=
d to many DAI links.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
