From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 0/3] ALSA: pcm: anonymous dup
	implementation
Date: Thu, 7 Feb 2019 16:29:27 +0000
Message-ID: <20190207162927.GF6190@sirena.org.uk>
References: <20190204183817.975-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3368020833721397785=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D935026747F
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 17:29:30 +0100 (CET)
In-Reply-To: <20190204183817.975-1-perex@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Zach Riggle <riggle@google.com>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3368020833721397785==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 07:38:14PM +0100, Jaroslav Kysela wrote:
> This patchset contains the anonymous dup implementation with permissions
> checking for the ALSA's PCM interface in kernel to enable the restricted
> DMA sound buffer sharing for the restricted tasks.

Reviewed-by: Mark Brown <broonie@kernel.org>

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxcXOcACgkQJNaLcl1U
h9C7hgf/drqBsn4Eno4pC7dEab8K33ksoVgDED+Bzpi2HsQDzZf94+MPBIXKv9bu
5kdweBYhu8UF37KESbWkikFo+HPZUezjb/Dy74MO8d7jjIl79b8Hsk9aZbRzrghA
6MoSVUsbEv1zTCxZRLr4S/RqUHx8oWBp5Zx+Zv4sl/QJDR8+qQLhRWcgv6KASwnY
UmkMEuw7KAySqd8z1wJ7liZo08W4Tn9STJ6H0ZKkeJ+DOXJ9ieg49Msvi6RfdpRk
Y/c9oQwa5gD6XO6q5c0poWA0+PMLnqNhcO/y8HuJqoqv8Rsel+cDJ+nStbLN3vUi
pkwFpcYyE1Xqn2CP/UIYEJeY2jSgEw==
=jBOJ
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--

--===============3368020833721397785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3368020833721397785==--
