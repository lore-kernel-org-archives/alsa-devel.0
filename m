From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5110: Add post SYSCLK register
 patch for rev D chip
Date: Tue, 19 Nov 2013 18:56:20 +0000
Message-ID: <20131119185620.GL2674@sirena.org.uk>
References: <1384858289-25396-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1692864658189550445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 37ACD2607D7
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 19:56:23 +0100 (CET)
In-Reply-To: <1384858289-25396-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1692864658189550445==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="smEuXhZLKnMjT4Ht"
Content-Disposition: inline


--smEuXhZLKnMjT4Ht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 10:51:29AM +0000, Charles Keepax wrote:
> Certain registers require patching after the SYSCLK has been brought up
> add support for this into the CODEC driver.

Applied, thanks.

--smEuXhZLKnMjT4Ht
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7RRAAoJELSic+t+oim9kdwP/A92R+FRW7ptrH+h6lAY5rjV
FQeZ6ZNOBKn8jFO21ysKyaZMMMCw1PIjrOIP4CJVXNR9GtYd3/8ka27Wc6tGHkqf
u9gEiucVXN6J+zxOWKqvTkBune5pYGDeMNodUvqyFDp3T77zdCIpXvrzhxV4gjLJ
lFvbBqeoDHQD4bfoCDhIMK/F83HqBpVywHr/cgynBwxgYbpAiRS6w5N322p3yZeW
nx5Cag7uA5nleBwVlN1SjhRvvTwAQsTe4NU2J4Yr5vbZ3QrB4O9AFX6jvUA4edph
xTQIhh9McomLVHszHIkhAi1iSzpG1bgdAWxdGs587HVLWjdDD8quGyZIe0eqRBLk
C630sXQzoYQ6ECajN3IuvZBVckhZFbq3WW9Ri9AkD3kEYU96Ae7OS8SjJZ2hAf2y
gVKa8fVKMrQoG/e0BPdwFWpE2gw2BBrEcRZ/FUpNqTwJSu8ZYkc8wOLpr2xII6ab
NOLjmNR+3XFVEalu080MmcqW32/ZlyCFvyobEJbyUArcts2JBKfa0G6NLpFnfpOA
QR5cCuWqcGodgeblWDWivYXNjcRYWxx59g0xb2Lx/co6NQMcvgyaaQSwiTyBO9UG
Owyf6rek6SNqRNXR7mvPKunqaQ+FN4hLJa36TQ8eHDSk3dtm5gGsWwPoUV1hlTL4
xPiamIrqxKr0gXU+Icuc
=dNFa
-----END PGP SIGNATURE-----

--smEuXhZLKnMjT4Ht--

--===============1692864658189550445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1692864658189550445==--
