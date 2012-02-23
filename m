From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Thu, 23 Feb 2012 15:19:34 +0000
Message-ID: <20120223151934.GB4553@opensource.wolfsonmicro.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0071038620166011967=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FE131041AE
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 16:19:36 +0100 (CET)
In-Reply-To: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0071038620166011967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2012 at 01:40:40PM +0100, javier Martin wrote:

> As I wasn't sure about the meaning of 'normal'  I've dug into the code
> of some platforms to see what they do. What I've found, however, is
> that it doesn't seem to be an agreement about it.

It's whatever is standard for the given format - the Wolfson datasheets
are a pretty good reference, they have clear diagrams.

> ALso, it seems that there is no possibility to specify different
> configurations for RX and TX parts.

This is correct, if the configurations are different you're really
looking at separate audio interfaces so should have multiple DAIs.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRlj/AAoJEBus8iNuMP3dBDwP/0G/WYBr6Q136I2bH3y+CAVD
5l6w5NwZlTz77PxoL08xcpjAo4v3f2cHrfsqHbPmVorz88Bv/1ihclziG1/wY9hD
Vibvfwg/O4FxC6OYBZo6+2tnOxundxLLiZcO1+o8NOE8KkHPZ2olCJNuqZcxjjnI
qYdJajlWSrkwHP34tytmUnIxXAiftKxpFgyCTLdX2BbllTsCMdM6Cq1wrBN1WmR8
AIqhT1TR4H2MvCGSbP3e7tsdKs3z3killOMeqGYveKmLqc5MB7/2Wqm7c65szli9
4ThWyc8qu5DcjAXY803Z3ldufcOHUQcyuWN5IiRoLPmQdDcE+Mvdqf47x8TUmEVS
bWASa7cO0H+oKqoKXZSlbiqAsEc8KzC0qB7Lhe7F092s1s1MibIL8krWmF5AnzDV
pU47sOQ6+fgxiLXB4whoWeCLtvSjF2Ii3lhUhHBStEpZkGYJxIlBzC29LZbQUCWE
BbAK+tN3KYME8flcP12Z183BwQDZBdNQEKIZhDDPzDtetDSSq0adkLBcAwboAFDs
ENyWh6Slk0Slu9leoNrmwizqgbj9DTdfwbPFz0tqF8VcyQQPeVUQ7aCt51D6jou5
K3UxIlu5Xsf1gHougAiABHWCvYYw0tJvkploc/PhNN+ZzqXdBJ6xFNSvvnwZsPcZ
sJSfLwhjgmAA8NEXqfzf
=Ah92
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--===============0071038620166011967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0071038620166011967==--
