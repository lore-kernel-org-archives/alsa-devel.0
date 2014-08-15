From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.17
Date: Fri, 15 Aug 2014 23:36:59 +0100
Message-ID: <20140815223659.GN17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0386019022576690096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80410265182
 for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2014 00:37:06 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girwdood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0386019022576690096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b9rFmGiYZDaoY3wS"
Content-Disposition: inline


--b9rFmGiYZDaoY3wS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ae34a78c430c37c06404f032fb04e51315204281:

  Merge remote-tracking branch 'asoc/topic/wm8985' into asoc-next (2014-08-04 16:32:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-v3.17-rc1

for you to fetch changes up to 7c063edee6855a2489f995578f6c7a4ab0ddfe07:

  Merge remote-tracking branches 'asoc/fix/arizona', 'asoc/fix/fsl', 'asoc/fix/fsl-esai', 'asoc/fix/intel', 'asoc/fix/mcasp' and 'asoc/fix/pxa' into asoc-linus (2014-08-15 12:51:29 +0100)

----------------------------------------------------------------
ASoC: Fixes for v3.17

Nothing too exciting here, a bunch of driver fixes that came along since
the initial pull request but none that really stand our and a warning
fix in the core.

----------------------------------------------------------------
Daniel Mack (1):
      ASoC: pxa-ssp: drop SNDRV_PCM_FMTBIT_S24_LE

Geert Uytterhoeven (1):
      ASoC: dapm: Fix uninitialized variable in snd_soc_dapm_get_enum_double()

Jarkko Nikula (4):
      ASoC: Intel: Update Baytrail ADSP firmware name
      ASoC: Intel: Merge Baytrail ADSP suspend_noirq into suspend_late
      ASoC: Intel: Wait Baytrail ADSP boot at resume_early stage
      ASoC: Intel: Restore Baytrail ADSP streams only when ADSP was in reset

Jyri Sarha (1):
      ASoC: mcasp: Fix implicit BLCK divider setting

Mark Brown (8):
      MAINTAINERS: Add i.MX maintainers and paths to Freescale ASoC entry
      ASoC: pcm512x: Correct Digital Playback control names
      Merge tag 'asoc-v3.16-rc1' into asoc-linus
      Merge tag 'asoc-v3.16-rc5' into asoc-linus
      Merge tag 'asoc-v3.17' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm512x' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/arizona', 'asoc/fix/fsl', 'asoc/fix/fsl-esai', 'asoc/fix/intel', 'asoc/fix/mcasp' and 'asoc/fix/pxa' into asoc-linus

Nikesh Oswal (1):
      ASoC: arizona: Fix TDM slot length handling in arizona_hw_params

Shengjiu Wang (1):
      ASoC: fsl-esai: Revert .xlate_tdm_slot_mask() support

 MAINTAINERS                        |  3 +++
 sound/soc/codecs/arizona.c         |  6 ++++--
 sound/soc/codecs/pcm512x.c         |  4 ++--
 sound/soc/davinci/davinci-mcasp.c  | 14 ++++++++++---
 sound/soc/fsl/Kconfig              |  1 -
 sound/soc/fsl/fsl_esai.c           |  2 --
 sound/soc/intel/sst-acpi.c         |  4 ++--
 sound/soc/intel/sst-baytrail-ipc.c | 10 +--------
 sound/soc/intel/sst-baytrail-ipc.h |  1 -
 sound/soc/intel/sst-baytrail-pcm.c | 43 +++++++++++++-------------------------
 sound/soc/pxa/pxa-ssp.c            |  4 +---
 sound/soc/soc-dapm.c               | 12 ++++++-----
 12 files changed, 46 insertions(+), 58 deletions(-)

--b9rFmGiYZDaoY3wS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7ouIAAoJELSic+t+oim9oYAQAJS36Yach4g+ZG5fMYPCZj0+
9FxXH1Hp0HHTazVyN4I651NgZLY9ZiueRDnX3hvIRhy/azjovZsI/PFkHhsoSjuf
1qcjgzxXMnsKgNVtnZmMvnJrsd4iS/x7JgiJqrhnTRuNnnKdie/qBa+NstevqkgK
5G+fORYoZVM0nHVYBSg2pvOgu7mH91BAFanxdhkR2k6tpKoX1sR1KLYiHyP3huAO
QtvQnmKVJtzD6nQLUQUwoABkl8G2qK7WDLRP0pqMTtgiQr1XI34A1QUUeG2Ga1eV
f5QSQ9W3bV+UjRP2rllRMXxUuHLq+cPaQ4GUM9I2gmN+P72TA51iAb7GzX69UsVs
vxmknEJpp1UrMLXpCXRX+GB0f5+UXFeOR5cXqaQE39MdjS24BZ51+vnxIpwrhCA8
UNzuOvJDuwS4zrzsyzW6VBFfdYSVlhCwvY0J1bAtM1q3U0eixuhe3hQ3Trvs9G6E
vPUtuUVD+xEF16A7X2b/MsedSNorvoECDQx4dalpXUJEfDBlgS/UC+RwDpsQFrET
Ex33aRrLzSu66UugPLhlnFI1qnO5TChUPNmkw0YoJYsDpddQt8Dfg2B2qasu5bIY
usgPXmMXOOLihMSeZbNpWr9ia1YSN9vEy26ZFTM4Ooktn0d0mROUeyoA35LeAzVE
jpY/Y3x4uMFHZxn+uVo6
=p0uv
-----END PGP SIGNATURE-----

--b9rFmGiYZDaoY3wS--

--===============0386019022576690096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0386019022576690096==--
