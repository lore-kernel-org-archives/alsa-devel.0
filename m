From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: mxs-saif: Fix channel swap
	for 24-bit format
Date: Fri, 2 Nov 2012 15:03:28 +0000
Message-ID: <20121102150327.GD4413@opensource.wolfsonmicro.com>
References: <1351792632-30649-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5675122494510868366=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FFB026509B
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 16:03:29 +0100 (CET)
In-Reply-To: <1351792632-30649-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, dong.aisheng@linaro.org, DWinner@tc-helicon.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============5675122494510868366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J9fO++IT6debZ01Z"
Content-Disposition: inline


--J9fO++IT6debZ01Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2012 at 03:57:11PM -0200, Fabio Estevam wrote:
> Playing 24-bit format file leads to channel swap on mx28 and the reason i=
s that
> the current driver performs one write/read to/from the SAIF_DATA register=
 to=20
> trigger the transfer.

Applied, thanks.

--J9fO++IT6debZ01Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk+C5AAoJELSic+t+oim92IUP/3f/P5F9ezXWtz/YyrxtHRWj
B/3IS88PPnHLIAIKEmAUSBdhHzIrXgqZGY6spil0EcHbmHu4uPFC2yvh7sKAH8sf
vhuy7tQRtiAivrCcauHGDdjSiUT/vCGuKXYQ1rCpK+9SYZIgXxtXVQq0bQsWScSM
Ew5mAO8lKOoni3KpylA9jp9QDNhKpg9A6180TxPqirVEH9TZ6MA8b0MI8HnTzkMf
5Sqm2uOA2D63TIOOY4nPE+9oKBiNkZ0dxADO8kfQNZlKgWHVQqPYyLfSXBI8yPND
BDtIWpph2I62dheiDALG/bVGnCNpJRZjUBByMAP1zb0JdujqTklaH+Lqmkd1EZuV
djJEo1SgpmT5KgSW/6+9NRoYDRDXfe0EMWFYyU/Yq+QdAGNQ7YBea//n/WduyPoe
r4eWgCqwAcFjU+6IIujslOihb+hxd8uBZVbvRr9SfLAInJYSMaKFSluqzLUJa+ta
GR8JUUVUfza7ez3FINc3A42m1fCRorcpUICjPk+3JE1fsvfNkIpb+bM7A3m6h1S1
wX17iWNO1Y1zL61Ehju3mTSsL6aaLRgE2VbyujJ9NHAa1TnhPVC3vkIrliUgZJVD
o8oFP1WBZElYTWN9YDMaPtwUKKypk8tfB6w+1V1YSESKK141ov/cc6hh9xuGQKa/
SB4qARhBQRijvxepLyDY
=PoxN
-----END PGP SIGNATURE-----

--J9fO++IT6debZ01Z--

--===============5675122494510868366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5675122494510868366==--
