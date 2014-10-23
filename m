From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jack: update calls to gpiod_get*()
Date: Thu, 23 Oct 2014 10:39:34 +0100
Message-ID: <20141023093934.GA3729@sirena.org.uk>
References: <1414052118-19742-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414052118-19742-1-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, gnurou@gmail.com
List-Id: alsa-devel@alsa-project.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 23, 2014 at 05:15:18PM +0900, Alexandre Courbot wrote:
> Add the new flags argument to calls of (devm_)gpiod_get*() and
> remove any direction setting code afterwards.

Applied, thanks.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUSMzQAAoJECTWi3JdVIfQDmAH/1ettm7Zdvm1I4Qmkq/2snKh
AjjNbzLNvypES3c4k2wR67ed7QJZrG1qef1y5ANUgBToqdsl5nDx5MY5ZBf1U2L3
Uqy4fzx2bg20+4D+BapAeWvj6LurROAfZ/VvxK3mF2g2/a5osrTNCaGyNNdk1lZs
p3ML76gcZT80KFyVI+a6cJKBfVMjjbCl6wD9m3z5RCEggQvLCbeKyttS7aRa/v/9
fGg/nqVIxhG3E/AMQyVwVxprRsHJ+UQOLUW+j+ldlP1a9DXuY0tyTMoNySOpdjRZ
ro/k3ik7CWUzEDk2/U7sHfCpTuNDK8XITcUZEuyhUq/VyQduvvsAX3p9tNMerfQ=
=NStq
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
