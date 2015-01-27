From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/10] ASoC: sta32x: Add device tree binding
Date: Tue, 27 Jan 2015 17:16:14 +0000
Message-ID: <20150127171614.GZ21293@sirena.org.uk>
References: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8518305916987993337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E24B2608EC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 18:16:38 +0100 (CET)
In-Reply-To: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, brandau@gmx.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8518305916987993337==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w5NuKm87q7qyH/qV"
Content-Disposition: inline


--w5NuKm87q7qyH/qV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 12:01:52AM +0100, Thomas Niederpr=FCm wrote:
> This patchset is the result of comparing the sta32x driver with the sta350
> driver with the goal to make the sta32x driver device tree capable. In the
> merging process the coding style of the sta350 driver was adopted since it
> seemed more up to date. I did my best to break up the changes in logical
> chunks. Additionally some small fixes were added.

Applied all except for the patch adding the status register, thanks.

--w5NuKm87q7qyH/qV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx8feAAoJECTWi3JdVIfQYJ0H/jh+iPJ9WXoFQwhzKB7bT/O2
LOkI6sy3UUZHAQolj2Jb9DTp7LiuzQFl4E8Zd7bo4ggpsNhhyik3XPXRyzTPX1r5
X/Ism7ifKaTCrEn1HfeuNeqwdX50DKpWSP01W2RLoxELR77w27f3chNZBJRreLN0
wDPgv5sBDOEC9iUzF+FEOxQJC2BhXAfl/eX899VKs0atNyHyg5pn4rM0YjvCCVga
IH2L2cMV2NYyylykeOF5HV5V4bvYCGC+anmxnp+B6ssZzbHfGqrWqLOIcAoIRGwn
s6uKK5R2Fa9csIvhQU+KcCWoEfitXMlKua3ddM1b5cVQJP5d5Nb3qLB6duX1WvE=
=I0Gy
-----END PGP SIGNATURE-----

--w5NuKm87q7qyH/qV--

--===============8518305916987993337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8518305916987993337==--
