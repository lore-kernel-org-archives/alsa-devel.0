From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: DA7219: Exposes clock enable as a
	mixer setting
Date: Fri, 16 Feb 2018 16:02:43 +0000
Message-ID: <20180216160243.GL5886@sirena.org.uk>
References: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
 <1518766875-15164-3-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0480098113266822259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EF4A2267E69
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 17:02:45 +0100 (CET)
In-Reply-To: <1518766875-15164-3-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0480098113266822259==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
Content-Disposition: inline


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 01:11:14PM +0530, Akshu Agrawal wrote:

> This is required for designs which uses da7219 in master mode
> and same clks are shared with other codecs. We need to enable
> and disable the clk during playback and capture on other codecs.

> +	/* Clock Enable */
> +	SOC_SINGLE("Clock Enable", DA7219_DAI_CLK_MODE,
> +		   DA7219_DAI_CLK_EN_SHIFT, DA7219_SWITCH_EN_MAX,
> +		   DA7219_NO_INVERT),

No, this isn't something users should be confronted with or have to
manage.  We have a clock API in the kernel, you should arrange for the
CODEC driver to provide a clock via that API and then the users should
be clock API consumers and enable it when they need it.

It's also an on/off control=20

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqHAKIACgkQJNaLcl1U
h9CiEAf/dfXUDzfvf35dIGUYzUnXxrHBRv0Nih535NT4H2zquyaG8JzglHwfG6cU
uMsd7fIcv+S0g5dpMNj31aY/9OmwEjx5P2hqCyZxuFnxkHsYI4FKBRvS0I3khkNm
iGfFvzrqZmDyeLrQQ1l/gd+5qRa6y/66P/RM0QwvSpaRKaIwHkQdn6KzjY+ibTjR
rwyQCP8oY5W0sz7j7wrR52JEiNcUbb+asqyjaecDYLvdjjKnN20rXoRsvA9utPra
/uVWN0GcT3moguArvnby27vNDhJL2FlFIlJsmKjo8xfepbN6/2MotZ7Ecff2e5id
legLJs1GoMr+curjjGG8xHvlHvQNaQ==
=sZvp
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--

--===============0480098113266822259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0480098113266822259==--
