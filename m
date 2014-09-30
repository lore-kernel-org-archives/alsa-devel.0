From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] Another fix for v3.17
Date: Tue, 30 Sep 2014 13:40:12 +0100
Message-ID: <20140930124012.GB4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1611535729439002937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AA9D260693
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 14:40:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1611535729439002937==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.17-rc7

for you to fetch changes up to fe2a08b3bf1a6e35c00e18843bc19aa1778432c3:

  ASoC: ssm2602: do not hardcode type to SSM2602 (2014-09-30 13:27:19 +0100)

----------------------------------------------------------------
ASoC: Fix SSM2602 device identification

Another fix for v3.17, fixing device identification after the split out
of the I2C and SPI code.

----------------------------------------------------------------
Stefan Kristiansson (1):
      ASoC: ssm2602: do not hardcode type to SSM2602

 sound/soc/codecs/ssm2602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKqSrAAoJECTWi3JdVIfQ4moH/R1WtOCygDJ+3lnFtUPhTOet
E89EV7V4dd7RUlst6kDSm5WE//krNQ9HbkMP4L4eeTYtDhEvXoWAUxvlkSWKKr7K
uTbzUNh1fs/faeiDqCUQQEIrKQVcQodgVtMw/8wxgy7UCRzC8210Q119j+Ntue7e
nwdOB8M2SeZJSydh0QAAcJobDti5eVVsoO4vNcwXZU9z6E8k7sAa0LPoEsYZX5XB
ME783+O37ALrLBal90DdOGIo5nDrPgasqtxaTXa0dqxHpuUjsWWuQX4Y38xmeqL7
hTC6D9OeS0kZDbq0okohFqK9JsWYcD2C2v9qEyY543MGX7g8wfUk7LZOdcFJbkw=
=z4jE
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

--===============1611535729439002937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1611535729439002937==--
