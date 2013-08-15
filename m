From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.11
Date: Thu, 15 Aug 2013 18:28:32 +0100
Message-ID: <20130815172832.GD30073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3439306091453295508=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DE8182655D0
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 19:28:37 +0200 (CEST)
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


--===============3439306091453295508==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.11-rc5

for you to fetch changes up to 44ffb69ec617f64cd83182e8b64d93b84758d636:

  Merge remote-tracking branch 'asoc/fix/tegra' into asoc-linus (2013-08-15=
 11:37:54 +0100)

----------------------------------------------------------------

ASoC: Fixes for v3.11

A few driver specific fixes here plus one core fix for a memory
corruption issue in DAPM initialisation which could lead to crashes.

----------------------------------------------------------------
Brian Austin (2):
      ASoC: cs42l52: Reorder Min/Max and update to SX_TLV for Beep Volume
      ASoC: cs42l52: Add new TLV for Beep Volume

Lars-Peter Clausen (1):
      ASoC: dapm: Fix empty list check in dapm_new_mux()

Lothar Wa=DFmann (2):
      ASoC: sgtl5000: prevent playback to be muted when terminating concurr=
ent capture
      ASoC: sgtl5000: fix buggy 'Capture Attenuate Switch' control

Mark Brown (4):
      Merge remote-tracking branch 'asoc/fix/cs42l52' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/sgtl5000' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/tegra' into asoc-linus

Stephen Warren (1):
      ASoC: tegra: fix Tegra30 I2S capture parameter setup

 sound/soc/codecs/cs42l52.c    |  5 ++++-
 sound/soc/codecs/sgtl5000.c   | 18 ++++++++++++++----
 sound/soc/soc-dapm.c          |  7 ++++---
 sound/soc/tegra/tegra30_i2s.c |  2 +-
 4 files changed, 23 insertions(+), 9 deletions(-)

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSDQ+9AAoJELSic+t+oim9QkYP/3I4hWGOLuZJVPujDroscF9j
sFyQiPVIRZGCKdOyWeEZoQKzyPHXORoOdFi5yE4EvaW/6ocy6UcX1wgts2W8TEeP
uF54m4U0KnymxYoPJTbzecuWvqSC9qRy+pomsZQRvvioRF4PGjQbB3eUPS2t7BYn
0i1XREZ+RCex3+io4myatsWDzTReO0fTrSDkm8njMpB/sLO1B27f6b0rj1cS54Di
S/L7v9o1AaITWnJnbO/BUCSftt8vc58zzuuKwhDFphAf0ZYH8JS6YJ7suYDT0aX9
968xh3LQFul2S3qssJPf1Rq7aOJxsRaQNMwoU76s5CNi9CSXfM+91u1FVz6gmiVf
aVEifUR6FhEoBWn8JHpYeM6mzwVkibQsyirE2bFl8dNNuCP9EgFEalk2OZKQwRD9
Wvndrj5VG6FJu9W3JdfW1+0G37WEFrOK1hgXLseUjlZDDOlHS8P6EgOv8ycV8x5p
nm0RzIPuuTXi5YlSJASvu/ovF2VxKL6EPG26TiM9/fuaomwFXEWy+Rd0GL0kjQbI
fMFE7LeLQ2RCw1B6S7MA9MliY+JmrD449fHtr8aYogVK4xn4egh0N+yP+CbSbVws
bu/rYMq2INeFtPBIy/VUByvxaP85EyQwr5Yb5ACPJhwQ4ND1Hk7P78zHmZx3cikL
DEdlYwOg0C/BICwLCxz/
=S93V
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

--===============3439306091453295508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3439306091453295508==--
