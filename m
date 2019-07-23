From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/21] ASoC: SOF: Intel: hda: fix link DMA
	config
Date: Tue, 23 Jul 2019 12:15:15 +0100
Message-ID: <20190723111515.GD5365@sirena.org.uk>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
 <20190722141402.7194-19-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1387984660245432647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86E6AF80227
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:15:17 +0200 (CEST)
In-Reply-To: <20190722141402.7194-19-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1387984660245432647==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 09:13:59AM -0500, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@linux.intel.com>
>=20
> For this bug, there are two capture pcm streams active, with one
> stream and its related stream tag released before suspend. Later
> when system suspend is done, the stream tag for the remaining

In general fixes should come at the start of a series so that they can
be applied as such and sent to Linus without getting caught up with
dependencies on development work.

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl027EIACgkQJNaLcl1U
h9ClRAf8CFImBgkY9i3eGjeByGyWctkrSFYh3EQlp1p3IuU1WaRma7JDnLrIdKOv
lMrAlzf9+48dMT/lWq2ZfVvZVsiI+9NdND74EX7EstGsxl4lV4Q3QWUYXykkZkwO
iA86GOEAFXgVJ0UcrePxG5U1amwB99xbTdV3cL19CDn3hBqzTWhCwJ5QoRyOmUGl
ku/D6aOQyK5kPOc8BNM/Po0Vv31Ie78sb5ngMWjJ84w0OS8KX7fXq/JRxeNDHauw
aXWIfDTTRwKQOQ50Et+cA+Mvhn5iY7DtohKKtKUeLTs4iYQKBGl07h6+HJrnMA5i
m37D9RQJm7NRmiwg3Eo/rFnnBnF++w==
=S8q5
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

--===============1387984660245432647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1387984660245432647==--
