From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: samsung idma: Add proper
 annotation for casting iomem pointers
Date: Sun, 17 Aug 2014 09:35:40 -0500
Message-ID: <20140817143540.GN14537@sirena.org.uk>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
 <1408285102-24538-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8202866308855475646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EBAF5265259
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:35:58 +0200 (CEST)
In-Reply-To: <1408285102-24538-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8202866308855475646==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ie5iOtK4e9kgqh2F"
Content-Disposition: inline


--Ie5iOtK4e9kgqh2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 04:18:21PM +0200, Lars-Peter Clausen wrote:
> It is not always possible to interchange iomem pointers with normal pointers,
> which why we have annotations for iomem pointers and warn when casting them to a
> normal pointer or vice versa. In this case the casting is fine and unfortunately

Applied, thanks.  As I've said on a number of occasions you should word
wrap your changelogs below 80 columns not at exactly 80 columns so that
replies to the mails are readable.

--Ie5iOtK4e9kgqh2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8L24AAoJELSic+t+oim9GtQQAJubgO+S9naIDj3YSNbHiPOX
lz+bwbHIzWBLqZePI1kQFIKuRFDj+s1gyA91UGRdxpFI4je1dv6j4WMOZwM41ouF
uGNnKj3bbUMqVwlnbGAVG6hwUfHvBFTSU6rd6x6F4WikG/RljqgcMhYnRg3aCK4l
PeUbrCcbcIr/lH1GWvlb4iuPCh8qRB2no2ndNwsXIRvmPoniUvIECJFioFzQrvmH
Rcn48T6EUlb/+PoxLn42RPRssslhLmQjKGgq9uMwZjDeDyw5aE9qwZjZDhV5Q8AI
01APJnTGS8PC4WAGxUsCvPln44rtY976wVWGyAV07dC3uWag6vHOJsqZ3OeZ8+SN
96D2SEjrN4Gb4Hte4J7ErSOeXQuVHojsjx4bPh6YJ3Z4lQVfyCNtNa2SPpg6SW/M
SsTCbYVppG3SFbk23MpgCc0dYJ9taJwahkNqWsh109VPZY6+x5UPoGdVcZOo/9KX
WTcOlTb6PN2lr/sqoFnK6W+E6VTRsDmB6S09I0UNJve7Ex2+5pb3zSDdRYVKfM0Z
nd2qy5PWG1l0VGRWxvFB2c+/pGhaNXKK3KL9hfG0yI7BI50Ewi2WGdF3NX8zXuo4
UKTqZerYrruaE6U53B44vicK2dK/zI7BSL2KM3yeQ9JhDoSkkB/cZTdOqr568Lwh
dqTMfQQ7iDVu8Diey+GN
=U2qz
-----END PGP SIGNATURE-----

--Ie5iOtK4e9kgqh2F--

--===============8202866308855475646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8202866308855475646==--
