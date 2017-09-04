From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] cs43130 fixes
Date: Mon, 4 Sep 2017 17:11:55 +0100
Message-ID: <20170904161155.lkjeso3cbf22hj5z@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4610016246096775844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 71969266F9D
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 18:11:57 +0200 (CEST)
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


--===============4610016246096775844==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wefohjievte53bat"
Content-Disposition: inline


--wefohjievte53bat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 465c925695593b43695e2396f7279879a72275eb:

  ASoC: cs43130: Add devicetree bindings for CS43130 (2017-09-01 11:45:16 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.14-cs43130

for you to fetch changes up to 7051334672e54fae67e02d5d3296fb62b3343be7:

  ASoC: cs43130: Fix unused compiler warnings for PM runtime (2017-09-04 15:45:12 +0100)

----------------------------------------------------------------
ASoC: Fixes for the CS43130 driver

A couple of warning fixes for the newly added CS43130 driver.

----------------------------------------------------------------
Colin Ian King (1):
      ASoC: cs43130: fix spelling mistake: "irq_occurrance" -> "irq_occurrence"

Takashi Iwai (2):
      ASoC: cs43130: Fix possible Oops with invalid dev_id
      ASoC: cs43130: Fix unused compiler warnings for PM runtime

 sound/soc/codecs/cs43130.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--wefohjievte53bat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmte0oACgkQJNaLcl1U
h9AnHAf/XN1ihpG5OEmp2HWKJwpxyf6pNZr24iBOB6FnduiXqcqnZnL40Q77k1ky
gYrDUwkemOP35mjWOgrwcaPq+nrjZwegLdwOQWOnlXxkhOkR4qiV8Tl2H5p7dID+
EWt/yPNz/0WV+WUFGOT9QhePcbytgG70UWN9qdtauAivpZV1HhH24rR7VQTqK8db
sOc2SBitZReVuAqCNKre9SPFJwGcZ9JJNjftnLuWla5TUB4X7hvss7p3hJx0Tfc5
W3Dq0C3oeyXvSoJDXTRWbertL/P00JCq8SuPPkTB82ArX4goFKgX45sCu5U4pYoZ
ovKBqrzJSsXgwdcQcKhAnxTRxmsgFw==
=lb+K
-----END PGP SIGNATURE-----

--wefohjievte53bat--

--===============4610016246096775844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4610016246096775844==--
