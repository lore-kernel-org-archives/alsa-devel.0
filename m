From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Wed, 6 Mar 2013 18:57:15 +0800
Message-ID: <20130306105713.GF4896@opensource.wolfsonmicro.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8300903865343364936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 016C9265383
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 11:57:46 +0100 (CET)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michal Bachraty <michal.bachraty@streamunlimited.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8300903865343364936==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2013 at 10:54:52AM +0000, Bedia, Vaibhav wrote:

> Since you are using a multichannel codec things are a lot simplified for you :)
> Someone might want to hook up multiple codecs to get multi-channel behavior.
> There will be only 1 CPU DAI but there can be upto 16 CODEC DAIs operating in
> sync. I haven't really followed the recent ASoC changes so I don't know whether
> something like this can be handled right now.

> Mark, Liam,

> Any suggestions?

Nobody with any interest in such systems has stepped up to work on the
framework, and of course relatively little CPU hardware supports
multiple streams on a single DAI.

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNyD+AAoJELSic+t+oim9hbkP/iS/HmbNLwBjjo23IqQBT649
FH4UVeyV6P/y1Ub6i9/mGsTePVXdI1m17+v9IC+Tkp/Tt4UO4wOWov/wlRWT6RiB
EgZJ1rwut0B4nCUwDaomOy3bdluERL1wgSoYrpBVr2Y7S+7bmhBO0BaVyXZde0gu
4CltA/84w29ImNjH9vRo24GWhyWLnhDhQ5HF553moeLW5XwezChsgsjJsyxlvgl/
9y/mSqx0++COLPy1xvFtQNmuDwIwd0Gpn1OlhJz8czlOTTW+XHfY8mGbI97jwpUP
QmOm12v3YtVxIV1uQQmrkY+JmMd5zUcTmj/qJYgeK1D7iREyXEhwT3bdA36ZKWzl
G3F7uryTvY/Qroo7OxbTcByZNOR/VsmCB8n4pSeMLp3DY1V9ZULeJMYogiw1XD1I
K2iDxOOdpGoLUCbbkay2D5CehjtqPBlpEkE1iK9+wj/TzZ42M8+cOLclqUnxvjOD
blhOMi5pVc8cUldKb+uzvN99wlS6UzauUrylPP5xOu+y0RVc1z0WqYzRxRNIQGYf
R3j79pm6E0zeoryLfK1uPuZNT8kspyKNW/+uof9jHiWuJHtK26Sa+ugNwOKBTYi5
fRYELDc++EEK/Wh1OUiYCcug66+8lCpfvDLEjkmxYJNjT1UcU07wgiZn1ydTYD0f
o8anx8zNEp+/Fe101DzX
=gsf/
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--

--===============8300903865343364936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8300903865343364936==--
