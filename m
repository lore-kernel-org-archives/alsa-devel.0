From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/27] ASoC: rsnd: explain SRC bypass mode
 settings in comment
Date: Tue, 28 Jan 2014 11:14:30 +0000
Message-ID: <20140128111430.GJ11841@sirena.org.uk>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
 <87ob32f6h2.wl%kuninori.morimoto.gx@gmail.com>
 <20140127194554.GT11841@sirena.org.uk>
 <871tzt9cfv.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2798660693145975810=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 828E62651AC
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 12:14:39 +0100 (CET)
In-Reply-To: <871tzt9cfv.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2798660693145975810==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5RIsqXDwgzvYGRyn"
Content-Disposition: inline


--5RIsqXDwgzvYGRyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 04:28:54PM -0800, Kuninori Morimoto wrote:
> > > SRC bypass mode is useful for debugging.
> > > This patch explains SRC bypass mode settings in comment

> > Surely it's also useful for providing a power saving in cases where the
> > SRC is not required?  Depending on the implementation it may also end up
> > resulting in a small improvement in audio quality in such cases.

> If user don't use SRC, SRC power is OFF in current implementation.
> But, I'll send new patch if I noticed about PM on SRC.

OK - that's good.  I'd have expected that before powering off you'd have
needed to bypass the SRC but if you don't that's fine.

--5RIsqXDwgzvYGRyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS55ETAAoJELSic+t+oim9CI8P/31Nb+68mv0sZiHHufQGIaGg
gnaWtrVY6LsseN/jQLnRvB90aH+Bdhkd023qWFYwC+yi5+3d73tpBvTlG+0+2Qmh
cRW7315zL+5FZkphh0Ky1ovep6t8OkgRwD0AcRFLys7smWmvrui6XcXGYV5/XJH/
yi6uTKU2ULjoE7CRP112xK6rDWxvtjcS3bhV816+GI64bkpg1cufzmPGRMTUoacM
PyfOttgIxWi4zjS0cHww76Cnki0Jo6MSoZhXaFD/JeRfj1dVuS6YLOXaGdrT5F0M
hM8VWoqoLng3jFqLl0/54PnxueriG0w+L3fSR/C91Z4rg9PQGWjunS72ZF3/suaI
cjVWnUwCkGvI/qfmXTCMvTCoOmhHor2GBeLeO2nvoTP4qi5z9Hb30g42xQepnq9y
UBsFt4beha7kZO5wevmNn3CTnFAEeKpW6cHZyAv9hHSztGZ9N0VO0iNPL+RdKg+A
TzSEe29JYxLrdKShpY6JlAWOyxBAar1FbQCD3e6n7qI8BXyTyACMVv+ku2+ttT2n
88d2dLz6+EHcoNOz1l5QGboACT1UaAJW6W4xNmDIThji8jzkJSxa0srzE/Mq7MTK
gu4LwyDZDQyvSvChuxo37/QHEsxJvIrwz7gtHYikgPIbuZ6XhJbuZ8eNGqA2U0Ba
M5rNcvlhmbz6+8Hds4yw
=JjyP
-----END PGP SIGNATURE-----

--5RIsqXDwgzvYGRyn--

--===============2798660693145975810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2798660693145975810==--
