From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: No need to use strncmp()
Date: Wed, 31 Jul 2013 14:23:02 +0100
Message-ID: <20130731132302.GO9858@sirena.org.uk>
References: <1375260253-23376-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <20130731090726.GF9858@sirena.org.uk>
 <20130731094814.GA7231@opensource.wolfsonmicro.com>
 <20130731110147.GI9858@sirena.org.uk>
 <20130731115929.GA26438@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4686015043568101781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D1772615F7
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 15:23:04 +0200 (CEST)
In-Reply-To: <20130731115929.GA26438@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4686015043568101781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4WSCzoh9u01IUsAL"
Content-Disposition: inline


--4WSCzoh9u01IUsAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 12:59:29PM +0100, Dimitris Papastamos wrote:
> On Wed, Jul 31, 2013 at 12:01:47PM +0100, Mark Brown wrote:

> > One of the reasons we use strncmp() here is to avoid going beyond the
> > end of the fixed size buffer.

> Right, surely though the kcontrol names are always null terminated?
> In any case, looks more safe to strncmp().

They probably should be but it's easy to get it wrong and hit exactly
the array size.

--4WSCzoh9u01IUsAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+Q+zAAoJELSic+t+oim9YbkP/2bqCDXFv0DH2rhdfsmB8YJ0
OL8hl0BzF3U6jOvkJAPiDM48V491KRNOUvCIw5FZw6SDrvTtPbHAmClEBDAryL5j
ZUuGMYOKjtIibg6w4kBxDVBc6ZlQNn6qsm1Z2IfI1qQDDPb1VpSuQNMz7eGcOLU9
qNmZwU1xjfxC5Q2SJ0fSxevXrpPowRE2sh3sCUO8WEDFv4XMbAuLR+t441utXco1
0MOQWjZZBu7P0mig2x50osLET1uB1S2uMRLeyhpSCZu+Qw65mDC9J+NgmbwtArV2
jnZQsacqtfjeWXOPs1BXCzTcKwo0Xpz9ZipqWM5Fxxlo2sJt31tBaGatozPc1pXW
A0PrTB9qawR6qRwgFpPQaRHj8rON1rmAQ4O34SBD89+cUlOiThm3OCHC1EHll61g
FOLQasFld6FJHDD9uR04s7Mlt9cVrhDOrlj/3lt5NtDYOjT4M3F4U+Fde2q/PGCr
07q7MrhMyOiIJ7vuY3dU6mXMKmGI8zrKn+gwMj5oKzTH/qHGDYINy8zt+RAygIFJ
PVa6Dx3Z8coxGlMhV7eyqdNq1D52q1NBW3Mub9Rs7hd0psnnOm+ZxHJ2sUClHxTF
GjiVqOTr50caS5XK0aHw0BqqwR7H1Wom7u+H/YVne4F+MoacNqzpkNKXpW4ttv6y
sABNLn/XwBOwtUYEett6
=hDZR
-----END PGP SIGNATURE-----

--4WSCzoh9u01IUsAL--

--===============4686015043568101781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4686015043568101781==--
