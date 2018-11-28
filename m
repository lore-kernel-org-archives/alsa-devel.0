From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: pcm3168a: Don't disable pcm3168a
 when CONFIG_PM defined
Date: Wed, 28 Nov 2018 16:22:11 +0000
Message-ID: <20181128162211.GL6828@sirena.org.uk>
References: <20181128122612.17820-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0540757198568489560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 74AC9267B4F
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 17:22:13 +0100 (CET)
In-Reply-To: <20181128122612.17820-1-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jiada_wang@mentor.com
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============0540757198568489560==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wA9WyeW1yVBM2Q32"
Content-Disposition: inline


--wA9WyeW1yVBM2Q32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 09:26:12PM +0900, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
>=20
> pcm3168 codec support runtime_[resume|suspend], whenever it
> is not active, it enters suspend mode, and it's clock and regulators
> will be disabled. so there is no need to disable them again in
> remove callback.  Otherwise we got following kernel warnings,
> when unload pcm3168a driver
>=20
> [  222.257514] unbalanced disables for amp-en-regulator
> [  222.262526] ------------[ cut here ]------------
> [  222.267158] WARNING: CPU: 0 PID: 2423 at drivers/regulator/core.c:2264=
 _regulator_disable+0x28/0x108
> [  222.276291] Modules linked in:
> [  222.279343]  snd_soc_pcm3168a_i2c(-)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--wA9WyeW1yVBM2Q32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+wLIACgkQJNaLcl1U
h9AE6wf/fUj43xe+OXVuc4QSIiRt0payrWXBKKvyj+KhVPvnLZF1dKaQdhV9bejr
TMx+Kdxj3ZpkL/UBmJHgL5XeveqVz9qHKVfYSe2bYqYUKWznEcyMGyRcSAuoTeAr
+dhvGr0OUuEaQX0zUr2N1H4az3tUmsXBSR+qVZGfOREe58NFFAflD/Q14ODAa7tp
9NxsbhmubVVPAMuv2vO6ez4nUOj14lh4Dml6xDKOCohTjTTYxl6BcrGV9E7SZNa0
IyU1fMkAzDIzRXcjzcGYN4hdi+q5vdPDYaTn7mzt3ZGcndiLMb5Rla4l/SuUAngm
xO8COaqgn8H8ZLJCniula7hdxCQiUQ==
=gA+C
-----END PGP SIGNATURE-----

--wA9WyeW1yVBM2Q32--

--===============0540757198568489560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0540757198568489560==--
