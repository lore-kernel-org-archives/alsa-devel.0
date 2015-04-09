From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Create card debugfs directory
	earlier
Date: Thu, 9 Apr 2015 11:24:15 +0100
Message-ID: <20150409102415.GR6023@sirena.org.uk>
References: <1428569558-15883-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8160961715451559654=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D53DB26051B
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 12:24:25 +0200 (CEST)
In-Reply-To: <1428569558-15883-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8160961715451559654==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E57q0RgUZocldiZC"
Content-Disposition: inline


--E57q0RgUZocldiZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 10:52:36AM +0200, Lars-Peter Clausen wrote:
> Create the card debugfs directory at the begining of the initilization
> rather then the end as various steps in the initilization sequence will try
> to register files and sub-directories in the card directory.

Applied, thanks.

--E57q0RgUZocldiZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJlNOAAoJECTWi3JdVIfQAhgH/AgNz4zoAHIpFxmwf5xJfk9/
h2bZXUcSSjl35HfSwigIpGWNT479u5gZ/+OfLgsAz5tbby0aB2nKu5wkh1oYDfse
41XY8w7GMsi47Kr+xfRehGBD3NO+0RzrGcrPSNBKC0SFVgpB17h5FhdcD3XE0Kpq
eSmW3A7kHxMIV45+Q7EuNM72jNF6IYlpiV8wUckrA9Sf4NyccAAGHQramo7kLSM+
Utz+k6tRHTh0YTmgkx5SckRuW9RhoMl4YvgVW5R670iYMrQZ6gOCX08jnVwVj7G3
yiexW61tLsL9rxXVjlc4VhuNrq4cbxmlE/o0HtHGVr5SvgTdg22iqBPzhOjgLYM=
=AcPS
-----END PGP SIGNATURE-----

--E57q0RgUZocldiZC--

--===============8160961715451559654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8160961715451559654==--
