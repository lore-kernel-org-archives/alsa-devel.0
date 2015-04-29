From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: fixed wrong DMIC ref
	clock
Date: Wed, 29 Apr 2015 12:20:03 +0100
Message-ID: <20150429112003.GI22845@sirena.org.uk>
References: <1430191660-2959-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6855933988527958402=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D4FC260517
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 13:20:08 +0200 (CEST)
In-Reply-To: <1430191660-2959-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6855933988527958402==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="04PAcNgY+PB7biBq"
Content-Disposition: inline


--04PAcNgY+PB7biBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 11:27:39AM +0800, Bard Liao wrote:
> DMIC clock source is not from codec system clock directly. it is
> generated from the division of system clock. And it should be 256 *
> sample rate of AIF1.

Applied, thanks.

--04PAcNgY+PB7biBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQL5iAAoJECTWi3JdVIfQyYcH/R4s5YT2vW+SySBbjwyNwPww
3bW3HDGzznpQxgzD9OpmoXliDKRztdZdvamvPJmSajBpiZc0+dXz85URbC7jWgjS
sYaLRv0g4tvDRluCFeGOajAsS6XiDw/T55sZzHSYSmYI1JqFMd1rmjZD2Wb8i1/5
TP9nzvelINA0NzgDMnbC7r5YzlKksYl3XeAzl7WiuSzCVuymueEtUSi1hWpigMPj
ACvqeoh2+67jw0PNeOYsjPZhbzNz8Pw54VwxxrGvXjhSZNnFBv1XxpDTrqITv23A
fLOutH4q5YdG8SrcW+Ydl2PAtgcvzGK3FnR5D+3/IvVZmGjMEJTvts9tez50rFA=
=vN+P
-----END PGP SIGNATURE-----

--04PAcNgY+PB7biBq--

--===============6855933988527958402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6855933988527958402==--
