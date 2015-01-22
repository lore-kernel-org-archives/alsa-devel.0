From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Thu, 22 Jan 2015 09:07:23 +0100
Message-ID: <20150122090723.50ac0156@armhf>
References: <cover.1421868426.git.moinejf@free.fr>
	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
	<54C0088F.9070609@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C0088F.9070609-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jan 2015 21:14:07 +0100
Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:

> [...]
> > +	card->dai_link->dai_fmt =3D
> > +		snd_soc_of_parse_daifmt(of_cpu, "dt-audio-card,",
> > +					NULL, NULL) &
> > +			~SND_SOC_DAIFMT_MASTER_MASK;
>=20
>=20
> This one does not seem to be in the bindings documentation.

Sorry, I forgot to remove it from the patch.

BTW, the graph of port should also contain pieces of the audio specific
hardware information as the ones found in the simple-card (clock,
GPIO, ...). This information could be written as generic device node
properties. i.e without any prefix.

I was also wondering about some of these properties, as widgets and
routing. They seem to be software information and Linux specific.
Must these properties appear in the DTs?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
