From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] Last minute ASoC fix for v4.0
Date: Sat, 11 Apr 2015 23:04:44 +0100
Message-ID: <20150411220444.GV6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8107322389668379154=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47FB2260434
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 00:04:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Howard Mitchell <hm@hmbedded.co.uk>, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org


--===============8107322389668379154==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UOD621YUYloUEn6d"
Content-Disposition: inline


--UOD621YUYloUEn6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.0-rc7

for you to fetch changes up to 14f0413ce3c400a74213a861bc8f47dca5e4d231:

  ASoC: pcm512x: Remove hardcoding of pll-lock to GPIO4 (2015-04-11 22:09:14 +0100)

----------------------------------------------------------------
ASoC: Last minute fix for v4.0

This patch backs out a change that came in during the merge window which
selects a configuration for GPIO4 on pcm512x CODECs that may not be
suitable for all systems using the device.  Changes for v4.1 will make
this properly configurable but for now it's safest to revert to the
v3.19 behaviour and leave the pin configuration alone.

Sorry for sending this direct at the last minute but due to the GPIO
misuse it'd be really good to get it in the release and I'd not realised
it hadn't been sent yet - between some travel, a job change and other
non-urgent fixes coming in I'd lost track of the urgency.  It's been in
-next for several weeks now, is isolated to the driver and fairly clear
to inspection.

----------------------------------------------------------------
Howard Mitchell (1):
      ASoC: pcm512x: Remove hardcoding of pll-lock to GPIO4

 sound/soc/codecs/pcm512x.c | 19 -------------------
 1 file changed, 19 deletions(-)

--UOD621YUYloUEn6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKZp7AAoJECTWi3JdVIfQWtMH/jNcL2Pdm5fkpTEOQWXiB2Jd
sNjN/Hq59uM1GqF1fK4N/4vcHAtISmcEKTgyKN2sQ9spFpHCtuM1OdoyRQgz1MjZ
S4y87ukiBpFWh1y+onIwXMbSWZXB3P5Cla+2/P37LcLT4LxbeBuOYWUeOSWKHyvy
lX1Z4xFHoy9QL+xXjFGKp4fBNMSKhZ21u5dZxl+5Li2hOSPfpn8qziAjpm/WFY5N
G6HxZL/Bot5gYDngMjImXrcWeQNwgxlKB3+teZtz6tR8OHoH6YK8I8psgzRki5Zo
hcTfTCD1xdG8ba7anFk4LFiWaknGS5bJ+lVIemjuDieLtlFyYtsbLZxIwiU/zvE=
=KdkQ
-----END PGP SIGNATURE-----

--UOD621YUYloUEn6d--

--===============8107322389668379154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8107322389668379154==--
