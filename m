From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Split firmware load into
	smaller chunks
Date: Thu, 6 Mar 2014 12:35:21 +0800
Message-ID: <20140306043521.GC13126@sirena.org.uk>
References: <1394029696-25975-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5466306513997124470=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C484265232
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 05:35:31 +0100 (CET)
In-Reply-To: <1394029696-25975-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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


--===============5466306513997124470==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yFtQr8VNODwu6Dbr"
Content-Disposition: inline


--yFtQr8VNODwu6Dbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 02:28:16PM +0000, Charles Keepax wrote:
> The firmware files can be quite large and allocating the whole firmware
> a single DMA safe buffer can be problematic if the system is under a
> high memory load. Ease the requirements slightly by writing the firmware
> out in page sized chunks.

Applied, thanks.

--yFtQr8VNODwu6Dbr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTF/sGAAoJELSic+t+oim9qOcP/0AvOIRAO7uAwLZKJnWja3lk
ppCH9nx/Zqjw5og10KB3HW1DkjtbsRkNqVEmiNi/sW0rEqzuO//BsJJRxwccPqGt
yR4Yj+RlGkfrs77vJkC3AkNWp2Vi04y/h0l0GSBxjCr75fuSuxbrcqYlwWksXEmm
UJPQcmp8Ysuo3IW2eOhvpyLZv+wOilZXUUaHcVhprDFyYfn6jkUD5GKzM3wMTkrM
rGIX7NpeegmNmb1W5eDmtKvLBO8VbfI5YTTTsXKBYQ5jlzV6v1lY/t4gM8ckZv/t
An86LnaUE/vAnpTh7DOaBDweAUdlpVKd0Fmft/SocvGt2wuhGJTkKxVtGI5VsiHH
MZjOUWR8IhT/u8/XHHsyOfHoDsoBl5uSTWYePJXRBcreS2PSq3Lqo/K5vOgxzGsd
K/K9JyO6ZPobhma6yf29Ykz9UN9mHgMuDmUnZMZHI6au6oMk08re2KsNd+de5dA5
aDQM94ZCI2w2g4dKQF5ZkfEuF1INTuvENkL3CpTnHNOZeMXnLczRhejt/y41gDcD
1FrGGeYTgx2P/mh2AZZw5qhnhUZwenINHKXnhyYI9DUxBZU3+BRU6zcIFPeDXEm7
ipw5pjzf//6cf+Qd/cFn9s/AgnmGxYoq/YniMHeZ8lzmXDJoX3zxMVpTZRTDUMN7
f4t1qER7HHz45n3d6jMB
=TaPf
-----END PGP SIGNATURE-----

--yFtQr8VNODwu6Dbr--

--===============5466306513997124470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5466306513997124470==--
