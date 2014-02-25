From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: simple-card: Fix device node locks
Date: Tue, 25 Feb 2014 08:30:56 +0100
Message-ID: <20140225083056.7bfb35f6@armhf>
References: <cover.1392995566.git.moinejf@free.fr>
	<4dca81f45b67a4dcb21271e57409ba114c3b59cb.1392995566.git.moinejf@free.fr>
	<23e531e0edb34aa9b84799e558abaf26@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <23e531e0edb34aa9b84799e558abaf26-+7O3WWA3DPshjIn37xzcLOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Feb 2014 02:17:00 +0000
"Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:

> > @@ -169,22 +164,26 @@ static int asoc_simple_card_parse_of(struct d=
evice_node
> > *node,
> >  	/* CPU sub-node */
> >  	ret =3D -EINVAL;
> >  	np =3D of_get_child_by_name(node, "simple-audio-card,cpu");
> > -	if (np)
> > +	if (np) {
> >  		ret =3D asoc_simple_card_sub_parse_of(np, priv->daifmt,
> >  						  &priv->cpu_dai,
> >  						  &dai_link->cpu_of_node,
> >  						  &dai_link->cpu_dai_name);
> > +		of_node_put(np);
>=20
> Does the of_node_put(np) is really needed here ?
	[snip]

Yes, of_get_child_by_name() increments the node refcount and np is not
used afterwards.

But, you are right, this creates a bug in the next patch when using
of_get_next_child(). I will fix it.

Thanks.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
