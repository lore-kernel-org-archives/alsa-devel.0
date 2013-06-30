From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: adau1701: more direct regmap
	usage
Date: Sun, 30 Jun 2013 12:42:55 +0100
Message-ID: <20130630114255.GQ27646@sirena.org.uk>
References: <1372363205-31244-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4023007007126408492=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EC0FD262606
 for <alsa-devel@alsa-project.org>; Sun, 30 Jun 2013 13:43:02 +0200 (CEST)
In-Reply-To: <1372363205-31244-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============4023007007126408492==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8KlXS1coelMGD729"
Content-Disposition: inline


--8KlXS1coelMGD729
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2013 at 10:00:04PM +0200, Daniel Mack wrote:
> Replace calls to snd_soc_update_bits() with regmap_update_bits().

Applied both, thanks.

--8KlXS1coelMGD729
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0Bm8AAoJELSic+t+oim98R0P/11IN5g2c/GBYB1BG1o8KmN3
oQ46R2zhmqxsiAa+b0V6p1Lw7ML8ZanE1KvZ49Q8xiHyQeOYTOicwey9gK6WSUQt
eZEIP8RVHDL1a2W6FOJTsp9hhdPwzTI2oqOL17FouTe0dy7qsmNS8xj/TBc2W/il
UH7rDl1twESmsgu/pH479hEZ4s4TJ25uX0FGHGrLIrWDPyAVyDTC+p2AZeOlAxZh
01CszxvlCN5VQX4VbPUPW5oKaYzc/Ntz8in06KXhZiRDYV8wpw+L3jP+gRevciwM
Qmg3lCENHIoQSo7tYBZTBXqCJinF4kCMa/FWcLRMr8Y8X1aOk9iUMGcehZZQyF8m
eBSFToHxhvxdSnM1YGgHGjM+XDHzqmkpI5UOAzH1VpWu/vyO8YUgVM/lGLI/gqJz
evavixmh2L0VVfJSG8sDLKJlD2OZdyuYjplZBWE9TW33PyttZanIafblYjlctFJR
kuj/iNr7lYnrrcv5dWhkn/MfB90XNI+TMcUWt/z3DEB53SENkH2f8aNLDvF3NRfZ
/IO6u9lsprFqaBAD+YQOuMDNQjYvbRd5PaskUyeiWngLQfnYZArbeBjVAluH4imF
NX+E9Ei9bWueEW/n32T9JvLwH5UQrnI9bEGKiTLy6Cs6G4HRFtfGlHxJCnCawtbh
JWE974eYCt9MPHtPOvhc
=d4E5
-----END PGP SIGNATURE-----

--8KlXS1coelMGD729--

--===============4023007007126408492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4023007007126408492==--
