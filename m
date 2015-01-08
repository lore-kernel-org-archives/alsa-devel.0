From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Export snd_soc_runtime_set_dai_fmt()
Date: Thu, 8 Jan 2015 17:55:14 +0000
Message-ID: <20150108175514.GP2634@sirena.org.uk>
References: <1420716185-11974-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4338397937896271915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40799260484
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 18:55:24 +0100 (CET)
In-Reply-To: <1420716185-11974-1-git-send-email-lars@metafoo.de>
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


--===============4338397937896271915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/sOeOc411JsunZwA"
Content-Disposition: inline


--/sOeOc411JsunZwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2015 at 12:23:05PM +0100, Lars-Peter Clausen wrote:
> Export snd_soc_runtime_set_dai_fmt() so it can be used in modules.
>=20
> Fixes: ce64c8b9cf5b ("ASoC: Add helper function for changing the DAI link=
 format")
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied, thanks.

--/sOeOc411JsunZwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrsSBAAoJECTWi3JdVIfQaxEH+wX8t479wQ5XZp2IZOfbUsZI
K5fQU5MbPGFdKmQsAcCunLz25l8Hn9cKXB9rMHf5hMy0EHH2EpMK97BiqWu9foQP
oNEQS4xvFyTAyXkda6sQg4Ns3QfPiwkPWbwZvfwHRXGqG5AQOFIxNxoiZjkP6tym
EzbOaaAt0jgGgqo3ty4FGfEs+yEwYfgNaSXSzsnTwi0IAJehFT+KkNvsEwUr/WYJ
0gkfkLoP/rbeaxrT/FAcMjAVypJg7wCHYQ7akSJ55gDgdqazI2thRADbYqJ23DKb
GMrBQtbqM565QokqGLujBjAot5NuEgAPtVfsoBAXQM7m9M9fc1qMbbyYf4wry1o=
=ddfG
-----END PGP SIGNATURE-----

--/sOeOc411JsunZwA--

--===============4338397937896271915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4338397937896271915==--
