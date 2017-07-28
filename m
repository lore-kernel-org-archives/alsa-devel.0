From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/6] ASoC: codecs: msm8916-analog: fix
 DIG_CLK_CTL_RXD3_CLK_EN define
Date: Fri, 28 Jul 2017 14:36:23 +0100
Message-ID: <20170728133623.6n5mklco4enspaam@sirena.org.uk>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3251153854181157240=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10A2F266C13
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 15:36:36 +0200 (CEST)
In-Reply-To: <20170726003512.18965-3-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Damien Riegel <damien.riegel@savoirfairelinux.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============3251153854181157240==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3vhqlmay7zfgbxjb"
Content-Disposition: inline


--3vhqlmay7zfgbxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 02:35:08AM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Damien Riegel <damien.riegel@savoirfairelinux.com>
>=20
> The wrong bit is assigned to DIG_CLK_CTL_RXD3_CLK_EN, change it for the
> correct one.
>=20
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

It is *vital* that any patches you submit be signed off, please see
SubmittingPatches for details of what this means and why it is
important.  However in this case...

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--3vhqlmay7zfgbxjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7PdcACgkQJNaLcl1U
h9BWmgf8Cs4cpwWUGhZ9RnVa4ug3/vZn1sYvnhEyOyASrdXzuoaSYLTu8Ky0zuXu
6OVdXASLv7oBY6WKZq61LAKoZKwlmtQ9/z5CZlKNIqSwH+zsle9NKK+YUOkj3vHb
qd7WatP0JjgGKhdldDb3qS+EE7yrksFvtluH3DOJfE7Cg8Je2rhePfCEZAMKf7vv
v3UhxvzD/Ze7kucGude5VJGwbqQH1e2hYFC24czbEh3akIP/AZZ1kvPf17lmqIXR
hqDqfREtU7mmBcK1UEWmSR6BRFV3OpNVTwyRcJ18m2LhZmOiYFs9kFa/UPxmaIwd
nzkqdzrDGxSuvEQ0vs8GKx1hv6PWmQ==
=zczk
-----END PGP SIGNATURE-----

--3vhqlmay7zfgbxjb--

--===============3251153854181157240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3251153854181157240==--
