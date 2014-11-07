From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: simple-card: add multi-CODECs in DT
Date: Fri, 7 Nov 2014 20:05:57 +0100
Message-ID: <20141107200557.78971e08@armhf>
References: <cover.1415096705.git.moinejf@free.fr>
	<53ef077d2174f8eb5b861d6cebe7c9e732f06d52.1415096705.git.moinejf@free.fr>
	<20141107123035.GO8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141107123035.GO8509-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Nov 2014 12:30:35 +0000
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >  	} else {
> > -		clk =3D of_clk_get(args.np, 0);
> > +		clk =3D of_clk_get((struct device_node *) dai_np, 0); =20
>=20
> Adding this cast looks suspicous - why?  As far as I can tell the
> original code didn't need one.

Right, 'args.np' was (struct device_node *), but, now, 'dai_np' is
(const struct device_node *).

Changing 'dai_np' to (struct device_node *) in the
asoc_simple_card_sub_parse_of() argument asks for a cast in calling
this function because the field 'of_node' of the struct
snd_soc_dai_link_component is (const struct device_node *).

Do you better like this last cast?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
