From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8978: enable symmetric rates
Date: Fri, 12 Jul 2013 09:45:21 +0100
Message-ID: <20130712084521.GX24508@sirena.org.uk>
References: <87zjtsbhjf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4043196436321479504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D73265117
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 11:13:07 +0200 (CEST)
In-Reply-To: <87zjtsbhjf.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4043196436321479504==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/BvujNCPFVhiGON"
Content-Disposition: inline


--o/BvujNCPFVhiGON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2013 at 08:09:43PM -0700, Kuninori Morimoto wrote:
> wm8978 needs .symmetric_rates = 1.
> The playback/capture will be strange without this patch
> when it used asymmetric rate in same time

Applied, thanks.

--o/BvujNCPFVhiGON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR38IeAAoJELSic+t+oim9CoYP/jsgeoCXn7foJH0Xbxur7ukL
Q5Dk4EYHMgda043U66+9BJlMXsXd2kb4sZJAbyGqQdcqkaKPYNETzs/EuRWDjyG3
N6ZcwGipOfZhUJj8m3Cz21kUOhfLn6CNVd2RjUC5uCKl/CzTF0ttMtjgtzhebdRc
63IyVgm9yPISaEc2GAYv/kqwj4fTnePx7SIpp5h0pUi00P7q9l5z5m+5+wB02SJJ
XrIz/1lOuWwXquBHCtnKn8PIUphAU1utcAXEQS7okNm5cP6jLmVwNJWyBVKUPas1
LXrIgc6ZgoWinwg73Ncc+zNX93zkJ+m0wFrQzP3GAdnAWahbdPTBmaiF03Mcae8U
M9NUyuBk5KUabueZG62VLrzda0h0rxVxaH2UsesMQ4vXETvn6YGFUSiK14pQZjQJ
cqv4N2wWO/czBTkXwe+iF9B5aHqY347Eh1pYjdd5XhBorcc/+otHt1IgWhtohKwb
bfOyWtH9EuMAbstF2RqnyzTGZhDWJvrXNpMKcPCewa9WRb1Zj5mwUFrnsWSQG26p
AZ96XBU1dcf8cxcz3uE/D7+eTd0fYhpQEq0zrJCmCVqgNx9R2NybSMQSgLGZrBuG
o2uBbUEnQBgSuPv7+DhbgVRXN33Fm+Zcaqs5vlkEEF4vuNoyffD//2NXxGh6ek7J
ODHgntmh3asVzebpDOaN
=/llY
-----END PGP SIGNATURE-----

--o/BvujNCPFVhiGON--

--===============4043196436321479504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4043196436321479504==--
