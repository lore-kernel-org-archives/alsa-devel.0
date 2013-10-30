From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/9] ASoC: ml26124: Fix negative array
	index read
Date: Wed, 30 Oct 2013 09:48:38 -0700
Message-ID: <20131030164838.GH2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3130753884477558019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A58DB2654DC
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:09:19 +0100 (CET)
In-Reply-To: <1383118507-21503-8-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3130753884477558019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 08:35:05AM +0100, Takashi Iwai wrote:

>  	int i =3D get_coeff(priv->mclk, params_rate(hw_params));
> =20
> +	if (i < 0)
> +		return -EINVAL;

This is ignoring the supplied error code, I'd expect to see the error
code being passed back (and fixed at the point where it's injected if
it's just returning -1 or something).

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScThjAAoJELSic+t+oim9eRAP/RE/RYxjMh/SSSvSX5Qsf5w3
NxsyNZwrI/SfMfTBbhnmluwqJuqtf0MCfDDell0dtxP/61CkY8PMrGCjbcpQZctl
cFvkRG98PXZq4N8sHn8lG3Fu/Jnm2OPYfVki3UGw8GtL1oFFS90bsfdR1h4wPLV4
ra8pUqyGX4pZIQBrB0AYKj/NirP5BgQnPY5Jd1/ukBhz1wQbI4dnoDxnFh7Ga1cN
J5pKoxVVG7aXLfttIwqO8mS8ICcAvrZbyhzd0k8c4gDjGAq+Pd+IuQPOGQB7/jYT
iqhXupJFUQ7zuVtYfT6qwo1ZtqkC9PhtUXr/BzqAG/xCLIvy1Upx8rUye8mofp54
X6t1e3sS3PXm5Pl3ZxWmYQRxITehq3rlMnw5FjXQsAItNHr6jF1VPiQBQU7SDLtd
dJHUh4gqDSd0IEbhKh08QSbXti2/2QY0qGlv3DO0cr+bYEwPkQiiLbXCFDIxBOzN
hQX3jmQJqn7EaRlAgVoIDPfKO3rhaa8J4YaFoVnlUiF5OyQsxVe3fpK41QWx+s1f
kurkanDu/Bk6m7PbQt9QAZYlpuKm9VR6bcg5Q0T8qejWDbEmHkymwFyH1jnV/GHc
hyTeLoSyy0xbCfjoZEa/so+iISHH9Y/SAVBOOLaraChuEtA7aqWBAhn5YtkuPnbx
mQniV6qXlxRNneFOUFnE
=BYrc
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--

--===============3130753884477558019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3130753884477558019==--
