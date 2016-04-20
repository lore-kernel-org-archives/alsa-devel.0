From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: Export snd_soc_find_dai()
Date: Wed, 20 Apr 2016 17:12:26 +0100
Message-ID: <20160420161226.GN3217@sirena.org.uk>
References: <cover.1461042239.git.mengdong.lin@linux.intel.com>
 <5e7147f76b2c54d2d23eb1f6a1146a3716bd5172.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2236603874094080166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CDA462666D2
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:12:32 +0200 (CEST)
In-Reply-To: <5e7147f76b2c54d2d23eb1f6a1146a3716bd5172.1461042239.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2236603874094080166==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3sP1+uScbtwzRm4f"
Content-Disposition: inline


--3sP1+uScbtwzRm4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2016 at 01:12:25PM +0800, mengdong.lin@linux.intel.com wrot=
e:

>  }
> =20
> -static struct snd_soc_dai *snd_soc_find_dai(
> +struct snd_soc_dai *snd_soc_find_dai(
>  	const struct snd_soc_dai_link_component *dlc)
>  {
>  	struct snd_soc_component *component;
> @@ -959,6 +959,7 @@ static struct snd_soc_dai *snd_soc_find_dai(
> =20
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(snd_soc_find_dai);

Can you please add a kerneldoc comment as well since this is getting
exported?

--3sP1+uScbtwzRm4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXF6poAAoJECTWi3JdVIfQdzcH/0UkezcFh9IboYqkoPHP4h/0
RL9OxTN2MRuGmrRTBVQ/pVLi6Z+y1r4EJmYGqmBWvdx46XLoFJozuqoLVWQpFnwu
piArIFQJevvXrg9Wt7PHQVVLgW9FkkW2GimYl2pWd5ViGbUIUfQW0aUd7i9naVK7
pgtWhJKJpqOEvUsNlvM2EV+YoJIKNYPwUQt3UAnU0+psy1+zw7xjcKjFN1ewVeHI
QeQQgHHt64iGFNuRxH+2R2pCLIGaIeBkxYv+LmxoBfXDFocxkwexfsqtdiGaguHZ
d4ftv0W24xe+lmEiH4DgxeC/OmLTAcxlm3ziEX6BTb9O47yIZlgpg982HwB7kxo=
=bQIQ
-----END PGP SIGNATURE-----

--3sP1+uScbtwzRm4f--

--===============2236603874094080166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2236603874094080166==--
