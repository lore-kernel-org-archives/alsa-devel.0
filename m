From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.14
Date: Thu, 26 Oct 2017 16:13:14 +0200
Message-ID: <20171026141314.f7bckpfhy5p2ipmw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5643379160437662428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B7922266E15
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 16:13:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5643379160437662428==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="65dyrvrc4whjafsf"
Content-Disposition: inline


--65dyrvrc4whjafsf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:

  Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-fix-v4.14-rc6

for you to fetch changes up to 0bebd2f1bfcbf954a93b65d4b2848488fd049c78:

  Merge remote-tracking branches 'asoc/fix/topology' and 'asoc/fix/wm8998' =
into asoc-linus (2017-10-26 09:45:52 +0200)

----------------------------------------------------------------
ASoC: Fixes for v4.14

I've been quite lax in sending these due to conference season but here's
a fairly large collection of ASoC updates.  The one thing that's not
device specific is Takashi's fix for races between delayed work and PCM
destruction, otherwise everything is specific to an individual device.

----------------------------------------------------------------
Bard Liao (3):
      ASoC: rt5659: register power bit of LOUT Amp
      ASoC: rt5659: connect LOUT Amp with Charge Pump
      ASoC: rt5616: fix 0x91 default value

Charles Keepax (1):
      ASoC: wm8998: Correct handling of input muxes

Chintan Patel (1):
      ASoC: Intel: Skylake: Fix jack name format substitution

Christophe JAILLET (2):
      ASoC: topology: Fix a potential NULL pointer dereference in 'soc_tplg=
_dapm_widget_denum_create()'
      ASoC: topology: Fix a potential memory leak in 'soc_tplg_dapm_widget_=
denum_create()'

Christophe Jaillet (2):
      ASoC: samsung: i2s: Fix error handling path in i2s_set_sysclk()
      ASoC: davinci-mcasp: Fix an error handling path in 'davinci_mcasp_pro=
be()'

Colin Ian King (1):
      ASoC: Intel: Skylake: fix swapped order of function arguments dir and=
 pin_index

Hsin-Yu Chao (2):
      ASoC: rt5514-spi: check irq status to schedule data copy
      ASoC: rt5514: Revert Hotword Model control

Jean-Fran=E7ois T=EAtu (2):
      ASoC: msm8916-wcd-digital: fix RX2 MIX1 and RX3 MIX1
      ASoC: codecs: msm8916-wcd-analog: fix micbias level

John Keeping (1):
      ASoC: rockchip: i2s: fix unbalanced clk_disable

Kuninori Morimoto (2):
      ASoC: rsnd: fix ADG flags
      ASoC: rcar: skip disabled-SSI nodes

Marek Szyprowski (1):
      ASoC: samsung: i2s: disable secondary DAI until it gets fixed

Mark Brown (8):
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/msm8916' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rockchip' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adau17x1', 'asoc/fix/davinci=
' and 'asoc/fix/max98090' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5514', 'asoc/fix/rt5616', =
'asoc/fix/rt5659', 'asoc/fix/rt5663', 'asoc/fix/samsung' and 'asoc/fix/stm3=
2' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/topology' and 'asoc/fix/wm89=
98' into asoc-linus

Olivier Moysan (3):
      ASoC: stm32: sai: fix stop management in isr
      ASoC: stm32: sai: Fix DMA burst size
      ASoC: stm32: sai: Fix get reset controller

Pierre-Louis Bossart (2):
      ASoC: max98090: reduce verbosity on PLL unlock
      ASoC: Intel: cht_bsw_max98090: Fix I2S config + unused code

Ricard Wanderlof (1):
      ASoC: adau17x1: Workaround for noise bug in ADC

Takashi Iwai (1):
      ASoC: pcm: Sync delayed work before releasing resources

oder_chiou@realtek.com (1):
      ASoC: rt5663: Change the dev getting function in rt5663_irq

 sound/soc/codecs/adau17x1.c                        | 24 ++++++-
 sound/soc/codecs/adau17x1.h                        |  2 +
 sound/soc/codecs/max98090.c                        |  2 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |  7 +-
 sound/soc/codecs/msm8916-wcd-digital.c             |  4 +-
 sound/soc/codecs/rt5514-spi.c                      | 17 ++++-
 sound/soc/codecs/rt5514-spi.h                      |  3 +
 sound/soc/codecs/rt5514.c                          | 63 ----------------
 sound/soc/codecs/rt5514.h                          |  3 -
 sound/soc/codecs/rt5616.c                          |  2 +-
 sound/soc/codecs/rt5659.c                          |  4 +-
 sound/soc/codecs/rt5663.c                          |  3 +-
 sound/soc/codecs/wm8998.c                          | 84 +++++-------------=
----
 sound/soc/davinci/davinci-mcasp.c                  |  6 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |  6 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |  2 +
 sound/soc/intel/skylake/skl-topology.c             |  2 +-
 sound/soc/rockchip/rockchip_i2s.c                  |  1 -
 sound/soc/samsung/i2s.c                            |  6 +-
 sound/soc/sh/rcar/adg.c                            |  4 +-
 sound/soc/sh/rcar/ssi.c                            |  5 +-
 sound/soc/soc-pcm.c                                | 13 +++-
 sound/soc/soc-topology.c                           |  5 +-
 sound/soc/stm/stm32_sai.c                          |  2 +-
 sound/soc/stm/stm32_sai_sub.c                      | 33 +++++----
 25 files changed, 134 insertions(+), 169 deletions(-)

--65dyrvrc4whjafsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnx7XkACgkQJNaLcl1U
h9Cs3QgAgBniHh9M66V21669v5rdQcfOSv1WYmcrkU9H6fJDNh6rbg1jI3PjNWYU
gQr2yV8FMjA2FY1GMbWjOZHjsaIuMBo/D+g9qGPPPFxxI7xxwLGhgzvc7zRdl0of
Bsa4mdCxE5uojQrlwreUdBwSv8cxwlqv3/ICzw/QTfUEdxX/FskrywbvVb5wZ6eA
N+lHue9NElIrMSbmcfHJncAuwZykmQK+OylvD9bPLAh3Gpy5x4YOIhV/q7OF7xmE
cZRQSw71NZ5RNGa4lGBlfYAg+UDTHKNs4C3mYMoiuVfwlZ00eAIghr+6oGXuJzS/
wbwYsCWTZV0apBmlPncLrjbOFCUwaA==
=HwIw
-----END PGP SIGNATURE-----

--65dyrvrc4whjafsf--

--===============5643379160437662428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5643379160437662428==--
