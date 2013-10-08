From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Tue, 8 Oct 2013 16:49:23 +0100
Message-ID: <20131008154923.GE21581@sirena.org.uk>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3014854908619087031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2629A265355
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 17:49:34 +0200 (CEST)
In-Reply-To: <1381237680-32654-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3014854908619087031==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cseAwlqrBzmhRTxO"
Content-Disposition: inline


--cseAwlqrBzmhRTxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2013 at 03:07:59PM +0200, Lars-Peter Clausen wrote:

> supported. This patch adds code which uses the newly introduced
> dma_get_slave_caps() API to query this information from the dmaengine driver.

How newly introduced (ie, is it in Linus' tree)?

--cseAwlqrBzmhRTxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVCmAAAoJELSic+t+oim9GEYP+wX3jmV1pC7+9ciS/KpV/LPm
k3wxYXwwwox8zWEMtJ7V0zFTqlWgbiE7QVeTUQsjsgs5izS8TGygromAH0AeflT6
ZNONqS0k2zihPVw6an8jIxiDkm3W3CNMY24OUGXDirHB1aKYwmN9OwDjJwM+LysY
e5YC2J9m0zLOEiuh4E/tX0xlzuON328FTExhOiCevHnm9GWYz0dOj45zcyXgxqdh
33lrfPDPGv9pXCuomRKzikviADk05x5OzidxBXVxmZ/ULhBxyzrmsg9bBhFeHLfw
daq3GWbt7SMiJrIH9RLGJVJ5lcrjoTGMC+fAFWJI26qZORltuQLYqJU68fyK9HF4
2KLIst2jhzrh0c70BYlOtLZb/scht3G/CPE5K5c3DSKnUK3/H0GmHVWGsjBI/aD9
bazCtdjFLUMz0lh0loZ5lzq+YZSJLfZPVCBc7WG7lRcRHq6/MRWiMVUXPHux01P3
zFvA0vawOvXtjGwl6rCoCVl2f+Ukgf9BiILuM1wrht7f0qTeqzYtPW4hil/043UZ
hFHDLB9xz/x1pZuiQdmm6rzRGxsP+URWV+fkPIOrOweMTecJBLtuP74VdHG2YInx
o5Eq7YlvbBJySqTl4Auol6u+dwWuc9FmF051IjDhJdjccav4GLeHCTpTGffTBC98
fQ58letahMPEYIs/FX4b
=+1GM
-----END PGP SIGNATURE-----

--cseAwlqrBzmhRTxO--

--===============3014854908619087031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3014854908619087031==--
