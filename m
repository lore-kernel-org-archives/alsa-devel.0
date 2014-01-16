From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.13
Date: Thu, 16 Jan 2014 14:05:24 +0000
Message-ID: <20140116140524.GD17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3199121029017712736=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9BFD261735
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 15:05:31 +0100 (CET)
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


--===============3199121029017712736==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7e22e91102c6b9df7c4ae2168910e19d2bb14cd6:

  Linux 3.13-rc8 (2014-01-12 17:04:18 +0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.13-rc8-2

for you to fetch changes up to c6affc0dba45bb2074ff56b21386d22eeaf682f8:

  Merge remote-tracking branches 'asoc/fix/adau1701' and 'asoc/fix/tlv320aic32x4' into asoc-linus (2014-01-16 14:02:52 +0000)

----------------------------------------------------------------

ASoC: Fixes for v3.13

A few small fixes in drivers, nothing too remarkable here but all good
to have - mainly these are fixes for things that were introduced in the
last merge window but only just got useful testing.

----------------------------------------------------------------
Lars-Peter Clausen (1):
      ASoC: adau1701: Fix ADAU1701_SEROCTL_WORD_LEN_16 constant

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/adau1701' and 'asoc/fix/tlv320aic32x4' into asoc-linus

Markus Pargmann (2):
      ASoC: codec: tlv320aic32x4: Fix regmap range config
      ASoC: tlv320aic32x4: Fix regmap range_min

 sound/soc/codecs/adau1701.c      | 2 +-
 sound/soc/codecs/tlv320aic32x4.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1+cgAAoJELSic+t+oim9oHIQAINOclOZvWH3FV3mGKbOoS2F
cqO/HQ8L1/1ZBibqzFAEuQjqQxm2yXbDlF7OZV61jp7b9BC4mEWDPqQ6xRjc19/h
HrJZrubYBIthdle9BTlHv33+knq0AFjLE4Ypfmna6oMsZbRoUu6eTeD8watxMeyB
3XELApuaUulQ1YiOO2tJot+dg3DVIkJGZNewhWpm1deh438UeY9R/cgXIRTWVLsj
3kRsIFUWvTnJPyXZdwEhiRK1nCpIcU6KTZeg50p8KBoypMhpd+5/cWFazH0M7+RS
eflek+ci40kx+SAwk7AjRvXvdTCpZcv+38vXBCNB49t65fWJQ8NC9wnQ0M93dhG4
fUOBhVgEbZCSP6XiKOZFt2iydOau/z5AKOagnP/IHcXb0MHWYhcaXd4o4JD08SyU
rvXSLmML+nGW6IN2TDWCYDZxGoe1I8JGV3bWS9H+V5/9StTxJbvBftnwIWzh120S
Y881ylxNZ7SxTgd3J7BsyX+pHXg5Sn6+tSSjKLly0A7mYlglLIZugbjAcg8wTlM4
PoVkO45iYEFWmJWSBnFEhhAYUVUuogpEdhgjxiPI/Ifw69PXKlSwBvmJPqo4QNhq
MOlSIMtvRLpmwA8JM1EGQBbrOHraKeR0acgAq6pvE984tbEMxatKHM7Aa6qaKK0s
0Gfvb+V8m0z0i38V6Ikq
=FF7y
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--

--===============3199121029017712736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3199121029017712736==--
