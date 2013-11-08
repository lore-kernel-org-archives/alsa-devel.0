From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: fsl: imx-wm8962: remove an unneeded check
Date: Fri, 8 Nov 2013 10:22:19 +0000
Message-ID: <20131108102219.GG2493@sirena.org.uk>
References: <20131108095444.GM27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6u7lpXof/8C/+w+8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131108095444.GM27977@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Nicolin Chen <b42378@freescale.com>, Wolfram Sang <wsa@the-dreams.de>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sachin Kamat <sachin.kamat@linaro.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--6u7lpXof/8C/+w+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2013 at 12:54:44PM +0300, Dan Carpenter wrote:
> "data->codec_clk" can't be an ERR_PTR here so I have removed the
> superflous check.

Applied, thanks.

--6u7lpXof/8C/+w+8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfLtYAAoJELSic+t+oim910EP/RwPfoJroRKzAhtw3KtifUwf
kky8eSZUNqNBEsYEbOdf0NccaENLT5iMmEHASGMhO5BHLv95N26rwEO0noHbOFPb
5hAhgl/s0YqR2mdVmI6UlxhEpaNIvbKNWMOUbmysMLhrqbHJ/zZUthr2nXQrmCfP
g2SvvKWnzh50jeg0wTOwJU/2xvRjsh7tuajI8XNMu51r2HSeEI6uFQ/xmA8Qcb1g
bQW5FOQgVuwCTjwKUZo9OOjR2XkOUjCg+Y4jOUhm521EIuMaVk4980t3oLTXWML6
OBAkRcw0/4NhwQgzvJV+zakQ2LccDJrR6pegRlkuP21l9yAWVWUvnU+2De3YbtTG
AiQLWZu+IjMI5ctzSe1bFa+uMx9Wcq6xJnJpTPaN/k9Q6gSVNN6UFyR5c0JMuW+q
f2ESFndbHAqEYI07CGzhH5flOzWLew2/UCEcVxve8i9ZJX12k9gc6rwANbJefq8w
rBrHPPo5rnnEqV2te7GziC/4J6mDPt50FWOYzt5F4nrgYevdE2ySeW1dZYdm1NwI
lviFNxBrA/npGjqC26K3vSfaiPqRBs+yx4sny93MJ89V1YYji5DL4qaGN4Cmk/I5
lAqtWr2bbaszKOVEyzq74xzVq4Jc+ik1fczkNqwkXKvyEHRtcr2qb63XXH6mxhes
MFI8OxGgBFT1kbyKdvI1
=aU3/
-----END PGP SIGNATURE-----

--6u7lpXof/8C/+w+8--
