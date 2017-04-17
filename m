From: Nicolas George <george@nsup.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Atom: update Thinkpad 10
 quirk
Date: Mon, 17 Apr 2017 17:12:57 +0200
Message-ID: <20170417151257.GA983524@phare.normalesup.org>
References: <20170417150408.20935-1-pierre-louis.bossart@linux.intel.com>
 <20170417150408.20935-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0342328589115522258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nef2.ens.fr (nef2.ens.fr [129.199.96.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 35DD1266872
 for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2017 17:12:58 +0200 (CEST)
In-Reply-To: <20170417150408.20935-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0342328589115522258==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

L'octidi 28 germinal, an CCXXV, Pierre-Louis Bossart a =E9crit=A0:
> There are multiple skews of the same Lenovo audio hardware
> based on the Realtek RT5670 codec.

> Manufacturer: LENOVO
> 	Product Name: 20359
> 	Version: Lenovo Miix 2 10

Interesting. Any chance that applies to the Miix 3-1030 too?

> +	{
> +		.callback =3D byt_thinkpad10_quirk_cb,
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),

I guess I should run dmidecode, get the kernel sources, make a similar
change and test. Unfortunately, I will probably not have time to do that
until at least the week-end.

Thanks.

--=20
  Nicolas George

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ooRQGBoNzw0KnwPcZVLI8pNxgwFAlj023cACgkQcZVLI8pN
xgx6thAAu1H5mIajSyVHZljdm//ECpPZC6P28wbP9QUWGgCXstPF7UaVc81q9IX2
cKC1RSVfn7OXeIvAIKX5MIYGcP1zz1XQ+o/jkzlpXatXq1+d78TqhkEE1Mpyh9Bg
DERIzrj4XxyeHOpE4PgpwzLaI/SCaLnHxi9Pzr6YLOtDZuKjUFMxOOLe1S+nA6ic
P280Tup/zbrlUWhAOhwCAf9xm3e9Chs2V1GTWgwBN4gZZbQDq5AX9vqS5RXUxymf
PKOXoElOrteikGT20TtIN8bsOGwu01r/z2HJPQ0y+cTIRYO5Vpu/jstsnP+F1T3B
1NjsJ5+WZAABln21y++iylwaLm/3WU7an+Hj78MEu33c8B5fZEPdwy3fgzkVic0H
h8lL4jlSMBG9nNLgbZscmsHmy1j0HS3kZEtd7N83X51yiHx4QE0Fy5vxOdFvK21R
I6vU0y29mUK9UcFTKrWGhwzLZC+F13EvNf4PPOvOETjyhjhmSWmiLxGmaaKQstAM
a8dV6bA/8/oKxHCluacZ6CnfbKafKDuFk6SIVMkN6scNeftlOzt55DJcoNX7kQYO
vUg7eiMqFsdBCphxE6sEMci5zUW4dSTGQQ74qWWLOowp227GYLVhJ+c3b7LMn5XK
aet1ywGogJRInRArpzm8bD9ysWCLgrG4oAx8q6S6LporGPxgMyQ=
=5Umg
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--===============0342328589115522258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0342328589115522258==--
