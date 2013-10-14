From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] sound/soc/fsl: remove leftover
	release_mem_region
Date: Mon, 14 Oct 2013 14:21:17 +0100
Message-ID: <20131014132117.GV2443@sirena.org.uk>
References: <1381693899-12075-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3754588179548366197=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 794C2261098
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 15:21:45 +0200 (CEST)
In-Reply-To: <1381693899-12075-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3754588179548366197==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eV9cGEf2bJwTs/8b"
Content-Disposition: inline


--eV9cGEf2bJwTs/8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 13, 2013 at 09:51:26PM +0200, Wolfram Sang wrote:
> When converting this driver to devm_ioremap_resource, the removal of this now
> unneeded function has been forgotten.

Applied, thanks.

--eV9cGEf2bJwTs/8b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSW+/KAAoJELSic+t+oim9azEP/0ax3sPkOMoHnxMM+7TCcRNG
0rVVgiHuXaXl41/b6fVe4WxIFFmoPLTAkraZ6orRaxOPtj3SVy+0W50CpjlpgRF8
DbXl1ma+h8P2fP8B2ejWpnDbAz5iq+LvWyMc1vuw0AkirA2Fcyc6x0yRs+Rg9z3r
1qzr76G9piD6NyJuezlYcbUvjOtjRr6aYJwi3jQZGyXZfi79kaDVBFd4IWz807UJ
Ahq7sP5MmJV5ikCD3ky+FEO4sMKP0Ri3tFZbckSq1evl3dM32c6BvpafJ88L5isM
BNxzIbOXJAx19oy7rVxRpgkWsTIi3MtVRt//FmLx4JtPmTTmyLw8ne1asCBrkqdN
VNhR5IXnUS/fWL5lBhYuRmtNQ35GSYilCERbWnUB0XpqxLpOZjskqHCL+GPVO6f0
JSlaCKchvDgtoNUcMrnTgxtte8d17SgHvF5hdFRP/mNtAMigrtIy8qDuMCER49go
5erTLcvNEC5pEpUJh0rf3Yv1c+J1W5UndX8d3kz/uZRncmyCy5/N9FXO94g1qDwB
VyWufD9j2/t/waEiXZINn5meDcqS/GTRCRAX4Ul4trVUNZwr44fMo4g5O2HJRp+6
seXNWD6LhZcpqL01hUF5yidyr1UcWheVUjVtrJTPCzMbbq477J5Ww7ek0AFjY2xp
vUQuE1oFZFtkw3kXZbt1
=zpIJ
-----END PGP SIGNATURE-----

--eV9cGEf2bJwTs/8b--

--===============3754588179548366197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3754588179548366197==--
