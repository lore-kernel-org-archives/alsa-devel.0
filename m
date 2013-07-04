From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: fix NULL pdata pointer
Date: Thu, 4 Jul 2013 16:50:28 +0100
Message-ID: <20130704155028.GF27646@sirena.org.uk>
References: <1372950840-13393-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7995608980979294847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 477DD261ADA
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 17:50:32 +0200 (CEST)
In-Reply-To: <1372950840-13393-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Stehle Vincent-B46079 <B46079@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7995608980979294847==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EZNZmU/Pkwyv++bx"
Content-Disposition: inline


--EZNZmU/Pkwyv++bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2013 at 11:14:00PM +0800, Shawn Guo wrote:
> There is an error in merge commit 384b834 on conflict resolution which
> causes the following NULL pdata pointer bug.

Applied, thanks.

--EZNZmU/Pkwyv++bx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1ZnBAAoJELSic+t+oim9rkEP/0Vu4DTBjeilJWf2qShWOvs0
2uS0PH47halpzrrBVFQ1C+Q/COkaLU79cLCz6z1CYn0dDOZ19TgiJ/8J8v3L4sTE
x/K7MsRI3z5LM+m004gWuWeTF5GcbsEYmibbkdhzFyio6MEta0SSPTef90tzIO3x
TX3mUzF+PfZ80Bq3lNnXef9o5uIDKRJ/Rkg6/OCMOVZWMz5WjoLnX1ulAvSgZ+jk
1HyVhtx/eXkuLwNpfj8DjwRt5re8e4bkLbUAf08oCF+B7JHkgJRhMYc5bnX1lLs0
yTm90G1VMGNIrvB6G7j9HOTo0g+2ZYYUDl5T1wkhdmz0ZglSD59Zw00LecgjLgk0
Ms4SnLmpHe3Q9kDZUY72VTGoKqt67y60QZWS75+t9pakqYhAdhGPRJmH64t9ekBT
ncTwih1zjVACPCthRs8RUv7bRUWKKMHuS3G/biz2xkMyHJWjFxBmvzdo98M0Rhjo
0y8QRtyQh8kPdz0kHaghCrnUGRg9f/NeX7+qTS+DZaGDs7A83MCwh9laBr2XQxW9
QcRpvr64tQtq0LIJc267cuhTPt+202lzgk+WFhGXnG0s4qe3nnltLJjDVHQpk2wx
f2MchvB/qYzxxUH1xYSDshQ8yaMVhaAceN/eyTCEVPKfdQ5IhNf62baWzzU1kcFE
pxpBYzqT0rHTXTZEphRU
=K1XI
-----END PGP SIGNATURE-----

--EZNZmU/Pkwyv++bx--

--===============7995608980979294847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7995608980979294847==--
