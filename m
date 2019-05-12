From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: ak4458: rstn_control - return a non-zero on
 error only
Date: Sun, 12 May 2019 16:54:17 +0900
Message-ID: <20190512075417.GG21483@sirena.org.uk>
References: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
 <1557408607-25115-2-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557408607-25115-2-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Daniel Baluta <daniel.baluta@nxp.com>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2019 at 01:30:36PM +0000, Viorel Suman wrote:

> -	return ret;
> +	/* Return a negative error code only. */
> +	return (ret < 0 ? ret : 0);

Please write normal conditional statements to help people who have to
read the code.

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX0SgACgkQJNaLcl1U
h9Bpqgf/Z4TM2ROcn75WSzHPLXR43KHE2salosbyrC5M/Mg9blRgsevh8gtJwHCW
e2IYJiCmHH80IKs6jMo2MOCXJZ4ib5XsvEd3ZUa1vAiajsIUEqUxJxBTgJY/8Lj6
KvgIc6i7qfd+8gtgvwenOntPYH1vdcJvDlI2pgLtJX1mA8zA8WAqkv8kwbHddQQp
c03uvUyOErkh0duoT4f5WBfsnky2kQh0oZWfREtPdLq4O/mck4zUCj+XJ5Ah0UMs
HP09a4nkC21r+NyYb7tJ2kqs7Mf89F/UW3B2xEx9Xdi0IDsYnONIF95UfIberk5V
jtLqEpVlKdRGgZxNUnqqpsIJmbrpUw==
=G/aP
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
