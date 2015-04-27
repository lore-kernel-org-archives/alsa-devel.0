From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: rt5645: Fix mask for setting
 RT5645_DMIC_2_DP_GPIO12 bit
Date: Mon, 27 Apr 2015 20:58:56 +0100
Message-ID: <20150427195856.GG22845@sirena.org.uk>
References: <1429589989.12465.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5142464229816980201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D6726041C
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 21:59:04 +0200 (CEST)
In-Reply-To: <1429589989.12465.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5142464229816980201==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JJ5w4ICj7JHze0x0"
Content-Disposition: inline


--JJ5w4ICj7JHze0x0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 12:19:49PM +0800, Axel Lin wrote:
> Current code uses wrong mask when setting RT5645_DMIC_2_DP_GPIO12 bit,
> fix it.

Applied, thanks.

--JJ5w4ICj7JHze0x0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpT/AAoJECTWi3JdVIfQSk8H/i+dZNYHCqrm2PRiiwjsBkx/
kVAT0ZAh+YwczDOJyYTUvB4G171iXE+SDpltkC6VR695K+PzB1uSS10C9hot1TLV
ufhTO+SrinKq3d3hCQzgkv+gy25cWwApH6BqeIxCeqYGgyEs3CxbndKUL1MSxQQX
V9McIgEEivW8ZjNzq+vYfi+Kgtq+KQFkKbjpJHd88am80xHw4fO8iOJOp0xcYu1+
e/WVS6De3eNmWa4rY99pnBrLvYxhvYKvrX+klq0CcCbSQWMfK92g+ZqbWUHrRqDb
JWSpeJVUSU6kIm5HWMBt3aPGdmfS2wiFz2Co7IysdFdjFK+MVPPtAIh+/P58REo=
=QpeL
-----END PGP SIGNATURE-----

--JJ5w4ICj7JHze0x0--

--===============5142464229816980201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5142464229816980201==--
