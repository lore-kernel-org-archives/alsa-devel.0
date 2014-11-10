From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: simple-card: Remove useless casts
Date: Mon, 10 Nov 2014 19:02:10 +0000
Message-ID: <20141110190210.GF3815@sirena.org.uk>
References: <cover.1415562021.git.moinejf@free.fr>
 <7d82dde0dc838d41bfb44ab734d10f838b49c47b.1415562021.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hzXMyaO2bax00huC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7d82dde0dc838d41bfb44ab734d10f838b49c47b.1415562021.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@arm.linux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--hzXMyaO2bax00huC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 09, 2014 at 12:38:56PM +0100, Jean-Francois Moine wrote:
> There is no need to cast the cpu_of_node or codec_of_node of the
> dai_links when calling of_put_node.

Applied, thanks.

--hzXMyaO2bax00huC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYQuyAAoJECTWi3JdVIfQXo4H/jXy3vUrltx40VffYwA/XQNl
cnzubESsR7edtgk1wYKMEHZvlhWmOV8d6l5W1FnPjF49N3ViSLXwSESkLLrdXzdL
EIjPaDpM2vAOEOP5zy4MXlNmX0EJrRNDXcqZ0AAa1hfCPGE+SB5hwLSB9YEQs0Zw
3uTDHA61rt5F6Cw7xMniG4ZsoqVFkg+c2sfDe/jKbr9b39Mgy8MQ75D8NWey1j7g
eykcyu1ZDinR+PSJyvopiCoeOzZ1sbH6S5wPfwAj4iRqZW+BziKWyATOOy+bZsqh
c0DHViKtbyZbaofVkglXzJGNFwsvlJmVOndsnRj6N6tpUlmWHRo/SAJPREm+zk4=
=QIYa
-----END PGP SIGNATURE-----

--hzXMyaO2bax00huC--
