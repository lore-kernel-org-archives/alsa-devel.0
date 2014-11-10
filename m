From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v4 3/4] ASoC: simple-card: add multi-CODECs in DT
Date: Mon, 10 Nov 2014 10:05:26 +0100
Message-ID: <20141110100526.76790f55@armhf>
References: <cover.1415605716.git.moinejf@free.fr>
	<d49d348da24fbd96e7be51ba2839ee8bc821ddec.1415605717.git.moinejf@free.fr>
	<3271244.uSgBKXChSS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3271244.uSgBKXChSS@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Nov 2014 09:39:57 +0100
Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:

> On Sunday 09 November 2014 12:22:21 Jean-Francois Moine wrote:
> > -- sound-dai                            : phandle and port of CPU/C=
ODEC
> > +either
> > +  - sound-dai                          : phandle and port of CPU/C=
ODEC
> > +or
> > +  - sound-dais                         : list of phandle and port =
of CODECs
>=20
> Is it really necessary to change the property name here? I woudl thin=
k
> that you can make it all work more consistently with just the existin=
g
> 'sound-dai' property, just extend it to allow multiple codecs

This was an idea from Benoit Cousson:

 "Something like that:

   sound-dais =3D <&spdif_codec 1>, <&hdmi 0>;

 That being said, it will require changing the name with a plural form,=
"

As I coded it, both names are accepted for a single or many codecs.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
