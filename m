From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.5
Date: Fri, 29 Jun 2012 08:29:10 +0100
Message-ID: <20120629072910.GQ28922@opensource.wolfsonmicro.com>
References: <20120629014959.GN28922@opensource.wolfsonmicro.com>
	<s5hmx3mbpj0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2329003151985492491=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18F9510BA19
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 09:29:12 +0200 (CEST)
In-Reply-To: <s5hmx3mbpj0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2329003151985492491==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Content-Disposition: inline


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2012 at 08:28:19AM +0200, Takashi Iwai wrote:
>=20
> The DAPM fix looks incorrect to me.  Since it isn't actually used, I
> can still pull it, but hold it on a bit until it's cleared.

As I said in the other mail it's clearly not breaking anything since at
worst it leaves things as they are but I'm running late already today...

The following changes since commit 6e1c39c6b00d9141a82c231ba7c5e5b1716974b2:

  ALSA: hda - Fix power-map regression for HP dv6 & co (2012-06-26 17:43:06=
 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.5

for you to fetch changes up to c9fe573a6584034670c1a55ee8162d623519cbbf:

  ASoC: tlv320aic3x: Fix codec pll configure bug (2012-06-29 08:18:03 +0100)

----------------------------------------------------------------
ASoC: Updates for 3.5

A couple of unexciting driver specific changes.

----------------------------------------------------------------
Hebbar, Gururaja (1):
      ASoC: tlv320aic3x: Fix codec pll configure bug

Mark Brown (1):
      ASoC: wm2200: Add missing BCLK rate

 sound/soc/codecs/tlv320aic3x.c |    4 +---
 sound/soc/codecs/tlv320aic3x.h |    1 +
 sound/soc/codecs/wm2200.c      |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7VkuAAoJEBus8iNuMP3dR+wP/3JjCP+MLYAyaNu8XU/E2lNr
0Z6H4FsPhXsTof6nyeYFKucc1/RwU/PEfRODP3fu8Uh/Fn9hrek5tLzfYizYH4cz
kXaPbHGmi+X9cHL0LK70HT4VN/OLyzSjV0K6wGFwIwEO35gYu6/VsMhuID4XNbGK
OT/x5R77+jdeKXQA8AQwPInTgWJlIewgtsR4WhdUwTNh6rrICGVqgjQ9/9DGYftg
ZuQIBUdKaUQqcgYUi1/2WDdiRE4NGKlbLLyZOuRwhdNh9Gudckclw7xHpJhdUB/g
XxVfGVbnYSeKDucg2dq0DSVoi8vFD2cUDwVC6+nBGFi7vfr0Os8Bp2cNwCUue3cg
30TWurlSXL7rILeK6jzsDSkIGfPmhhuK6dJDfzZWU9wT6XelQT3ZaTbUr61/shX9
MLz6PvqYyMx+T+1drh7gKFyDOTb1Q/Kkh9UGX0ZQPC5V4NWBb9XZm57yvCpAIa7J
YLVYws0rYJ6T+1ckfnr/EOrXwWmE5MHhL/Rd/bmOxi/Y+ihlm63WOZ8LTwYNmlT6
cr8qgZ8hppEVuoBcnWYd6MK07Zd49ohAdcgpzMnN0jAEOEUft0OQuP4GphBGQi1X
1sfEkSisxyaVWdBHWkYZamR5G1xnXndly1LM2Y9sIvz4gPYqvaf11za85wuOj229
ksCWCmppisBQuQfWMS9y
=NT6v
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--

--===============2329003151985492491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2329003151985492491==--
