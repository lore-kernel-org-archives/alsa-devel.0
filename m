From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/6] ASoC: Intel: Reorganize the common
	dsp structure
Date: Wed, 8 Jul 2015 19:38:33 +0100
Message-ID: <20150708183833.GA11162@sirena.org.uk>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0479905921257907359=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 999C72650AF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:38:38 +0200 (CEST)
In-Reply-To: <1435919647-14049-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0479905921257907359==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f/XZMZU9ST6S8MjH"
Content-Disposition: inline


--f/XZMZU9ST6S8MjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2015 at 04:04:04PM +0530, Vinod Koul wrote:
> From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
>=20
> We will add SKL platform data. So organizing common and platform
> specific data helps.

>  struct sst_dsp {
> =20
> +	/* Shared for all platforms */
> +
>  	/* runtime */
>  	struct sst_dsp_device *sst_dev;
>  	spinlock_t spinlock;	/* IPC locking */
> @@ -268,10 +270,6 @@ struct sst_dsp {
>  	int irq;
>  	u32 id;
> =20
> -	/* list of free and used ADSP memory blocks */
> -	struct list_head used_block_list;
> -	struct list_head free_block_list;
> -

Perhaps a union might start to make sense at some point?

--f/XZMZU9ST6S8MjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnW4pAAoJECTWi3JdVIfQlqIH/2i0v1Z8LHGnioXwtwr9pkwZ
2tJWsK0sTj2MZJm8LsQUb8loa+VW19K1csUpK3Ra6EuHOnRfWP04KkwjBwpQQvOF
YsC2m04ZjoImWQucO+N82lcnBnNfyVYJvEDMbIbwQ+g9XXjm1mkMseVwlz4GBGfT
hSoLScBiw3VAyR8+rkGVHczB4qFBx8m7Fg8sjO1bIlOjnLKPUipyljpTzByBWYgV
fX2G0Pxyk5RYeprhNxvy4ZZn31VlsuTueo5MJAxp10B5AFYCmVWL5/iUeb6sqBbS
p1HS/6XLy3oxg0VJAC2NKdBXyI5xEc27/y5/eqrGWW2llK+GluHTBewM/nmkWdU=
=/3D/
-----END PGP SIGNATURE-----

--f/XZMZU9ST6S8MjH--

--===============0479905921257907359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0479905921257907359==--
