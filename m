From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: cs42l73: Convert to use
	devm_gpio_request_one
Date: Fri, 18 Apr 2014 15:38:59 +0100
Message-ID: <20140418143859.GP12304@sirena.org.uk>
References: <1396966233.14167.1.camel@phoenix>
 <1396966300.14167.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6284098635432854824=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ECB2D2608CF
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 16:39:19 +0200 (CEST)
In-Reply-To: <1396966300.14167.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============6284098635432854824==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7C2vBKXehPEvK3/Z"
Content-Disposition: inline


--7C2vBKXehPEvK3/Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2014 at 10:11:40PM +0800, Axel Lin wrote:
> Current code missed a gpio_free() call in cs42l73_i2c_remove().
> Convert to use devm_gpio_request_one() to fix it.

Applied, thanks.

--7C2vBKXehPEvK3/Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUTkAAAoJELSic+t+oim9kZQP/RNNVoyPm18fyVa0kxJsqiN7
Vtz3J3Nda4Gzz/CUR3oVXUJYyDMSQqYqehf4FI6wtRl0NQvhb3Dh3M4SXwCxJsOX
zlcGPRxuTEZ6tcWQN+FWXYdeWKU4Mtir4FJFeB+apOnS+2NH0+XQko6iHdPdrJ0K
zmzL2b54D8Fr8ZgIehpvESBqepSORjafi82OqnATEzvBksr6+Fq2BjJXrGj1xtga
McIbN1A5FHYh+vyFsx953ftB79rj9hxqBAvmoQDnG3Lb0D54WEbMTO6rXD9sQpzg
ZA6bplLN+G2lTKZFwxgDH6vIncnjfahMpo9mXyWLPxN8IY2ojVygu9SNv1pgyp+A
7HWOJEz+Lv4n1OwU1uLWLCPpNeUFeMuOgGJlAjPnZhk7+f+QMecs2bApkBJ1f948
BQISGB5tP2mBf+GTQTA2bMYNal8cjtGyHx6tRG3CTyKUQ8tMjtUImmqbYLSfvaGg
4J8zTCIbQfWHNRHFTaEvpB8jlFl2i8z8Ac+eKAw8rm68+MD87ojybKrx65jhc7AD
LkO1qm/5FMqdOZrhNZvhFw1hnilb78U4S4nvYtoH7dZYOqN3T4UfHbSsikQ5zZcL
9e5sYyp17Ej3ROuEdvXYjHrlx0X8aYK2lr4ectuLbP3ualy/YgEDP64+U1VPQUfU
Xqvv9EORrsEMuD6dk21d
=ZaHD
-----END PGP SIGNATURE-----

--7C2vBKXehPEvK3/Z--

--===============6284098635432854824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6284098635432854824==--
