From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: wm8996: Pass the IRQF_ONESHOT
	flag
Date: Tue, 12 May 2015 19:48:07 +0100
Message-ID: <20150512184807.GT3066@sirena.org.uk>
References: <1431404580-17991-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9208054836325592588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1C22658E7
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 20:48:14 +0200 (CEST)
In-Reply-To: <1431404580-17991-1-git-send-email-festevam@gmail.com>
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


--===============9208054836325592588==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OowMmFE4aK71mEhh"
Content-Disposition: inline


--OowMmFE4aK71mEhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 01:22:56AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
> bogus threaded irq requests") threaded IRQs without a primary handler
> need to be requested with IRQF_ONESHOT, otherwise the request will fail.

Applied all, thanks.

--OowMmFE4aK71mEhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkrmAAoJECTWi3JdVIfQShQH/081MpGrHaPAvvnSgG93SFYf
94x1XOIEdVBOaJsOHg5QMKd/A9ebHitmlCVEWIknWbp5oF7jB8JIHzHugaFgUghl
5HQPFcHFvhSIHZVp0bUkI3Tfwwf9+/FCOL78kSBtnhqEP22QmAOGRkItTZYgR9wI
W3lL0SSIkOi0chirf8fd+GXybJY/txdi8niY6R3WJit68KmyYw+ESwuES0f0xX78
UZ16kntPAGY9BKP3L61QYQe0WtbfaA7cKX9iEJjUX77kA7vMukIbXZFo92bThPTo
uKYsQ/iN7m5+jrJGY08/uhKzTsowd9wpYPhD10aAbaI3tALjLCm2oVxZLkgW0yw=
=W2SC
-----END PGP SIGNATURE-----

--OowMmFE4aK71mEhh--

--===============9208054836325592588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9208054836325592588==--
