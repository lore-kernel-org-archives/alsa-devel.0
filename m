From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the sgt15000
 codec.
Date: Fri, 18 Oct 2013 18:28:14 +0100
Message-ID: <20131018172814.GT2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ozmrAWQcVMJcOLTa"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: r65073@freescale.com, timur@tabi.org, lgirdwood@gmail.com, r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--ozmrAWQcVMJcOLTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:01:14PM +0800, Xiubo Li wrote:

> @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
>  				struct regulator_init_data *init_data,
>  				int voltage)
>  {
> +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> +	return 0;
> +#else
>  	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
>  	return -EINVAL;
> +#endif
>  }

If these systems don't actually need the internal regulator then should
they not be trying to enable it?  Alternatively if it's OK to ignore
this then why is this conditional in the board?

If this is something that it's safe to ignore then it should either be
ignored all the time or should be controlled by platform data not by a
compile time #define.

--ozmrAWQcVMJcOLTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYW+rAAoJELSic+t+oim9e1cP/iq+FRM1OthmKupHcsx75mPo
/BSHzbRMV3vQg8d5stwzWn2iH0cDe8uu61lc/clarnoWdBdscb3dgvsRMrV4SO1X
K/VGYDmdC/baGPYNL+Mx6CFEgO5bv0HOzYh0ItCbfht1DJWe7WK8YPW3xidxutsN
2vc4SiBdYepNKPpeqMP+OLdS1TFxn+nZKKxERsDoMrdAt9XsDW6MSaqXt7/q7cUd
fUEnXTINIJl+KhNqsrsf+pxhds6ezL0SkyCjuRDdXpUyw1ur0HBndJsTL4XKtClU
gr022z5LRSwXano+JbtpWoydBJ2t7qhUL956CG29JVjHfzGNJvep2k2vW7bXC4lB
UWjfy7xBf+NZNlQtTvIGi6tSlMvqEEKF5EKOMZoNMGa1+Pk0vtx3eqdjZk/9GFzJ
82cW0sRdS1l2fNvF4LYb5jC8rcqV43UKjG0SWOT0vxEKaLdWGFMSXHwgZaepwBx9
TAIclxB5+F20Yfo6cxUDmaVwywyCf1xJNL3pjqOFDYwEdX82SHqh+xabGp+Bsf9l
QtLpmAB6o1nvMNj/l45hDPoO7Vz5c1P1WwuDcppVtz72M4HIBlGRVna9Q2DDX60s
/luBFR/1qhLsDzE5ZGm+rqcb8gftbZqmLDLCZmO4gf9lbkgtwLuIavytfXKZUrAb
1EzNihFkatoctVTdBBN0
=tZKV
-----END PGP SIGNATURE-----

--ozmrAWQcVMJcOLTa--
