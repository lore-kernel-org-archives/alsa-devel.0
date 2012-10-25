From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.7
Date: Thu, 25 Oct 2012 19:19:58 +0100
Message-ID: <20121025181958.GU18814@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7710964419330750408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B2AD26501A
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2012 20:27:03 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7710964419330750408==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vKcNkqnJHUUp475E"
Content-Disposition: inline


--vKcNkqnJHUUp475E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

for you to fetch changes up to 456ba5a7802e58eccb5aa9751b3ab515ef99b9ca:

  Merge remote-tracking branches 'asoc/fix/ux500' and 'asoc/fix/wm8994' into for-3.7 (2012-10-25 17:36:02 +0100)

----------------------------------------------------------------

ASoC: Fixes for v3.7

A couple of driver fixes, one that improves the interoperability of
WM8994 with controllers that are sensitive to extra BCLK cycles and some
build break fixes for ux500.

----------------------------------------------------------------
Lee Jones (2):
      ASoC: Ux500: Dispose of device nodes correctly
      ASoC: ux500_msp_i2s: Fix devm_* and return code merge error

Mark Brown (2):
      ASoC: wm8994: Only enable extra BCLK cycles when required
      Merge remote-tracking branches 'asoc/fix/ux500' and 'asoc/fix/wm8994' into for-3.7

 sound/soc/codecs/wm8994.c       |   18 +++++++++++++++++-
 sound/soc/codecs/wm8994.h       |    1 +
 sound/soc/ux500/mop500.c        |   17 +++++++++++++++++
 sound/soc/ux500/ux500_msp_i2s.c |    8 +++-----
 4 files changed, 38 insertions(+), 6 deletions(-)

--vKcNkqnJHUUp475E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiYJ3AAoJELSic+t+oim9sRoQAIwEfAT3ERpLiOnxnpX07tml
mj3m63gyVXP2z3auwLtnk/v27HjTga+wUcS6B7tvrVa9ElGwMW34MoaAnuAhVWOY
a3+N3hzO28dQcCaIHYV9xo+4TKJQ93yts2SC5KhOIO6txkagBQ0YZWCNFlUM48sq
q/EponJTKbtYET8yNAwroIJPP01xa9UpJH8i737KPkkPoqUPB5IU6qPMnXhH4RN5
NYGWvMlo/5hbQdLi7TXtrlE6S/vq6rmGybYiLcPawGj2WWpAvVC4wXxmuBQyO59X
2yOvM9BuYAz1yBebJWnQn1QpwnWfZb32BbR9V7HuJIp4lsGd/foYOVRbaBU46VzR
llKWhiOA8LmWCkUXBXxCdtxTw3mbG0ojalXgYLCRsBItd2vp/SpXoc0v37dThJFF
VcIIz69fQA3uFson4zvslFVcxO2NvNe+HgqU3Xhq49GRjvs0QH3+EgratUl5wMJk
vAGO8zK8GntNyUjLhC1vp/Nh/H3Frbr8TM5bv+XKOoyyULPd3yzgF3PbB5cwT2GQ
kOzu7pgjeT5SAgWkLqBlIm6PT/MKPiuZsHZcEl0PiEO4jZdw2bH+7kOgx6DjxV05
I/s4tVrC9nRFpRm8pEdXFCX0kqsqYn6HY31HT+wUgO0gPnVv2oZU4aXiow/Ay0SZ
ooPkH3z2+M6AoNxXDit6
=vxpl
-----END PGP SIGNATURE-----

--vKcNkqnJHUUp475E--

--===============7710964419330750408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7710964419330750408==--
