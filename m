From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: No need to call
 wm8962_configure_bclk() multiple times
Date: Fri, 19 Jul 2013 11:07:04 +0100
Message-ID: <20130719100704.GD9858@sirena.org.uk>
References: <1374213508-25617-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8257635129362412117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DD6226566A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 12:07:07 +0200 (CEST)
In-Reply-To: <1374213508-25617-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8257635129362412117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2013 at 02:58:28AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Currently after playing any audio file, we get the following error messag=
e:
>=20
> $ aplay clarinet.wav=20
> Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,=
 Stereo
> $ wm8962 0-001a: Unsupported sysclk ratio 544
>=20
> This error message appears about 5 seconds after the audio playback has=
=20
> finished.
>=20
> There is no need to re-calculate the bit clock after the playback has fin=
ished,
> so call wm8962_configure_bclk only once inside wm8962_hw_params().=20

No, you do end up needing to call it in multiple places - there's other
configuration going on there that is needed by bypass paths which won't
use the audio interface and hence won't call hw_params().

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6Q/FAAoJELSic+t+oim9ogAQAJEDFvc0cRJUvRw2+dYVyghB
T/Rved8CBdatEySKHKwhQECOBJb0emu5ziYYjDOm/nB2wi8qnMm2KaUGAnH6Z4Hy
S1ZC94359DJeo+M9H+tssS3CPo8OUXZwt2Xq9dC67kLSZT1ue4b+55Emnr3dSdbB
o4NYGWSmW2gqSBkYKDrBmT9+dm1W6+v0ebMyH2N2CUeE/OdnZZ4VW9JCbKvDvLrh
dwCJq9Iy2vECfzR40ImRuohHQw3nqA7YXWVjO7dNuBYLOGttXc4iZV5Oj+mNPFyu
zmu1EZVS2k12ln9tO26RmbEPWVUBNvreOOx+tb97rmsRWBRR5n8jxBByQ4+ZzswG
p6qx+D/H0p1bPROqLr/mHr4NpCk+EJhq/atmJUTeSMeG5gnM43WReDEUQYpiJmKU
SxpnNNir9Gf/aEMUFncq/YyCY9B3T+yUW8AEQ7rXMSVySYSHcykojLfqT68cMIFl
PviPfx9Y2eYIzUAt88c4M3HOfJ6g5RUt4XW7K6bwvCjUN8yq3UZgE5zQMiLljHFn
aa5uUZoBxAdUReur5BZ36ND+rlrssfU77R0ZAssnp0VduKtb0hzEI59SuB/WBK8G
BD5QZTQGrrUyEvy52yXSEyrRyoKYekLcPBTFKTCminIQ9pYYvRb/WOpRiQKurDd9
dPPPU7fcYMS1tXDIbT5n
=JWze
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

--===============8257635129362412117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8257635129362412117==--
