From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-dapm: Use ASYNC_DOMAIN_EXCLUSIVE
Date: Sun, 1 Jul 2012 19:11:49 +0100
Message-ID: <20120701181149.GD28922@opensource.wolfsonmicro.com>
References: <1341085175-20599-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7668231744025853366=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6AE52436A
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Jul 2012 20:11:51 +0200 (CEST)
In-Reply-To: <1341085175-20599-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, dan.j.williams@intel.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7668231744025853366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ax5Xc7LkAiI0IBI6"
Content-Disposition: inline


--Ax5Xc7LkAiI0IBI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 30, 2012 at 04:39:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> commit e895407d (async: introduce 'async_domain' type)
> changed the parameter types of async_schedule_domain() and async_synchron=
ize_full_domain().

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but obviously this needs to go along with the patckes introducing the
issue rather than the ASoC tree.

--Ax5Xc7LkAiI0IBI6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8JLeAAoJEBus8iNuMP3dEGkP/AtC2zew5HjDtmjow9qn3ujZ
8RpTpyhZu//rw0wfzneOWhg8BA7uJB5EOODEeNTGG7WlZIcZNKrw44F3iLgHT2U6
f+A91ioHM//MKuLNK6Dxx0a0Mos9w22j4CuhFOmbfUHJS7/4usNVSvQyBzDtqtcc
p4KBrSQfRGsP2/6FlI7IYxJ3vae8iQGaqo0YmbVykJR0H2VWimTy63OBMpQZlat7
tVFL0TJI+pxdvkyMr1LW+QzBzCwj6nqhN/mQvrRISqfwDNopNI4YwxI6D3IaZjQ5
yjt10Ku7NPebhRPzrf683iCHQwZ+GemUtUSQODN9Cv2jVdzFeeftik7hzwTYXq64
IGDPZq3MbVyYzHKOWAQBtPuuZ/ILdKPeHyUu1r2jAF5OrZ5/AmsyeldX80Ss2ed2
sffTP2HO9nhHRX3s/K3NL8t/j5TLSgBjR6u3Bu4JUzOBW/l1qGuqzAHH46NGSKQA
N/ibKOacHuhyQ6hze6UAZjtLPQ/zKaXbin6L1I9b3gvAvdYtJ4+KqE8JMbKfHLcd
vrPYcr0qMDvxTdDWg0yrpTZ8kbi873vSIIxQBuSgXvh3WZg+1Uh/fDp6oEe9to3H
xpX9duyrMagnhHHhD2vEGozeBgJyFI1I3sxbuCybrEaQYpPV5hET4ZZvNvdWRP/U
Jg+uPoE1A5AhMVgfqWYV
=MHVU
-----END PGP SIGNATURE-----

--Ax5Xc7LkAiI0IBI6--

--===============7668231744025853366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7668231744025853366==--
