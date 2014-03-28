From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Improve fsl_sai_isr()
Date: Fri, 28 Mar 2014 12:30:54 +0000
Message-ID: <20140328123054.GG30768@sirena.org.uk>
References: <1396006765-4527-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rvXnmSEQm80JaX+R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396006765-4527-1-git-send-email-Guangyu.Chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--rvXnmSEQm80JaX+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 07:39:25PM +0800, Nicolin Chen wrote:
> This patch improves fsl_sai_isr() in these ways:
> 1, Add comment for mask fetching code.
> 2, Return IRQ_NONE if the IRQ is not for the device.
> 3, Use regmap_write() instead of regmap_update_bits().

Applied, thanks.  It would have been better to do separate patches here
- actually with your explanation the update_bits() made sense so you
could've left that but equally it doesn't do any harm to skip the read.

--rvXnmSEQm80JaX+R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNWt6AAoJELSic+t+oim9zjwP/RxH3GkRKFmMyKOUYdB11055
0dO6yRgzWA5kRclpq6aP7Zf6YOlFOlGNxDz/uk89ZEv5QtlcnphkaKwPRNW6LB72
s6sJ0U9cxPDY499IV1FidR7ke5ebwigsGhkBJ76UZFMjT3TCFrDHTue47xSBkDka
L/Ib/yhqDHI/jksJITpduKzwjj742cAdnt4xGIhvzadMxZqe0lOOp3ocAKF4CBPs
nSgh+8rWJ0j9+M6InYFjfBi6iA8WTvwKUjGuaxi4LAp2SAgMhSe7YcJAn1FWt7sl
7ETx2asKi55bx/8deTOKKWwFhmROwc4c9FYUm/gXpAejCbg0/fSFmU3oPMOkRCng
b+b1x9XXBJi/SnAK9y04z6TeHQO/bvg1DSOu5TT/ItGqf2vzv3AiJU2vpg3XD1wn
elCN4d2XlAzziU/72Sc3S20okHt8L9MF8ylb1ygTWCkcTv4aYsHmPrasEVtirDyK
bBnvZwQ8xOkbpnJ2gtS3ooxCcTFfuJkvmZYO6K64IvIBgGcL+m58DDSsgomx6XXo
ihPEWv0WIuHT3iC53UxO5G7EqY1Ik9I3MSq9Y55qj33Okle35vscDdaFhJAC2eL2
fYsy5sLcZ77sTvwGBDDhgFb3rq7kzy96S5olcfrreI7Dfx0CyP2EKERlxiVUEwX/
nT8fof4NLcyDoCIJNezE
=Nnf5
-----END PGP SIGNATURE-----

--rvXnmSEQm80JaX+R--
