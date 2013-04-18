From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: More ASoC updates for v3.10
Date: Thu, 18 Apr 2013 15:15:22 +0100
Message-ID: <20130418141521.GI13687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4465956896595230714=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8776264EF5
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 16:15:24 +0200 (CEST)
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


--===============4465956896595230714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l4IMblsHEWQg+b+m"
Content-Disposition: inline


--l4IMblsHEWQg+b+m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit b02e48f2f8755e51fe8ce246988a29bd96f6b85e:

  MAINTAINERS: Update e-mail address (2013-04-12 11:53:41 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

for you to fetch changes up to 24568ea4bef5ab8106206eddf5512434421c00ed:

  Merge remote-tracking branch 'asoc/topic/max98088' into asoc-next (2013-0=
4-18 15:05:35 +0100)

There's a bunch of extra stuff in the diffstat/log since your for-next
is further behind Linus' tree than one of my branches.

----------------------------------------------------------------

ASoC: More updates for v3.10

The main additional change here is Lars-Peter's DMA work plus the
platform conversions which have been tested - getting this in mainline
will make life easier for development after the merge window.  These
factor a large chunk of code out of the drivers for the platforms using
dmaengine, greatly simplifying development.

----------------------------------------------------------------
Al Viro (3):
      ecryptfs: close rmmod race
      procfs: add proc_remove_subtree()
      palinfo fixes

Alex Williamson (1):
      vfio-pci: Fix possible integer overflow

Alexandre Belloni (1):
      gpio: pca953x: fix irq_domain_add_simple usage

Alexey Khoroshilov (1):
      tty: mxser: fix cycle termination condition in mxser_probe() and mxse=
r_module_init()

Alexey Pelykh (1):
      OMAP/serial: Revert bad fix of Rx FIFO threshold granularity

Andrea Arcangeli (2):
      x86/mm/cpa: Convert noop to functional fix
      x86/mm/cpa/selftest: Fix false positive in CPA self test

Andrey Vagin (1):
      mnt: release locks on error path in do_loopback

Arnd Bergmann (5):
      block: avoid using uninitialized value in from queue_var_store
      Merge tag 'mxs-fixes-3.9-4' of git://git.linaro.org/people/shawnguo/l=
inux-2.6 into fixes
      Merge tag 'imx-fixes-3.9-5' of git://git.linaro.org/people/shawnguo/l=
inux-2.6 into fixes
      Merge tag 'samsung-fixes-for-v3.9' of git://git.kernel.org/.../kgene/=
linux-samsung into fixes
      Merge tag 'mvebu_fixes_for_v3.9_round3' of git://git.infradead.org/us=
ers/jcooper/linux into fixes

Artem Savkov (1):
      cfg80211: sched_scan_mtx lock in cfg80211_conn_work()

Arun Easi (1):
      [SCSI] qla2xxx: Fix crash during firmware dump procedure.

Asai Thambi S P (3):
      mtip32xx: recovery from command timeout
      mtip32xx: return 0 from pci probe in case of rebuild
      mtip32xx: Add debugfs entry device_status

Asias He (7):
      tcm_vhost: Use ACCESS_ONCE for vs->vs_tpg[target] access
      tcm_vhost: Use vq->private_data to indicate if the endpoint is setup
      tcm_vhost: Initialize vq->last_used_idx when set endpoint
      tcm_vhost: Remove double check of response
      tcm_vhost: Fix tv_cmd leak in vhost_scsi_handle_vq
      tcm_vhost: Add vhost_scsi_send_bad_target() helper
      tcm_vhost: Send bad target to guest when cmd fails

Bing Zhao (1):
      mwifiex: complete last internal scan

Boris Ostrovsky (2):
      x86, mm: Patch out arch_flush_lazy_mmu_mode() when running on bare me=
tal
      x86/mm: Flush lazy MMU when DEBUG_PAGEALLOC is set

Brian King (1):
      [SCSI] ibmvscsi: Fix slave_configure deadlock

Calvin Owens (1):
      drm/nouveau: fix unconditional return waiting on memory

Chen Gang (3):
      perf: Fix strncpy() use, always make sure it's NUL terminated
      perf: Fix strncpy() use, use strlcpy() instead of strncpy()
      ftrace: Fix strncpy() use, use strlcpy() instead of strncpy()

Chris Metcalf (1):
      tile: comment assumption about __insn_mtspr for <asm/irqflags.h>

Christian Ruppert (1):
      ARC: Add implicit compiler barrier to raw_local_irq* functions

Christoph Paasch (1):
      ipv6/tcp: Stop processing ICMPv6 redirect messages

Christopher Harvey (1):
      drm/mgag200: Index 24 in extended CRTC registers is 24 in hex, not de=
cimal.

Chuck Lever (1):
      SUNRPC: Remove extra xprt_put()

Daniel Vetter (1):
      drm/fb-helper: Fix locking in drm_fb_helper_hotplug_event

Dave Airlie (2):
      Merge branch 'drm-nouveau-fixes-3.9' of git://anongit.freedesktop.org=
/git/nouveau/linux-2.6 into drm-fixes
      udl: handle EDID failure properly.

Dave Hansen (1):
      x86-32: Fix possible incomplete TLB invalidate with PAE pagetables

David S. Miller (3):
      Merge branch 'infoleaks'
      Merge branch 'wireless'
      Merge branch 'fixes-for-3.9' of git://gitorious.org/linux-can/linux-c=
an

David Woodhouse (1):
      libata: fix DMA to stack in reading devslp_timing parameters

Dirk Behme (1):
      ARM i.MX6: Fix ldb_di clock selection

Dirk Brandewie (1):
      cpufreq / intel_pstate: Set timer timeout correctly

Dmitry Tarnyagin (1):
      remoteproc/ste: fix memory leak on shutdown

Dylan Reid (1):
      ASoC: max98088: Fix logging of hardware revision.

Eldad Zack (1):
      ALSA: usb-audio: fix endianness bug in snd_nativeinstruments_*

Eric Dumazet (1):
      selinux: add a skb_owned_by() hook

Franky Lin (1):
      brcmfmac: do not proceed if fail to download nvram to dongle

Gabor Juhos (1):
      rt2x00: rt2x00pci: fix build error on Ralink RT3x5x SoCs

Greg Ungerer (1):
      m68k: define a local gpio_request_one() function

Gregory CLEMENT (1):
      arm: mvebu: Fix the irq map function in SMP mode

Guennadi Liakhovetski (1):
      tty: Documentation: fix a path in a DocBook template

Guenter Roeck (1):
      misc/vmw_vmci: Add dependency on CONFIG_NET

Haiyang Zhang (2):
      hyperv: Fix a kernel warning from netvsc_linkstatus_callback()
      hyperv: Fix RNDIS send_completion code path

Hante Meuleman (3):
      brcmfmac: fix tkip mic tx/rx ap swap bug.
      brcmfmac: fix stopping AP.
      brcmfmac: fix returning cipher_suite for get_key operation.

Huacai Chen (1):
      PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()

Jan Kiszka (1):
      ftrace: Consistently restore trace function on sysctl enabling

Jens Axboe (2):
      mtip32xx: fix two smatch warnings
      Revert "loop: cleanup partitions when detaching loop device"

Jiri Pirko (2):
      net: ipv4: reset check_lifetime_work after changing lifetime
      net: ipv4: fix schedule while atomic bug in check_lifetime()

Joe Carnuccio (1):
      [SCSI] Revert "qla2xxx: Add setting of driver version string for vend=
or application."

Joe Lawrence (1):
      [SCSI] st: Take additional queue ref in st_probe

John Gong (1):
      [SCSI] libsas: use right function to alloc smp response

John W. Linville (2):
      Merge branch 'for-john' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem

Josef Bacik (1):
      Btrfs: make sure nbytes are right after log replay

Jussi Kivilinna (1):
      crypto: gcm - fix assumption that assoc has one segment

Keir Fraser (1):
      xen/events: Handle VIRQ_TIMER before any other hardirq in event loop.

Kleber Sacilotto de Souza (1):
      [SCSI] ipr: fix addition of abort command to HRRQ free queue

Konrad Rzeszutek Wilk (1):
      xen/mmu: On early bootup, flush the TLB when changing RO->RW bits Xen=
 provided pagetables.

Krzysztof Mazur (1):
      [libata] Fix HDIO_DRIVE_* ioctl() Linux 3.9 regression

Lars-Peter Clausen (9):
      ASoC: dmaengine-pcm: Make requesting the DMA channel at PCM open opti=
onal
      ASoC: Add snd_soc_{add, remove}_platform
      ASoC: Add a generic dmaengine_pcm driver
      ASoC: dmaengine_pcm: Add support for compat platforms
      ASoC: tegra: Use generic dmaengine PCM
      ASoC: dmaengine-pcm: Add support for platforms which can't report res=
idue
      ASoC: imx: Setup dma data in DAI probe
      ASoC: imx: Use generic dmaengine PCM
      ASoC: ux500: Use generic dmaengine PCM

Li Fei (1):
      hwspinlock: fix __hwspin_lock_request error path

Linus Torvalds (39):
      Merge tag 'trace-fixes-3.9-rc6' of git://git.kernel.org/.../rostedt/l=
inux-trace
      Merge tag 'upstream-linus' of git://git.kernel.org/.../jgarzik/libata=
-dev
      Merge tag 'for-linus' of git://git.kernel.org/.../sfr/next-fixes
      Merge tag 'remoteproc-3.9-fixes' of git://git.kernel.org/.../ohad/rem=
oteproc
      Merge tag 'hwspinlock-3.9-fix' of git://git.kernel.org/.../ohad/hwspi=
nlock
      spinlocks and preemption points need to be at least compiler barriers
      Merge tag 'for-linus-20130409' of git://git.kernel.dk/linux-block
      Merge tag 'vfio-v3.9-rc7' of git://github.com/awilliam/linux-vfio
      Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge git://git.kernel.org/.../herbert/crypto-2.6
      Merge tag 'nfs-for-3.9-4' of git://git.linux-nfs.org/projects/trondmy=
/linux-nfs
      Merge tag 'nfs-for-3.9-5' of git://git.linux-nfs.org/projects/trondmy=
/linux-nfs
      Merge tag 'for-linus' of git://linux-c6x.org/git/projects/linux-c6x-u=
pstreaming
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'trace-fixes-3.9-rc-v2' of git://git.kernel.org/.../rostedt=
/linux-trace
      Merge tag 'stable/for-linus-3.9-rc6-tag' of git://git.kernel.org/.../=
konrad/xen
      Merge tag 'tty-3.9-rc6' of git://git.kernel.org/.../gregkh/tty
      Merge tag 'char-misc-3.9-rc6' of git://git.kernel.org/.../gregkh/char=
-misc
      Merge tag 'arm-soc-fixes' of git://git.kernel.org/.../arm/arm-soc
      Merge tag 'gpio-fixes-v3.9-rc6' of git://git.kernel.org/.../linusw/li=
nux-gpio
      Merge tag 'regmap-v3.9-rc6' of git://git.kernel.org/.../broonie/regmap
      Merge tag 'pm-3.9-rc7' of git://git.kernel.org/.../rafael/linux-pm
      Merge branch 'fixes' of git://git.infradead.org/users/vkoul/slave-dma
      Merge tag 'sound-3.9' of git://git.kernel.org/.../tiwai/sound
      Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge git://git.kernel.org/.../nab/target-pending
      kobject: fix kset_find_obj() race with concurrent last kobject_put()
      Add file_ns_capable() helper function for open-time capability checki=
ng
      Merge tag 'trace-fixes-v3.9-rc-v3' of git://git.kernel.org/.../rosted=
t/linux-trace
      Merge branch 'for-linus' of git://git.kernel.org/.../mason/linux-btrfs
      Merge git://www.linux-watchdog.org/linux-watchdog
      Merge branch 'for-linus' of git://git.kernel.org/.../gerg/m68knommu
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/.../tip=
/tip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Linux 3.9-rc7

Linus Walleij (1):
      crypto: ux500 - add missing comma

Lukasz Dorau (1):
      [SCSI] libsas: fix handling vacant phy in sas_set_ex_phy()

Marek Vasut (1):
      ARM: mxs: Slow down the I2C clock speed

Mark Brown (13):
      regmap: Back out work buffer fix
      Merge remote-tracking branch 'asoc/fix/compress' into tmp
      Merge remote-tracking branch 'asoc/fix/core' into tmp
      Merge remote-tracking branch 'asoc/fix/samsung' into tmp
      Merge remote-tracking branch 'asoc/fix/tegra' into tmp
      Merge remote-tracking branch 'asoc/fix/wm8903' into tmp
      Merge branch 'topic/core' of git://git.kernel.org/.../broonie/sound i=
nto asoc-dma
      Merge tag 'v3.9-rc7' into asoc-dma
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs4271' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98088' into asoc-next

Mark Salter (1):
      add memory barrier to arch_local_irq_restore

Markus Pargmann (3):
      ARM: clk-imx35: Bugfix iomux clock
      ARM: imx35 Bugfix admux clock
      ASoC: fsl-ssi: Add SACNT definitions

Mathias Krause (16):
      atm: update msg_namelen in vcc_recvmsg()
      ax25: fix info leak via msg_name in ax25_recvmsg()
      Bluetooth: fix possible info leak in bt_sock_recvmsg()
      Bluetooth: RFCOMM - Fix missing msg_namelen update in rfcomm_sock_rec=
vmsg()
      Bluetooth: SCO - Fix missing msg_namelen update in sco_sock_recvmsg()
      caif: Fix missing msg_namelen update in caif_seqpkt_recvmsg()
      irda: Fix missing msg_namelen update in irda_recvmsg_dgram()
      iucv: Fix missing msg_namelen update in iucv_sock_recvmsg()
      l2tp: fix info leak in l2tp_ip6_recvmsg()
      llc: Fix missing msg_namelen update in llc_ui_recvmsg()
      netrom: fix info leak via msg_name in nr_recvmsg()
      NFC: llcp: fix info leaks via msg_name in llcp_sock_recvmsg()
      rose: fix info leak via msg_name in rose_recvmsg()
      tipc: fix info leaks via msg_name in recv_msg/recv_stream
      VSOCK: vmci - fix possible info leak in vmci_transport_dgram_dequeue()
      VSOCK: Fix missing msg_namelen update in vsock_stream_recvmsg()

Michael Riesch (1):
      rtnetlink: Call nlmsg_parse() with correct header length

Michael Wolf (1):
      powerpc: pSeries_lpar_hpte_remove fails from Adjunct partition being =
performed before the ANDCOND test

Namhyung Kim (2):
      tracing: Fix double free when function profile init failed
      tracing: Fix possible NULL pointer dereferences

Neil Horman (1):
      e100: Add dma mapping error check

Nicholas Bellinger (1):
      target: Fix incorrect fallthrough of ALUA Standby/Offline/Transition =
CDBs

Nicolas Ferre (1):
      watchdog: Revert the AT91RM9200_WATCHDOG dependency

Nigel Roberts (2):
      ARM: Kirkwood: Fix typo in the definition of ix2-200 rebuild LED
      Fix GE0/GE1 init on ix2-200 as GE0 has no PHY

Padmavathi Venna (1):
      DMA: PL330: Add check if device tree compatible

Paul Moore (1):
      lsm: add the missing documentation for the security_skb_owned_by() ho=
ok

Peter Ujfalusi (1):
      dmaengine: omap-dma: Start DMA without delay for cyclic channels

Robert Shade (1):
      ath9k: Re-enable interrupts after a channel change failure

Robert Tivy (1):
      remoteproc: fix FW_CONFIG typo

Roland Stigge (1):
      MAINTAINERS: Add maintainer for LPC32xx

Sachin Prabhu (1):
      cifs: Allow passwords which begin with a delimitor

Samu Kallio (1):
      x86, mm, paravirt: Fix vmalloc_fault oops during lazy MMU updates

Saurav Kashyap (3):
      [SCSI] qla2xxx: Update copyright dates information in LICENSE.qla2xxx=
 file.
      [SCSI] qla2xxx: Remove debug code that msleeps for random duration.
      [SCSI] qla2xxx: Update the driver version to 8.04.00.13-k.

Sean Young (1):
      Revert "tty/8250_pnp: serial port detection regression since v3.7"

Shan Hai (2):
      libata: Use integer return value for atapi_command_packet_set
      libata: Set max sector to 65535 for Slimtype DVD A DS8A8SH drive

Shawn Guo (1):
      ARM: imx: provide twd clock lookup from device tree

Sjur Br=E6ndeland (1):
      remoteproc: fix error path of handle_vdev

Sridhar Samudrala (1):
      sctp: remove 'sridhar' from maintainers list

Stanislaw Gruszka (1):
      sched/cputime: Fix accounting on multi-threaded processes

Stas Sergeev (1):
      ASoC: define playback and capture streams in dummy codec

Stefan Raspl (1):
      qeth: fix qeth_wait_for_threads() deadlock for OSN devices

Stephane Eranian (2):
      perf/x86: Fix uninitialized pt_regs in intel_pmu_drain_bts_buffer()
      perf: Fix ring_buffer perf_output_space() boundary calculation

Steven Rostedt (Red Hat) (3):
      tracing: Fix race with update_max_tr_single and changing tracers
      ftrace: Do not call stub functions in control loop
      ftrace: Move ftrace_filter_lseek out of CONFIG_DYNAMIC_FTRACE section

Suleiman Souhlal (1):
      vfs: Revert spurious fix to spinning prevention in prune_icache_sb

Suman Anna (1):
      remoteproc: fix the error check for idr_alloc

Sylwester Nawrocki (2):
      ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
      ARM: S3C24XX: Fix interrupt pending register offset of the EINT contr=
oller

Takashi Iwai (2):
      Merge tag 'asoc-v3.9-rc6' of git://git.kernel.org/.../broonie/sound i=
nto for-linus
      Merge tag 'asoc-maintainers-v3.9-rc6' of git://git.kernel.org/.../bro=
onie/sound into for-linus

Tejun Heo (1):
      sched: Convert BUG_ON()s in try_to_wake_up_local() to WARN_ON_ONCE()s

Thomas Gleixner (1):
      sched_clock: Prevent 64bit inatomicity on 32bit systems

Tim Gardner (1):
      rt2x00: rt2x00pci_regbusy_read() - only print register access failure=
 once

Trond Myklebust (5):
      NFSv4: Fix a memory leak in nfs4_discover_server_trunking
      NFSv4/4.1: Fix bugs in nfs4[01]_walk_client_list
      SUNRPC: Fix a potential memory leak in rpc_new_client
      NFSv4: Fix another potential state manager deadlock
      NFSv4: Doh! Typo in the fix to nfs41_walk_client_list

Ursula Braun (1):
      af_iucv: fix recvmsg by replacing skb_pull() function

Wei Yongjun (4):
      netrom: fix invalid use of sizeof in nr_recvmsg()
      can: gw: use kmem_cache_free() instead of kfree()
      [SCSI] lpfc: fix potential NULL pointer dereference in lpfc_sli4_rq_p=
ut()
      perf: Fix error return code

Yaniv Rosner (1):
      bnx2x: Fix KR2 rapid link flap

Youquan Song (1):
      ata_piix: Fix DVD not dectected at some Haswell platforms

Yuval Mintz (1):
      bnx2x: Prevent null pointer dereference in AFEX mode

libin (1):
      sched/debug: Fix sd->*_idx limit range avoiding overflow

nikolay@redhat.com (2):
      Revert "bonding: remove sysfs before removing devices"
      bonding: fix bonding_masters race condition in bond unloading

wenxiong@linux.vnet.ibm.com (2):
      [SCSI] ipr: ipr_test_msi() fails when running with msi-x enabled adap=
ter
      [SCSI] ipr: dlpar failed when adding an adapter back

willy tarreau (1):
      net: mvneta: enable features before registering the driver

 Documentation/DocBook/device-drivers.tmpl          |    2 +-
 Documentation/scsi/LICENSE.qla2xxx                 |    2 +-
 MAINTAINERS                                        |    7 +-
 Makefile                                           |    2 +-
 arch/arc/include/asm/irqflags.h                    |   12 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |    1 -
 arch/arm/boot/dts/imx28-sps1.dts                   |    1 -
 arch/arm/boot/dts/imx6qdl.dtsi                     |    1 +
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   14 +-
 arch/arm/mach-imx/clk-imx35.c                      |    2 +
 arch/arm/mach-imx/clk-imx6q.c                      |    3 +-
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |    7 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |   16 +-
 arch/arm/mach-s3c24xx/include/mach/irqs.h          |    4 +-
 arch/arm/mach-s3c24xx/irq.c                        |    2 +-
 arch/c6x/include/asm/irqflags.h                    |    2 +-
 arch/ia64/kernel/palinfo.c                         |   77 +----
 arch/m68k/include/asm/gpio.h                       |   20 ++
 arch/powerpc/platforms/pseries/lpar.c              |    8 +-
 arch/tile/include/asm/irqflags.h                   |   10 +-
 arch/x86/include/asm/paravirt.h                    |    5 +-
 arch/x86/include/asm/paravirt_types.h              |    2 +
 arch/x86/include/asm/tlb.h                         |    2 +-
 arch/x86/kernel/cpu/perf_event_intel_ds.c          |    3 +-
 arch/x86/kernel/paravirt.c                         |   25 +-
 arch/x86/lguest/boot.c                             |    1 +
 arch/x86/mm/fault.c                                |    6 +-
 arch/x86/mm/pageattr-test.c                        |    2 +-
 arch/x86/mm/pageattr.c                             |   12 +-
 arch/x86/mm/pgtable.c                              |    7 +
 arch/x86/xen/mmu.c                                 |   13 +-
 block/blk-sysfs.c                                  |    2 +
 block/partition-generic.c                          |    1 -
 crypto/gcm.c                                       |   17 +-
 drivers/ata/ata_piix.c                             |   14 +-
 drivers/ata/libata-core.c                          |    6 +-
 drivers/ata/libata-scsi.c                          |    8 +-
 drivers/base/regmap/regmap.c                       |    3 +-
 drivers/block/loop.c                               |   21 +-
 drivers/block/mtip32xx/mtip32xx.c                  |  327 ++++++++++++++--=
----
 drivers/block/mtip32xx/mtip32xx.h                  |   18 +-
 drivers/cpufreq/intel_pstate.c                     |    1 -
 drivers/crypto/ux500/cryp/cryp_core.c              |    2 +-
 drivers/dma/omap-dma.c                             |   20 +-
 drivers/dma/pl330.c                                |   38 ++-
 drivers/gpio/gpio-pca953x.c                        |    2 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    8 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   13 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |    2 +-
 drivers/gpu/drm/udl/udl_connector.c                |    4 +
 drivers/hwspinlock/hwspinlock_core.c               |    2 +
 drivers/misc/vmw_vmci/Kconfig                      |    2 +-
 drivers/net/bonding/bond_main.c                    |   11 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   |   18 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    3 +-
 drivers/net/ethernet/intel/e100.c                  |   36 ++-
 drivers/net/ethernet/marvell/mvneta.c              |    9 +-
 drivers/net/hyperv/netvsc.c                        |   17 +-
 drivers/net/hyperv/netvsc_drv.c                    |    2 -
 drivers/net/hyperv/rndis_filter.c                  |   14 +-
 drivers/net/wireless/ath/ath9k/main.c              |    4 +
 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c |    6 +-
 .../net/wireless/brcm80211/brcmfmac/wl_cfg80211.c  |   46 +--
 drivers/net/wireless/mwifiex/scan.c                |   11 +-
 drivers/net/wireless/rt2x00/Kconfig                |    7 +
 drivers/net/wireless/rt2x00/Makefile               |    1 +
 drivers/net/wireless/rt2x00/rt2400pci.c            |    1 +
 drivers/net/wireless/rt2x00/rt2500pci.c            |    1 +
 drivers/net/wireless/rt2x00/rt2800pci.c            |    1 +
 drivers/net/wireless/rt2x00/rt2x00mmio.c           |  216 +++++++++++++
 drivers/net/wireless/rt2x00/rt2x00mmio.h           |  119 +++++++
 drivers/net/wireless/rt2x00/rt2x00pci.c            |  176 -----------
 drivers/net/wireless/rt2x00/rt2x00pci.h            |   88 ------
 drivers/net/wireless/rt2x00/rt61pci.c              |    1 +
 drivers/remoteproc/Kconfig                         |    2 +-
 drivers/remoteproc/remoteproc_core.c               |    6 +-
 drivers/remoteproc/ste_modem_rproc.c               |    7 +-
 drivers/s390/net/qeth_core.h                       |    3 +
 drivers/s390/net/qeth_core_main.c                  |   19 ++
 drivers/s390/net/qeth_l2_main.c                    |    2 +
 drivers/s390/net/qeth_l3_main.c                    |    2 +
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |    2 +-
 drivers/scsi/ipr.c                                 |   13 +-
 drivers/scsi/libsas/sas_expander.c                 |   14 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |    3 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |    5 -
 drivers/scsi/qla2xxx/qla_dbg.c                     |    3 +-
 drivers/scsi/qla2xxx/qla_def.h                     |    1 -
 drivers/scsi/qla2xxx/qla_gbl.h                     |    3 -
 drivers/scsi/qla2xxx/qla_init.c                    |    4 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   58 ----
 drivers/scsi/qla2xxx/qla_version.h                 |    2 +-
 drivers/scsi/st.c                                  |    8 +-
 drivers/target/target_core_alua.c                  |    3 +
 drivers/tty/mxser.c                                |    8 +-
 drivers/tty/serial/8250/8250_pnp.c                 |   12 +-
 drivers/tty/serial/omap-serial.c                   |   11 +
 drivers/vfio/pci/vfio_pci.c                        |    3 +-
 drivers/vhost/tcm_vhost.c                          |  198 ++++++++----
 drivers/watchdog/Kconfig                           |    2 +-
 drivers/xen/events.c                               |   19 +-
 fs/btrfs/tree-log.c                                |   48 ++-
 fs/cifs/connect.c                                  |   16 +-
 fs/ecryptfs/miscdev.c                              |   14 +-
 fs/inode.c                                         |    2 +-
 fs/namespace.c                                     |    2 +-
 fs/nfs/nfs4client.c                                |   45 ++-
 fs/nfs/nfs4proc.c                                  |    1 +
 fs/nfs/nfs4state.c                                 |    8 +-
 fs/proc/generic.c                                  |  119 +++++--
 include/asm-generic/tlb.h                          |    7 +-
 include/linux/ata.h                                |    2 +-
 include/linux/capability.h                         |    2 +
 include/linux/ftrace.h                             |    5 +-
 include/linux/libata.h                             |    1 +
 include/linux/preempt.h                            |   22 +-
 include/linux/proc_fs.h                            |    2 +
 include/linux/security.h                           |   12 +
 include/linux/spinlock_up.h                        |   29 +-
 include/net/iucv/af_iucv.h                         |    8 +
 include/sound/dmaengine_pcm.h                      |   92 +++++-
 include/sound/soc-dapm.h                           |    1 -
 include/sound/soc.h                                |   13 +-
 kernel/capability.c                                |   24 ++
 kernel/events/core.c                               |    4 +-
 kernel/events/internal.h                           |    2 +-
 kernel/events/ring_buffer.c                        |   22 +-
 kernel/sched/clock.c                               |   26 ++
 kernel/sched/core.c                                |    8 +-
 kernel/sched/cputime.c                             |    2 +-
 kernel/sys.c                                       |    3 +-
 kernel/trace/ftrace.c                              |   54 ++--
 kernel/trace/trace.c                               |    9 +-
 kernel/trace/trace_stack.c                         |    2 +-
 lib/kobject.c                                      |    9 +-
 mm/memory.c                                        |    1 +
 net/atm/common.c                                   |    2 +
 net/ax25/af_ax25.c                                 |    1 +
 net/bluetooth/af_bluetooth.c                       |    4 +-
 net/bluetooth/rfcomm/sock.c                        |    1 +
 net/bluetooth/sco.c                                |    1 +
 net/caif/caif_socket.c                             |    2 +
 net/can/gw.c                                       |    6 +-
 net/core/rtnetlink.c                               |    4 +-
 net/ipv4/devinet.c                                 |   60 +++-
 net/ipv4/tcp_output.c                              |    1 +
 net/ipv6/tcp_ipv6.c                                |    1 +
 net/irda/af_irda.c                                 |    2 +
 net/iucv/af_iucv.c                                 |   36 +--
 net/l2tp/l2tp_ip6.c                                |    1 +
 net/llc/af_llc.c                                   |    2 +
 net/netrom/af_netrom.c                             |    1 +
 net/nfc/llcp/sock.c                                |    3 +
 net/rose/af_rose.c                                 |    1 +
 net/sunrpc/clnt.c                                  |   11 +-
 net/tipc/socket.c                                  |    7 +
 net/vmw_vsock/af_vsock.c                           |    2 +
 net/vmw_vsock/vmci_transport.c                     |    3 +-
 net/wireless/sme.c                                 |    2 +
 security/capability.c                              |    6 +
 security/security.c                                |    5 +
 security/selinux/hooks.c                           |    7 +
 sound/soc/Kconfig                                  |    4 +
 sound/soc/Makefile                                 |    4 +
 sound/soc/atmel/atmel-pcm-dma.c                    |   29 +-
 sound/soc/cirrus/edb93xx.c                         |    1 -
 sound/soc/cirrus/ep93xx-ac97.c                     |    9 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |   16 +-
 sound/soc/cirrus/ep93xx-pcm.c                      |   38 +--
 sound/soc/cirrus/ep93xx-pcm.h                      |   20 --
 sound/soc/cirrus/simone.c                          |    2 -
 sound/soc/cirrus/snappercl15.c                     |    1 -
 sound/soc/codecs/Kconfig                           |    2 +-
 sound/soc/codecs/cs4271.c                          |  166 +++++-----
 sound/soc/codecs/max98088.c                        |   32 +-
 sound/soc/codecs/wm5102.c                          |    2 +-
 sound/soc/codecs/wm8903.c                          |    2 +
 sound/soc/fsl/Kconfig                              |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |   55 ++--
 sound/soc/fsl/fsl_ssi.h                            |    8 +
 sound/soc/fsl/imx-audmux.c                         |    3 +-
 sound/soc/fsl/imx-pcm-dma.c                        |  120 +------
 sound/soc/fsl/imx-pcm-fiq.c                        |    6 +-
 sound/soc/fsl/imx-pcm.c                            |    6 +-
 sound/soc/fsl/imx-pcm.h                            |   24 +-
 sound/soc/fsl/imx-sgtl5000.c                       |    2 +-
 sound/soc/fsl/imx-ssi.c                            |   51 ++-
 sound/soc/fsl/imx-ssi.h                            |    7 +-
 sound/soc/mxs/mxs-pcm.c                            |   43 +--
 sound/soc/mxs/mxs-pcm.h                            |    4 +-
 sound/soc/mxs/mxs-saif.c                           |    6 +-
 sound/soc/omap/am3517evm.c                         |    1 -
 sound/soc/omap/ams-delta.c                         |    1 -
 sound/soc/omap/mcbsp.c                             |   14 +-
 sound/soc/omap/mcbsp.h                             |    7 +-
 sound/soc/omap/n810.c                              |    1 -
 sound/soc/omap/omap-abe-twl6040.c                  |    1 -
 sound/soc/omap/omap-dmic.c                         |   38 +--
 sound/soc/omap/omap-hdmi.c                         |   24 +-
 sound/soc/omap/omap-mcbsp.c                        |   18 +-
 sound/soc/omap/omap-mcpdm.c                        |  109 ++++---
 sound/soc/omap/omap-pcm.c                          |   86 +----
 sound/soc/omap/omap-pcm.h                          |   40 ---
 sound/soc/omap/omap-twl4030.c                      |    1 -
 sound/soc/omap/omap3pandora.c                      |    9 +-
 sound/soc/omap/osk5912.c                           |    1 -
 sound/soc/omap/rx51.c                              |    1 -
 sound/soc/pxa/mmp-pcm.c                            |   34 +-
 sound/soc/samsung/i2s.c                            |   17 +-
 sound/soc/soc-compress.c                           |   14 +-
 sound/soc/soc-core.c                               |  116 ++++---
 sound/soc/soc-dapm.c                               |    1 -
 sound/soc/soc-dmaengine-pcm.c                      |  150 +++++----
 sound/soc/soc-generic-dmaengine-pcm.c              |  284 +++++++++++++++++
 sound/soc/soc-io.c                                 |    5 +-
 sound/soc/soc-utils.c                              |   25 ++
 sound/soc/spear/spear_pcm.c                        |   19 +-
 sound/soc/tegra/Kconfig                            |    2 +-
 sound/soc/tegra/tegra20_ac97.c                     |   13 +-
 sound/soc/tegra/tegra20_ac97.h                     |    4 +-
 sound/soc/tegra/tegra20_i2s.c                      |   13 +-
 sound/soc/tegra/tegra20_i2s.h                      |    4 +-
 sound/soc/tegra/tegra20_spdif.c                    |    7 +-
 sound/soc/tegra/tegra20_spdif.h                    |    4 +-
 sound/soc/tegra/tegra30_ahub.c                     |    8 +-
 sound/soc/tegra/tegra30_ahub.h                     |    8 +-
 sound/soc/tegra/tegra30_i2s.c                      |   13 +-
 sound/soc/tegra/tegra30_i2s.h                      |    4 +-
 sound/soc/tegra/tegra_pcm.c                        |  209 +------------
 sound/soc/tegra/tegra_pcm.h                        |    7 -
 sound/soc/ux500/Kconfig                            |    2 +-
 sound/soc/ux500/ux500_pcm.c                        |  229 ++------------
 sound/soc/ux500/ux500_pcm.h                        |   14 -
 sound/usb/mixer_quirks.c                           |    4 +-
 sound/usb/quirks.c                                 |    2 +-
 235 files changed, 2790 insertions(+), 2211 deletions(-)
 create mode 100644 drivers/net/wireless/rt2x00/rt2x00mmio.c
 create mode 100644 drivers/net/wireless/rt2x00/rt2x00mmio.h
 delete mode 100644 sound/soc/cirrus/ep93xx-pcm.h
 delete mode 100644 sound/soc/omap/omap-pcm.h
 create mode 100644 sound/soc/soc-generic-dmaengine-pcm.c

--l4IMblsHEWQg+b+m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRb//tAAoJELSic+t+oim9YpkP/R6GTQSNtoVAhwVhPkbV+DQQ
ai4gOwA6TNA0eNJPKMPsCW+LFhbHndj4G8qtxOr4LP4clR37yiwrsRcaLPG3Feui
SQU8NkAw1GlD98brKHp+Jm460MH190wsfvQjwnf4DutnWCM6NSHZak8MDpexBlpl
rVc/eypU5N417CPeZ/zOVCHz8DTT2DB6a1MERTXEGDbSVeZ+qKLdpWuI6EgJ4hz+
qCEVlUm/XFuVTHVLypas8OZY29wLFN8HZYgpkV2PLGZ0ZetEOi5vfjH4377SBYKB
dBK6B63sL/LqsPR8gfYUQL4inYM8b7VGJgGscNUEj85sk8vZm1M/1WECUly0YCn1
p33TrElRap+R0RHN2zZuqyPgJi2GS0CS2v+eRE/feGALtKQEwranWbLcS93AJQVC
UgD/imiF9+X6Yljz7pdJT+To8z1MUMjpRpd/lcE1ilVRQ/jYpaE6lwuKRUqTRNUl
Zu7uv3DfWsv5zAmsBc5UrgpPI/tC8UtiVB09FiMczZhUQlEAzXDtKsiGJtXDTDzh
GwQXEoLwMcWLBrmlQ2EkXeRrUVwoVtlN/WtOTCfT51OzDzXR8IV0DDLl7yEwj9fP
Y25xfcGrwGbrPTK8eW7qxgf0ud2lzg4Ue0GvEX5YHNBsRPLZVP+1s0UtUdsu1maf
2ck/9NNvHxCyVBGsxjqD
=6wbY
-----END PGP SIGNATURE-----

--l4IMblsHEWQg+b+m--

--===============4465956896595230714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4465956896595230714==--
