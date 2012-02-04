From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Sat, 4 Feb 2012 12:55:27 +0000
Message-ID: <20120204125527.GC8042@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5836314310534256455=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB9D624356
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 13:55:30 +0100 (CET)
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


--===============5836314310534256455==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1ae5cbc52e7c6619a3f44b87809fd25370df31bb:

  ASoC: neo1973_wm8753: remove references to the neo1973-gta01 machine (2012-01-30 13:22:13 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

for you to fetch changes up to 43b6cec27e1e50a1de3eff47e66e502f3fe7e66e:

  ASoC: wm_hubs: Correct line input to line output 2 paths (2012-02-01 23:55:56 +0000)

----------------------------------------------------------------
The only particularly remarkable change here is the one for handling of
the Android suspend ignore code for idle_bias_off CODECs.  That one is
actually a regression fix as some of the new power savings that have
been introduced confused the suspend ignore code, making devices that
are active for non-audio reasons look like they are idle causing them to
be suspended instead of being kept active.
----------------------------------------------------------------

Axel Lin (1):
      ASoC: cs42l73: Fix Output [X|A|V]SP_SCLK Sourcing Mode setting for master mode

Mark Brown (4):
      ASoC: wm_hubs: Fix routing of input PGAs to line output mixer
      ASoC: wm8994: Remove ASoC level register cache sync
      ASoC: core: Better support for idle_bias_off suspend ignores
      ASoC: wm_hubs: Correct line input to line output 2 paths

Susan Gao (1):
      ASoC: wm8962: Fix word length configuration

 sound/soc/codecs/cs42l73.c |    2 +-
 sound/soc/codecs/wm8962.c  |    6 +++---
 sound/soc/codecs/wm8994.c  |    5 -----
 sound/soc/codecs/wm_hubs.c |    8 ++++----
 sound/soc/soc-core.c       |   11 +++++++++++
 5 files changed, 19 insertions(+), 13 deletions(-)

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPLSq3AAoJEBus8iNuMP3d9+YP/jbqxcEYlcz4bNu5vR2KFRlo
Doicp4Z0iLW+EIYH066SjIExg3Y4/nfqxITQ+OeTfJ3QyjohxaQYxVWOgTNSIyOg
e0lkLZ+TOVqi0Z52bPzWwlUFPAWDMxGGmj2BDcv2SSbpMO0lDy6EPUFrSN/w58cJ
OpII7cumBc71if0+1XeV6iykpLVAwLdMoN662v9Xh6mW73U8eJXss9wHbo2WzkKc
TfXl79HJeeEhm3Jq6WdeNvm/3dYBUVeQQiwRRQVboPtq9l7M9gD3XCaq79XuuUzB
o4VOUC2u4FzGcPAnPwMWoiu1KE/axv38sp4cX2yCU+O0kEBOQrWcO3DIS52z8yIl
TF/0tASxxVFNpWZdgmuhRq2o8Zn7VxHodqXx+siJjDuIu3VaUh3KLJKFQBF6hOQ6
gDKT3AQlReABRQNzHsNL2T04WurM/58PTyUAmVcF3JWtYebTQo7SusdKUWYRtxEn
fzZMSGzMmnSyyVJemI0qHqPmg3RWxweiU0YB2sA0x23ibuGsIrFCkLtOh50zFr6K
5CEQEDluGMMoFCHh8XaK04HQPHstPoRTol7mRMjnMY3NCkP3vrabErB53588c/hz
nu1vB/DtgLkZq/zeQVIFd/LCzXU6uSeI0I922LLHvE5PbkPgUzCNfzE93P18lXvO
ICX7Ydy7QwRwVUs2sN87
=tv8D
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--

--===============5836314310534256455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5836314310534256455==--
