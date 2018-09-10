From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/16] ASoC: cirrus: use
	devm_snd_soc_register_component()
Date: Mon, 10 Sep 2018 15:06:58 +0100
Message-ID: <20180910140658.GG5856@sirena.org.uk>
References: <87sh2mruw6.wl-kuninori.morimoto.gx@renesas.com>
 <87musurutv.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5035995672530878734=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C21A2676ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 16:06:59 +0200 (CEST)
In-Reply-To: <87musurutv.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============5035995672530878734==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Content-Disposition: inline


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 01:01:05AM +0000, Kuninori Morimoto wrote:

> @@ -422,8 +420,6 @@ static int ep93xx_ac97_remove(struct platform_device =
*pdev)
>  {
>  	struct ep93xx_ac97_info	*info =3D platform_get_drvdata(pdev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  	/* disable the AC97 controller */
>  	ep93xx_ac97_write_reg(info, AC97GCR, 0);
> =20

Similar ordering thing here - it's generally fine to convert to devm_ if
the unregister is the last thing in the remove function but otherwise
you need to be careful.

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWeoIACgkQJNaLcl1U
h9Ch5wgAho3Xj4M3aT3hSA4RShKU//X/PcGPPUQovRDFN+fPHx4Wx2Yb3pp9fRCf
tCnc5JEwbRGgBaKi5UjTJGZvnLEuHgKBeDFb9YVrtVCVwg9R/WGB0t7PiXVnRckS
H6ZgTiPYfAU1jCUvSquydLD8pWHw17oOYah8cxmLCFw+xybgwSu91ZU+++op7kPK
bRDGmuXINrO2QNKGWYccC18F3AzsQVHTVWSEFa8KVKmCfVLTSwakgq0Lz7YpVg8m
b87FHCGmwKtPVmoQAyQwzeWC7VCUXX6GRiSNrUn0VUslM8pDjHOR5uH12BkMMF/S
iqneBVwnN5UJrqbdexv//ah/3/Fl1Q==
=g7vd
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--

--===============5035995672530878734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5035995672530878734==--
