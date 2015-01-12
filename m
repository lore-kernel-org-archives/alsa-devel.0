From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ad193x: Don't power down DAC in
	CODEC probe
Date: Mon, 12 Jan 2015 12:58:57 +0000
Message-ID: <20150112125857.GJ4160@sirena.org.uk>
References: <1421067253-14483-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0148890020956255554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F25726054E
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 13:59:24 +0100 (CET)
In-Reply-To: <1421067253-14483-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0148890020956255554==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Content-Disposition: inline


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2015 at 01:54:13PM +0100, Lars-Peter Clausen wrote:
> The DAC powerdown bit is managed by DAPM. Manually powering down the DAC in
> the CODEC probe function may cause unnecessary power state transitions which
> can lead to click and pop noises.

Applied, thanks.

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUs8UQAAoJECTWi3JdVIfQgdAH+QFz1a2eyauDjGOaanK/4EpR
/R43VWgEcrAnD6NsSqXsEuVjjomR1kQs6TFEeFHTVgHD0Z8slvuwHsMTSEPuZdxa
ETusJ7XO/HDFnBpKtPi+AYmtaQ/IunWXY7+rqsrdhCbDPDxfYmswSoOcGZ6fGq7V
75dxznZNoOsZUBRQiVD5ucQMFWRoE2wG+OPqHoCW1JE1SfReuvmR/Nx0TvAaMalr
WPjP2UKufMnHZxpsE79sXOTrMvrvDcgKlBWoY8GYc2w21HzSa1//HhN2zoxTHP65
XqDPNG0Dh5tAoaUXwSBhPUd3OYGoWdbafgOm7UDNAVUBQOcTfXvUFWmFrSOBU8M=
=fXKS
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--

--===============0148890020956255554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0148890020956255554==--
