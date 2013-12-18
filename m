From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Wed, 18 Dec 2013 18:52:36 +0000
Message-ID: <20131218185236.GI31886@sirena.org.uk>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5129807047715689544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E35C2617B6
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 19:52:39 +0100 (CET)
In-Reply-To: <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5129807047715689544==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Content-Disposition: inline


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 02:43:03PM +0800, Shawn Guo wrote:
> Function sgtl5000_enable_regulators() is somehow odd in handling the
> optional external VDDD supply.  The driver can only enable this supply
> on SGTL5000 chip before revision 0x11, and of course when this external
> VDDD is present.  It currently does something like below.

Applied, thanks.

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSse7xAAoJELSic+t+oim9Bz4P/2fgTuKQXrdJDCVGjvzEKQ6w
xPFC4D4vSiaT5N757fyT199x9AAt10ehdGPGmnkz2TWpV4SNpljjzSlvpUu6Mfh+
ay3pMJAoL9JN8ZUe/PrJYzUPU+Y8PcfnvY6zBRIeZ9+OkXtyuOoLuBiYBa8cvxjf
gRrAWVwVnHDUpAFoNzx5TEqIkc7wDwQnca0SsZRrbPOLv4L90L7tca38z7GVfrX+
/xZw1knBJXYG9NdfgmfJu5rWfQdNNxdDJ3Rosm8TatNswQ97Z0YVHsr1tX6x1jvc
YBQK/zhU+tMzLDVLO+zSfqT26a5CemUrF6ohnB5cP+9E/czNhTv8+cMT6U/FojRJ
7I9cxcm0TON+KeOvb6XVzQgnQsd+FYIlSRJQjBPAEas8JJohOnz1KjjGfnZHuqAI
lmuUPmbiTGXTXZCWnKtIIQO7LzjWenc7mDlk1Y48B0/ZbDqL0hru+SjmA16hc2Jg
q7JqpQI3lGkrRk852R1Sdleff+fCqYdWiEDkLT2fsbHThM+rLG8KhR+Vz8TBcIQo
3SbwziBa1kKKKuWbHcrgMg8UVewBQF0ocB+R+4kquXEHC25sjieYe6JCnGT+ovjj
qkOgzpB0T16wbbyvB5VEhwSkk3otUvnTEknykh3OgOHFzRx4PtVkIqeBqA9c2Qxs
tyaNmb2bBifATwPRZzBA
=jjjG
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--

--===============5129807047715689544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5129807047715689544==--
