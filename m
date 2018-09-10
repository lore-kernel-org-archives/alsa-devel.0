From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/16] ASoC: rt5668: use
	devm_snd_soc_register_component()
Date: Mon, 10 Sep 2018 15:08:16 +0100
Message-ID: <20180910140816.GH5856@sirena.org.uk>
References: <87sh2mruw6.wl-kuninori.morimoto.gx@renesas.com>
 <87k1nyrut2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0249519492588963456=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C803E2676ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 16:08:16 +0200 (CEST)
In-Reply-To: <87k1nyrut2.wl-kuninori.morimoto.gx@renesas.com>
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


--===============0249519492588963456==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7SAgGoIHugoKhRwh"
Content-Disposition: inline


--7SAgGoIHugoKhRwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 07, 2018 at 01:01:34AM +0000, Kuninori Morimoto wrote:

>  static int rt5668_i2c_remove(struct i2c_client *i2c)
>  {
> -	snd_soc_unregister_component(&i2c->dev);
> -
>  	return 0;
>  }

This one is fine but the function is now empty so should be removed
entirely.

--7SAgGoIHugoKhRwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWes8ACgkQJNaLcl1U
h9AK7Qf/Y02/lhJTD8VCS0Y5v/hWp4alPHrU8s4c/ocQpQRDQOrnKNbGpGytHR8H
OAadatrRyY3IO/xwCB6zu0wBDiELxQPbeHs5VDx5cvkQ56wHSQLHhg1o0Dxrehay
R7UEoG1DYizimS3Bmyk0k20dNQEQTZkdB7ZODPRpRPcPdqPg04vhHPtPE/Rrykyx
IKQspgg/tjYeNXBo6fyVOmFBJgZ5N7RQXQb75420sP4hqx/nIi6IjpVv8SjZCXKN
ufS2YD7tKmAx7zwPlbWsUg71Fcd9ta/bnrC5+oB77fenmXOMMmdmN7PNo3MAWqXj
3ty1J8ccLlNJtq77MXArGFe4XJaOUA==
=4OdH
-----END PGP SIGNATURE-----

--7SAgGoIHugoKhRwh--

--===============0249519492588963456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0249519492588963456==--
