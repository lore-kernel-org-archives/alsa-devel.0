From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
Date: Thu, 9 Jan 2014 12:45:13 +0000
Message-ID: <20140109124513.GI31886@sirena.org.uk>
References: <1387195916-3106-1-git-send-email-bardliao@realtek.com>
 <20131219122527.GX31886@sirena.org.uk>
 <1121E117AD4ECE49880A389A396215BB939A951093@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5707296309318770387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0512652BE
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 13:45:21 +0100 (CET)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB939A951093@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5707296309318770387==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F6MtUtJ2CVOfiu0Z"
Content-Disposition: inline


--F6MtUtJ2CVOfiu0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 03:47:52PM +0800, Bard Liao wrote:

> > > +unsigned rt5670_pdm1_read(struct snd_soc_codec *codec, unsigned int
> > > +reg) {
> >=20
> > > +EXPORT_SYMBOL(rt5670_pdm1_read);

> > Why is this exported at all and why is it exported non-GPL?

> If a pdm device connect to RT5670, it may need to be controlled by RT5670=
's pdm read/write commands.
> I will export it with GPL.

Please provide more detail on this.  Why would a generic PDM device have
specific hooks into this driver?

> > > +	if (rt5670->pdata.asrc_en) {
> > > +		snd_soc_dapm_new_controls(&codec->dapm, rt5670_asrc_widgets,
> > > +				ARRAY_SIZE(rt5670_dapm_widgets));
> > > +		snd_soc_dapm_add_routes(&codec->dapm, rt5670_asrc_routes,
> > > +				ARRAY_SIZE(rt5670_dapm_routes));
> > > +	}

> > Why is this configured in platform data?

> Usually, we don't enable ASRC function.
> But in some platforms, they will need to enable ASRC function to get cloc=
k properly.
> And I think this is not needed to configure in run time.

That's not going to be true in the general case, for example systems
that support both narrow band and wide band might switch between them.

--F6MtUtJ2CVOfiu0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzpnWAAoJELSic+t+oim9VkgP/RU01h4lcCPJ44GYRDHwRPWO
wsQT5zNJjw0Rb4QqTXPKetkv2rhYuhf1qSSwPbKqX4SGsFneinIZn1PmSxK0MxzH
CNM7USQDaqF5mjhI+sviE6n5zS8wU20o1hHdy73QxhyYa1PRik3k2oEpqJquWHPm
ZS2rX2tYMXNVbPK0mexy1PNbHHceOVOIBd1JQdE9l4e71ndSHCXKX+KSozQYNgeb
Y7vYkdrx4eK5JBSIuSsvl3X/6saFHNfqQm5elgCnt7opWOYHB/QEqQQzpbI74D1Y
G0tyuTIBarGIffVBxm2/0AerBY6XcNxrb5w3JsZUHExes1P5o5mWD1TqAoSvG4yI
Iy9u9/jqlQQazoRuj4b5sXl8DcY+5o+c1uHaS5aOQzWgozrT8+WGpC7auTV387rv
OO2FUBFm+zAyODXiXKwLhkvBCTYh6m64CATkmoVYps5biLdIvl4N54/6yIy4zRtJ
/ro1gReIYIVU58aQHF01e1dI8pROwbn0j57O+gmJKCjZ1jsfd3TvWiCyA6QR1QKA
08a5Hnx3RshgDmVRZYqULdi/JaxBTTwomxt3YXmRwspZGIncGj0aXFlDPMvTB1XL
G3n46Cihi6q1QbtYTNaApKvyfI9ocvVIZC+xufoxB1CR6DIvMVBj8jr2Q3bbqeeM
F/lYEiIbcVHYWs/9hks9
=qJk+
-----END PGP SIGNATURE-----

--F6MtUtJ2CVOfiu0Z--

--===============5707296309318770387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5707296309318770387==--
