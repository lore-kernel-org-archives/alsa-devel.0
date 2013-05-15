From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for v3.10
Date: Wed, 15 May 2013 09:05:52 +0400
Message-ID: <20130515050552.GL24524@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2900808941210354405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C58126109E
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 07:05:57 +0200 (CEST)
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


--===============2900808941210354405==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.10-rc1

for you to fetch changes up to 407a0e18ecfbd7f58f49c307a657b63e6f32544d:

  Merge remote-tracking branch 'asoc/fix/wm0010' into asoc-linus (2013-05-14 16:53:21 +0400)

----------------------------------------------------------------

ASoC: Fixes for v3.10

A few small driver-specific fixes, none of them especially crippling.

----------------------------------------------------------------
Axel Lin (1):
      ASoC: da7213: Fix setting dmic_samplephase and dmic_clk_rate

Fabio Baltieri (1):
      ASoC: ux500: Swap even/odd AD slot definitions

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/da7213' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/ux500' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm0010' into asoc-linus

Wei Yongjun (1):
      ASoC: wm0010: fix error return code in wm0010_boot()

 sound/soc/codecs/ab8500-codec.h |   36 ++++++++++++++++++------------------
 sound/soc/codecs/da7213.c       |    8 ++++----
 sound/soc/codecs/wm0010.c       |    1 +
 3 files changed, 23 insertions(+), 22 deletions(-)

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxerAAoJELSic+t+oim95aUQAIIuHtv4fhn8d9SWjKtJjJTx
giPS+IM4IZ8GX2CJE31HG3C3I4yui4p+K6agt9axyrEmVPc1YRZB3qoiUpERWGuy
qRmWiZi13aAZ95lU87dUF++tyDUBTjrPswn394P80HwUiTLCviWAbAq7TyaqO7ob
AP2nnE6e/CP14S/rIjWv+hZ9/2ozCwjB0iELv1KW3sE5GjD7rxXGNCBKwvsoeNpe
HMdG6qMt21Gbc4jK1+XY5kKmhaKURCoK4GCWjtf1rotnjpzDpJFzk2R+zqSmkGSf
oZaNPI6LwESD0gG1Q0EVt3AXXMUSp5Lc9QuL/k+EmeFS912zELAWnFjipet4j3co
ltpYZD6SfAgXumaeLwu277Vgo8lrmvfgEcua4Lf9QkpgSISrcUORW1p8tXikinxD
8cR7CnDJ2i7WHezGRr+RplI/2f0IaTfWc8ZjZVK7TB4PY9hvMWAwIXmidlFCDBOL
LonIvp/hqQJxonuJFkUKCX0LMtt5fybcfxJK6zBJU+xkXl3bpR72RGehyFuwjm1l
BmUHw/rkRHvyj13DWg5qjDdA0EpbWZXi1HRH9YNqGp3fm/unHhFOXV02Xx9bzmx0
RCL9gfOJ5tgKNMK4WH/ID4tiK7+OgCPdlEOjydACbrN6hASqU6TD7hPlcsz5cnHb
/+jtBjhLU4bp4odZUYEA
=0hQw
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--

--===============2900808941210354405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2900808941210354405==--
