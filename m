From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Fix kcontrol name string
 handling.
Date: Tue, 20 Mar 2018 08:57:04 +0800
Message-ID: <20180320005704.GM2186@sirena.org.uk>
References: <20180314204319.13919-1-liam.r.girdwood@linux.intel.com>
 <20180319070643.GD2186@sirena.org.uk>
 <1521487944.1923.71.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2367726837247453359=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 55E46267294
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 01:57:13 +0100 (CET)
In-Reply-To: <1521487944.1923.71.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2367726837247453359==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jsINjv9JwFjY+Quq"
Content-Disposition: inline


--jsINjv9JwFjY+Quq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2018 at 07:32:24PM +0000, Liam Girdwood wrote:
> On Mon, 2018-03-19 at 15:06 +0800, Mark Brown wrote:

> > This doesn't seem to apply against current code (I was going to apply it
> > as a fix but it doesn't seem to apply against -next either).

> Ok will do, Fwiw I did them against -next when you were at ELC, I guess there
> have been some updates between now and then.

It's also possible you have interdependencies between the patches - you
didn't send them as a series so any ordering requirements got lost.

--jsINjv9JwFjY+Quq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqwXF0ACgkQJNaLcl1U
h9C5ZQf+OOGcsSuDu/wCRVY3Pn92IM2m2MALwY3SYuT7HqEwKDiWqFUNGN2JcmB6
aIkoDWqgnIKPrj2hGvq3INE55fBV0eEaZ12x2MW7GdLpiXyyIHjfr43XIRhf8S5J
1MpEkk53XHoQO6OhnYCRFizAyg40Vh0nzAXxJN6HUn8T1t7IM4xM+5DDbnQPVl0U
uNlgbjIoceKHCis6Y0SPccwur+fe21/pdanRQZJtRWZfFTXNwsNYlkOiJRTZUDce
S2DLDWvlZseHlydlsQ9lubXAq+3WfHgOceon7h77nPzSx2ZMh+21LOw4YIiufVj/
lIkMi8ItRnpZdEuRi4i+1dvUTgoPCQ==
=EWMa
-----END PGP SIGNATURE-----

--jsINjv9JwFjY+Quq--

--===============2367726837247453359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2367726837247453359==--
