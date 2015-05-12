From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: twl6040: Pass the IRQF_ONESHOT
	flag
Date: Tue, 12 May 2015 19:47:55 +0100
Message-ID: <20150512184755.GS3066@sirena.org.uk>
References: <1431404580-17991-1-git-send-email-festevam@gmail.com>
 <1431404580-17991-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4893210943834787655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 508F626587B
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 20:48:03 +0200 (CEST)
In-Reply-To: <1431404580-17991-4-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Julia.Lawall@lip6.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4893210943834787655==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1IOPqZ3f1xe/JZlz"
Content-Disposition: inline


--1IOPqZ3f1xe/JZlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 01:22:59AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
> bogus threaded irq requests") threaded IRQs without a primary handler
> need to be requested with IRQF_ONESHOT, otherwise the request will fail.

Applied, thanks.

--1IOPqZ3f1xe/JZlz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkraAAoJECTWi3JdVIfQIrsIAIE9ayX5GzTdcJeG002Z40rC
PCa7tnAsHl2zgCEhIWybsN9yGzmmrM3MYLlsBuMmP+jSP7zCrJOE+mjFw8WQZl4D
nba1Jk4KdPT3IvyrZsJeL8+fU8ruKv4kxDpZJAbgWxvmbfrpaq+4w5ODMT/+K51d
0EJZ0uoydM6Xcw7O/gK4EB53hrcWX3dnqzKc702eBIowHB2hg3djkW4R40UO2nVd
wms7tmV4HPCdYVAQjym3ycUXAwCzcZ05VLB5llvE5rYkY18h8vlkixrNvXOhmhQb
m6/X/s2+aIHJOFSuVLW1LVDKf62sT54biS5/JG8A41+OqYEaniP9aaMRftTWA7o=
=w/YP
-----END PGP SIGNATURE-----

--1IOPqZ3f1xe/JZlz--

--===============4893210943834787655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4893210943834787655==--
