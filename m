From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.7
Date: Sat, 2 Jul 2016 10:48:46 +0200
Message-ID: <20160702084846.GG6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5531249696890606925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7244261B01
 for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2016 10:48:59 +0200 (CEST)
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


--===============5531249696890606925==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DnQ8R2kNBE8VLNdv"
Content-Disposition: inline


--DnQ8R2kNBE8VLNdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4c2e07c6a29e0129e975727b9f57eede813eea85:

  Linux 4.7-rc5 (2016-06-26 17:52:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.7-rc5

for you to fetch changes up to 7c5eec4edf4693aa61f3ee78bf28621dfe33d9f0:

  Merge remote-tracking branches 'asoc/fix/rcar', 'asoc/fix/rt5670' and 'asoc/fix/wm8940' into asoc-linus (2016-07-01 18:05:34 +0200)

----------------------------------------------------------------
ASoC: Fixes for v4.7

A small clutch of hardware specific fixes for various ASoC devices, all
small individually and important if you have that device but not
otherwise.

----------------------------------------------------------------
Ajit Pandey (1):
      ASoC: wm5110: Add missing route from OUT3R to SYSCLK

Alan Cox (1):
      ASoC: Intel: atom: fix missing breaks that would cause the wrong operation to execute

Alexander Shiyan (1):
      ASoC: fsl_ssi: Fix number of words per frame for I2S-slave mode

Arnd Bergmann (1):
      ASoC: hdmi-codec: select CONFIG_HDMI

Bard Liao (2):
      ASoC: rt5670: fix HP Playback Volume control
      ASoC: rt5645: fix reg-2f default value.

Charles Keepax (1):
      ASoC: wm5102: Correct supported channels on trace compressed DAI

Fabio Estevam (1):
      ASoC: ak4613: Remove owner assignment from platform_driver

Geert Uytterhoeven (2):
      ASoC: wm8940: Enable cache usage to fix crashes on resume
      ASoC: ak4613: Enable cache usage to fix crashes on resume

Janusz Krzysztofik (1):
      ASoC: cx20442: set tty->receiver_room in v253_open

Kuninori Morimoto (1):
      ASoC: rsnd: open 31bit of SSICKR mask

Mark Brown (4):
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ak4613', 'asoc/fix/arizona', 'asoc/fix/cx20442', 'asoc/fix/davinci', 'asoc/fix/fsl-ssi' and 'asoc/fix/hdmi' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rcar', 'asoc/fix/rt5670' and 'asoc/fix/wm8940' into asoc-linus

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Fix dra7 DMA offset when using CFG port

Vinod Koul (2):
      ASoC: hdac_hdmi: Fix potential NULL dereference
      ASoC: Intel: Skylake: Initialize module list for Broxton

 sound/soc/codecs/Kconfig                          |  7 +--
 sound/soc/codecs/ak4613.c                         |  2 +-
 sound/soc/codecs/cx20442.c                        |  1 +
 sound/soc/codecs/hdac_hdmi.c                      | 20 ++++++++
 sound/soc/codecs/rt5645.c                         |  2 +-
 sound/soc/codecs/rt5670.c                         |  2 +-
 sound/soc/codecs/wm5102.c                         |  2 +-
 sound/soc/codecs/wm5110.c                         |  1 +
 sound/soc/codecs/wm8940.c                         |  1 +
 sound/soc/davinci/davinci-mcasp.c                 | 56 +++++++++++++++++++++--
 sound/soc/davinci/davinci-mcasp.h                 |  4 +-
 sound/soc/fsl/fsl_ssi.c                           | 12 ++---
 sound/soc/intel/atom/sst-mfld-platform-compress.c |  9 +++-
 sound/soc/intel/skylake/bxt-sst.c                 |  1 +
 sound/soc/sh/rcar/adg.c                           |  2 +-
 15 files changed, 100 insertions(+), 22 deletions(-)

--DnQ8R2kNBE8VLNdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXd3/tAAoJECTWi3JdVIfQcVoH/1Fu6J9XOPDBa1ZToZJGQyAU
pS93R7SQjUxnBieLJbw0SsmW2gHllr6yI59bvrlRZW9UD63iuduSDCVbAx3n4Oxc
qAy6u8Xj+7ZwEB3bEoeNf/2AmRoeA9gsc114azvh8ZoGTucgxLrHrbJCMd8he2gE
tvASrtqp913slTh/pzF7Vur+rxAs+Kb0ee5AvWE83iGLXlgOFMHCnrwDzwbquMdz
ZnuSqZ5I5gR8GR+q9g21ZDTXPD10FFU2cuP+bqTTZNMI6D0kMWaDXvSj5lJ2CIcr
+E0TmFnL7EypJ1+IumV3ta9FpXbB+Co3ZC+Uiq6V48X7Xxdq2O0qmp2A8HdDMp0=
=bwZH
-----END PGP SIGNATURE-----

--DnQ8R2kNBE8VLNdv--

--===============5531249696890606925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5531249696890606925==--
