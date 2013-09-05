From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: change the compatible
 string of the kirkwood-i2s driver
Date: Thu, 5 Sep 2013 18:18:13 +0100
Message-ID: <20130905171813.GA2839@sirena.org.uk>
References: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130905185456.175f556b@armhf> <20130905190341.4a4a7820@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7171814135859683671=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8203D261A1F
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2013 19:18:28 +0200 (CEST)
In-Reply-To: <20130905190341.4a4a7820@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7171814135859683671==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2013 at 07:03:41PM +0200, Thomas Petazzoni wrote:

> not exactly the same. Should this error interrupt become useful in the
> driver, it should be done only for Dove, so it makes sense to have two
> different compatible strings.

In general it's reasonable to add compatible strings for the SoCs anyway
since even if we don't know of any reason why we'd want to distingush
between them right now it's possible that in the future some reason
might be discovered (such as an erratum being found).  Worst case the
kernel just treats both compatible strings identically which isn't a
great loss.  It's not essential though.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSKLzOAAoJELSic+t+oim9PKIP/0DTamEWKmJSeIICXa5YTedE
wigsQgDSclEhfMLYfEMDYr4vBsc9I7P2ORoRFebjvKcVj7ejm7/VekgNV6hMW4nv
rXWxChFbSp+ImxqLkPcZOvx4VhH7L5BQuacmSDv8gwfNcIwVvCS6tgl6h6SoWsv6
KMrhqpKpxtx19E3QPIpxUZPM1jmnPu4kyp7IQZwUtPOrmgtAZAZ01oSrnhbEH5MG
Z09IPgtE9d1kr77l1RzZCZM3jU8/UcsmZ61SbCNjZ/a0WEP8wF2ohwhWCCyA1jhs
nEatysJRyUvxbWIM+O6xcIl4GEBcL6B6e6COlIv58azOqvY4VSC451xS7kKbMRHu
aFqVpV6/kopfELyXWKU7DlML885s9CRxE2gj/2y/bDG6MorX/ouS5Y39ZVyI7Nuq
BJzJF+VhQF4P42bnqTDThXM/hDM+j+dBB66AnNaG5/8oiAkrP9nhdneav9kRR5Rf
gbR0DjDXzeuaVYR/rO4nh9tvfj44J+WEmn48PHWRWigJxnJJuboH13Kc4r7aIylH
/jvHJnAG2M11rXxajktHlSpZ6HmBb5rtV3k5o/BdG4tDf9lCuBe+1dhZTooFmxUu
NBHdRw3SJkYLO/9HKCmsC+RwAQYs8SVqlnYoJeqCQSv56a2RwxVRThp7Fvle52cG
kYa+57LEzFunikgBRXtP
=TrPX
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

--===============7171814135859683671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7171814135859683671==--
