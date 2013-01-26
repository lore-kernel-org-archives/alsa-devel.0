From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.8
Date: Sat, 26 Jan 2013 15:40:19 +0800
Message-ID: <20130126074018.GR10580@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8079472390156936779=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE8DB265173
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 09:20:02 +0100 (CET)
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


--===============8079472390156936779==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JaBjgNvtdKe5H086"
Content-Disposition: inline


--JaBjgNvtdKe5H086
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.8-rc4

for you to fetch changes up to a8c136d2eba7b0b0c872e59eb404b1fe36504112:

  Merge remote-tracking branch 'asoc/fix/wm2200' into tmp (2013-01-22 16:26:33 +0800)

----------------------------------------------------------------

ASoC: Updates for v3.8-rc4

The usual set of driver updates, nothing too thrilling in here - one
core change for the regulator bypass mode which was just not doing the
right thing at all and a bunch of driver specifics.

----------------------------------------------------------------
Charles Keepax (2):
      ASoC: arizona: Disable free-running mode on FLL1
      ASoC: wm_adsp: Release firmware on error

Chris Rattray (1):
      ASoC: wm2200: correct mixer values and text

Liam Girdwood (1):
      ASoC: MAINTAINERS: Update email address.

Mark Brown (10):
      ASoC: dapm: Fix sense of regulator bypass mode
      ASoC: wm5102: Correct AEC loopback mask
      ASoC: wm5110: Correct AEC loopback mask
      ASoC: arizona: Use actual rather than desired BCLK when calculating LRCLK
      ASoC: wm_adsp: Use GFP_DMA for things that may be DMAed
      Merge remote-tracking branch 'asoc/fix/arizona' into tmp
      Merge remote-tracking branch 'asoc/fix/core' into tmp
      Merge remote-tracking branch 'asoc/fix/fsl' into tmp
      Merge remote-tracking branch 'asoc/fix/lrg' into tmp
      Merge remote-tracking branch 'asoc/fix/wm2200' into tmp

Shawn Guo (1):
      ASoC: fsl: fix multiple definition of init_module

 MAINTAINERS                |    2 +-
 sound/soc/codecs/arizona.c |    5 ++++-
 sound/soc/codecs/wm2200.c  |    3 ---
 sound/soc/codecs/wm5102.c  |    3 +--
 sound/soc/codecs/wm5110.c  |    3 +--
 sound/soc/codecs/wm_adsp.c |    6 +++---
 sound/soc/fsl/Kconfig      |    9 ++-------
 sound/soc/fsl/Makefile     |    5 ++++-
 sound/soc/fsl/imx-pcm.c    |    3 ---
 sound/soc/soc-dapm.c       |   12 ++++++++++--
 10 files changed, 26 insertions(+), 25 deletions(-)

--JaBjgNvtdKe5H086
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA4hZAAoJELSic+t+oim9BSwP/3uoKjI66n2bj1pvYz4t1Tsw
yHWMnVRzR2Ry6RTxSYBOQWK2cIL4pioNHuaAgGx6zlUtW5Sr2VGFG4MLp0PdfaQ4
iRMYyQ9vu5K8KJfynqLYzDsitXFjhOLeeFFihCli6aF9gewJxmYGfu4aaW91kQj9
zBDKWeULA9PoAYCxn48jIEHUhM+2f5sLsU6E8TGSYnQtNACek6BCNn4EJQH/Oslt
19xRlPmK6BveDRhImYyHTwe8ccutq7iyl4aEBe8PaI3700VCzTmRMCpVnQtLPvqU
Vlx1Rvb+USZThpezWoMYFh89T7L86f8IFXTGMgWwkXI/W3t4YRj8Z2QQpFfYAyzH
DXwQrbbo2Brm3tVXLaR+NITiaAZ+wlfRQwRl8RcheaZ/ZmNkW8UJSezeDTnZLAx7
LgdmGlNwDZ40xOxb5j81d5LTPIMxL3wt64Zt/l7m6rbtFWvBMvtH+cA6cokl5ATK
Fs81OBY/Kahu0+Jt5hS0OTR0euKFyqQmWKqb+zst6b4IoKYe/cysnSk2brte/nhm
hAdFPtn2EF8gDHVPWSfLCu8GxodloXHiC3vLNhTEXF5ZNMykYB4S1fGOuM0yHhB5
/NBNB7hzCZnxW5UfuPDuLtBpqwuzhj57syPdqH/ubJdl0KVFvuhIhjwNNORcp3Ad
AW8J+4yjNdLIFmYSjYKg
=4+40
-----END PGP SIGNATURE-----

--JaBjgNvtdKe5H086--

--===============8079472390156936779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8079472390156936779==--
