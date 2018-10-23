From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for the next release
Date: Tue, 23 Oct 2018 12:39:08 +0100
Message-ID: <20181023113908.GL2103@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1533481662313492502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 20EF72675B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 13:39:09 +0200 (CEST)
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


--===============1533481662313492502==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KSn4sQg3MnruwCB4"
Content-Disposition: inline


--KSn4sQg3MnruwCB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7f91e2af1a4a2c34fc2e8fb046c722e1a9c85399:

  ASoC: sun4i-i2s: move code from startup/shutdown hooks into pm_runtime hooks (2018-10-21 16:46:32 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v5.0-2

for you to fetch changes up to 6be0f96d799f487f05eb412d362d5a1747d665c2:

  ASoC: stm32: sai: fix master clock naming (2018-10-23 10:51:45 +0100)

----------------------------------------------------------------
ASoC: Additional fixes for the next release

A couple of fixes for build bot issues in the STM32 SAI driver.

----------------------------------------------------------------
Olivier Moysan (2):
      ASoC: stm32: add clock dependency for sai
      ASoC: stm32: sai: fix master clock naming

 sound/soc/stm/Kconfig         | 1 +
 sound/soc/stm/stm32_sai_sub.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

--KSn4sQg3MnruwCB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvPCFsACgkQJNaLcl1U
h9BBGAf/a07R3RwBakm6gYTiVX+fCQ1I3XCPNwmo9VxhPsuNVh5T6GeZav7ACSxo
L744dDRb0vJVNEfLd4HSTMFLwL1jokWy+wu+MTQIgoE2FV7/6JaYnHRSK0lIsYcT
8prwAbMmwmCl7t5K4LVBF/ENXPNQAohVO4D7YJIH/JmcazqRkGzDfLTauvz47H7H
CbRi+9fBYUaNOdtuiz5W9BbVlFaFkIIJqvLYx86UPYsG882aV+fIKLGrkSdFeQDV
9gscQohJ3JiLBWKxSBw56YdzLxZHqPFz6Oqzytq4yhCBQP8IP9tjNCNKEQh3PdTd
hZD8tRcbDlWhbzUcpi9kYciucp/jFQ==
=EuzS
-----END PGP SIGNATURE-----

--KSn4sQg3MnruwCB4--

--===============1533481662313492502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1533481662313492502==--
