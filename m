From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ml26124: Remove duplicate code
Date: Mon, 15 Jun 2015 11:05:54 +0100
Message-ID: <20150615100554.GG18309@sirena.org.uk>
References: <1434248881.10956.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5074020159021280821=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EDB1260870
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 12:06:07 +0200 (CEST)
In-Reply-To: <1434248881.10956.2.camel@ingics.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5074020159021280821==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 14, 2015 at 10:28:01AM +0800, Axel Lin wrote:
> Current code has duplicate code for 16000, 32000 and 48000 sample rates.
> get_srate() returns negative error code for unsupported rate, so we can
> remove the duplicate code in the swith cases by calling get_srate() first.

Applied, thanks.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVfqOCAAoJECTWi3JdVIfQ7u4H+KHTI7yUN7fStuEDoiR3tWV9
/lkyqnKcrG9VZw7AI6ykgxlaEKhJqbe5vmejFu4Th4EG1+Dc235q+AeU2vubJzOZ
aukiV46MnpkddqRh5qiM+4XxcjP6cyd+aH42xOBA4ugFgOEu62oR4x8ppIBv7pws
uxvksMM5e+7dkTJ4dZXTAGATCuqrEBbafC4rUoYayBBK0EnLe9vKezRT82CDUOCx
pScQ6f7BKjO/XOfRXMmfzvO9BHmAcmRKZvnaiuJ8j075Bv6J903+MpKpCfDCacIe
tsrfdotwOFpVxNVZJr5wCAHvpwCBPxxvJs00BVYmgNbUYLBO9sGJ9Z1WdPb4cg==
=eyrc
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============5074020159021280821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5074020159021280821==--
