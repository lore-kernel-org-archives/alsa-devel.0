From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Wed, 8 Feb 2012 20:15:08 +0000
Message-ID: <20120208201508.GA13783@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7838273764946360857=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01508103F96
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 21:15:10 +0100 (CET)
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


--===============7838273764946360857==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 43b6cec27e1e50a1de3eff47e66e502f3fe7e66e:

  ASoC: wm_hubs: Correct line input to line output 2 paths (2012-02-01 23:55:56 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-3.3

for you to fetch changes up to a7c4183be2d6a7da8c97a9b671b5f3aed321127e:

  ASoC: wm8994: Disable line output discharge prior to ramping VMID (2012-02-08 19:52:00 +0000)

----------------------------------------------------------------
A few small WM8994 updates to go on top of the previous lot of things
that were sent.  They collide with some -next work so I'd really like to
get them into 3.3-rc3 if possible to merge back up into the -next code.
All driver specific and unexciting in the grand scheme of things.
----------------------------------------------------------------

Mark Brown (3):
      ASoC: wm8994: Enabling VMID should take a runtime PM reference
      ASoC: wm8994: Fix typo in VMID ramp setting
      ASoC: wm8994: Disable line output discharge prior to ramping VMID

 sound/soc/codecs/wm8994.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMtfFAAoJEBus8iNuMP3dMewP/0xq7f5/bq1RdLb1Omi0ol+F
awq8hiCj9FIzDla28mKyjanevAkYb4uJ0ImU4gCGVhV+s4H5N3hgPHVkLTeJj0ne
pcHuhPIJY3idKdeE9H2CPAZaEWpa4uODlq8NxrCboabDoXWNowd269XlXruX/n0m
4Of4x2TwSha2WAL/xCePC61O4q6+4nAqcEDkdKlD8b4zYac0mkbnXVFyhelZ/GTP
Asew301QPvDjE9HdRrzujQ9b+X+Flv4Fe4tc3IzbEiw1j+FLj5WNK7UuOgxhoHDZ
d2NZPPcV4xifonY38mPihqcRNjvLt8nW5BjQsPZqqOd0fppq+yBHjjcpaN6BSnm+
rW6PsNfPS3S2d9cxO/X+A/JFLs5Dd/X1OsQPNJoTvR0tQgUVaEGG5LeMF01T5jpV
D1Hk35MX0u/ebcHcIEJDsDCjIea9fjziADlk/o0p3++roeT7NUD/+w71VlwPofdQ
eipC2nklERde+mWdSN9BqwOUOdux9tawA7nB+HztiBiWKUXrudL0uYAHhJG5X46e
wPgqNLIvhVaSjAiTrzAmWKsbodYsy+UV/+JgV7T5t97GjKXAeVwPg8uMjfK93/qh
Ek0taX7epkx032sDLBUp/4hAWyx/htUaSFV3b+yzNe9+IjE6Mms4N0qjppZG44kb
6NLSOPEl10M5titGxBDZ
=cnf9
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--===============7838273764946360857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7838273764946360857==--
