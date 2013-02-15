From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.9
Date: Fri, 15 Feb 2013 17:15:05 +0000
Message-ID: <20130215171505.GE22283@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9035134242726947923=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBC9D261704
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 18:15:07 +0100 (CET)
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


--===============9035134242726947923==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 699ba4546cfe3f4eee73aff4f307bf16362f9232:

  Merge remote-tracking branch 'asoc/topic/wm8993' into asoc-next (2013-02-11 11:06:55 +0000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.9-updates

for you to fetch changes up to 54759313ececcbd07e43fad75e0683e39a1f2a25:

  Merge remote-tracking branch 'asoc/topic/da7213' into asoc-next (2013-02-14 17:28:00 +0000)

----------------------------------------------------------------

ASoC: Final updates for v3.9

A few more updates from the past week - a new driver from Dialog and
some small fixes and tweaks.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: codecs: Add da7213 codec

Fabio Estevam (1):
      ASoC: fsl: imx-audmux: Fix sparse warning

Mark Brown (6):
      ASoC: wm8994: Fix variable double use
      ASoC: arizona: Automatically manage input mutes
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/omap' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8994' into asoc-next
      Merge remote-tracking branch 'asoc/topic/da7213' into asoc-next

Sebastien Guiriec (1):
      ASoC: omap-mcpdm: Remove useless ressource get.

 include/sound/da7213.h      |   52 ++
 sound/soc/codecs/Kconfig    |    4 +
 sound/soc/codecs/Makefile   |    2 +
 sound/soc/codecs/arizona.c  |   17 +
 sound/soc/codecs/da7213.c   | 1599 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/da7213.h   |  523 ++++++++++++++
 sound/soc/codecs/wm5102.c   |   13 -
 sound/soc/codecs/wm5110.c   |   17 -
 sound/soc/codecs/wm8994.c   |   10 +-
 sound/soc/fsl/imx-audmux.c  |    2 +-
 sound/soc/omap/omap-mcpdm.c |    4 -
 11 files changed, 2203 insertions(+), 40 deletions(-)
 create mode 100644 include/sound/da7213.h
 create mode 100644 sound/soc/codecs/da7213.c
 create mode 100644 sound/soc/codecs/da7213.h

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHmz0AAoJELSic+t+oim9nSYP/jPflSXUyYhEd03U3k7WEmRR
gcbptxlcNo0Or/C5XoA08KsdlXUyUS3XzZG5w+u4XuqZcj4ZcqkpXazLwLEIO23l
WaJiGUxwK0cy8jEjgbdOERBuo6sAsUZ8f5d3BCt/k2aL/ukRbTbFxPh9EgM8Xfua
/lhD+nfYe/Qb2w7gjAI0E0yP1qV9f4jI5rXvg3mPGGsKbhceh6CdJqzdsdEEaOpz
UpyfrqSsU1WW3LT8/2RrvcChl9QQPGHeGEXr9EEi1tdG6ECEtsy8ZcXPuupHYnfF
NX90OdkkogpQuLP9XfvAgpMXQ4dmAxr+QbbJjKynJUXjEDqYpNCC3inVWl9Xetrq
QUIPfnoahu+/GF+U0GMoD/kFEBeK07GRwwlzQv54EREHf1B/SPX1hDIJgA1tqd7B
tU05bcl3LF3ZF4/B38wfe4qtGrbBkUNmPM3lrWuuqv4Hycmu/5/n19HlYaiRVDSW
kmu77qLHXhXa8gpHA4lgfDqNQBXV7miUfWvh9qx/NV651q+V0G7NgIR9exCxO72y
Ns2rOJ9Rz8i9OPl0onNmQ5PTV1zh90u8yWnR8frdpITTYiFBn8LFXsv861LqhmOz
b7xxFLMKcwxZYSXtdw6MV4tZCoug1ioom6Tc/xTJZzo0tyLLx1qXI6j6loojQQVX
NzWmjF8eqyX8Y7equIum
=0mW4
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--

--===============9035134242726947923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9035134242726947923==--
