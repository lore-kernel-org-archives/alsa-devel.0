From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 4/6] ASoC: jack: create kctls according
 to jack pins info
Date: Mon, 20 Apr 2015 22:20:31 +0100
Message-ID: <20150420212031.GS14892@sirena.org.uk>
References: <1429351460-15932-1-git-send-email-yang.jie@intel.com>
 <1429351460-15932-5-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7484192518782802053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3AFD265CA7
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 23:20:35 +0200 (CEST)
In-Reply-To: <1429351460-15932-5-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, tanu.kaskinen@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7484192518782802053==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6eUvXotnMb6+obQB"
Content-Disposition: inline


--6eUvXotnMb6+obQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2015 at 06:04:18PM +0800, Jie Yang wrote:
> In the new jack kctls design, we can create kctls according to
> pins info:
>=20
> 1. during jack creating, snd_jack_new() with NULL jack_kctl;
> 2. for each pin, call snd_jack_add_kctls() to add one kctl
> (it will call snd_ctl_add() to add kctl to card);

I'm a little confused why this isn't done by the jack core?

--6eUvXotnMb6+obQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNW2fAAoJECTWi3JdVIfQuUAH/j8gxzSzYm85sBIgZ36M50Qf
CPxPmQt5786/PDByI6OrejIHna65Oe8EeRsd3cQFxYpC719XuD6q05wh5N52moFE
RRIadRQDPyv6Lamq/1zYdjr31DhZ3cLyhz3dnol6dNkUKKosp7xtTtyX378WA+NR
SF8WCF6YHfN0bhThDxFG/7oYquwDD3uiFDpPzAZ5J4lQ5wWf1PdFSQtV6BzL3APZ
dAHpWm4qL8kygmGzYCSjVI/xffguilg5K0Y7dlR48nz99RjA2rGDtTchHVVn2Wzi
fJTX4Fu51rZJtGGZ2yoOzK8aO7Sh43hB7/PplFRudL/LdakYYEosfNCSKii0dio=
=UZ70
-----END PGP SIGNATURE-----

--6eUvXotnMb6+obQB--

--===============7484192518782802053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7484192518782802053==--
