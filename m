From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: mxs: move to use generic DMA
	helper
Date: Mon, 13 May 2013 09:55:41 +0400
Message-ID: <20130513055541.GF6836@sirena.org.uk>
References: <1368423056-8378-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6672092062905888770=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E2E4A261B00
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 07:55:43 +0200 (CEST)
In-Reply-To: <1368423056-8378-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6672092062905888770==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2013 at 01:30:56PM +0800, Shawn Guo wrote:
> With mxs-dma converted to generic DMA bindings, let's move mxs-pcm to
> use it by removing flages SND_DMAENGINE_PCM_FLAG_NO_DT and
> SND_DMAENGINE_PCM_FLAG_COMPAT.  As the result, those mxs custom dma
> params code can be removed now.

Applied, thanks.

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkIBZAAoJELSic+t+oim9qgQP/jhMcettQJzPw+bY0jeSshg+
9NvWTdoOt3y8abAGdxIomapY806gp7R1xzRCGfm0nqpN9ePp4AUlVY3p1IBApRX2
RlYpDYfh5H5K17qv+fbD65NiG0Ujuoa0BDv0Df0YAO4ZQS6gV0P2M94KjxqngvSJ
T3fzbE1A0uS2IU5095kMXEXqI3Q+sqddBfKTgqCwZsksOLAPgd1n1PCCu7iLwIGM
DVjPPOcc/KNZb/D3kJCZYVfxs1COQV8+zEzV84xDDOzqe+NEz7RbiWCcVYZYT8mM
XP10TWOcp1xLNsezeayh1HhSdOlHyt1jSK+pkMr4KAJ2xJknmfIO1UvoMYOiw2Lc
xOAayLFFae5M5O8P4ypNtYx5sqqHoNYd1MbYAvSg9Ce/TKeWacMZxLkD6j0fknqC
vPx1qHlgdue2vkPiNZbJql1asfxaPaCpdWUXqrWeoB07Ms5ZA5iFPi0wiuOGdnZr
FGIeg9MHMvucqUbDo8oYPA1PmoLu6VlFCja7hFvjOdl32XXSXBD5GEHb+IDaOVwI
uNQdzRVfy2SWRtxZx2hQhoei0n/hcjj5SfySQ4nDtrSSCUsL+9hKazxRViiX1XjK
CtgcJozg+rL2dIIC2TKELtFq85vYWDRpryfVD9dVYpQY32M1htApC19yGb4CzOdY
ol2WrnchyZxzp4PQDdng
=KnoH
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--

--===============6672092062905888770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6672092062905888770==--
