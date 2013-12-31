From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Add DAPM routes parse
	from device tree
Date: Tue, 31 Dec 2013 12:38:57 +0000
Message-ID: <20131231123857.GS31886@sirena.org.uk>
References: <1387774621-23968-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3244679558155326937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D82D426171B
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 13:39:01 +0100 (CET)
In-Reply-To: <1387774621-23968-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-doc@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, rob@landley.net
List-Id: alsa-devel@alsa-project.org


--===============3244679558155326937==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oaK9NA/DDdTag9m3"
Content-Disposition: inline


--oaK9NA/DDdTag9m3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 23, 2013 at 12:57:01PM +0800, Xiubo Li wrote:
> Parses a simple DAPM route table from device tree.

I've applied this on the basis that it's using a generic feature and
won't do any harm but given that no off-CODEC widgets are defined I do
have to wonder when it'll actually be useful.

--oaK9NA/DDdTag9m3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrreAAoJELSic+t+oim96zAP/2Rd5TlnLTCgfSk+Aa4T8Hlz
vYom7mbtQsNgsVxZKqAcZ7sKBv8tqfhuTNPYBbAH7QGRIc8+b5yPQJzPAG/Nz7kk
JKhQbiVRAkp7CXKEakYz3mXPFAIgj3gMoqefEXCez+2YpYOMKGQ3nXBhJ03rT9Jo
AynqWX2+AB1eWDZIk1xJ/X6fYdV/fBeRxd9ECSaUafJEjm7bcgEp09nCZ47IbptF
g1+AbMCTy41b6i2cF8uwRKwIlJ8m0B0toLm92xbP4IONXApjAx63bRMPtCQHrPHK
Lw1yZtTiC9urWYP4QeX6r4AJPtVc9UiVbl8B0UWnnYOKWfkb5fnPKEgVMDIOa9Pi
ytnMmvxwjDnBmlokO/TpYNMZ8SKeq5gOw0IJdP/tUfvRPHPRQUcY1u2LpCnXrnKH
lHUXZ3qBF+Rt0WfkX8zD5X36mXXCx+1amLqUM/iMEWLeOqzACCsGNJb0f+YdSRIR
lmb3CZnncSfCd53Jh5hjLlWWiEG6jNfELMoD+3NVL6x3qT6rqOTtYMscV6SRFJ9+
PC688GZR+f5tsrJdFkTBZYSxpQQup0+JfDe+BrG1yC549+mrApNNBgOqcVpKhdQZ
k/KGaLPwjNQUJVsKQwsbfQJ1ATRHnmpDyt4KBlnbW9lA352eP4T1uRu2u/BShsBX
MOJ4Jilia7yLyhn+ys1x
=bNO0
-----END PGP SIGNATURE-----

--oaK9NA/DDdTag9m3--

--===============3244679558155326937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3244679558155326937==--
