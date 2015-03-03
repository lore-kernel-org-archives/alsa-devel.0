From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Tue, 3 Mar 2015 15:07:42 +0000
Message-ID: <20150303150742.GZ21293@sirena.org.uk>
References: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5496800270102031316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1FD2615C0
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 16:07:51 +0100 (CET)
In-Reply-To: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5496800270102031316==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t7OYZ5hxufpohHNJ"
Content-Disposition: inline


--t7OYZ5hxufpohHNJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2015 at 04:26:32PM +0200, Peter Ujfalusi wrote:

> @@ -553,6 +554,7 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_=
dai *dai, int div_id,
>  		return -EINVAL;
>  	}
> =20
> +	pm_runtime_put_sync(mcasp->dev);

Why the _put_sync()s?  I know it's more symmetrical but I don't see a
need to wait and it means we may be able to avoid some unneeded power
cycles.

> @@ -1078,6 +1082,9 @@ static int davinci_mcasp_suspend(struct snd_soc_dai=
 *dai)
>  	u32 reg;
>  	int i;
> =20
> +	if (!dai->active)
> +		pm_runtime_get_sync(mcasp->dev);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(context_regs); i++)
>  		context->config_regs[i] =3D mcasp_get_reg(mcasp, context_regs[i]);
> =20
> @@ -1094,6 +1101,8 @@ static int davinci_mcasp_suspend(struct snd_soc_dai=
 *dai)
>  		context->xrsr_regs[i] =3D mcasp_get_reg(mcasp,
>  						DAVINCI_MCASP_XRSRCTL_REG(i));
> =20
> +	pm_runtime_put_sync(mcasp->dev);
> +

On first glance this looks unbalanced without the active check in the
put case.  I'd also need to check if runtime resume works OK in suspend
context, I guess it must but there were issues in the past (the more
common idiom is to not suspend if we're already runtime powered down but
obviously here we're actually doing extra work).

I see there's actually a balanced put in the resume path...  I see
what's going on here but I'm thinking that perhaps something more
explicit that calls the ops directly and checks pm_runtime_is_enabled()
might be clearer?  Unconditionally do the power down/up at the end with
a direct call outside of runtime PM and then make the checks at the
top/bottom be "if it's runtime suspended then...".  That's also more
direct about what's actually being checked and hence less risk that some
future changes would go wrong.

--t7OYZ5hxufpohHNJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9c4+AAoJECTWi3JdVIfQVagH/1HbR6lZz+3euyZN252Jwvjj
403Pma7OHBa+EeEJ/VxRVr+mXpGOPIX+uzMOCgkaKXpQjbh8UEvnPzSG6aU+1XnF
XkqSreB5WZgqLeFu0vAu56lnkU9pcmQ9Pf/3ur5uCgOBsESM3PK+GVI0qCYDEr7o
DIU8CvY72MPPK0zth0XIzy/KpjtFO5TX2n5/HsevNhpWBz0zUC2QvjVVT8JnpUqv
MdmctePXrj31OCpsWzUBEtf2nrFb40e5by2E7AvZXeQdaaEBrKekmUZ+m0tDNGSy
zw2A8Cy6wvE1IB76ZRoqlJ90l1ZipAWHB6n9wI8FZrf7rGuO5qcp6NvLNvv8coo=
=+HpQ
-----END PGP SIGNATURE-----

--t7OYZ5hxufpohHNJ--

--===============5496800270102031316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5496800270102031316==--
