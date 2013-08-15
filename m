From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ALSA: move dmaengine implementation
 from ASoC to ALSA core
Date: Thu, 15 Aug 2013 11:18:49 +0100
Message-ID: <20130815101849.GX2401@sirena.org.uk>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8895232532445002622=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 844BE2615D1
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 12:18:55 +0200 (CEST)
In-Reply-To: <1376296961-20564-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8895232532445002622==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4YatIo8qwOC8yTX3"
Content-Disposition: inline


--4YatIo8qwOC8yTX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2013 at 10:42:37AM +0200, Daniel Mack wrote:
> For the PXA DMA rework, we need the generic dmaengine implementation
> that currently lives in sound/soc for standalone (non-ASoC) AC'97
> support.

Applied, thanks.  Remember to use git format-patch -M for moves and
renames.

--4YatIo8qwOC8yTX3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSDKsFAAoJELSic+t+oim9V6QQAILSQLka4zrG1rnQJoAcbZ6I
mi8mBaq5/jhPZBFDN4oTbeaqQnMaGj7Hj064jFB6VuRHrh+n+Jv6SJDqnuHKrzxl
RyfhwTvXoMCFkEMWBhDD3Ua/nUy3oK5qjb3tXFT5ntcTsF6FJngSCZIU10tGIXai
EtzC90Lvls9QcOjE/EQov3Q82Q9Yi24VLbHMylgbbWnkuGYUGGqvsIdwAxNLY/3O
3bVDyOExi1wJuCX6qj8MaiUyTkN9v0XdibJA1JfV4TByVh9Lpih6bvywLXmjNWDT
NTWoCarxyhiert83UisBtN/yj1wck0/F78U+nrxoqiqddgZWTJqUjXSgdbVsfLrb
5YUuZk905AS0XDdahBYt1/JajU7oe1MQxBJNEfzZvrezjgcu7G2sLG/fMNNmBCjU
BKhCpJLG7WWhFhlDWIMtmE1zOGzyf72wYLWfgHBNG7EGPw4Mp6LMcCGGJX62R5v9
+vYwi/vy87k8fmT6ZYLdffSCwutMyON7PfF2y8zGeX++eZmIle7/r4cRGA2F34SS
MUVmSdh1GzRC/X8WjDHbAC7rLEE/ShbCRxaRylBiNe6oYy8TVAiverkA7WFqGz0a
Oaoq+nniF5fHwgncL6q3wHp3HjWHRMG1vvT/qP+1iU8Pl5wuUK4IQK+yQZW7X0UF
AMRpZh+wfw8uhWwtBZJO
=QKoc
-----END PGP SIGNATURE-----

--4YatIo8qwOC8yTX3--

--===============8895232532445002622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8895232532445002622==--
