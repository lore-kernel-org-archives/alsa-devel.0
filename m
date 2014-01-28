From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.14
Date: Tue, 28 Jan 2014 17:35:47 +0000
Message-ID: <20140128173547.GS11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6774813801596825097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5044526521D
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 18:35:56 +0100 (CET)
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


--===============6774813801596825097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="moLig8uJibGkz5Yz"
Content-Disposition: inline


--moLig8uJibGkz5Yz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7552f34a790069a008bd3e2ab4c0954b30c2f63b:

  Merge tag 'asoc-v3.14-3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus (2014-01-20 15:48:55 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.14-rc1

for you to fetch changes up to e65523ca79fd087d9888598eadeb9554e2bd2102:

  Merge remote-tracking branches 'asoc/fix/arizona', 'asoc/fix/fsl', 'asoc/fix/omap', 'asoc/fix/samsung', 'asoc/fix/simple', 'asoc/fix/tlv320aic32x4' and 'asoc/fix/wm5100' into asoc-linus (2014-01-27 18:18:36 +0000)

----------------------------------------------------------------

ASoC: Fixes for v3.14

A few fixes, all in drivers.  Nothing stands out particularly, the
biggest set of fixes is some build coverage issues from Sachin.

----------------------------------------------------------------
Charles Keepax (1):
      ASoC: wm5110: Extend SYSCLK patch file for rev D

Fabio Estevam (2):
      ASoC: fsl_ssi: We do support master mode now
      ASoC: fsl_ssi: Do not print 'baud clock' error message all the time

Mark Brown (2):
      ASoC: omap: Make RX51 depend on GPIOLIB due to jack usage
      Merge remote-tracking branches 'asoc/fix/arizona', 'asoc/fix/fsl', 'asoc/fix/omap', 'asoc/fix/samsung', 'asoc/fix/simple', 'asoc/fix/tlv320aic32x4' and 'asoc/fix/wm5100' into asoc-linus

Markus Pargmann (2):
      ASoC: tlv320aic32x4: Fix mono playback
      ASoC: tlv320aic32x4: Fix MICPGA input configuration

Sachin Kamat (8):
      ASoC: samsung: Fix build regressions due to gpio re-org
      ASoC: Samsung: s3c-i2s-v2: Fix build error
      ASoC: samsung: smdk_wm8994: Fix build error
      ASoC: wm5100: Export wm5100_detect
      ASoC: samsung: Fix Kconfig dependency
      ASoC: Samsung: Fix build error due to missing dependency
      ASoC: samsung: Add NULL check in i2s.c
      ASoC: samsung: Remove dma.h inclusion

Xiubo Li (1):
      ASoC: simple-card: fix simple card widgets routing property name usage

 .../devicetree/bindings/sound/simple-card.txt      |  2 +-
 MAINTAINERS                                        |  3 ++
 Makefile                                           |  2 +-
 arch/arm/kernel/devtree.c                          |  2 +-
 arch/arm/kernel/perf_event_cpu.c                   |  2 +-
 arch/arm/kernel/traps.c                            |  5 +-
 arch/arm/mach-highbank/highbank.c                  |  1 +
 arch/arm/mach-omap2/omap4-common.c                 |  1 +
 arch/arm/mm/init.c                                 |  2 +-
 arch/arm/net/bpf_jit_32.c                          |  6 +--
 arch/arm64/include/asm/io.h                        |  2 +-
 arch/mips/include/asm/cacheops.h                   |  2 +-
 arch/mips/include/asm/r4kcache.h                   | 51 +++++++++++----------
 arch/mips/mm/c-r4k.c                               | 11 ++++-
 arch/parisc/include/uapi/asm/socket.h              |  2 +-
 arch/powerpc/kernel/prom_init.c                    | 22 +++++----
 arch/powerpc/net/bpf_jit_comp.c                    |  7 +--
 arch/s390/net/bpf_jit_comp.c                       | 29 +++++++-----
 arch/sparc/net/bpf_jit_comp.c                      | 17 +++++--
 arch/x86/include/asm/fpu-internal.h                | 13 +++---
 arch/x86/kernel/cpu/perf_event_amd_ibs.c           | 53 ++++++++++++++++++----
 arch/x86/kernel/entry_32.S                         |  4 +-
 arch/x86/kernel/entry_64.S                         |  2 +-
 arch/x86/kvm/lapic.c                               |  2 +-
 arch/x86/mm/fault.c                                | 18 ++++++++
 arch/x86/net/bpf_jit_comp.c                        | 14 ++++--
 arch/x86/vdso/vclock_gettime.c                     |  8 ++--
 drivers/acpi/acpi_lpss.c                           |  1 -
 drivers/clocksource/cadence_ttc_timer.c            | 21 +++++----
 drivers/gpu/drm/drm_modes.c                        |  2 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  2 +
 drivers/gpu/drm/i915/intel_ddi.c                   |  8 +++-
 drivers/gpu/drm/i915/intel_display.c               |  4 +-
 drivers/gpu/drm/nouveau/core/include/subdev/i2c.h  |  2 +-
 .../gpu/drm/nouveau/core/include/subdev/instmem.h  |  7 +++
 drivers/gpu/drm/nouveau/core/subdev/i2c/base.c     |  4 +-
 drivers/gpu/drm/nouveau/core/subdev/mxm/nv50.c     |  4 +-
 drivers/gpu/drm/nouveau/core/subdev/therm/ic.c     | 10 ++--
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  2 +-
 drivers/hwmon/coretemp.c                           |  2 +-
 drivers/md/md.c                                    | 18 ++++++--
 drivers/md/md.h                                    |  3 ++
 drivers/md/raid1.c                                 |  3 +-
 drivers/md/raid10.c                                | 12 ++---
 drivers/md/raid5.c                                 |  7 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 29 ++++++------
 drivers/net/ethernet/chelsio/cxgb4/l2t.c           |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c        | 11 ++++-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  8 +---
 drivers/net/ethernet/qlogic/qlge/qlge_main.c       |  2 +
 drivers/net/ethernet/via/via-rhine.c               |  1 +
 drivers/net/usb/dm9601.c                           | 12 +++++
 drivers/net/usb/usbnet.c                           |  2 +-
 drivers/pinctrl/pinctrl-baytrail.c                 |  1 -
 fs/dcache.c                                        |  7 ++-
 fs/fs-writeback.c                                  | 15 +++---
 fs/namespace.c                                     |  2 +-
 fs/nilfs2/segment.c                                | 10 ++--
 include/linux/crash_dump.h                         |  2 +
 include/linux/i2c.h                                |  2 +-
 include/linux/seqlock.h                            | 27 +++++++----
 include/net/if_inet6.h                             |  1 -
 kernel/fork.c                                      |  2 +-
 kernel/sched/fair.c                                |  2 +-
 kernel/time/sched_clock.c                          |  6 +--
 lib/percpu_counter.c                               |  4 +-
 mm/util.c                                          |  5 +-
 net/batman-adv/main.c                              |  2 +-
 net/core/filter.c                                  | 30 +-----------
 net/ieee802154/nl-phy.c                            |  6 ++-
 net/ipv4/inet_diag.c                               |  5 +-
 net/ipv4/ipmr.c                                    |  7 ++-
 net/ipv4/tcp_metrics.c                             | 51 +++++++++++++--------
 net/ipv6/addrconf.c                                | 38 +++++++---------
 net/ipv6/ip6mr.c                                   |  7 ++-
 net/rds/ib_recv.c                                  |  7 ++-
 sound/soc/codecs/tlv320aic32x4.c                   | 28 +++++++-----
 sound/soc/codecs/tlv320aic32x4.h                   |  3 ++
 sound/soc/codecs/wm5100.c                          |  2 +
 sound/soc/codecs/wm5110.c                          | 48 ++++++++++++++++++++
 sound/soc/fsl/fsl_ssi.c                            |  9 +---
 sound/soc/omap/Kconfig                             |  1 +
 sound/soc/samsung/Kconfig                          |  4 +-
 sound/soc/samsung/h1940_uda1380.c                  |  1 +
 sound/soc/samsung/i2s.c                            |  5 +-
 sound/soc/samsung/neo1973_wm8753.c                 |  1 +
 sound/soc/samsung/rx1950_uda1380.c                 |  1 +
 sound/soc/samsung/s3c-i2s-v2.c                     |  6 +--
 sound/soc/samsung/s3c2412-i2s.c                    |  2 +
 sound/soc/samsung/s3c24xx-i2s.c                    |  2 +
 sound/soc/samsung/smartq_wm8987.c                  |  1 +
 sound/soc/samsung/smdk_wm8994.c                    |  4 +-
 93 files changed, 525 insertions(+), 296 deletions(-)

--moLig8uJibGkz5Yz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5+pwAAoJELSic+t+oim9xHYQAIbmIN13AUQmEVpvTrHcGdPg
CUbXdXVYN7vxKOBBcSVr9UT0Kb+5sk+RIjuro9EYAjgIOB4093G6do4Afl+mM6TW
4unG4vBmAlx9tbnFm6IfiUrAOKm+HkYPgx0dGyeFbaVxh7jOgoHuVDpqLC77WGPX
QOVjDsoT/S4OuGtDxq0bPy+OSxU4/lfCsQNoZv8hU/+sa+oC9F69Urc5LusJlSTE
OtiDGYNOGEBg1u/Vednt5lqji/HDkEhkTh1MNWEFiiGq/y6TSGzS12I2x5HTiPc8
V3xjfhvFnbAL5a7aSt8p1Y/Y7s3MDdpztr8U/y7ykicClbySlgQ6KKIDhXYxMS9N
NQC6j0TFmpCOyX5E9ilDh+HkoQI+Eeh444qc1E6a0rVwcF9o0AV7wKNF2nFjVHrc
XKafx+LfctxiVoUrg9Tbo5wqUsUxeXQYFdUqk3SBkC5qzDRCZu0FMPWGNEltVCCn
D6l0Rkujh/UOWwq03ThGIiOSzCNsme6Nq2uGVK4JnFBzpSvWiap6cG0TuJhmg04w
h6Go4kYhzRKKXTNxRylanJNtk+7Zq6eoJYnF2zNJCBp9sdK0cEdywAj7R2y294ca
ONQ2o13+3Luo9hA85eJJ22C06ZgTRdxJI7V9DAJ0FGHrCLb0Qf98jQgaa1D1c+5i
vNklGyXRZ/eJ+eAyQBSG
=2cUD
-----END PGP SIGNATURE-----

--moLig8uJibGkz5Yz--

--===============6774813801596825097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6774813801596825097==--
