From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 036/102] ASoC: da9055: Use
	SOC_*_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:25:12 +0900
Message-ID: <20140220022512.GO2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1469676988866980748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BDF7265626
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:29:08 +0100 (CET)
In-Reply-To: <1392723517-12772-9-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1469676988866980748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BbxdsAEEwUsvV4YU"
Content-Disposition: inline


--BbxdsAEEwUsvV4YU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 12:37:52PM +0100, Takashi Iwai wrote:
> Just replace with the helper macros.  No functional change at all.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/codecs/max98088.c | 39 +++++++++++++++++++--------------------

Applied with a fixed subject, thanks.

--BbxdsAEEwUsvV4YU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWeFAAoJELSic+t+oim9QbQQAITleT+kvyya/Mnotifp5FXP
nHgl1LDXF4KuvSN+NT2+cBf1uZ3zndTLGCL7Fy5tBjovxf+X4CUnmYpQmN/InM91
7WgZklUCcpii4YwOr+Tf8Fem+IB9/4p6CIXCafR2w/PbsxyOAbDMl5ItbbnNivmp
zTBYMtfDHcE8saNnYM8bJta0zMgqlCTUOO3YixUxYWP/vWu4J7W82Q9Ze0R77j/G
yCaqjWa9reBmM0ljZI/cqTb5xJwdlei/8JsvM/BTNvg6lzSBYmmPoBz4ko2R07xZ
GvScvBRzX6OoSpP0r9J8tzLjEyI8+xavY2UrOaqCmBIoqWEkWvUPmE3YhD/zzPD2
T6S11+uMDW+cuVMZ9GGIFM9K4twc4yr9lgW1E8IWzv3sPi9q4gk5eYdoLrlEYF7d
jVUFtKE3lMafeT7py+hJ9b+YfMOHOpyQ0rlc8FUr2SGePdIRDajEwUelP7aL4bNH
jLQ2Sjbeo9rdNnL8044C7kqGuXKCwrpWnyrj+gxlazGyS92FW8fTvsd236K0yVZ2
hdb2dVJI5N3dInyl9CvOaGbFQLHOsbiD2Dx6LxYx75LY+a11eRjHMqs/3LUe1csE
nSZZQnGfvOm6lyA8LSqUESMGbbM6+PZ/KQS9eM0x4RgoixhCPoT1H/2qy4SfrpXN
5GqxGklbX/VtYOo8otTy
=UV8J
-----END PGP SIGNATURE-----

--BbxdsAEEwUsvV4YU--

--===============1469676988866980748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1469676988866980748==--
