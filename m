From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Fri, 6 Nov 2009 15:59:05 +0000
Message-ID: <20091106155905.GA29207@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE940243BF
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 16:59:07 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The following changes since commit b3f5a272a33ef06a37cd44703c46ec916b8a1c93:
  Peter Ujfalusi (1):
        ASoC: TWL4030: Make sure, that the codec is powered on startup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.33

Again this is mostly the merge up of rc6 so looks a lot bigger than it
is.

Aaro Koskinen (2):
      panic: Fix panic message visibility by calling bust_spinlocks(0) befo=
re dying
      omap: RX-51: Drop I2C-1 speed to 2200

Adam Jackson (1):
      drm/i915: Initialize HDMI outputs as HDMI connectors, not DVI.

Ajit Khaparde (4):
      be2net: Fix a bug in preparation of mcc wrb which was causing flash o=
peration to fail
      be2net: Bug Fix while accounting of multicast frames during netdev st=
ats update
      be2net: Fix a typo in be_cmds.h
      be2net: Bug fix to properly update ethtool tx-checksumming after etht=
ool -K <ifname> tx off

Alan Cox (9):
      libertas: fix build
      libertas: fix build
      ethoc: fix warning from 32bit build
      Staging: et131x: Correct WRAP bit handling
      Staging: et131x: Fix the add_10bit macro
      pata_sc1200: Fix crash on boot
      dpt_i2o: Fix up copy*user
      ray_cs: Fix copy_from_user handling
      tty: Mark generic_serial users as BROKEN

Alan Stern (3):
      USB: serial: don't call release without attach
      USB: ipaq: fix oops when device is plugged in
      USB: storage: When a device returns no sense data, call it a Hardware=
 Error

Albert Herranz (1):
      b43: do not stack-allocate pio rx/tx header and tail buffers

Alek Du (1):
      kbuild: Fix size_append issue for bzip2/lzma kernel

Alex Chiang (7):
      Documentation: ABI: rename sysfs-devices-cache_disable properly
      Documentation: ABI: document /sys/devices/system/cpu/
      Documentation: ABI: /sys/devices/system/cpu/ topology files
      Documentation: ABI: /sys/devices/system/cpu/cpu#/ topology files
      Documentation: ABI: /sys/devices/system/cpu/sched_[mc|smt]_power_savi=
ngs
      Documentation: ABI: /sys/devices/system/cpu/cpuidle/
      Documentation: ABI: /sys/devices/system/cpu/cpu#/node

Alex Deucher (1):
      drm/radeon/kms: add support for "Surround View"

Alex Elder (2):
      Merge branch 'master' into for-linus
      Merge branch 'master' of ssh://oss.sgi.com/oss/git/xfs/xfs into for-l=
inus

Alexander Duyck (4):
      e1000e: swap max hw supported frame size between 82574 and 82583
      igb: fix memory leak when setting ring size while interface is down
      ixgbe: fix memory leak when resizing rings while interface is down
      igbvf: fix memory leak when ring size changed while interface down

Alexey Dobriyan (4):
      Btrfs: constify dentry_operations
      headers: remove sched.h from interrupt.h
      loop: fix NULL dereference if mount fails
      sysctl: fix false positives when PROC_SYSCTL=3Dn

Alok Kataria (1):
      x86, vmi: Mark VMI deprecated and schedule it for removal

Amerigo Wang (1):
      kbuild,scripts: use non-builtin echo for '-e'

Amit Kucheria (1):
      Input: fix rx51 board keymap

Amit Kumar Salecha (1):
      netxen: fix tx timeout handling on firmware hang

Andi Kleen (4):
      HWPOISON: Clean up PR_MCE_KILL interface
      HWPOISON: Add brief hwpoison description to Documentation
      HWPOISON: Fix page count leak in hwpoison late kill in do_swap_page
      HWPOISON: Allow schedule_on_each_cpu() from keventd

Andreas Gruenbacher (1):
      dnotify: ignore FS_EVENT_ON_CHILD

Andreas Krebbel (1):
      [S390] Add highgprs facility to /proc/cpuinfo

Andreas Schwab (3):
      tty: fix vt_compat_ioctl
      powerpc: Fix segment mapping in vdso32
      powerpc: Align vDSO base address

Andrew Morton (2):
      dm log: userspace fix incorrect luid cast in userspace_ctr
      revert "mm: oom analysis: add buffer cache information to show_free_a=
reas()"

Andrey Yurovsky (1):
      mac80211: trivial: fix spelling in mesh_hwmp

Andy Whitcroft (7):
      checkpatch: possible types -- prevent illegal modifiers being added
      checkpatch: correctly stop scanning at the bottom of a hunk
      checkpatch: update copyright dates
      checkpatch: fix false errors due to macro concatenation
      checkpatch: fix __attribute__ matching
      checkpatch: fix false EXPORT_SYMBOL warning
      checkpatch: version 0.30

Anil Ravindranath (1):
      [SCSI] pmcraid: Changed driver prints to scmd/sdev_printk

Anil Veerabhadrappa (1):
      [SCSI] bnx2i: Fix context mapping issue for architectures with PAGE_S=
IZE !=3D 4096

Anirban Chakraborty (1):
      [SCSI] qla2xxx: Fix NULL ptr deref bug in fail path during queue crea=
te

Anton Blanchard (2):
      futex: Fix typo in FUTEX_WAIT/WAKE_BITSET_PRIVATE definitions
      powerpc: Fix hypervisor TLB batching

Anton Vorontsov (3):
      powerpc/kgdb: Fix build failure caused by "kgdb.c: unused variable 'a=
cc'"
      net: Fix OF platform drivers coldplug/hotplug when compiled as modules
      USB: fsl_udc_core: Fix kernel oops on module removal

Antonio Ospite (1):
      [ARM] pxamci: fix printing gpio numbers in pxamci_probe

Anuj Aggarwal (1):
      omap: SDMA: Fixing bug in omap_dma_set_global_params()

Arjan van de Ven (7):
      perf timechart: Add a power-only mode
      x86: Simplify bound checks in the MTRR code
      x86, timers: Check for pending timers after (device) interrupts
      perf timechart: Fix the wakeup-arrows that point to non-visible proce=
sses
      perf timechart: Improve the visual appearance of scheduler delays
      net: use WARN() for the WARN_ON in commit b6b39e8f3fbbb
      x86: Remove STACKPROTECTOR_ALL

Arnaldo Carvalho de Melo (2):
      perf top: Add poll_idle to the skip list
      perf tools: elf_sym__is_function() should accept "zero" sized functio=
ns

Arnaud Patard (1):
      MIPS: O32: Fix ppoll

Arnd Bergmann (1):
      warn about use of uninstalled kernel headers

Artem Bityutskiy (3):
      OMAP3: PM: introduce a new powerdomain walk helper
      ARM: 5759/1: Add register information of threads to coredump
      UBI: fix backward compatibility

Ashwin Chaugule (1):
      perf tools: Remove static debugfs path from parse-events

Atsushi Nemoto (1):
      MIPS: TXx9: Fix spi-baseclk value

Aurelien Jarno (1):
      KVM: fix LAPIC timer period overflow

Avi Kivity (1):
      KVM: Prevent overflow in KVM_GET_SUPPORTED_CPUID

Barry Song (1):
      Blackfin: BF51x: add PTP MMR defines

Bart Van Assche (1):
      IB: Fix typo in udev rule documentation

Bartlomiej Zolnierkiewicz (7):
      pata_atp867x: fix it to not claim MWDMA support
      pata_atp867x: PIO support fixes
      pata_atp867x: add Power Management support
      sis5513: fix PIO setup for ATAPI devices
      Revert "Revert "ide: try to use PIO Mode 0 during probe if possible""
      MAINTAINERS: rt2x00 list is moderated
      MAINTAINERS: rt2x00 list is moderated

Ben Dooks (12):
      KS8851: Add soft reset at probe time
      KS8851: Fix MAC address write order
      KS8851: Fix ks8851_set_rx_mode() for IFF_MULTICAST
      DM9000: Fix revision ID for DM9000B
      ARM: S3C: Add info for supporting circular DMA buffers
      ARM: S3C2410: Fix link if CONFIG_S3C2410_IOTIMING is not set
      ARM: Merge fixes-s3c64xx
      ARM: Merge fixes-s3c64xx-dma
      ARM: S3C2440: mini2440: Fix missing CONFIG_S3C_DEV_USB_HOST
      ARM: S3C24XX: Fix warnings in arch/arm/plat-s3c24xx/gpio.c
      ARM: S3C2440: mini2440: Fix spare warnings
      ARM: S3C2410: Fix sparse warnings in arch/arm/mach-s3c2410/gpio.c

Ben Hutchings (5):
      net: Support inclusion of <linux/socket.h> before <sys/socket.h>
      nfs: Avoid overrun when copying client IP address string
      acenic: Pass up error code from ace_load_firmware()
      sfc: Set ip_summed correctly for page buffers passed to GRO
      hfsplus: refuse to mount volumes larger than 2TB

Benjamin Herrenschmidt (7):
      powerpc/pmac: Fix issues with sleep on some powerbooks
      powerpc/mm: Fix hang accessing top of vmalloc space
      usb-storage: Workaround devices with bogus sense size
      Merge commit 'ftrace/ppc' into merge
      powerpc/ppc64: Use preempt_schedule_irq instead of preempt_schedule
      Merge commit 'gcl/merge' into merge
      8250_pci: add IBM Saturn serial card

Benoit PAPILLAULT (1):
      rt2x00: Fix crypto in TX frame for rt2800usb

Bernd Schmidt (1):
      ROMFS: fix length used with romfs_dev_strnlen() function

Bjorn Helgaas (3):
      PCI: PCIe portdrv: remove "-driver" from driver name
      PCI: remove pci_assign_resource_fixed()
      iwlwifi: use %pM for formatted MAC addresses

Bj=F6rn Smedman (1):
      mac80211: fix for incorrect sequence number on hostapd injected frames

Bo Liu (1):
      mm: remove incorrect swap_count() from try_to_unuse()

Borislav Petkov (10):
      initcalls: Add early_initcall() for modules
      x86: EDAC: carve out AMD MCE decoding logic
      amd64_edac: fix driver instance lookup table allocation
      amd64_edac: fix DRAM base and limit address extraction
      amd64_edac: fix interleave enable tests
      amd64_edac: fix K8 intlv_sel check
      amd64_edac: fix chip select handling
      amd64_edac: fix DRAM base and limit extraction
      amd64_edac: beef up DRAM error injection
      amd64_edac: fix DRAM base and limit extraction masks, v2

Brandon Philips (1):
      sky2: set carrier off in probe

Brian Niebuhr (1):
      USB: gadget: Fix EEM driver comments and VID/PID

Brian Rogers (1):
      drm/i915: Don't call intel_update_fbc from intel_crtc_cursor_set

Brice Goglin (1):
      myri10ge: improve port type reporting in ethtool

Bruce Allan (9):
      e1000e: reset the PHY on 82577/82578 when going to Sx
      e1000e: clear PHY wakeup bit after LCD reset on 82577/82578
      e1000e: increase swflag acquisition timeout for ICHx/PCH
      e1000e: 82577/82578 requires a different method to configure LPLU
      e1000e: separate mutex usage between NVM and PHY/CSR register for ICH=
x/PCH
      e1000e: allow for swflag to be held over consecutive PHY accesses
      e100: e100_phy_init() isolates selected PHY, causes 10 second boot de=
lay
      e1000e: config PHY via software after resets
      e1000e: rework disable K1 at 1000Mbps for 82577/82578

Bryan Wu (1):
      USB: option: TLAYTECH TUE800 support

Catalin Marinas (4):
      ARM: 5746/1: Handle possible translation errors in ARMv6/v7 coherent_=
user_range
      ARM: 5747/1: Fix the start_pg value in free_memmap()
      kmemleak: Check for NULL pointer returned by create_object()
      ARM: 5757/1: Thumb-2: Correct "mov.w pc, lr" instruction which is unp=
redictable

Chris Dearman (4):
      MIPS: MTI: Fix accesses to device registers on MIPS boards
      MIPS: SPRAM: Clean up support code a little
      MIPS: CMP: Fix memory barriers for correct operation of amon_cpu_start
      MIPS: GIC: Random fixes and enhancements.

Chris Mason (10):
      Btrfs: fix deadlock on async thread startup
      Btrfs: cleanup extent_clear_unlock_delalloc flags
      Btrfs: delay clearing EXTENT_DELALLOC for compressed extents
      Btrfs: fix uninit compiler warning in cow_file_range_nocow
      Btrfs: fix file clone ioctl for bookend extents
      Btrfs: only write one super copy during fsync
      Btrfs: avoid tree log commit when there are no changes
      Btrfs: streamline tree-log btree block writeout
      Btrfs: fix btrfs acl #ifdef checks
      Btrfs: always pin metadata in discard mode

Chris Rankin (1):
      net: Teach pegasus driver to ignore bluetoother adapters with clashin=
g Vendor:Product IDs

Chris Wilson (4):
      drm/i915: Record device minor rather than pointer in TRACE_EVENT
      drm/i915: batch submit seqno off-by-one.
      drm/i915: Enable irq to trace batch buffer completion.
      perf: Propagate term signal to child

Christian Borntraeger (6):
      KVM: s390: fix memsize >=3D 4G
      [S390] module: fix memory leak in s390 module loader
      [S390] Fix memory leak in /proc/cio_ignore
      [S390] Fix enabled udelay for short delays.
      virtio: let header files include virtio_ids.h
      connector: fix regression introduced by sid connector

Christof Schmitt (10):
      [SCSI] sg: Free data buffers after calling blk_rq_unmap_user
      [SCSI] zfcp: correctly initialize unchained requests
      [SCSI] zfcp: Fix initial device and cfdc for delayed adapter allocati=
on
      [SCSI] zfcp: Fix oops during shutdown of offline device
      [SCSI] zfcp: Fix lockdep warning when offlining device with offline c=
hpid
      [SCSI] zfcp: Fix hang when offlining device with offline chpid
      [SCSI] zfcp: Handle WWPN mismatch in PLOGI payload
      [SCSI] zfcp: Warn about storage devices with broken PLOGI data
      [SCSI] zfcp: Fix timer initialization for ct and els requests
      [SCSI] zfcp: Flush SCSI registration work when adding unit

Christoph Hellwig (9):
      parisc: convert to asm-generic/hardirq.h
      sparc32: convert to asm-generic/hardirq.h
      xfs: implement ->dirty_inode to fix timestamp handling
      xfs: cleanup ->sync_fs
      xfs: stop calling filemap_fdatawait inside ->fsync
      xfs: fix double IRELE in xfs_dqrele_inode
      Btrfs: add -o discard option
      Btrfs: enable discard support
      virtio_blk: revert QUEUE_FLAG_VIRT addition

Chuck Ebbert (1):
      perf_events: Make ABI definitions available to userspace

Claudio Scordino (1):
      ARM: 5776/1: Check compiler version and EABI support when adding ARM =
unwind support.

Clemens Ladisch (2):
      sound: via82xx: move DXS volume controls to PCM interface
      sound: via82xx: deactivate DXS controls of inactive streams

Cornelia Huck (1):
      sysfs: Allow sysfs_move_dir(..., NULL) again.

Corrado Zoccolo (3):
      cfq-iosched: fix possible problem with jiffies wraparound
      cfq-iosched: fix think time allowed for seekers
      cfq-iosched: avoid probable slice overrun when idling

Daisuke Nishimura (1):
      mm: don't call pte_unmap() against an improper pte

Dan Williams (6):
      md/raid5: initialize conf->device_lock earlier
      md/raid456: downlevel multicore operations to raid_run_ops
      md/raid6: kill a gcc-4.0.1 'uninitialized variable' warning
      async_pq: kill a stray dma_map() call and other cleanups
      async_pq: rename scribble page
      async_tx: fix asynchronous raid6 recovery for ddf layouts

Daniel T Chen (1):
      ALSA: hda: Use quirk mask for Dell Inspiron Mini9/Vostro A90 using AL=
C268

Daniel Walker (1):
      omap: iovmm: Add missing mutex_unlock

Darren Hart (3):
      futex: fix requeue_pi key imbalance
      futex: Check for NULL keys in match_futex
      futex: Move drop_futex_key_refs out of spinlock'ed region

Darren Salt (2):
      eeepc-laptop: Prevent a panic when disabling RT2860 wireless when ass=
ociated
      Staging: rt2860sta: prevent a panic when disabling when associated

Darrick J. Wong (2):
      KVM: Prevent kvm_init from corrupting debugfs structures
      hwmon: enhance the sysfs API for power meters

Dave Airlie (9):
      drm/radeon/kms: respect single crtc cards, only create one crtc. (v2)
      drm/fb: add setcmap and fix 8-bit support.
      drm/fb: add more correct 8/16/24/32 bpp fb support.
      drm/ttm: fix refcounting in ttm global code.
      drm/radeon: use list_for_each_entry instead of list_for_each
      drm/radeon/kms: fix vline register for second head.
      Merge branch 'drm-next' of ../drm-next into drm-linus
      drm/radeon/kms: ignore vga arbiter return.
      drm/kms: fix kms/fbdev colormap support properly.

Dave Chinner (3):
      xfs: fix xfs_quiesce_data
      xfs: mark inodes dirty before issuing I/O
      xfs: make sure xfs_sync_fsdata covers the log

Dave Mitchell (1):
      ibm_newemac: Added 16K Tx FIFO size support for EMAC4

Dave Young (2):
      bluetooth: scheduling while atomic bug fix
      bluetooth: static lock key fix

David Daney (3):
      MIPS: Octeon: Fix compile error in arch/mips/cavium-octeon/smp.c
      MIPS: Octeon: Use write_{un,}lock_irq{restore,save} to set irq affini=
ty
      MIPS: Octeon: Use lockless interrupt controller operations when possi=
ble.

David Henningsson (1):
      ALSA: ice1724 - Make call to set hw params succeed on ESI Juli@

David Howells (2):
      KEYS: get_instantiation_keyring() should inc the keyring refcount in =
all cases
      NOMMU: Don't pass NULL pointers to fput() in do_mmap_pgoff()

David H=E4rdeman (1):
      Input: winbond-cir - select LEDS_TRIGGERS

David J. Wilder (1):
      RDMA/addr: Fix resolution of local IPv6 addresses

David Jeffery (1):
      [SCSI] st: fix possible memory use after free after MTSETBLK ioctl

David Miller (1):
      mm, perf_event: Make vmalloc_user() align base kernel virtual address=
 to SHMLBA

David Rientjes (1):
      oprofile: fix race condition in event_buffer free

David S. Miller (21):
      sparc: Support HW cache events.
      sparc: Support all ultra3 and ultra4 derivatives.
      sparc: Add Niagara2 HW cache event support.
      sparc: Niagara1 perf event support.
      sparc64: Add initial perf event conflict resolution and checks.
      sparc64: Increase vmalloc size to fix percpu regressions.
      sparc64: Add a basic conflict engine in preparation for multi-counter=
 support.
      sparc64: Minor coding style fixups in perf code.
      sparc64: Fix comment typo in perf_event.c
      sparc64: Cache per-cpu %pcr register value in perf code.
      Revert "ide: try to use PIO Mode 0 during probe if possible"
      znet: Don't claim DMA lock around free_dma() calls.
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless-2=
.6
      sparc64: Fix niagara2 perf IRQ bits.
      net: Link in PHY drivers before others.
      sparc64: Fix D-cache flushing on swapin from SW devices.
      sparc64: Set IRQF_DISABLED on LDC channel IRQs.
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless-2=
.6
      Revert "tcp: fix tcp_defer_accept to consider the timeout"
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless-2=
.6
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless-2=
.6

David Teigland (2):
      dlm: fix lowcomms_connect_node for sctp
      dlm: fix socket fd translation

David Vrabel (4):
      mmc: sdio: don't require CISTPL_VERS_1 to contain 4 strings
      USB: rename Documentation/ABI/.../sysfs-class-usb_host
      USB: whci-hcd: handle early deletion of endpoints
      USB: whci-hcd: always do an update after processing a halted qTD

David Woodhouse (6):
      intel-iommu: Yet another BIOS workaround: Isoch DMAR unit with no TLB=
 space
      Rename pci_init() to pci_apply_final_quirks(), move it to quirks.c
      Mark pci_apply_final_quirks() __init rather than __devinit
      Run pci_apply_final_quirks() sooner.
      x86: Move pci_iommu_init to rootfs_initcall()
      libertas if_usb: Fix crash on 64-bit machines

Dennis O'Brien (1):
      [ARM] pxa: workaround errata #37 by not using half turbo switching

Dhananjay Phadke (3):
      netxen: fix pci bar mapping
      netxen: fix i2c init
      netxen: avoid undue board config check

Dirk Hohndel (1):
      pata_ali: trivial fix of a very frequent spelling mistake

Dmitry Artamonow (2):
      ARM: 5752/1: SA1100: fix building of h3100
      irda/sa1100_ir: check return value of startup hook

Dmitry Eremin-Solenikov (1):
      Input: gpio-keys - use IRQF_SHARED

Dmitry Torokhov (12):
      Input: libps2 - fix dependancy on i8042
      Input: i8042 - print debug data when testing AUX IRQ delivery
      Input: synaptics - add another Protege M300 to rate blacklist
      Input: i8042 - make pnp_data_busted variable boolean instead of int
      Input: atkbd - restore resetting LED state at startup
      Input: atkbd - postpone restoring LED/repeat rate at resume
      Input: fix locking issue in /proc/bus/input/ handlers
      Input: i8042 - add Sony Vaio VGN-FZ240E to the nomux list
      Input: logips2pp - model 73 is actually TrackMan FX
      Driver core: allow certain drivers prohibit bind/unbind via sysfs
      Merge commit 'v2.6.32-rc5' into for-linus
      Input: i8042 - try to get stable CTR value when initializing

Dominik Brodowski (3):
      pcmcia: pccard_read_tuple and TUPLE_RETURN_COMMON cleanup
      pcmcia: do not try to store more than 4 version strings
      ALSA: pcmcia: use dynamic debug infrastructure, deprecate CS_CHECK (s=
ound)

Don Skidmore (2):
      ixgbe: add support for 82599 Combined Backplane
      ixgbe: add support for 82599 based X520 10G Dual KX4 Mezz card

Dragos Tatulea (1):
      powerpc/oprofile: Add ppc750 CL as supported by oprofile

Earl Chew (1):
      fs: pipe.c null pointer dereference

Eero Nurkkala (1):
      NOHZ: update idle state also when NOHZ is inactive

Eli Cohen (1):
      mlx4_core: Add a new supported 40 GigE device ID

Elina Pasheva (3):
      USB: serial: sierra driver version change to 1.3.8
      USB: serial: sierra driver send_setup() autopm fix
      USB: serial: sierra driver autopm fixes

Eric Anholt (1):
      Merge commit 'ickle/for-anholt' into drm-intel-next

Eric Dumazet (13):
      x86: Don't generate cmpxchg8b_emu if CONFIG_X86_CMPXCHG64=3Dy
      pktgen: Fix multiqueue handling
      pktgen: restore nanosec delays
      net: Add patchwork URL to MAINTAINERS
      net: Fix struct sock bitfield annotation
      udp: Fix udp_poll() and ioctl()
      virtio_net: use dev_kfree_skb_any() in free_old_xmit_skbs()
      net: Fix IP_MULTICAST_IF
      net: Fix struct inet_timewait_sock bitfield annotation
      ifb: should not use __dev_get_by_index() without locks
      pktgen: Dont leak kernel memory
      net: fix kmemcheck annotations
      net: fix sk_forward_alloc corruption

Eric Paris (2):
      fsnotify: do not set group for a mark before it is on the i_list
      inotify: deprecate the inotify kernel interface

Eric Sandeen (2):
      fix readahead calculations in xfs_dir2_leaf_getdents()
      xfs: free temporary cursor in xfs_dialloc

Eric Van Hensbergen (1):
      9p: fix readdir corner cases

Felipe Contreras (2):
      kbuild: fix warning when domainname is not available
      kbuild: mkcompile_h: trivial cleanups

Felix Beck (2):
      [S390] zcrypt: Fix sparse warning.
      [S390] zcrypt: Improve some comments

Felix Fietkau (1):
      mac80211: fix logic error ibss merge bssid check

Feng Tang (1):
      x86: Make EFI RTC function depend on 32bit again

Florian Fainelli (6):
      MIPS: BCM63xx: Fix soft-reset lockup on BCM6345
      MIPS: AU1000: Fix build failure for db1x00 configured for Au1100 SoC
      MIPS: BCM63xx: Make bcm63xx_uart_register an initfunc
      MIPS: BCM63xx: Prepare for watchdog support
      MIPS: AR7: register watchdog device only if enabled in hw configurati=
on
      MIPS: bcm63xx: Set the correct BCM3302 CPU name

Frank Mori Hess (2):
      Staging: comedi: ni_pcimio: Added device id for pxi-6225.
      Staging: comedi: pcmcia irq fixes

Frans Pop (2):
      kbuild: fix the binrpm-pkg target to work with KBUILD_OUTPUT set
      pcmcia: properly close previous dev_printk if kzalloc fails in do_io_=
probe

Frederic Weisbecker (2):
      tracing: Check total refcount before releasing bufs in profile_enable=
 failure
      tracing: Use free_percpu instead of kfree

Frederik Deweerdt (1):
      KVM: MMU: fix pointer cast

Gabe Black (1):
      PCI quirk: TI XIO200a erroneously reports support for fast b2b transf=
ers

Gabor Gombas (1):
      net: Fix 'Re: PACKET_TX_RING: packet size is too long'

George Nassar (1):
      USB: rndis_host: debug info clobbered before it is logged

Gerald Schaefer (1):
      [S390] Add EX_TABLE for addressing exception in usercopy functions.

Gergely Imreh (1):
      USB: usbtmc: fix timeout increase

Giuseppe Cavallaro (1):
      net: add support for STMicroelectronics Ethernet controllers.

Graf Yang (1):
      Blackfin: fix missed cache config renames

Grant Likely (2):
      powerpc/5200: Update defconfigs
      MAINTAINERS: add Open Firmware / Flattened Device Tree entry

Greg Kroah-Hartman (11):
      Staging: comedi: serial2002: fix include build issue
      Staging: remove agnx driver
      Staging: remove cowloop driver
      Staging: comedi: fix build on arches that don't want comedi drivers
      Staging: comedi: fix sched.h build breakage
      Staging: b3dfg: fix sched.h build breakage
      Staging: poch: fix sched.h build breakage
      Staging: vme: fix sched.h build breakage
      Staging: remove stlc45xx driver
      Staging: android: mark subsystem as broken
      Staging: wireless drivers Kconfig change

Greg Ungerer (1):
      m68knommu: fix rename of pt_regs offset defines breakage

Guennadi Liakhovetski (2):
      fix compilation of i.MX31 platforms
      fix pcm037_eet compilation with the new SPI driver

Gwendal Grignou (1):
      sata_mv: Prevent PIO commands to be defered too long if traffic in pr=
ogress.

H Hartley Sweeten (1):
      Input: rotary_encoder - fix relative axis support

H. Peter Anvin (1):
      x86: fix kernel panic on 32 bits when profiling

Haavard Skinnemoen (1):
      atmel_serial: fix bad BUILD_BUG_ON() usage

Haiyang Zhang (1):
      Staging: hv: Fix null pointer error after vmbus loading

Hank Janssen (1):
      Staging: hv: Fix vmbus load hang caused by faulty data packing

Hannes Reinecke (1):
      [SCSI] Retry ADD_TO_MLQUEUE return value for EH commands

Harald Welte (1):
      ARM: S3C24XX: Introduce S3C2442B CPU

Hartley Sweeten (10):
      ARM: 5744/1: ep93xx: add remaining phys offset selections
      ARM: 5745/1: Change ep93xx gpio_irq static inlines to macros
      ARM: 5729/1: ep93xx: define EP93XX_*_PHYS_BASE with macros
      ARM: 5753/1: ep93xx: remove old EP93XX_GPIO_* defines
      ARM: 5754/1: ep93xx: update i2c support
      ARM: 5756/1: ep93xx: introduce clk parent
      ARM: 5760/1: ep93xx: fix build error in edb93xx.c
      ARM: 5767/1: ep93xx: remove ep93xx_init_time() prototype
      ARM: 5768/1: ep93xx: remove dead code in ep93xx_gpio_ab_irq_handler()
      ARM: 5769/1: CPU_ARM920T: remove dead Maverick EP9312 URL

Heiko Carstens (13):
      [S390] Enable kmemleak on s390.
      [S390] Provide arch specific mdelay implementation.
      [S390] compat: fix truncate system call wrapper
      [S390] ftrace: drop nmi protection
      [S390] perf_counter: fix vdso detection
      [S390] 64-bit register support for 31-bit processes
      [S390] call home support: fix proc handler
      [SCSI] zfcp: fix kfree handling in zfcp_init_device_setup
      [S390] smp: fix prefix handling of offlined cpus
      [S390] call home: fix error handling in init function
      [S390] call home: fix string length handling
      [S390] smp: fix sigp stop handling
      [S390] smp: fix sigp sense handling

Heiko Schocher (3):
      powerpc/pci: Fix MODPOST warning
      mpc5200: support for the MAN mpc5200 based board uc101
      mpc5200: support for the MAN mpc5200 based board mucmc52

Helge Deller (3):
      parisc: rename parisc's vmalloc_start to parisc_vmalloc_start
      parisc: Fix linker script breakage.
      agp: parisc-agp.c - use correct page_mask function

Herbert Xu (3):
      crypto: padlock-sha - Fix stack alignment
      tcp: Try to catch MSG_PEEK bug
      gre: Fix dev_addr clobbering for gretap

Herton Ronaldo Krzesinski (2):
      Input: atkbd - consolidate force release quirks for volume keys
      Staging: rtl8187se/rtl8192e/rtl8192su: allow module unload

HighPoint Linux Team (1):
      [SCSI] hptiop: Add RR44xx adapter support

Hiroshi DOYU (2):
      omap: iovmm: Fix incorrect spelling
      omap: iommu: fix wrong condition check for SUPERSECTION

Hiroshi Shimamoto (1):
      trace: Fix missing assignment in trace_ctxwake_*

Holger Schurig (1):
      libertas spi: fix sparse errors

Huang Weiyi (1):
      m68knommu: remove duplicated #include

Huang Ying (1):
      crypto: aesni-intel - Fix irq_fpu_usable usage

Huaxu Wan (1):
      hwmon: (coretemp) Maintainer update

Hubert Feurstein (3):
      ARM: 5749/1: ep93xx/micro9: Update maintainer
      ARM: 5750/1: ep93xx/micro9: Update platform code
      ARM: 5751/1: ep93xx/micro9: Add Micro9-Slim

Hugh Dickins (5):
      ksm: more on default values
      HWPOISON: fix oops on ksm pages
      HWPOISON: fix/proc/meminfo alignment
      hwpoison: fix oops on ksm pages
      hwpoison: fix/proc/meminfo alignment

Huzaifa Sidhpurwala (1):
      USB: option: Support for AIRPLUS MCD650 Datacard

Ian Abbott (9):
      Staging: comedi: Corrected type of a printk argument in resize_async_=
buffer().
      Staging: comedi: jr3_pci: Initialize transf variable fully in jr3_pci=
_poll_subdevice().
      Staging: comedi: cb_pcidio: fix "section mismatch" error
      Staging: comedi: s526: Fix number of channels on DIO subdevice
      Staging: comedi: s526: Get rid of global variable 'cmReg'.
      Staging: comedi: s526: Take account of arch's byte order.
      Staging: comedi: s526: fixes for pulse generator
      Staging: comedi: ni_65xx.c: fix insn_bits shift calculation.
      Staging: comedi: ni_65xx.c: fix output inversion problem.

Ian Campbell (1):
      Correct nr_processes() when CPUs have been unplugged

Ian E. Morgan (1):
      lis3: add support for the HP HDX 18

Ilkka Koskinen (1):
      mfd: Do not dereference null pointer in twl4030 error path

Imre Deak (1):
      ARM: 5742/1: ARM: add debug check for invalid kernel page faults

Ingo Molnar (9):
      x86: EDAC: MCE: Fix MCE decoding callback logic
      Revert "x86, timers: Check for pending timers after (device) interrup=
ts"
      perf tools: Fix the NO_64BIT build on pure 64-bit systems
      Merge branch 'urgent' of git://git.kernel.org/.../rric/oprofile into =
core/urgent
      headers: Fix build after <linux/sched.h> removal
      Merge branch 'linus' into x86/urgent
      Revert "x86: linker script syntax nits"
      x86: Document linker script ASSERT() quirk
      perf tools: Bump version to 0.0.2

Ira W. Snyder (1):
      edac: i5400 fix missing CONFIG_PCI define

Izik Eidus (3):
      KVM: MMU: dont hold pagecount reference for mapped sptes pages
      KVM: MMU: add SPTE_HOST_WRITEABLE flag to the shadow ptes
      KVM: add support for change_pte mmu notifiers

Jaidev Patwardhan (2):
      MIPS: GCMP: Avoid accessing registers when they are not present
      MIPS: SMTC: Avoid queing multiple reschedule IPIs

James Bottomley (2):
      parisc: add me to Maintainers
      [SCSI] fix memory leak in initialization

Jamie Lentin (1):
      Input: atkbd - add a quirk for OQO 01+ multimedia keys

Jan Beulich (4):
      x86: Don't leak 64-bit kernel register values to 32-bit processes
      iSCSI/iBFT: use proper address translation
      x86: Fix Suspend to RAM freeze on Acer Aspire 1511Lmi laptop
      x86-64: Fix register leak in 32-bit syscall audting

Jan Kara (1):
      ext3: Update documentation about ext3 quota mount options

Janusz Krzysztofik (5):
      omap: Fix omap-keypad by restoring old keypad.h without breaking omap=
2 boards that use matrix_keypad
      omap1: Fix redundant UARTs pin muxing that can break other hardware s=
upport
      omap1: Fix DSP public peripherals support for ams-delta
      netdev: usb: dm9601.c can drive a device not supported yet, add suppo=
rt for it
      ASoC: OMAP: Don't try to set unsupported OMAP_DMA_DATA_BURST_16 on OM=
AP1

Jarkko Nikula (1):
      omap: McBSP: Fix incorrect receiver stop in omap_mcbsp_stop

Jason Wessel (1):
      x86: earlyprintk: Fix regression to handle serial,ttySn as 1 arg

Jasper Spaans (1):
      bonding: Modify hash transmit policies to use the packet's source MAC=
 address

Jassi Brar (1):
      ASoC: S3C64XX I2S: Enable audio-bus clock

Jaswinder Singh Rajput (7):
      parisc: includecheck fix: signal.c
      x86, SLUB: Remove unused CONFIG FAST_CMPXCHG_LOCAL
      Blackfin: includecheck fix: mach-bf548, ezkit.c
      mm: includecheck fix: vmalloc.c
      fs: includecheck fix: proc, kcore.c
      video: includecheck fix: msm, mddi.c
      video: includecheck fix: da8xx-fb.c

Jay Sternberg (1):
      iwlwifi: incorrect method used for finding valid OTP blocks

Jayamohan Kallickal (3):
      [SCSI] be2iscsi: add 10Gbps iSCSI - BladeEngine 2 driver
      [SCSI] libiscsi: iscsi_session_setup to allow for private space
      [SCSI] be2iscsi: Moving to pci_pools v3

Jean Delvare (3):
      MAINTAINERS: Fix Riku Voipio's address
      hwmon: (dme1737) No vid attributes for SCH311x
      hwmon: (it87) Fix VID reading on IT8718F/IT8720F

Jeff Mahoney (6):
      Staging: winbond: implement prepare_multicast and fix API usage
      Staging: iio: Don't build on s390
      Staging: rtl8192e: Add #include <linux/vmalloc.h>
      staging: Complete sched.h removal from interrupt.h
      staging: more sched.h fixes
      hfs: fix oops on mount with corrupted btree extent records

Jeff Roberson (1):
      edac: i5400 fix csrow mapping

Jens Axboe (7):
      cfq-iosched: fix issue with rq-rq merging and fifo list ordering
      block: get rid of kblock_schedule_delayed_work()
      block: use proper BLK_RW_ASYNC in blk_queue_start_tag()
      cfq-iosched: abstract out the 'may this cfqq dispatch' logic
      cfq-iosched: fix the slice residual sign
      cfq-iosched: apply bool value where we return 0/1
      backing-dev: ensure that a removed bdi no longer has super_block refe=
rencing it

Jeremy Fitzhardinge (2):
      x86/paravirt: Use normal calling sequences for irq enable/disable
      xen: set up mmu_ops before trying to set any ptes

Jerome Glisse (14):
      drm/radeon/kms: Convert RS400/RS480 to new init path & fix legacy VGA=
 (V3)
      drm/radeon/kms: Convert R300 to new init path
      drm/radeon/kms: Convert R100 to new init path (V2)
      drm/radeon/kms: Convert RS690/RS740 to new init path (V2).
      drm/radeon/kms: Convert RS600 to new init path
      drm/radeon/kms: Remove old init path as no hw use it anymore
      drm/radeon/kms: Fix R600 write back buffer
      drm/radeon/kms: Fix R600/RV770 startup path & reset
      drm/radeon/kms: Fix R600/RV770 disable acceleration path
      drm/radeon/kms: R600/RV770 remove dead code and print message for wro=
ng BIOS
      drm/radeon/kms: Fix irq handling on AVIVO hw
      drm/radeon/kms: Fix RS600/RV515/R520/RS690 IRQ
      drm/radeon/kms: Fallback to non AGP when acceleration fails to initia=
lize (v2)
      drm/radeon/kms: Fix AGP support for R600/RV770 family (v2)

Jesse Barnes (2):
      ACPI button: don't try to use a non-existent lid device
      Revert "PCI: get larger bridge ranges when space is available"

Jing Huang (1):
      [SCSI] bfa: Brocade BFA FC SCSI driver

Jiri Bohac (1):
      bonding: fix a race condition in calls to slave MII ioctls

Jiri Kosina (4):
      HID: fix kerneldoc comment for hid_input_report()
      HID: fix possible deadlock in hidraw_read
      percpu: allow pcpu_alloc() to be called with IRQs off
      sched: move rq_weight data array out of .percpu

Jiri Olsa (4):
      tracing: Update *ppos instead of filp->f_pos
      tracing: Fix trace_seq_printf() return value
      tracing: Fix comment typo and documentation example
      tracing: Remove cpu arg from the rb_time_stamp() function

Jiri Pirko (1):
      netlink: fix typo in initialization

Jiri Slaby (6):
      ACPI: Kconfig, fix proc aggregator text
      USB: usblcd, fix memory leak
      x86: crash_dump: Fix non-pae kdump kernel memory accesses
      PM / Hibernate: Fix blkdev refleaks
      PM / Hibernate: Fix error handling in save_image()
      PM / Hibernate: Add newline to load_image() fail path

Joakim Tjernlund (1):
      i2c-mpc: Do not generate STOP after read.

Joe Perches (13):
      MAINTAINERS: update GENERIC UIO FOR PCI DEVICES
      MAINTAINERS: update TRACING section
      MAINTAINERS: update OMAP Tony Lindgren email name
      MAINTAINERS: change ATM mailing list to moderated
      MAINTAINERS: use tab not spaces after field types
      MAINTAINERS: update Kernel Janitors after mismerge
      MAINTAINERS: update SCORE architecture name style and add file pattern
      MAINTAINERS: SIMPLE FIRMWARE INTERFACE: update email style
      MAINTAINERS: WINBOND CIR - Integrate P:/M: lines, fixup David H=E4rde=
man's name
      MAINTAINERS: fix up PERIPHERAL spelling
      MAINTAINERS: update WOLFSON MICROELECTRONICS
      scripts/get_maintainer.pl: add patch/file search for keywords
      MAINTAINERS: document new "K:" entry type

Joerg Roedel (2):
      KVM: SVM: Fix tsc offset adjustment when running nested
      KVM: SVM: Handle tsc in svm_get_msr/svm_set_msr correctly

Johan Hovold (6):
      USB: ftdi_sio: remove tty->low_latency
      USB: ftdi_sio: remove unused rx_byte counter
      USB: ftdi_sio: clean up read completion handler
      USB: ftdi_sio: re-implement read processing
      USB: pl2303: fix error characters not being reported to ldisc
      USB: digi_acceleport: Fix broken unthrottle.

Johannes Berg (13):
      wext: let get_wireless_stats() sleep
      mac80211: fix vlan and optimise RX
      cfg80211: fix netns error unwinding bug
      mac80211: fix ibss race
      b43: fix ieee80211_rx() context
      mac80211: document ieee80211_rx() context requirement
      mac80211: keep auth state when assoc fails
      cfg80211: sme: deauthenticate on assoc failure
      mac80211: fix BSS leak
      mac80211: fix addba timer
      mac80211: fix reason code output endianness
      cfg80211: fix NULL ptr deref
      mac80211: check interface is down before type change

Johannes Weiner (2):
      ARM: boolean bit testing
      vmscan: order evictable rescue in LRU putback

John Bonesio (1):
      net/fec_mpc52xx: Fix kernel panic on FEC error

John Stultz (1):
      Blackfin: convert to use arch_gettimeoffset()

John W. Linville (1):
      rndis_host: support ETHTOOL_GPERMADDR

John(Jung-Ik) Lee (1):
      pata_atp867x: clarifications in timings calculations and cable detect=
ion

Jon Hunter (1):
      OMAP3: PM: Prevent hang in prcm_interrupt_handler

Jonathan Brassow (1):
      dm snapshot: free exception store on init failure

Jonathan Cameron (1):
      Staging: iio: Fix missing include <linux/sched.h>

Jonathan Corbet (1):
      Update flex_arrays.txt

Jonathan Woithe (1):
      fujitsu-laptop: address missed led-class ifdef fixup

Joris van Rantwijk (1):
      USB: Fix throttling in generic usbserial driver

Josef Bacik (5):
      Btrfs: fix possible softlockup in the allocator
      Btrfs: release delalloc reservations on extent item insertion
      Btrfs: async delalloc flushing under space pressure
      Btrfs: optimize fsync for the single writer case
      Btrfs: fix possible ENOSPC problems with truncate

JosephChan@via.com.tw (1):
      pata_via: extend the rev_max for VT6330

Josh Boyer (1):
      powerpc/booke: Fix xmon single step on PowerPC Book-E

Joyce Yu (1):
      niu: VLAN_ETH_HLEN should be used to make sure that the whole MAC hea=
der was copied to the head buffer in the Vlan packets case

Julia Lawall (6):
      parisc: correct use of SHF_ALLOC
      [ARM] pxa/csb726: adjust duplicate structure field initialization
      drivers/serial/mpc52xx_uart.c: Use UPIO_MEM rather than SERIAL_IO_MEM
      ARM: S3C24XX: arch/arm/plat-s3c24xx: Move dereference after NULL test
      ALSA: sound: Move dereference after NULL test and drop unnecessary NU=
LL tests
      ALSA: sound/parisc: Move dereference after NULL test

Julian Anastasov (3):
      tcp: accept socket after TCP_DEFER_ACCEPT period
      tcp: reduce SYN-ACK retrans for TCP_DEFER_ACCEPT
      tcp: fix TCP_DEFER_ACCEPT retrans calculation

Justin P. Mattock (1):
      ieee1394: update URLs in debugging-via-ohci1394.txt

J=E9r=F4me Pouiller (1):
      of: Remove nested function

KOSAKI Motohiro (6):
      elv_iosched_store(): fix strstrip() misuse
      congestion_wait(): don't use WRITE
      cgroup: fix strstrip() misuse
      strstrip(): mark as as must_check
      mbind(): fix leak of never putback pages
      do_mbind(): fix memory leak

Kalle Jokiniemi (1):
      OMAP: Fix race condition with autodeps

Kashyap, Desai (9):
      [SCSI] mpt2sas: Update driver to MPI2 REV K headers.
      [SCSI] mpt2sas: Added mpi2_history.txt for MPI2 headers.
      [SCSI] mpt2sas: Copyright change to 2009.
      [SCSI] mpt2sas: Added SCSIIO, Internal and high priority memory pools=
 to support multiple TM
      [SCSI] mpt2sas: Target Reset will be issued from Interrupt context.
      [SCSI] mpt2sas: Call init_completion on a per request basis.
      [SCSI] mpt2sas: Timeout occurred within the HANDSHAKE logic while wai=
ting on firmware to ACK.
      [SCSI] mpt2sas: Support dev remove when phy status is MPI2_EVENT_SAS_=
TOPO_PHYSTATUS_VACANT
      [SCSI] mpt2sas: Bump version 02.100.03.00

Keith Mannthey (2):
      amd64_edac: simple fix to allow reporting of CECC errors
      edac: i5100 fix initialization code

Ken Kawasaki (3):
      pcnet_cs: add cis of National Semicondoctor's multifunction pcmcia ca=
rd
      3c574_cs: spin_lock the set_multicast_list function
      pcnet_cs: add cis of PreMax PE-200 ethernet pcmcia card

Kenji Kaneshige (1):
      PCI: Prevent AER driver from being loaded on non-root port PCIE devic=
es

Kevin Cernekee (1):
      MIPS: Fix machine check exception in kmap_coherent()

Kevin Hilman (3):
      OMAP3: PM: Enable GPIO module-level wakeups
      omap3: PM: enable UART3 module wakeups
      cpuidle: always return with interrupts enabled

Kiyoshi Ueda (1):
      dm: dec_pending needs locking to save error value

Komuro (1):
      pcmcia: do not load the pd6729 driver if io_base is NULL

Krauth.Julien (1):
      serial: add ADDI-DATA GmbH PCI-Express communication cards in 8250_pc=
i.c and pci_ids.h

Krzysztof Halasa (1):
      WAN: fix Cisco HDLC handshaking.

Krzysztof Helt (1):
      ALSA: opl3: circular locking in the snd_opl3_note_on() and snd_opl3_n=
ote_off()

Kukjin Kim (1):
      ARM: S3C64XX: Fix S3C64XX_CLKDIV0_ARM_MASK value

Kumar Gala (7):
      powerpc: Add a Book-3E 64-bit defconfig
      powerpc: Fix compile errors found by new ppc64e_defconfig
      powerpc: Limit hugetlbfs support to PPC64 Book-3S machines
      powerpc: Limit memory hotplug support to PPC64 Book-3S machines
      powerpc: Minor cleanup to init/Kconfig
      powerpc: Minor cleanup to sound/ppc/Kconfig
      powerpc: Minor cleanup to lib/Kconfig.debug

Kuninori Morimoto (3):
      sh: mach-ecovec24: Add TouchScreen support
      sh: mach-ecovec24: modify 1st MTD area to read only
      sh: mach-ecovec24: Document DS2 switch settings.

Kyle McMartin (7):
      parisc: tracehook_report_syscall
      parisc: tracehook_signal_handler
      parisc: add missing TI_TASK macro in syscall.S
      parisc: split syscall_trace into two halves
      parisc: stop using task->ptrace for {single,block}step flags
      parisc: add skeleton syscall.h
      parisc: HAVE_ARCH_TRACEHOOK

Larry Finger (2):
      b43: Fix PPC crash in rfkill polling on unload
      b43: Fix Bugzilla #14181 and the bug from the previous 'fix'

Len Brown (4):
      Merge branch 'bugzilla-14129' into release
      Merge branch 'eeepc-laptop' into release
      Merge branch 'launchpad-333386' into release
      Merge branch 'misc' into release

Lennart Sorensen (1):
      m68knommu: show KiB rather than pages in "Freeing initrd memory:" mes=
sage

Leo Chen (2):
      ARM: 5748/1: bcmring: fix build warning messages
      ARM: 5764/1: bcmring: add oprofile pmu support

Li Hong (1):
      x86, perf_event: Rename 'performance counter interrupt'

Li Zefan (1):
      tracing/filters: Fix memory leak when setting a filter

Linus Torvalds (148):
      x86: Optimize cmpxchg64() at build-time some more
      Merge branch 'for-linus' of git://git.kernel.org/.../gerg/m68knommu
      Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/.../tip/li=
nux-2.6-tip
      Merge branch 'tracing-fixes-for-linus' of git://git.kernel.org/.../ti=
p/linux-2.6-tip
      Merge branch 'timers-fixes-for-linus' of git://git.kernel.org/.../tip=
/linux-2.6-tip
      Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge git://git.kernel.org/.../davem/sparc-2.6
      Merge branch 'fixes-for-linus' of git://git.monstr.eu/linux-2.6-micro=
blaze
      Merge branch 'kvm-updates/2.6.32' of git://git.kernel.org/pub/scm/vir=
t/kvm/kvm
      Merge git://git.kernel.org/.../davem/ide-2.6
      Merge branch 'fixes' of git://git.kernel.org/.../kyle/parisc-2.6
      Merge git://git.kernel.org/.../davem/ide-2.6
      Merge git://git.kernel.org/.../davem/net-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../bp/bp
      Merge branch 'omap-fixes-for-linus' of git://git.kernel.org/.../tmlin=
d/linux-omap-2.6
      Merge branch 'drm-linus' of git://git.kernel.org/.../airlied/drm-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6
      Merge branch 'timers-fixes-for-linus' of git://git.kernel.org/.../tip=
/linux-2.6-tip
      Merge branch 'perf-fixes-for-linus-2' of git://git.kernel.org/.../tip=
/linux-2.6-tip
      Merge branch 'sparc-perf-events-fixes-for-linus' of git://git.kernel.=
org/.../tip/linux-2.6-tip
      Merge branch 'tracing-fixes-for-linus' of git://git.kernel.org/.../ti=
p/linux-2.6-tip
      Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/.../tip/li=
nux-2.6-tip
      Merge branch 'sched-fixes-for-linus' of git://git.kernel.org/.../tip/=
linux-2.6-tip
      Merge branch 'core-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge branch 'upstream-linus' of git://git.kernel.org/.../jgarzik/lib=
ata-dev
      Merge branch 'bugfixes' of git://git.linux-nfs.org/projects/trondmy/n=
fs-2.6
      Merge branch 'drm-intel-next' of git://git.kernel.org/.../anholt/drm-=
intel
      Merge branch 'sh/for-2.6.32' of git://git.kernel.org/.../lethal/sh-2.6
      Merge branch 'upstream-linus' of git://git.kernel.org/.../jgarzik/lib=
ata-dev
      Merge branch 'for-linus' of git://oss.sgi.com/xfs/xfs
      Merge branch 'for-linus' of git://git.kernel.org/.../ecryptfs/ecryptf=
s-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../jmorris/security=
-testing-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../vapier/blackfin
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge branch 'for-linus' of git://git.kernel.org/.../roland/infiniband
      Merge git://git.kernel.org/.../jejb/scsi-rc-fixes-2.6
      Merge git://git.kernel.org/.../mason/btrfs-unstable
      Merge branch 'hwmon-for-linus' of git://git.kernel.org/.../jdelvare/s=
taging
      Merge git://git.kernel.org/.../gregkh/staging-2.6
      Merge git://git.kernel.org/.../gregkh/usb-2.6
      Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6
      Linux 2.6.32-rc4
      Revert "USB: Work around BIOS bugs by quiescing USB controllers earli=
er"
      tty, serial: Fix race and NULL check in uart_close()
      Merge master.kernel.org:/home/rmk/linux-2.6-arm
      Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6
      Merge git://git.infradead.org/~dwmw2/iommu-2.6.32
      Merge branch 'for-linus' of git://git.kernel.org/.../sameo/mfd-2.6
      Merge branch 'for_linus' of git://git.kernel.org/.../jack/linux-fs-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../jikos/hid
      Merge git://git.kernel.org/.../sam/kbuild-fixes
      Merge branch 'for-linus' of git://git.kernel.org/.../tj/percpu
      Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block
      Make flush_to_ldisc properly handle parallel calls
      workqueue: add 'flush_delayed_work()' to run and wait for delayed work
      tty: use the new 'flush_delayed_work()' helper to do ldisc flush
      tty: Make flush_to_ldisc() locking more robust
      workqueue: add 'flush_delayed_work()' to run and wait for delayed work
      tty: use the new 'flush_delayed_work()' helper to do ldisc flush
      Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/.../tip/li=
nux-2.6-tip
      Merge branch 'tracing-fixes-for-linus' of git://git.kernel.org/.../ti=
p/linux-2.6-tip
      Merge branch 'sched-fixes-for-linus' of git://git.kernel.org/.../tip/=
linux-2.6-tip
      Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge branch 'core-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge branch 'sh/for-2.6.32' of git://git.kernel.org/.../lethal/sh-2.6
      Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6
      Merge git://git.kernel.org/.../davem/sparc-2.6
      Merge branch 'topic/x86-lds-nits' of git://git.kernel.org/.../frob/li=
nux-2.6-roland
      Merge branch 'tty-fixes'
      Merge branch 'for-linus' of git://git.kernel.org/.../ieee1394/linux13=
94-2.6
      Merge the right tty-fixes branch
      Merge git://git.kernel.org/.../davem/net-2.6
      Merge git://git.kernel.org/.../gregkh/staging-2.6
      Merge git://git.kernel.org/.../gregkh/usb-2.6
      Merge git://git.kernel.org/.../gregkh/driver-core-2.6
      Merge git://git.kernel.org/.../gregkh/tty-2.6
      Merge branch 'master' of git://git.kernel.org/.../mason/btrfs-unstable
      Merge branch 'omap-fixes-for-linus' of git://git.kernel.org/.../tmlin=
d/linux-omap-2.6
      Merge branch 'release' of git://git.kernel.org/.../lenb/linux-acpi-2.6
      Merge branch 'merge' of git://git.kernel.org/.../benh/powerpc
      Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/.../tip/li=
nux-2.6-tip
      Merge branch 'for-linus' of git://git.kernel.org/.../teigland/dlm
      Merge branch 'docs-next' of git://git.lwn.net/linux-2.6
      Linux 2.6.32-rc5
      Merge branch 'upstream-linus' of git://git.kernel.org/.../jgarzik/lib=
ata-dev
      Merge branch 'for-linus' of git://git.kernel.org/.../bp/bp
      Merge git://git.kernel.org/.../herbert/crypto-2.6
      Merge branch 'sh/for-2.6.32' of git://git.kernel.org/.../lethal/sh-2.6
      Merge git://git.kernel.org/.../agk/linux-2.6-dm
      Merge branch 'kvm-updates/2.6.32' of git://git.kernel.org/pub/scm/vir=
t/kvm/kvm
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge branch 'for-linus' of git://git.infradead.org/users/eparis/noti=
fy
      Merge git://git.kernel.org/.../davem/net-2.6
      Merge git://git.kernel.org/.../rusty/linux-2.6-for-linus
      Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/.../tip/li=
nux-2.6-tip
      Merge branch 'sched-fixes-for-linus' of git://git.kernel.org/.../tip/=
linux-2.6-tip
      Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge branch 'core-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge master.kernel.org:/home/rmk/linux-2.6-arm
      Merge branch 'urgent-v2' of git://git.kernel.org/.../brodo/pcmcia-2.6
      Merge branch 'hwmon-for-linus' of git://git.kernel.org/.../jdelvare/s=
taging
      Merge branch 'for-linus' of git://git.infradead.org/ubi-2.6
      Merge branch 'omap-fixes-for-linus' of git://git.kernel.org/.../tmlin=
d/linux-omap-2.6
      Merge branch 'for-linus' of git://oss.sgi.com/xfs/xfs
      Merge branch 'hwpoison-2.6.32' of git://git.kernel.org/.../ak/linux-m=
ce-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../sameo/mfd-2.6
      Merge branch 'merge' of git://git.kernel.org/.../benh/powerpc
      Merge git://git.kernel.org/.../sfrench/cifs-2.6
      Merge branch 'bugfixes' of git://git.linux-nfs.org/projects/trondmy/n=
fs-2.6
      Merge branch 'sh/for-2.6.32' of git://git.kernel.org/.../lethal/sh-2.6
      Merge branch 'drm-fixes' of git://git.kernel.org/.../airlied/drm-2.6
      Merge git://git.kernel.org/.../jejb/scsi-rc-fixes-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../roland/infiniband
      Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6
      Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block
      Merge git://git.kernel.org/.../rusty/linux-2.6-for-linus
      Merge git://git.kernel.org/.../rusty/linux-2.6-param-fixes
      Merge branch 'for-linus' of git://git.kernel.org/.../tj/percpu
      Merge git://git.kernel.org/.../davem/net-2.6
      Merge git://git.kernel.org/.../davem/ide-2.6
      Merge branch 'bugfix' of git://git.kernel.org/.../jeremy/xen
      Merge branch 'for-linus' of git://neil.brown.name/md
      Merge branch 'for-linus' of git://git.kernel.org/pub/scm/fs/xfs/xfs
      Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6
      Merge git://git.kernel.org/.../gregkh/driver-core-2.6
      Merge git://git.kernel.org/.../gregkh/tty-2.6
      Merge git://git.kernel.org/.../gregkh/usb-2.6
      Merge git://git.kernel.org/.../gregkh/staging-2.6
      i915: fix intel graphics suspend breakage due to resume/lid event con=
fusion
      Merge branch 'x86-fixes-for-linus' of git://git.kernel.org/.../tip/li=
nux-2.6-tip
      Merge branch 'tracing-fixes-for-linus' of git://git.kernel.org/.../ti=
p/linux-2.6-tip
      Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge branch 'core-fixes-for-linus' of git://git.kernel.org/.../tip/l=
inux-2.6-tip
      Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6
      Merge branch 'for-linus' of master.kernel.org:/home/rmk/linux-2.6-arm
      Revert "ext4: Remove journal_checksum mount option and enable it by d=
efault"
      Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../ericvh/v9fs
      Merge git://git.kernel.org/.../davem/net-2.6
      Merge branch 'for-linus' of git://git.kernel.org/.../ryusuke/nilfs2
      Merge branch 'i2c-fixes' of git://git.fluff.org/bjdooks/linux
      Merge branch 'fixes-s3c-2632-rc5' of git://git.fluff.org/bjdooks/linux
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge branch 'pm-fixes' of git://git.kernel.org/.../rafael/suspend-2.6
      Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-=
linus
      Merge branch 'for-linus' of git://github.com/at91linux/linux-2.6-at91
      Linux 2.6.32-rc6

Linus Walleij (1):
      ARM: 5765/1: Updated U300 defconfig

Lubomir Rintel (2):
      sh: Build fix: export __movmem
      sh: Build fix: define more __movmem* symbols

Luca Tettamanti (2):
      hwmon: (asus_atk0110) Refactor the code
      hwmon: (asus_atk0110) Enable the EC

Luis R. Rodriguez (1):
      ath9k: fix misplaced semicolon on rate control

Magnus Damm (5):
      usb: r8a66597-udc unaligned fifo fix
      sh: enable sleep state LEDs on Ecovec24
      sh: disabled cache handling fix.
      sh: rsk7203 CONFIG_MTD=3Dn fix
      sh: add uImage.bin target

Manuel Lauss (2):
      net: au1000_eth: add missing capability.h
      MIPS: Alchemy: Fix hang with high-frequency edge interrupts

Marcelo Tosatti (2):
      KVM: VMX: flush TLB with INVEPT on cpu migration
      KVM: use proper hrtimer function to retrieve expiration time

Marcin Slusarz (2):
      ide: use printk_once
      [IA64] use printk_once() unaligned.c/io_common.c

Marin Mitov (1):
      x86, pci: Correct spelling in a comment

Mark Brown (7):
      hwmon: (s3c-hwmon) Disable build for S3C64xx
      ARM: S3C64XX: Set rate of crystal mux
      mfd: Always initialise WM831x IRQ mutex
      ASoC: Staticise wm8727 driver structure
      ASoC: Move sysfs and debugfs functions to head of soc-core.c
      ASoC: Factor out snd_soc_init_card()
      Merge branch 'for-2.6.32' into for-2.6.33

Mark Hills (3):
      ALSA: snd-usb-caiaq: Missing lock around use of buffer positions
      ALSA: snd-usb-caiaq: Lock on stream start/unpause
      ALSA: snd-usb-caiaq: Bump version number to 1.3.20

Mark Langsdorf (1):
      ACPI: add AC/DC notifier

Mark McLoughlin (1):
      block: silently error unsupported empty barriers too

Markus Trippelsdorf (1):
      ahci: Add ifdef wrapper to ahci_gtf_filter_workaround

Marti Raudsepp (1):
      perf tools: Fix compatibility with libelf 0.8 and autodetect

Martin K. Petersen (5):
      [SCSI] Deprecate SCSI_PROT_*_CONVERT operations
      [SCSI] sd: Detach DIF from block integrity infrastructure
      [SCSI] Fix protection scsi_data_buffer leak
      [SCSI] sd: Support disks formatted with DIF Type 2
      [SCSI] scsi_debug: Implement support for DIF Type 2

Martin Schwidefsky (4):
      [S390] fix build breakage with CONFIG_AIO=3Dn
      [S390] pm: ignore time spend in suspended state
      [S390] s/r: cmm resume fix
      [S390] cputime: fix overflow on 31 bit systems

Martin Stava (2):
      9p: fix a small bug in readdir for long directories
      9p: fix readlink

Matt Carlson (1):
      tg3: Fix phylib locking strategy

Matt Fleming (7):
      sh: Don't enable interrupts in the page fault path
      tracing: Fix infinite recursion in ftrace_update_pid_func()
      sh: Sprinkle __uses_jump_to_uncached
      sh: Plug PMB alloc memory leak
      sh: Try PMB mapping based on physical address, not mapping size
      sh: Don't allocate smaller sized mappings on every iteration
      sh: Check for return_to_handler when unwinding the stack

Matthew Wilcox (1):
      [IA64] Require SAL 3.2 in order to do extended config space ops

Michael Buesch (3):
      b43: Don't use struct wldev after detach.
      b43: Protect sanity check against physical device removal
      b43: Fix DMA TX bounce buffer copying

Michael Chan (1):
      cnic: Fix L2CTX_STATUSB_NUM offset in context memory.

Michael Ellerman (1):
      powerpc: Fix memory leak in axon_msi.c

Michael Ernst (1):
      [S390] cio: channel path memory leak

Michael Hennerich (3):
      Input: ad7879 - pass up error codes from probe functions
      Blackfin: convert adv7393 resources to new i2c framework
      Blackfin: convert to GENERIC_HARDIRQS_NO__DO_IRQ

Michael Holzheu (4):
      [S390] hibernate: Use correct place for CPU address in lowcore
      [S390] hypfs: Use subcode 6 if subcode 7 is not available
      [S390] tape390: Fix request queue handling in block driver
      [S390] sclp_vt220 build fix

Michael Neuling (1):
      powerpc/perf_events: Fix priority of MSR HV vs PR bits

Michael S. Tsirkin (3):
      virtio-net: fix data corruption with OOM
      virtio-pci: fix per-vq MSI-X request logic
      virtio: order used ring after used index read

Michal Ostrowski (1):
      PPPoE: Fix flush/close races.

Michal Simek (2):
      microblaze: UMS is used only for MMU kernel
      microblaze: Clear sticky FSR register after saving it to func parametr

Miguel Boton (1):
      b43: add 'struct b43_wl' missing declaration

Mike Frysinger (9):
      Blackfin: asm/irq.h: pull in mach/anomaly.h for anomaly defines
      Blackfin: cplbinfo: drop d_path() hacks
      Blackfin: bf533-ezkit: convert to physmap/jedec_probe
      Blackfin: drop cs_change_per_word setting
      Blackfin: drop all simple-gpio board resources
      USB: musb: make HAVE_CLK support optional
      USB: isp1362: fix build warnings on 64-bit systems
      USB: musb: invert arch depend string
      twl4030-gpio: remove __devexit markings from remove func

Mike Galbraith (1):
      sched: Update the clock of runqueue select_task_rq() selected

Mike Rapoport (1):
      [ARM] pxa/cm-x300: fix mmc numbering

Mikulas Patocka (7):
      dm snapshot: sort by chunk size to fix race
      dm snapshot: require non zero chunk size by end of ctr
      dm exception store: fix failed set_chunk_size error path
      dm snapshot: lock snapshot while supplying status
      dm snapshot: use unsigned integer chunk size
      dm snapshot: allow chunk size to be less than page size
      ide: Serialize CMD643 and CMD646 to fix a hardware bug with SSD

Milan Dadok (3):
      Staging: hv: fix oops in vmbus - udev events
      Staging: hv: fix oops in vmbus - netvsc list_head
      Staging: hv: fix oops in vmbus - missing #include

Mimi Zohar (1):
      ima: ecryptfs fix imbalance message

Moger, Babu (1):
      [SCSI] scsi_dh_rdac: Fix for returning correct mode select cmd return=
 info

Mulyadi Santosa (1):
      perf tools: Run generate-cmdlist.sh properly

Neil Brown (2):
      sysfs: Allow sysfs_notify_dirent to be called from interrupt context.
      block: use after free bug in __blkdev_get

Neil Horman (2):
      add maintainer for network drop monitor kernel service
      AF_RAW: Augment raw_send_hdrinc to expand skb to fit iphdr->ihl (v2)

NeilBrown (8):
      Revert "md: do not progress the resync process if the stripe was bloc=
ked"
      md/raid1/raid10: add a cond_resched
      md: raid1/raid10: handle allocation errors during array setup.
      md: remove clumsy usage of do_sync_mapping_range from bitmap code
      md: fix problems with RAID6 calculations for DDF.
      md: Fix handling of raid5 array which is being reshaped to fewer devi=
ces.
      md/async: don't pass a memory pointer as a page pointer.
      raid6/async_tx: handle holes in block list in async_syndrome_val

Nick Cheng (1):
      [SCSI] mvsas: Support Areca SAS/SATA HBA, ARC-1300/1320

Nicolas Ferre (2):
      avr32: add two new at91 to cpu.h definition
      at91: at91sam9g45 family: identify several chip versions

Nigel Stephens (1):
      MIPS: Fix abs.[sd] and neg.[sd] emulation for NaN operands

Nikanth Karthikesan (1):
      block: Seperate read and write statistics of in_flight requests v2

Nitin Gupta (1):
      ARM: force dcache flush if dcache_dirty bit set

Nobuhiro Iwamatsu (1):
      sh_eth: Add asm/cacheflush.h

OGAWA Hirofumi (1):
      dpt_i2o: Fix typo of EINVAL

Oliver Neukum (7):
      USB: visor: fix trivial accounting bug in visor driver
      USB: small fix in error case of suspend in generic usbserial code
      USB: serial: fix race between unthrottle and completion handler in op=
ticon
      USB: serial: fix race between unthrottle and completion handler in sy=
mbolserial
      USB: serial: fix assumption that throttle/unthrottle cannot sleep
      USB: serial: fix race between unthrottle and completion handler in vi=
sor
      USB: serial: no unnecessary GFP_ATOMIC in oti6858

Paul E. McKenney (13):
      rcu: Clean up code based on review feedback from Josh Triplett
      rcu: Clean up code based on review feedback from Josh Triplett, part 2
      rcu: Clean up code to address Ingo's checkpatch feedback
      rcu: Fix rcu_lock_map build failure on CONFIG_PROVE_LOCKING=3Dy
      rcu: Clean up code based on review feedback from Josh Triplett, part 3
      rcu: Clean up code based on review feedback from Josh Triplett, part 4
      rcu: Replace the rcu_barrier enum with pointer to call_rcu*() function
      rcu: Move rcu_barrier() to rcutree
      rcu: Make hot-unplugged CPU relinquish its own RCU callbacks
      rcu: Place root rcu_node structure in separate lockdep class
      rcu: Prevent RCU IPI storms in presence of high call_rcu() load
      rcu: Stopgap fix for synchronize_rcu_expedited() for TREE_PREEMPT_RCU
      rcu: Fix TREE_PREEMPT_RCU CPU_HOTPLUG bad-luck hang

Paul Mackerras (1):
      perf_event: Adjust frequency and unthrottle for non-group-leader even=
ts

Paul Menage (1):
      cgroups: update documentation of cgroups tasks and procs files

Paul Mundt (18):
      sh: Handle ioport_map() cases for >=3D P1SEG addresses.
      sh: Set the default I/O port base to P2SEG.
      sh: magicpanelr2 and dreamcast can use the generic I/O base.
      sh: Disable unaligned kernel access printks by default.
      kmemtrace: Fix up tracer registration
      sh: update die() output.
      sh: force dcache flush if dcache_dirty bit set.
      sh: ftrace: Fix up syscall tracepoint support.
      sh: Use boot_cpu_data for FPU tests in sigcontext paths.
      sh: Tidy up SMP cpuinfo.
      sh: Populate initial secondary CPU info from boot_cpu_data.
      sh: Optimize the setup_rt_frame() I-cache flush.
      sh: Fix a TRACE_IRQS_OFF typo.
      sh: Kill off stray HAVE_FTRACE_SYSCALLS reference.
      sh: __irq_entry annotate do_IRQ().
      perf tools: Remove -Wcast-align
      sh: Document uImage.bin target in archhelp.
      sh: Fix hugetlbfs dependencies for SH-3 && MMU configurations.

Paul Walmsley (3):
      OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
      OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts
      OMAP2xxx clock: set up clockdomain pointer in struct clk

Pavel Herrmann (1):
      lis3: better support for hp 6730x

Pavel Hofman (1):
      ALSA: ICE1712/24 - Change the Multi Track Peak control (level meters)=
 from MIXER to PCM type

Pavel Machek (1):
      PM: Remove some debug messages producing too much noise

Pekka Enberg (1):
      Staging: w35und: Fix ->beacon_int breakage

Peter Huewe (2):
      HID: add __init/__exit macros to twinhan.c
      Staging: Panel: prevent driver from calling misc_deregister twice on =
same ressource

Peter Magdina (1):
      USB: option: Toshiba G450 device id

Peter Oberparleiter (4):
      [S390] cio: make disconnected handling consistent
      [S390] cio: make not operational handling consistent
      [S390] cio: allow setting boxed devices offline
      [S390] cio: change misleading console logic

Peter Williams (1):
      sched: Set correct normal_prio and prio values in sched_fork()

Peter Zijlstra (5):
      perf_event: Provide vmalloc() based mmap() backing
      futex: Nullify robust lists after cleanup
      lockdep: Use cpu_clock() for lockstat
      sched: Disable SD_PREFER_LOCAL for MC/CPU domains
      sched: Do less agressive buddy clearing

Philby John (2):
      ALSA: aaci: ARM1176 aaci-pl041 AC97 register read timeout
      ARM: 5774/1: Fix Realview ARM1176PB board reboot

Rafael J. Wysocki (4):
      PCI PM: Read device power state from register after updating it
      ACPI / PCI: Fix NULL pointer dereference in acpi_get_pci_dev() (rev. =
2)
      PM: Make warning in suspend_test_finish() less likely to happen
      PM / yenta: Split resume into early and late parts (rev. 4)

Raimonds Cicans (1):
      r8169: Fix card drop incoming VLAN tagged MTU byte large jumbo frames

Rajendra Nayak (1):
      omap: Lock DPLL5 at boot

Rajiv Andrade (1):
      TPM: fix pcrread

Rakib Mullick (2):
      hwmon: (sht15) Fix spurious section mismatch warning
      eeepc-laptop: Properly annote eeepc_enable_camera().

Ralf Baechle (12):
      IRQ: Change __softirq_pending to unsigned int in asm-generic/hardirq.=
h.
      MIPS: Extend COMMAND_LINE_SIZE
      MIPS: Don't write ones to reserved entryhi bits.
      MIPS: Cleanup CONFIG_DEBUG_STACK_USAGE version of alloc_thread_info.
      MIPS: IP27: Fix build
      MIPS: VPE: Remove stray unlock_kernel.
      MIPS: MTX-1: Fix build if CONFIG_PCI is disabled.
      MIPS: Kconfig: Fix duplicate default value for MIPS_L1_CACHE_SHIFT.
      MIPS: Malta: Enable PCI 2.1 compatibility in PIIX4
      MIPS: 1004K: Enable SPRAM support.
      MIPS: Set S-cache linesize to 64-bytes for MTI's S-cache
      MIPS: Avoid potential hazard on Context register

Ralf Roesch (1):
      MIPS: TXx9: Fix error handling / Fix for noenexisting gpio_remove.

Ramax Lo (1):
      ARM: S3C24XX: Define a macro to avoid compilation error

Randy Dunlap (13):
      [SCSI] scsi_transport_fc: fix missing kernel-doc
      PCI: pci.c: fix kernel-doc notation
      ecryptfs: depends on CRYPTO
      blk-settings: fix function parameter kernel-doc notation
      perf tools: Fix const char type propagation
      sched: Fix missing kernel-doc notation
      net: ks8851_mll uses mii interfaces
      vmxnet: fix 2 build problems
      [IA64] fix percpu warnings
      vmxnet3: use dev_dbg, fix build for CONFIG_BLOCK=3Dn
      pcmcia: fix controller printk format warnings
      cpufreq: add cpufreq_get() stub for CONFIG_CPU_FREQ=3Dn
      Staging: fix wireless drivers depends

Reinette Chatre (3):
      iwlwifi: fix compile warning
      iwlagn: fix compile warning in iwl5000_gain_computation
      mac80211: fix ibss joining

Richard Zhao (3):
      i2c: imx: check busy bit when START/STOP
      i2c: imx: only imx1 needs disable delay
      i2c: imx: disable clock when it's possible to save power.

Robert Hancock (3):
      ahci: display all AHCI 1.3 HBA capability flags (v2)
      ALSA: ice1724: increase SPDIF and independent stereo buffer sizes
      ALSA: ice1724: Fix surround on Chaintech AV-710

Robert Noland (1):
      drm/r600: avoid assigning vb twice in blit code

Robert Richter (1):
      oprofile: warn on freeing event buffer too early

Robin Getz (1):
      Blackfin: mass clean up of copyright/licensing info

Robin Holt (3):
      x86, UV: Fix information in __uv_hub_info structure
      x86, UV: Fix and clean up bau code to use uv_gpa_to_pnode()
      x86, UV: Set DELIVERY_MODE=3D4 for vector=3DNMI_VECTOR in uv_hub_send=
_ipi()

Roel Kluin (10):
      drm/radeon: Fix setting of bits
      netxen: Fix Unlikely(x) > y
      mac80211: fix ADM8211_SYNCTL_RFtype define
      mac80211: use kfree_skb() to free struct sk_buff pointers
      [IA64] unsigned cannot be less than 0 in sn_hwperf_ioctl()
      Input: hp_sdc_rtc - fix test in hp_sdc_rtc_read_rt()
      UBI: fix check on unsigned long
      hwmon: (fschmd) Fix check on unsigned in watchdog_write()
      airo: Reorder tests, check bounds before element
      frv: fix check on unsigned in do_signal()

Roger Quadros (2):
      mfd: Fix twl4030 boot with twl4030 usb transceiver enabled
      omap_hsmmc: add missing probe handler hook

Roland Dreier (5):
      intel-iommu: Make "Unknown DMAR structure" message more informative
      intel-iommu: Decode (and ignore) RHSA entries
      hrtimer: Remove overly verbose "switch to high res mode" message
      Merge branches 'cxgb3', 'misc' and 'mlx4' into for-next
      x86: Don't print number of MCE banks for every CPU

Roland McGrath (1):
      x86: linker script syntax nits

Romit Dasgupta (1):
      PM: Fix warning on suspend errors

Ron Mercer (12):
      qlge: Fix some bit definitions for reset register.
      qlge: Fix queueing of firmware handler in ISR.
      qlge: Fix lock/mutex warnings.
      qlge: Fix RSS hashing values.
      qlge: Fix frame routing issue related to bonding.
      qlge: Fix frame routing for multicast frames.
      qlge: Fix RX multicast filter settings.
      qlge: Fix chip reset process.
      qlge: Restore rx mode after internal reset.
      qlge: Add disable/enable firmare irqs to handler.
      qlge: Fix EEH handling.
      qlge: Fix firmware mailbox command timeout.

Ronnie Furuskog (1):
      USB: option: Patch for Huawei Mobile Broadband E270+ Modem

Russell King (15):
      ARM: Dump memory and backtrace as one printk per line
      ARM: Dump code/mem oops lines with the appropriate log level
      ARM: update die() output
      ARM: Add kmap_atomic type debugging
      Merge branch 'fix' of git://git.kernel.org/.../ycmiao/pxa-linux-2.6
      Merge branch 'for-rmk-rc' of git://git.pengutronix.de/git/imx/linux-2=
.6
      Merge branch 'fix' of git://git.kernel.org/.../ycmiao/pxa-linux-2.6
      ARM: Fix lubbock defconfig build
      ARM: Fix signal restart issues with NX and OABI compat
      ARM: integrator: allow Integrator to be built with highmem
      ARM: Use GFP_DMA only for masks _less_ than 32-bit
      mm: fix sparsemem configuration
      ARM: Fix sparsemem with SPARSEMEM_EXTREME enabled
      ARM: Fix errata 411920 workarounds
      ARM: ensure initial page tables are setup for SMP systems

Rusty Russell (5):
      virtio_blk: Revert serial number support
      x86: Side-step lguest problem by only building cmpxchg8b_emu for pre-=
Pentium
      param: fix lots of bugs with writing charp params from sysfs, by leak=
ing mem.
      param: fix NULL comparison on oom
      param: fix setting arrays of bool

Ryan Mallon (1):
      ARM: S3C: Fix adc function exports

Ryota Yamauchi (1):
      xfs: fix xfs_quota remove error

Ryusuke Konishi (3):
      nilfs2: fix dirty page accounting leak causing hang at write
      nilfs2: fix irregular checkpoint creation due to data flush
      nilfs2: add zero-fill for new btree node buffers

Sam Ravnborg (1):
      kbuild: revert "save ARCH & CROSS_COMPILE ..."

Samu Onkalo (1):
      lis3lv02d_spi: module unload didn't remove sysfs entry

Samuel Thibault (1):
      x86: Fix csum_ipv6_magic asm memory clobber

Sanjeev Premi (1):
      omap: CONFIG_ISP1301_OMAP redefined in Beagle defconfig

Santosh Shilimkar (4):
      ARM: 5763/1: ARM: SMP: Fix the BUG with CONFIG_PREEMPT enabled
      omap: SDMA: Fix omap_stop_dma() API for channel linking
      omap4: Allow omap_serial_early_init() for OMAP4430 board
      omap4: Fix UART4 platform data on omap4

Sarah Sharp (6):
      USB: xhci: Stop debugging polling loop when HC dies.
      USB: xhci: Handle canceled URBs when HC dies.
      USB: xhci: Don't wait for a disable slot cmd when HC dies.
      USB: xhci: Fix dropping endpoints from the xHC schedule.
      USB: ehci: Fix isoc scheduling boundary checking.
      USB: ehci: Fix IST boundary checking interval math.

Sascha Hauer (6):
      i.MX27 clock: rename spi clocks to match device
      mx25 devices: Add missing include
      mx25pdk: remove nand support as it is not present in current tree
      mx25: Add missing copyright / license header
      pcm038: Add SPI/MC13783 support
      pcm970 mmc: Fix ro switch

Sathya Perla (2):
      be2net: fix promiscuous and multicast promiscuous modes being enabled=
 always
      be2net: fix support for PCI hot plug

Sean MacLennan (1):
      powerpc: warning: allocated section `.data_nosave' not in segment

Sebastian Frei (1):
      Input: wistron_btns - add DMI entry for Medion WIM2030 laptop

Sebastian Ott (2):
      [S390] 3270 console build fix
      [S390] call home: fix local buffer usage in proc handler

Serge E. Hallyn (1):
      Staging: p9auth: a few fixes

Sergey Pinaev (1):
      USB: storage: iRiver P7 UNUSUAL_DEV patch

Sergio Aguirre (1):
      omapfb: Condition mutex acquisition

Shane Huang (1):
      ahci / atiixp / pci quirks: rename AMD SB900 into Hudson-2

Shreyas Bhatewara (1):
      net: VMware virtual Ethernet NIC driver: vmxnet3

Simon Wunderlich (1):
      r8169: fix Ethernet Hangup for RTL8110SC rev d

Soeren Sandmann (2):
      perf events: Fix swevent hrtimer sampling by keeping track of remaini=
ng time when enabling/disabling swevent hrtimers
      perf events: Don't generate events for the idle task when exclude_idl=
e is set

Srinidhi Kasagar (1):
      ARM: 5741/1: pl022: fix peripheral id for ST vendor

Sriram (1):
      TI DaVinci EMAC: Clear statistics register properly.

Stanislav Brabec (1):
      [ARM] pxa/spitz: add gpio button support (fixes regression)

Stas Sergeev (2):
      ALSA: pcsp - Fix nforce workaround
      Driver core: fix driver_register() return value

Stefan Bader (1):
      ACPI: video: Loosen strictness of video bus detection code

Stefan Haberland (3):
      [S390] dasd: fix race condition in resume code
      [S390] dasd: fix locking bug
      [S390] dasd: use idal for device characteristics

Stefan Richter (3):
      ieee1394: add documentation entry to MAINTAINERS
      NFS: suppress a build warning
      firewire: sbp2: provide fallback if mgt_ORB_timeout is missing

Stefano Panella (1):
      USB: wusb: don't use the stack to read security descriptor

Stephen Boyd (1):
      connector: Fix incompatible pointer type warning

Stephen Hemminger (2):
      ipv4: arp_notify address list bug
      Staging: hv TODO patches

Stephen M. Cameron (2):
      cciss: Fix multiple calls to pci_release_regions
      cciss: Add cciss_allow_hpsa module parameter

Stephen Rothwell (2):
      sparc: using HZ needs an include of linux/param.h
      powerpc/iseries: Remove compiler version dependent hack

Steve French (1):
      [CIFS] Fixing to avoid invalid kfree() in cifs_get_tcp_session()

Steve Wise (2):
      RDMA/iwcm: Don't call provider reject func with irqs disabled
      RDMA/cxgb3: Handle NULL inetdev pointer in iwch_query_port()

Steven King (1):
      net: fix section mismatch in fec.c

Steven Rostedt (6):
      tracing: fix transposed numbers of lock_depth and preempt_count
      ftrace: check for failure for all conversions
      tracing: user local buffer variable for trace branch tracer
      tracing: fix trace_vprintk call
      powerpc/ftrace: show real return addresses in modules
      powerpc64/ftrace: use PACA to retrieve TOC in mod_return_to_handler

Takao Indoh (1):
      [IA64] Restore registers in the stack on INIT

Takashi Iwai (18):
      ALSA: hda - Fix invalid initializations for ALC861 auto mode
      ALSA: hda - Add a workaround for ASUS A7K
      ALSA: hda - Don't pick up invalid HP pins in alc_subsystem_id()
      ALSA: hda - Fix yet another auto-mic bug in ALC268
      Merge branch 'fix/hda' into for-linus
      Merge branch 'fix/misc' into for-linus
      ALSA: hda - Add full rates/formats support for Nvidia HDMI
      ALSA: hda - Fix overflow of spec->init_verbs in patch_realtek.c
      ALSA: bt87x - Add a whitelist for Pinnacle PCTV (11bd:0012)
      ALSA: hda - Fix mute sound with STAC9227/9228 codecs
      ALSA: hda - Fix volume-knob setup for Dell laptops with STAC9228
      ALSA: hda - Allow all formats as default for Nvidia HDMI
      Merge branch 'fix/hda' into for-linus
      ALSA: hda - Fix capture source checks for ALC662/663 codecs
      ALSA: dummy - Fix descriptions of pcm_substreams parameter
      ALSA: hda - Don't check invalid HP pin
      Merge branch 'fix/asoc' into for-linus
      Merge branch 'fix/hda' into for-linus

Teerth Reddy (1):
      omap: Initialization of SDRC params on Zoom2

Tejun Heo (11):
      [SCSI] sr: consider the last written sector when determining media si=
ze
      ahci: disable 64bit DMA by default on SB600s
      libata: cosmetic updates
      libata: implement more acpi filtering options
      libata: make gtf_filter per-dev
      ahci: filter FPDMA non-zero offset enable for Aspire 3810T
      libata: fix incorrect link online check during probe
      percpu: fix compile warnings
      sata_nv: make sure link is brough up online when skipping hardreset
      libata: fix PMP initialization
      libata: fix internal command failure handling

Terry Loftin (1):
      nfs: Panic when commit fails

Tetsuo Handa (1):
      kmemleak: Use GFP_ATOMIC for early_alloc().

Theodore Ts'o (1):
      ext3: Don't update superblock write time when filesystem is read-only

Thomas Chou (8):
      ethoc: fix typo to compute number of tx descriptors
      ethoc: fix buffer address mapping
      ethoc: align received packet to make IP header at word boundary
      ethoc: use system memory as buffer
      ethoc: limit the number of buffers to 128
      Blackfin: fix framebuffer mmap bug for nommu
      ethoc: inline regs access
      ethoc: clear only pending irqs

Thomas Gleixner (6):
      futex: Fix locking imbalance
      futex: Move exit_pi_state() call to release_mm()
      futex: Handle spurious wake up
      watchdog: Fix rio watchdog probe function
      sh: Remove BKL from landisk gio.
      futex: Fix spurious wakeup for requeue_pi really

Thomas Gruber (1):
      Input: xpad - add BigBen Interactive XBOX 360 Controller

Tilman Schmidt (12):
      Documentation: expand isdn/INTERFACE.CAPI document
      isdn: accept CAPI Informational Info values as success
      isdn: avoid races in capidrv
      isdn: make capidrv module parameter "debugmode" writeable
      gigaset: fix reject/hangup handling
      gigaset: linearize skb
      gigaset: handle isoc frame errors more gracefully
      gigaset: announce if built with debugging
      gigaset: fix device ERROR response handling
      gigaset: improve error recovery
      gigaset: correct debugging output selection
      gigaset: add kerneldoc comments

Tim Abbott (1):
      parisc: Make THREAD_SIZE available to assembly files and linker scrip=
ts.

Tim Blechmann (1):
      perf top: Fix --delay_secs 0 division by zero

Tobias Klauser (1):
      USB: gadget: imx_udc: Use resource size

Tom Zanussi (3):
      perf trace: Remove unused code in builtin-trace.c
      perf trace: Update eval_flag() flags array to match interrupt.h
      tracing/syscalls: Use long for syscall ret format and field definitio=
ns

Tommi Rantala (2):
      omapfb: Blizzard: fix pointer to be const
      omapfb: Blizzard: constify register address tables

Tomoki Sekiyama (1):
      AF_UNIX: Fix deadlock on connecting to shutdown socket

Tony Lindgren (5):
      omap: Fix incorrect 730 vs 850 detection
      Merge branch 'pm-fixes-32' of git://git.kernel.org/.../khilman/linux-=
omap-pm into omap-fixes-for-linus
      Merge branch '2_6_32rc4_fixes' of git://git.pwsan.com/linux-2.6 into =
omap-fixes-for-linus
      omap2: Fix detection of n8x0
      omap2: Fix console serial port number for n8x0

Tony Luck (6):
      [IA64] Squeeze ticket locks back into 4 bytes.
      [IA64] Re-implement spinaphores using ticket lock concepts
      [IA64] SMT friendly version of spin_unlock_wait()
      Pull ticket4byte into release branch
      Pull ticket-spinaphore into release branch
      Revert "[IA64] fix percpu warnings"

Trond Myklebust (8):
      NFS: Fix a default mount regression...
      NFS: Fix port and mountport display in /proc/self/mountinfo
      NFS: Fix port initialisation in nfs_remount()
      NFSv4: Fix the referral mount code
      NFSv4: Kill nfs4_renewd_prepare_shutdown()
      NFSv4: Fix a bug when the server returns NFS4ERR_RESOURCE
      NFSv4: Fix two unbalanced put_rpccred() issues.
      NFSv4: The link() operation should return any delegation on the file

Tyler Hicks (1):
      eCryptfs: Remove Kconfig NET dependency and select MD5

Uwe Kleine-K=F6nig (4):
      Input: sparkspkr - move remove() functions to .devexit.text
      mmc: at91_mci: Don't include asm/mach/mmc.h
      move virtballoon_remove to .devexit.text
      move virtrng_remove to .devexit.text

Valentin Longchamp (1):
      MXC: fix reset for mx31, mx35 and mx27 SoCs

Valentin Sitdikov (1):
      sh: Fix up single page flushing to use PAGE_SIZE.

Valentine Barshak (1):
      pasemi_mac: ethtool get settings fix

Vikram Pandita (1):
      OMAP3: PM: USBHOST: clear wakeup events on both hosts

Vincent Legoll (1):
      perf events: Update MAINTAINERS entry file patterns

Vincent Sanders (1):
      net: Fix IXP 2000 network driver building.

Vladimir Dronnikov (1):
      md: drivers/md/unroll.pl replaced with awk analog

Wei Yongjun (1):
      inotify: fix coalesce duplicate events into a single event in special=
 case

Wey-Yi Guy (2):
      iwlwifi: fix EEPROM enhance tx power offset
      iwlwifi: change the order of freeing memory

Willy Tarreau (1):
      tcp: fix tcp_defer_accept to consider the timeout

Wolfram Sang (3):
      include/linux/netdevice.h: fix nanodoc mismatch
      powerpc/boot/dts: drop obsolete 'fsl5200-clocking'
      pcmcia: Fix possible printk format warnings

Wu Fengguang (13):
      pagemap: export KPF_HWPOISON
      pagemap: document KPF_KSM and show it in page-types
      page-types: add GPL note
      page-types: introduce checked_open()
      page-types: make standalone pagemap/kpageflags read routines
      page-types: make voffset local variables
      page-types: introduce kpageflags_flags()
      page-types: add hwpoison/unpoison feature
      writeback: account IO throttling wait as iowait
      writeback: kill space in debugfs item name
      HWPOISON: return early on non-LRU pages
      HWPOISON: fix invalid page count in printk output
      vmscan: limit VM_EXEC protection to file pages

Wu Zhangjin (6):
      ALSA: SND_CS5535AUDIO: Remove the X86 platform dependency
      MIPS: Loongson: Remove redundant local_irq_disable()
      MIPS: Add IRQF_TIMER flag for timer interrupts
      MIPS: 64-bit: Fix o32 lookup_dcookie syscall
      MIPS: Add IRQF_TIMER flag for timer interrupts
      MIPS: Oprofile: Rename cpu_type from godson2 to loongson2

Xiao Guangrong (2):
      perf_event: Fix event group handling in __perf_event_sched_*()
      perf_event: Clean up perf_event_init_task()

Xiaotian Feng (1):
      isdn: fix possible circular locking dependency

Xose Vazquez Perez (1):
      rt73usb.c : more ids

Yan, Zheng (3):
      Btrfs: remove negative dentry when deleting subvolumne
      Btrfs: optimize back reference update during btrfs_drop_snapshot
      Btrfs: properly wait log writers during log sync

Yegor Yefremov (1):
      ARM: 5766/1: Fix watchdog enabling for AT91SAM9G45

Yevgeny Petrilin (1):
      mlx4_core: Add 40GigE device ID

Yinghai Lu (3):
      PCI: get larger bridge ranges when space is available
      pci: increase alignment to make more space for hidden code
      nfs: Fix nfs_parse_mount_options() kfree() leak

Yoshihiro Shimoda (1):
      USB: r8a66597-hcd: fix cannot detect a device when uses_new_polling i=
s set

Zdenek Kabelac (1):
      dm: add missing del_gendisk to alloc_dev error path

Zhang Le (1):
      MIPS: Loongson 2: Set cpu_has_dc_aliases and cpu_icache_snoops_remote=
_store

Zhao Yakui (3):
      drm/i915: Multiply the refresh by 1000 in TV mode validatiion
      drm: Delete the DRM_DEBUG_KMS in drm_mode_cursor_ioctl
      drm: Add the basic check for the detailed timing in EDID

Zhenwen Xu (1):
      tracing: fix warning on kernel/trace/trace_branch.c andtrace_hw_branc=
hes.c

Zhu Yi (1):
      ipw2200: fix oops on missing firmware

fran=E7ois romieu (1):
      r8169: partial support and phy init for the 8168d

jamal (2):
      pkt_sched: pedit use proper struct
      net: Fix RPF to work with policy routing

jolsa@redhat.com (1):
      tracing: correct module boundaries for ftrace_release

miaofng (1):
      Staging: vt6656: fix the memory free bug in vntwusb_disconnect()

peer chen (2):
      ahci: Add the AHCI controller Linux Device ID for NVIDIA chipsets.
      ALSA: hda_intel: Add the Linux device ID for NVIDIA HDA controller

roel kluin (2):
      au1000_eth: Duplicate test of RX_OVERLEN bit in update_rx_stats()
      ibmtr: possible Read buffer overflow?

ye janboe (1):
      omap: SRAM: flush the right address after memcpy in omap_sram_push

=C9ric Piel (2):
      USB: cp210x: Add support for the DW700 UART
      lis3: add support for the HP EliteBook 8530w

 ...fs-class-usb_host =3D> sysfs-class-uwb_rc-wusbhc} |    4 +-
 .../ABI/testing/sysfs-devices-cache_disable        |   18 -
 Documentation/ABI/testing/sysfs-devices-system-cpu |  156 +
 Documentation/cgroups/cgroups.txt                  |   11 +-
 Documentation/cputopology.txt                      |   47 +-
 Documentation/debugging-via-ohci1394.txt           |    8 +-
 Documentation/feature-removal-schedule.txt         |   38 +
 Documentation/filesystems/ext3.txt                 |   16 +-
 Documentation/filesystems/ext4.txt                 |    8 +-
 Documentation/flexible-arrays.txt                  |   43 +-
 Documentation/hwmon/sysfs-interface                |   57 +-
 Documentation/infiniband/user_mad.txt              |    4 +-
 Documentation/infiniband/user_verbs.txt            |    2 +-
 Documentation/isdn/INTERFACE.CAPI                  |   83 +-
 Documentation/kernel-parameters.txt                |    1 +
 Documentation/lguest/lguest.c                      |    1 -
 Documentation/networking/pktgen.txt                |    8 +
 Documentation/scsi/hptiop.txt                      |   21 +-
 Documentation/sound/alsa/ALSA-Configuration.txt    |    2 +-
 Documentation/sound/alsa/HD-Audio-Models.txt       |    1 +
 Documentation/trace/ftrace.txt                     |    2 +
 Documentation/vm/hwpoison.txt                      |  136 +
 Documentation/vm/ksm.txt                           |   13 +-
 Documentation/vm/page-types.c                      |  304 ++-
 Documentation/vm/pagemap.txt                       |    8 +
 MAINTAINERS                                        |  196 +-
 Makefile                                           |   48 +-
 arch/arm/configs/n8x0_defconfig                    |    2 +-
 arch/arm/configs/omap3_beagle_defconfig            |    1 -
 arch/arm/configs/u300_defconfig                    |   94 +-
 arch/arm/include/asm/bitops.h                      |    6 +-
 arch/arm/include/asm/cacheflush.h                  |    5 +
 arch/arm/include/asm/elf.h                         |    3 +
 arch/arm/include/asm/tlbflush.h                    |    3 +-
 arch/arm/kernel/entry-armv.S                       |   28 +-
 arch/arm/kernel/entry-header.S                     |   15 +
 arch/arm/kernel/process.c                          |    9 +
 arch/arm/kernel/signal.c                           |   41 +-
 arch/arm/kernel/signal.h                           |    4 +-
 arch/arm/kernel/time.c                             |    1 +
 arch/arm/kernel/traps.c                            |   80 +-
 arch/arm/kernel/unwind.c                           |    9 +
 arch/arm/mach-at91/at91sam9g45_devices.c           |    2 +-
 arch/arm/mach-at91/include/mach/cpu.h              |    9 +
 arch/arm/mach-bcmring/core.c                       |    4 +-
 arch/arm/mach-bcmring/include/mach/system.h        |    2 +-
 arch/arm/mach-ep93xx/Kconfig                       |   44 +-
 arch/arm/mach-ep93xx/Makefile.boot                 |    9 +
 arch/arm/mach-ep93xx/clock.c                       |  166 +-
 arch/arm/mach-ep93xx/core.c                        |   32 +-
 arch/arm/mach-ep93xx/edb93xx.c                     |   31 +-
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h    |   42 +-
 arch/arm/mach-ep93xx/include/mach/gpio.h           |   16 +-
 arch/arm/mach-ep93xx/include/mach/memory.h         |    6 +
 arch/arm/mach-ep93xx/include/mach/platform.h       |    5 +-
 arch/arm/mach-ep93xx/micro9.c                      |  132 +-
 arch/arm/mach-integrator/include/mach/memory.h     |    1 +
 arch/arm/mach-integrator/pci_v3.c                  |    1 +
 arch/arm/mach-mx2/clock_imx27.c                    |    8 +-
 arch/arm/mach-mx2/pcm038.c                         |   96 +-
 arch/arm/mach-mx2/pcm970-baseboard.c               |    2 +-
 arch/arm/mach-mx25/devices.c                       |   19 +
 arch/arm/mach-mx25/mx25pdk.c                       |   25 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    2 +-
 arch/arm/mach-mx3/clock.c                          |    2 +-
 arch/arm/mach-mx3/devices.c                        |   24 +-
 arch/arm/mach-mx3/devices.h                        |    6 +-
 arch/arm/mach-mx3/mm.c                             |    2 +
 arch/arm/mach-omap1/board-ams-delta.c              |    6 +
 arch/arm/mach-omap1/board-generic.c                |    8 +
 arch/arm/mach-omap1/board-innovator.c              |   20 +
 arch/arm/mach-omap1/board-palmte.c                 |    8 +
 arch/arm/mach-omap1/board-palmtt.c                 |    8 +
 arch/arm/mach-omap1/board-palmz71.c                |    8 +
 arch/arm/mach-omap1/board-sx1.c                    |    8 +
 arch/arm/mach-omap1/board-voiceblue.c              |    8 +
 arch/arm/mach-omap1/serial.c                       |   26 -
 arch/arm/mach-omap2/Kconfig                        |   12 +
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    4 +-
 arch/arm/mach-omap2/board-ldp.c                    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   82 +-
 arch/arm/mach-omap2/board-rx51.c                   |    1 -
 arch/arm/mach-omap2/board-zoom2.c                  |    6 +-
 arch/arm/mach-omap2/clock24xx.c                    |    1 +
 arch/arm/mach-omap2/clock34xx.c                    |   35 +
 arch/arm/mach-omap2/clockdomain.c                  |   74 +-
 arch/arm/mach-omap2/io.c                           |    2 +
 arch/arm/mach-omap2/pm-debug.c                     |    4 +-
 arch/arm/mach-omap2/pm34xx.c                       |  188 +-
 arch/arm/mach-omap2/powerdomain.c                  |   39 +-
 arch/arm/mach-omap2/serial.c                       |   10 -
 arch/arm/mach-pxa/cm-x300.c                        |   38 +-
 arch/arm/mach-pxa/cpufreq-pxa2xx.c                 |    2 +-
 arch/arm/mach-pxa/csb726.c                         |    2 +-
 arch/arm/mach-pxa/spitz.c                          |   39 +
 arch/arm/mach-realview/core.h                      |    2 +-
 arch/arm/mach-realview/include/mach/board-pb1176.h |    5 +
 arch/arm/mach-realview/include/mach/board-pb11mp.h |   12 +
 arch/arm/mach-realview/include/mach/platform.h     |   15 +-
 arch/arm/mach-realview/include/mach/system.h       |   10 +-
 arch/arm/mach-realview/realview_pb1176.c           |   11 +
 arch/arm/mach-realview/realview_pb11mp.c           |   16 +
 arch/arm/mach-s3c2410/gpio.c                       |    1 +
 arch/arm/mach-s3c2410/include/mach/dma.h           |    7 +
 arch/arm/mach-s3c2440/Kconfig                      |    1 +
 arch/arm/mach-s3c2440/mach-mini2440.c              |    4 +-
 arch/arm/mach-s3c6400/include/mach/dma.h           |    5 +
 arch/arm/mach-sa1100/Makefile                      |    1 +
 arch/arm/mm/Kconfig                                |    5 +-
 arch/arm/mm/cache-v6.S                             |   20 +-
 arch/arm/mm/cache-v7.S                             |   19 +-
 arch/arm/mm/context.c                              |    5 +-
 arch/arm/mm/dma-mapping.c                          |    4 +-
 arch/arm/mm/fault-armv.c                           |    9 +-
 arch/arm/mm/fault.c                                |    5 +
 arch/arm/mm/flush.c                                |   31 +-
 arch/arm/mm/highmem.c                              |    2 +
 arch/arm/mm/init.c                                 |   22 +-
 arch/arm/mm/mmu.c                                  |    7 +
 arch/arm/mm/proc-v6.S                              |    7 +-
 arch/arm/mm/proc-v7.S                              |    7 +-
 arch/arm/oprofile/op_model_v6.c                    |    3 +
 arch/arm/plat-omap/dma.c                           |   33 +-
 arch/arm/plat-omap/include/mach/cpu.h              |   37 +-
 arch/arm/plat-omap/include/mach/keypad.h           |    5 +-
 arch/arm/plat-omap/include/mach/powerdomain.h      |    2 +
 arch/arm/plat-omap/iommu.c                         |    2 +-
 arch/arm/plat-omap/iovmm.c                         |    9 +-
 arch/arm/plat-omap/mcbsp.c                         |    2 +-
 arch/arm/plat-omap/sram.c                          |    3 +-
 arch/arm/plat-s3c24xx/adc.c                        |    3 +-
 arch/arm/plat-s3c24xx/cpu.c                        |   10 +
 arch/arm/plat-s3c24xx/dma.c                        |    6 +-
 arch/arm/plat-s3c24xx/gpio.c                       |    1 +
 arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h |    9 +-
 arch/arm/plat-s3c24xx/include/plat/s3c2410.h       |    1 +
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h    |    4 +-
 arch/arm/plat-s3c64xx/s3c6400-clock.c              |    3 +
 arch/avr32/mach-at32ap/include/mach/cpu.h          |    3 +
 arch/blackfin/ADI_BSD.txt                          |   41 +
 arch/blackfin/Kconfig                              |   13 +-
 arch/blackfin/include/asm/atomic.h                 |    6 +
 arch/blackfin/include/asm/bfin-global.h            |   26 +-
 arch/blackfin/include/asm/bfin5xx_spi.h            |    2 -
 arch/blackfin/include/asm/bfin_rotary.h            |    4 +
 arch/blackfin/include/asm/bfin_simple_timer.h      |    6 +
 arch/blackfin/include/asm/bitops.h                 |    6 +
 arch/blackfin/include/asm/blackfin.h               |    5 +-
 arch/blackfin/include/asm/bug.h                    |    6 +
 arch/blackfin/include/asm/byteorder.h              |    5 -
 arch/blackfin/include/asm/cache.h                  |    9 +-
 arch/blackfin/include/asm/cacheflush.h             |   27 +-
 arch/blackfin/include/asm/cdef_LPBlackfin.h        |   32 +-
 arch/blackfin/include/asm/checksum.h               |    9 +-
 arch/blackfin/include/asm/clocks.h                 |   27 +-
 arch/blackfin/include/asm/context.S                |   27 +-
 arch/blackfin/include/asm/cplb.h                   |   27 +-
 arch/blackfin/include/asm/cplbinit.h               |   27 +-
 arch/blackfin/include/asm/cpu.h                    |   21 +-
 arch/blackfin/include/asm/def_LPBlackfin.h         |   36 +-
 arch/blackfin/include/asm/dma-mapping.h            |    6 +
 arch/blackfin/include/asm/dpmc.h                   |    6 +-
 arch/blackfin/include/asm/early_printk.h           |   22 +-
 arch/blackfin/include/asm/elf.h                    |    6 +-
 arch/blackfin/include/asm/entry.h                  |    6 +
 arch/blackfin/include/asm/fcntl.h                  |    6 +
 arch/blackfin/include/asm/fixed_code.h             |   10 +-
 arch/blackfin/include/asm/flat.h                   |    5 +-
 arch/blackfin/include/asm/gpio.h                   |   27 +-
 arch/blackfin/include/asm/hardirq.h                |    6 +
 arch/blackfin/include/asm/io.h                     |    6 +
 arch/blackfin/include/asm/irq.h                    |   19 +-
 arch/blackfin/include/asm/irq_handler.h            |    6 +
 arch/blackfin/include/asm/l1layout.h               |    5 +-
 arch/blackfin/include/asm/linkage.h                |    6 +
 arch/blackfin/include/asm/mmu.h                    |    9 +-
 arch/blackfin/include/asm/mmu_context.h            |   27 +-
 arch/blackfin/include/asm/module.h                 |    6 +
 arch/blackfin/include/asm/mutex.h                  |    4 +
 arch/blackfin/include/asm/nand.h                   |   12 +-
 arch/blackfin/include/asm/page.h                   |    6 +
 arch/blackfin/include/asm/page_offset.h            |    9 +-
 arch/blackfin/include/asm/pda.h                    |   21 +-
 arch/blackfin/include/asm/pgtable.h                |   12 +
 arch/blackfin/include/asm/poll.h                   |    7 +
 arch/blackfin/include/asm/portmux.h                |    5 +-
 arch/blackfin/include/asm/posix_types.h            |    6 +
 arch/blackfin/include/asm/processor.h              |    6 +
 arch/blackfin/include/asm/ptrace.h                 |    6 +
 arch/blackfin/include/asm/sections.h               |    6 +
 arch/blackfin/include/asm/segment.h                |    6 +
 arch/blackfin/include/asm/sigcontext.h             |    6 +
 arch/blackfin/include/asm/siginfo.h                |    6 +
 arch/blackfin/include/asm/smp.h                    |   21 +-
 arch/blackfin/include/asm/spinlock.h               |    6 +
 arch/blackfin/include/asm/spinlock_types.h         |    6 +
 arch/blackfin/include/asm/stat.h                   |    6 +
 arch/blackfin/include/asm/string.h                 |    6 +
 arch/blackfin/include/asm/swab.h                   |    6 +
 arch/blackfin/include/asm/system.h                 |   32 +-
 arch/blackfin/include/asm/thread_info.h            |   24 +-
 arch/blackfin/include/asm/tlb.h                    |    6 +
 arch/blackfin/include/asm/trace.h                  |    5 +-
 arch/blackfin/include/asm/traps.h                  |   13 +-
 arch/blackfin/include/asm/uaccess.h                |    5 +-
 arch/blackfin/include/asm/unistd.h                 |    6 +
 arch/blackfin/kernel/asm-offsets.c                 |   27 +-
 arch/blackfin/kernel/bfin_dma_5xx.c                |    1 +
 arch/blackfin/kernel/bfin_gpio.c                   |   27 +-
 arch/blackfin/kernel/cplb-mpu/cplbinit.c           |   20 +-
 arch/blackfin/kernel/cplb-mpu/cplbmgr.c            |   19 +-
 arch/blackfin/kernel/cplb-nompu/cplbinit.c         |   19 +-
 arch/blackfin/kernel/cplb-nompu/cplbmgr.c          |   16 +-
 arch/blackfin/kernel/cplbinfo.c                    |   26 +-
 arch/blackfin/kernel/dma-mapping.c                 |   27 +-
 arch/blackfin/kernel/early_printk.c                |   23 +-
 arch/blackfin/kernel/entry.S                       |   27 +-
 arch/blackfin/kernel/fixed_code.S                  |    5 +
 arch/blackfin/kernel/flat.c                        |   18 +-
 arch/blackfin/kernel/init_task.c                   |   27 +-
 arch/blackfin/kernel/irqchip.c                     |   27 +-
 arch/blackfin/kernel/module.c                      |   27 +-
 arch/blackfin/kernel/process.c                     |   27 +-
 arch/blackfin/kernel/ptrace.c                      |   28 +-
 arch/blackfin/kernel/setup.c                       |    6 +-
 arch/blackfin/kernel/shadow_console.c              |    2 -
 arch/blackfin/kernel/signal.c                      |   27 +-
 arch/blackfin/kernel/sys_bfin.c                    |   41 +-
 arch/blackfin/kernel/time-ts.c                     |   10 +-
 arch/blackfin/kernel/time.c                        |   64 +-
 arch/blackfin/kernel/traps.c                       |   27 +-
 arch/blackfin/kernel/vmlinux.lds.S                 |   27 +-
 arch/blackfin/lib/ashldi3.c                        |   27 +-
 arch/blackfin/lib/ashrdi3.c                        |   27 +-
 arch/blackfin/lib/checksum.c                       |   30 +-
 arch/blackfin/lib/divsi3.S                         |   28 +-
 arch/blackfin/lib/gcclib.h                         |   27 +-
 arch/blackfin/lib/lshrdi3.c                        |   27 +-
 arch/blackfin/lib/memchr.S                         |   27 +-
 arch/blackfin/lib/memcmp.S                         |   27 +-
 arch/blackfin/lib/memcpy.S                         |   37 +-
 arch/blackfin/lib/memmove.S                        |   27 +-
 arch/blackfin/lib/memset.S                         |   27 +-
 arch/blackfin/lib/modsi3.S                         |   36 +-
 arch/blackfin/lib/muldi3.S                         |    6 +
 arch/blackfin/lib/outs.S                           |   29 +-
 arch/blackfin/lib/smulsi3_highpart.S               |    6 +
 arch/blackfin/lib/udivsi3.S                        |   27 +-
 arch/blackfin/lib/umodsi3.S                        |   27 +-
 arch/blackfin/lib/umulsi3_highpart.S               |    6 +
 arch/blackfin/mach-bf518/boards/ezbrd.c            |   45 +-
 arch/blackfin/mach-bf518/dma.c                     |   28 +-
 arch/blackfin/mach-bf518/include/mach/bf518.h      |   27 +-
 .../mach-bf518/include/mach/bfin_serial_5xx.h      |   29 +-
 arch/blackfin/mach-bf518/include/mach/blackfin.h   |   29 +-
 arch/blackfin/mach-bf518/include/mach/cdefBF512.h  |   29 +-
 arch/blackfin/mach-bf518/include/mach/cdefBF514.h  |   29 +-
 arch/blackfin/mach-bf518/include/mach/cdefBF516.h  |   29 +-
 arch/blackfin/mach-bf518/include/mach/cdefBF518.h  |   70 +-
 .../mach-bf518/include/mach/cdefBF51x_base.h       |   28 +-
 arch/blackfin/mach-bf518/include/mach/defBF512.h   |   28 +-
 arch/blackfin/mach-bf518/include/mach/defBF514.h   |   28 +-
 arch/blackfin/mach-bf518/include/mach/defBF516.h   |   28 +-
 arch/blackfin/mach-bf518/include/mach/defBF518.h   |   56 +-
 .../mach-bf518/include/mach/defBF51x_base.h        |   28 +-
 arch/blackfin/mach-bf518/include/mach/gpio.h       |    3 -
 arch/blackfin/mach-bf518/include/mach/irq.h        |   29 +-
 arch/blackfin/mach-bf518/include/mach/portmux.h    |    6 +
 arch/blackfin/mach-bf518/ints-priority.c           |   27 +-
 arch/blackfin/mach-bf527/boards/cm_bf527.c         |   61 +-
 arch/blackfin/mach-bf527/boards/ezbrd.c            |   45 +-
 arch/blackfin/mach-bf527/boards/ezkit.c            |   60 +-
 arch/blackfin/mach-bf527/dma.c                     |   28 +-
 arch/blackfin/mach-bf527/include/mach/bf527.h      |   27 +-
 .../mach-bf527/include/mach/bfin_serial_5xx.h      |   29 +-
 arch/blackfin/mach-bf527/include/mach/blackfin.h   |   29 +-
 arch/blackfin/mach-bf527/include/mach/cdefBF522.h  |   29 +-
 arch/blackfin/mach-bf527/include/mach/cdefBF525.h  |   29 +-
 arch/blackfin/mach-bf527/include/mach/cdefBF527.h  |   29 +-
 .../mach-bf527/include/mach/cdefBF52x_base.h       |   28 +-
 arch/blackfin/mach-bf527/include/mach/defBF522.h   |   28 +-
 arch/blackfin/mach-bf527/include/mach/defBF525.h   |   28 +-
 arch/blackfin/mach-bf527/include/mach/defBF527.h   |   28 +-
 .../mach-bf527/include/mach/defBF52x_base.h        |   28 +-
 arch/blackfin/mach-bf527/include/mach/gpio.h       |    3 -
 arch/blackfin/mach-bf527/include/mach/irq.h        |   29 +-
 arch/blackfin/mach-bf527/include/mach/portmux.h    |    6 +
 arch/blackfin/mach-bf527/ints-priority.c           |   27 +-
 arch/blackfin/mach-bf533/boards/H8606.c            |   33 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c       |   29 +-
 arch/blackfin/mach-bf533/boards/cm_bf533.c         |   45 +-
 arch/blackfin/mach-bf533/boards/ezkit.c            |  132 +-
 arch/blackfin/mach-bf533/boards/ip0x.c             |   37 +-
 arch/blackfin/mach-bf533/boards/stamp.c            |   60 +-
 arch/blackfin/mach-bf533/dma.c                     |   28 +-
 arch/blackfin/mach-bf533/include/mach/bf533.h      |   27 +-
 .../mach-bf533/include/mach/bfin_serial_5xx.h      |   29 +-
 arch/blackfin/mach-bf533/include/mach/blackfin.h   |   28 +-
 arch/blackfin/mach-bf533/include/mach/cdefBF532.h  |   28 +-
 arch/blackfin/mach-bf533/include/mach/defBF532.h   |   44 +-
 arch/blackfin/mach-bf533/include/mach/gpio.h       |    3 -
 arch/blackfin/mach-bf533/include/mach/irq.h        |   28 +-
 arch/blackfin/mach-bf533/include/mach/portmux.h    |    6 +
 arch/blackfin/mach-bf533/ints-priority.c           |   27 +-
 arch/blackfin/mach-bf537/boards/cm_bf537e.c        |   46 +-
 arch/blackfin/mach-bf537/boards/cm_bf537u.c        |   46 +-
 arch/blackfin/mach-bf537/boards/minotaur.c         |    6 +
 arch/blackfin/mach-bf537/boards/pnav10.c           |   31 +-
 arch/blackfin/mach-bf537/boards/stamp.c            |   60 +-
 arch/blackfin/mach-bf537/boards/tcm_bf537.c        |   46 +-
 arch/blackfin/mach-bf537/dma.c                     |   28 +-
 arch/blackfin/mach-bf537/include/mach/bf537.h      |   27 +-
 .../mach-bf537/include/mach/bfin_serial_5xx.h      |   29 +-
 arch/blackfin/mach-bf537/include/mach/blackfin.h   |   29 +-
 arch/blackfin/mach-bf537/include/mach/cdefBF534.h  |   29 +-
 arch/blackfin/mach-bf537/include/mach/cdefBF537.h  |   29 +-
 arch/blackfin/mach-bf537/include/mach/defBF534.h   |   28 +-
 arch/blackfin/mach-bf537/include/mach/defBF537.h   |   29 +-
 arch/blackfin/mach-bf537/include/mach/gpio.h       |    3 -
 arch/blackfin/mach-bf537/include/mach/irq.h        |   29 +-
 arch/blackfin/mach-bf537/include/mach/portmux.h    |    6 +
 arch/blackfin/mach-bf537/ints-priority.c           |   27 +-
 arch/blackfin/mach-bf538/boards/ezkit.c            |   46 +-
 arch/blackfin/mach-bf538/dma.c                     |   28 +-
 arch/blackfin/mach-bf538/include/mach/bf538.h      |   27 +-
 .../mach-bf538/include/mach/bfin_serial_5xx.h      |   29 +-
 arch/blackfin/mach-bf538/include/mach/blackfin.h   |   29 +-
 arch/blackfin/mach-bf538/include/mach/cdefBF538.h  |   28 +-
 arch/blackfin/mach-bf538/include/mach/defBF539.h   |   44 +-
 arch/blackfin/mach-bf538/include/mach/gpio.h       |    3 -
 arch/blackfin/mach-bf538/include/mach/irq.h        |   29 +-
 arch/blackfin/mach-bf538/include/mach/portmux.h    |    6 +
 arch/blackfin/mach-bf538/ints-priority.c           |   27 +-
 arch/blackfin/mach-bf548/boards/cm_bf548.c         |   48 +-
 arch/blackfin/mach-bf548/boards/ezkit.c            |   49 +-
 arch/blackfin/mach-bf548/dma.c                     |   27 +-
 arch/blackfin/mach-bf548/include/mach/bf548.h      |   27 +-
 .../blackfin/mach-bf548/include/mach/bf54x-lq043.h |    6 +
 arch/blackfin/mach-bf548/include/mach/bf54x_keys.h |    6 +
 .../mach-bf548/include/mach/bfin_serial_5xx.h      |   29 +-
 arch/blackfin/mach-bf548/include/mach/blackfin.h   |   29 +-
 arch/blackfin/mach-bf548/include/mach/cdefBF542.h  |   28 +-
 arch/blackfin/mach-bf548/include/mach/cdefBF544.h  |   28 +-
 arch/blackfin/mach-bf548/include/mach/cdefBF547.h  |   28 +-
 arch/blackfin/mach-bf548/include/mach/cdefBF548.h  |   28 +-
 arch/blackfin/mach-bf548/include/mach/cdefBF549.h  |   28 +-
 .../mach-bf548/include/mach/cdefBF54x_base.h       |   28 +-
 arch/blackfin/mach-bf548/include/mach/defBF542.h   |   28 +-
 arch/blackfin/mach-bf548/include/mach/defBF544.h   |   28 +-
 arch/blackfin/mach-bf548/include/mach/defBF547.h   |   28 +-
 arch/blackfin/mach-bf548/include/mach/defBF548.h   |   28 +-
 arch/blackfin/mach-bf548/include/mach/defBF549.h   |   28 +-
 .../mach-bf548/include/mach/defBF54x_base.h        |   28 +-
 arch/blackfin/mach-bf548/include/mach/gpio.h       |   30 +-
 arch/blackfin/mach-bf548/include/mach/irq.h        |   29 +-
 arch/blackfin/mach-bf548/include/mach/portmux.h    |    6 +
 arch/blackfin/mach-bf548/ints-priority.c           |   27 +-
 arch/blackfin/mach-bf561/atomic.S                  |   21 +-
 arch/blackfin/mach-bf561/boards/cm_bf561.c         |   45 +-
 arch/blackfin/mach-bf561/boards/ezkit.c            |   44 +-
 arch/blackfin/mach-bf561/boards/tepla.c            |   14 +-
 arch/blackfin/mach-bf561/dma.c                     |   28 +-
 arch/blackfin/mach-bf561/include/mach/bf561.h      |   27 +-
 .../mach-bf561/include/mach/bfin_serial_5xx.h      |   29 +-
 arch/blackfin/mach-bf561/include/mach/blackfin.h   |   28 +-
 arch/blackfin/mach-bf561/include/mach/cdefBF561.h  |   28 +-
 arch/blackfin/mach-bf561/include/mach/defBF561.h   |   29 +-
 arch/blackfin/mach-bf561/include/mach/gpio.h       |    3 -
 arch/blackfin/mach-bf561/include/mach/irq.h        |   29 +-
 arch/blackfin/mach-bf561/include/mach/portmux.h    |    6 +
 arch/blackfin/mach-bf561/include/mach/smp.h        |    6 +
 arch/blackfin/mach-bf561/ints-priority.c           |   27 +-
 arch/blackfin/mach-bf561/secondary.S               |   24 +-
 arch/blackfin/mach-bf561/smp.c                     |   21 +-
 arch/blackfin/mach-common/arch_checks.c            |   27 +-
 arch/blackfin/mach-common/cache-c.c                |    2 -
 arch/blackfin/mach-common/cache.S                  |    2 -
 arch/blackfin/mach-common/cpufreq.c                |   27 +-
 arch/blackfin/mach-common/entry.S                  |   31 +-
 arch/blackfin/mach-common/head.S                   |    2 -
 arch/blackfin/mach-common/interrupt.S              |   30 +-
 arch/blackfin/mach-common/ints-priority.c          |   35 +-
 arch/blackfin/mach-common/irqpanic.c               |   27 +-
 arch/blackfin/mach-common/pm.c                     |   34 +-
 arch/blackfin/mach-common/smp.c                    |   22 +-
 arch/blackfin/mm/blackfin_sram.h                   |   27 +-
 arch/blackfin/mm/init.c                            |   27 +-
 arch/blackfin/mm/isram-driver.c                    |   14 +-
 arch/blackfin/mm/sram-alloc.c                      |   27 +-
 arch/frv/kernel/signal.c                           |    2 +-
 arch/ia64/include/asm/spinlock.h                   |   62 +-
 arch/ia64/include/asm/spinlock_types.h             |    2 +-
 arch/ia64/kernel/mca.c                             |  104 +-
 arch/ia64/kernel/unaligned.c                       |    6 +-
 arch/ia64/mm/tlb.c                                 |   24 +-
 arch/ia64/pci/pci.c                                |    9 +-
 arch/ia64/sn/kernel/io_common.c                    |    8 +-
 arch/ia64/sn/kernel/sn2/sn_hwperf.c                |    7 +-
 arch/m32r/kernel/smp.c                             |    1 +
 arch/m68k/Kconfig                                  |    6 +-
 arch/m68knommu/kernel/asm-offsets.c                |   28 +-
 arch/m68knommu/kernel/entry.S                      |    6 +-
 arch/m68knommu/mm/init.c                           |    2 +-
 arch/m68knommu/platform/5206e/config.c             |    1 -
 arch/m68knommu/platform/68328/entry.S              |   32 +-
 arch/m68knommu/platform/68360/entry.S              |   16 +-
 arch/m68knommu/platform/coldfire/entry.S           |   20 +-
 arch/microblaze/kernel/entry.S                     |    2 +
 arch/microblaze/kernel/hw_exception_handler.S      |    2 +-
 arch/microblaze/kernel/process.c                   |    2 +
 arch/mips/Kconfig                                  |    4 +-
 arch/mips/alchemy/common/irq.c                     |   34 +-
 arch/mips/alchemy/mtx-1/board_setup.c              |    3 +-
 arch/mips/ar7/platform.c                           |    9 +-
 arch/mips/bcm63xx/Makefile                         |    2 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    3 -
 arch/mips/bcm63xx/cpu.c                            |    3 +
 arch/mips/bcm63xx/dev-uart.c                       |    2 +-
 arch/mips/bcm63xx/dev-wdt.c                        |   37 +
 arch/mips/bcm63xx/setup.c                          |    4 +-
 arch/mips/cavium-octeon/octeon-irq.c               |  224 ++-
 arch/mips/cavium-octeon/smp.c                      |    5 +-
 arch/mips/include/asm/fixmap.h                     |    4 +-
 arch/mips/include/asm/gcmpregs.h                   |   18 +-
 arch/mips/include/asm/gic.h                        |  188 +-
 arch/mips/include/asm/mach-ar7/ar7.h               |    3 +
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h    |    2 +
 .../include/asm/mach-bcm63xx/bcm63xx_dev_uart.h    |    6 -
 arch/mips/include/asm/mach-ip27/topology.h         |    4 +-
 .../asm/mach-loongson/cpu-feature-overrides.h      |    3 +-
 arch/mips/include/asm/mmu_context.h                |   13 +-
 arch/mips/include/asm/setup.h                      |    2 +-
 arch/mips/include/asm/smtc_ipi.h                   |    1 +
 arch/mips/include/asm/spram.h                      |   10 +
 arch/mips/include/asm/thread_info.h                |    9 +-
 arch/mips/jazz/irq.c                               |    2 +-
 arch/mips/kernel/cevt-bcm1480.c                    |    2 +-
 arch/mips/kernel/cevt-ds1287.c                     |    2 +-
 arch/mips/kernel/cevt-gt641xx.c                    |    2 +-
 arch/mips/kernel/cevt-r4k.c                        |    2 +-
 arch/mips/kernel/cevt-sb1250.c                     |    2 +-
 arch/mips/kernel/cevt-txx9.c                       |    2 +-
 arch/mips/kernel/cpu-probe.c                       |    8 +-
 arch/mips/kernel/head.S                            |    1 +
 arch/mips/kernel/i8253.c                           |    2 +-
 arch/mips/kernel/irq-gic.c                         |  114 +-
 arch/mips/kernel/linux32.c                         |    6 +
 arch/mips/kernel/scall64-o32.S                     |    4 +-
 arch/mips/kernel/smtc.c                            |   34 +-
 arch/mips/kernel/spram.c                           |    5 +-
 arch/mips/kernel/vpe.c                             |    2 -
 arch/mips/loongson/common/irq.c                    |    1 -
 arch/mips/math-emu/dp_simple.c                     |   13 +-
 arch/mips/math-emu/sp_simple.c                     |   11 +-
 arch/mips/mm/init.c                                |    6 +-
 arch/mips/mti-malta/malta-amon.c                   |    7 +-
 arch/mips/mti-malta/malta-int.c                    |  119 +-
 arch/mips/mti-malta/malta-pci.c                    |   27 +-
 arch/mips/nxp/pnx8550/common/int.c                 |    2 +-
 arch/mips/nxp/pnx8550/common/time.c                |    4 +-
 arch/mips/oprofile/op_model_loongson2.c            |    2 +-
 arch/mips/sgi-ip27/ip27-timer.c                    |    2 +-
 arch/mips/sni/time.c                               |    2 +-
 arch/mips/txx9/generic/setup.c                     |    5 +-
 arch/parisc/Kconfig                                |    1 +
 arch/parisc/include/asm/fixmap.h                   |    4 +-
 arch/parisc/include/asm/hardirq.h                  |   20 +-
 arch/parisc/include/asm/ptrace.h                   |    5 +-
 arch/parisc/include/asm/syscall.h                  |   40 +
 arch/parisc/include/asm/thread_info.h              |   14 +-
 arch/parisc/kernel/asm-offsets.c                   |    4 +-
 arch/parisc/kernel/entry.S                         |   21 +-
 arch/parisc/kernel/irq.c                           |    5 -
 arch/parisc/kernel/module.c                        |    2 +-
 arch/parisc/kernel/ptrace.c                        |   42 +-
 arch/parisc/kernel/signal.c                        |    5 +-
 arch/parisc/kernel/syscall.S                       |   22 +-
 arch/parisc/kernel/vmlinux.lds.S                   |   10 +
 arch/parisc/mm/init.c                              |   11 +-
 arch/powerpc/boot/dts/cm5200.dts                   |    1 -
 arch/powerpc/boot/dts/digsy_mtc.dts                |    1 -
 arch/powerpc/boot/dts/lite5200.dts                 |    2 -
 arch/powerpc/boot/dts/lite5200b.dts                |    2 -
 arch/powerpc/boot/dts/media5200.dts                |    2 -
 arch/powerpc/boot/dts/motionpro.dts                |    1 -
 arch/powerpc/boot/dts/mpc5121ads.dts               |    3 -
 arch/powerpc/boot/dts/mucmc52.dts                  |  332 ++
 arch/powerpc/boot/dts/pcm030.dts                   |    2 -
 arch/powerpc/boot/dts/pcm032.dts                   |    2 -
 arch/powerpc/boot/dts/tqm5200.dts                  |    1 -
 arch/powerpc/boot/dts/uc101.dts                    |  284 ++
 arch/powerpc/configs/52xx/cm5200_defconfig         |  136 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig      |  153 +-
 arch/powerpc/configs/52xx/motionpro_defconfig      |  146 +-
 arch/powerpc/configs/52xx/pcm030_defconfig         |  142 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig        |  148 +-
 arch/powerpc/configs/mpc5200_defconfig             |  192 +-
 arch/powerpc/configs/ppc64e_defconfig              | 2199 +++++++++++++
 arch/powerpc/include/asm/firmware.h                |   10 +-
 arch/powerpc/kernel/cputable.c                     |    2 +
 arch/powerpc/kernel/entry_64.S                     |   44 +-
 arch/powerpc/kernel/kgdb.c                         |    6 -
 arch/powerpc/kernel/pci-common.c                   |    2 +-
 arch/powerpc/kernel/pci_64.c                       |    2 +
 arch/powerpc/kernel/perf_event.c                   |   17 +-
 arch/powerpc/kernel/process.c                      |   12 +-
 arch/powerpc/kernel/setup_64.c                     |    1 -
 arch/powerpc/kernel/vdso.c                         |   11 +-
 arch/powerpc/kernel/vdso32/vdso32.lds.S            |    4 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |    1 +
 arch/powerpc/mm/slb_low.S                          |   10 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c       |    2 +
 arch/powerpc/platforms/cell/axon_msi.c             |    2 +-
 arch/powerpc/platforms/iseries/Makefile            |   11 +-
 arch/powerpc/platforms/iseries/dt.c                |   56 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |    7 +-
 arch/powerpc/platforms/pseries/firmware.c          |    3 +-
 arch/powerpc/xmon/xmon.c                           |   20 +-
 arch/s390/hypfs/hypfs_diag.c                       |    2 +-
 arch/s390/include/asm/cputime.h                    |    6 +-
 arch/s390/include/asm/delay.h                      |    7 +-
 arch/s390/include/asm/elf.h                        |   12 +
 arch/s390/include/asm/ptrace.h                     |    4 +
 arch/s390/include/asm/ucontext.h                   |   15 +
 arch/s390/kernel/compat_signal.c                   |   35 +-
 arch/s390/kernel/compat_wrapper.S                  |    2 +-
 arch/s390/kernel/ftrace.c                          |    3 -
 arch/s390/kernel/ipl.c                             |    7 +-
 arch/s390/kernel/module.c                          |    3 +
 arch/s390/kernel/processor.c                       |    6 +-
 arch/s390/kernel/ptrace.c                          |   70 +
 arch/s390/kernel/setup.c                           |   15 +-
 arch/s390/kernel/smp.c                             |    7 +-
 arch/s390/kernel/swsusp_asm64.S                    |   28 +-
 arch/s390/kernel/vdso.c                            |   16 +-
 arch/s390/kernel/vmlinux.lds.S                     |    1 +
 arch/s390/kvm/kvm-s390.h                           |    2 +-
 arch/s390/lib/delay.c                              |   27 +-
 arch/s390/lib/uaccess_mvcos.c                      |   12 +-
 arch/s390/lib/uaccess_std.c                        |   14 +-
 arch/s390/mm/pgtable.c                             |   10 +-
 arch/sh/Kconfig                                    |    6 +-
 arch/sh/Makefile                                   |    3 +-
 arch/sh/boards/board-magicpanelr2.c                |    2 -
 arch/sh/boards/mach-dreamcast/setup.c              |    2 -
 arch/sh/boards/mach-ecovec24/setup.c               |   63 +-
 arch/sh/boards/mach-landisk/gio.c                  |   10 +-
 arch/sh/boards/mach-rsk/devices-rsk7203.c          |    4 -
 arch/sh/boards/mach-rsk/setup.c                    |   23 +-
 arch/sh/boot/Makefile                              |    6 +-
 arch/sh/kernel/cpu/sh3/entry.S                     |    2 -
 arch/sh/kernel/dwarf.c                             |   22 +
 arch/sh/kernel/entry-common.S                      |    2 +-
 arch/sh/kernel/ftrace.c                            |   37 +-
 arch/sh/kernel/io_generic.c                        |    3 +
 arch/sh/kernel/irq.c                               |    3 +-
 arch/sh/kernel/machvec.c                           |    3 +
 arch/sh/kernel/setup.c                             |    2 +
 arch/sh/kernel/sh_ksyms_32.c                       |   15 +
 arch/sh/kernel/signal_32.c                         |    9 +-
 arch/sh/kernel/smp.c                               |    2 +
 arch/sh/kernel/traps_32.c                          |   11 +-
 arch/sh/mm/Kconfig                                 |    2 +-
 arch/sh/mm/cache-sh4.c                             |   24 +-
 arch/sh/mm/cache-sh7705.c                          |    4 +-
 arch/sh/mm/cache.c                                 |   12 +-
 arch/sh/mm/ioremap_32.c                            |    2 +-
 arch/sh/mm/pmb.c                                   |   37 +-
 arch/sparc/Kconfig                                 |    2 +
 arch/sparc/include/asm/hardirq_32.h                |   12 +-
 arch/sparc/include/asm/irq_32.h                    |    4 +-
 arch/sparc/include/asm/pgtable_64.h                |    4 +-
 arch/sparc/kernel/ktlb.S                           |    8 +-
 arch/sparc/kernel/ldc.c                            |    4 +-
 arch/sparc/kernel/perf_event.c                     |  579 ++++-
 arch/sparc/mm/init_64.c                            |    2 +-
 arch/sparc/oprofile/init.c                         |    1 +
 arch/um/drivers/line.c                             |    1 +
 arch/um/drivers/port_kern.c                        |    1 +
 arch/um/kernel/irq.c                               |    1 +
 arch/x86/Kconfig                                   |   19 +-
 arch/x86/Kconfig.cpu                               |    3 +-
 arch/x86/Makefile                                  |    1 -
 arch/x86/boot/setup.ld                             |    3 +
 arch/x86/crypto/aesni-intel_glue.c                 |   10 +-
 arch/x86/ia32/ia32entry.S                          |   41 +-
 arch/x86/include/asm/kvm_host.h                    |    1 +
 arch/x86/include/asm/mce.h                         |    2 +
 arch/x86/include/asm/paravirt.h                    |   28 +-
 arch/x86/include/asm/paravirt_types.h              |   10 +-
 arch/x86/include/asm/topology.h                    |    1 +
 arch/x86/include/asm/uv/uv_hub.h                   |   23 +-
 arch/x86/kernel/acpi/realmode/wakeup.lds.S         |    3 +
 arch/x86/kernel/apic/x2apic_uv_x.c                 |    8 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |   61 +-
 arch/x86/kernel/cpu/mcheck/mce_intel.c             |    1 +
 arch/x86/kernel/cpu/mtrr/if.c                      |   17 +-
 arch/x86/kernel/crash_dump_32.c                    |   19 +
 arch/x86/kernel/e820.c                             |    4 +-
 arch/x86/kernel/early_printk.c                     |    5 +-
 arch/x86/kernel/efi.c                              |    2 +
 arch/x86/kernel/i386_ksyms_32.c                    |    2 +
 arch/x86/kernel/irq.c                              |    4 +-
 arch/x86/kernel/pci-dma.c                          |    4 +-
 arch/x86/kernel/pci-gart_64.c                      |    1 +
 arch/x86/kernel/reboot.c                           |    1 +
 arch/x86/kernel/time.c                             |    3 +-
 arch/x86/kernel/tlb_uv.c                           |    9 +-
 arch/x86/kernel/trampoline.c                       |   12 +-
 arch/x86/kernel/trampoline_64.S                    |    4 +
 arch/x86/kernel/vmi_32.c                           |    2 +-
 arch/x86/kernel/vmlinux.lds.S                      |    3 +
 arch/x86/kvm/i8254.c                               |    2 +-
 arch/x86/kvm/lapic.c                               |    4 +-
 arch/x86/kvm/mmu.c                                 |   86 +-
 arch/x86/kvm/paging_tmpl.h                         |   18 +-
 arch/x86/kvm/svm.c                                 |   25 +-
 arch/x86/kvm/vmx.c                                 |    2 +-
 arch/x86/kvm/x86.c                                 |    2 +
 arch/x86/lib/Makefile                              |    6 +-
 arch/x86/xen/enlighten.c                           |    3 +-
 arch/xtensa/kernel/time.c                          |    1 +
 block/blk-core.c                                   |   18 +-
 block/blk-merge.c                                  |    2 +-
 block/blk-settings.c                               |    2 +-
 block/blk-tag.c                                    |    2 +-
 block/cfq-iosched.c                                |  259 +-
 block/elevator.c                                   |    4 +-
 block/genhd.c                                      |    4 +-
 crypto/aead.c                                      |    1 +
 crypto/async_tx/async_pq.c                         |   60 +-
 crypto/async_tx/async_raid6_recov.c                |  100 +-
 crypto/async_tx/async_xor.c                        |   18 +-
 drivers/acpi/Kconfig                               |    4 +-
 drivers/acpi/ac.c                                  |    1 +
 drivers/acpi/button.c                              |    3 +
 drivers/acpi/pci_root.c                            |   11 +
 drivers/acpi/video.c                               |    7 +-
 drivers/acpi/video_detect.c                        |    2 +-
 drivers/ata/ahci.c                                 |  201 +-
 drivers/ata/libata-acpi.c                          |   40 +-
 drivers/ata/libata-core.c                          |   15 +-
 drivers/ata/libata-eh.c                            |   56 +-
 drivers/ata/libata.h                               |    2 +
 drivers/ata/pata_ali.c                             |    2 +-
 drivers/ata/pata_atiixp.c                          |    2 +-
 drivers/ata/pata_atp867x.c                         |  101 +-
 drivers/ata/pata_sc1200.c                          |    3 +-
 drivers/ata/pata_via.c                             |    2 +-
 drivers/ata/sata_mv.c                              |   29 +-
 drivers/ata/sata_nv.c                              |   18 +-
 drivers/base/bus.c                                 |   17 +-
 drivers/base/driver.c                              |    2 +-
 drivers/base/platform.c                            |    6 +-
 drivers/base/power/main.c                          |    1 +
 drivers/base/power/runtime.c                       |    4 -
 drivers/block/cciss.c                              |   79 +-
 drivers/block/loop.c                               |    2 +-
 drivers/block/virtio_blk.c                         |   39 +-
 drivers/char/Kconfig                               |    6 +-
 drivers/char/agp/parisc-agp.c                      |    2 +-
 drivers/char/applicom.c                            |    1 +
 drivers/char/epca.c                                |    1 +
 drivers/char/generic_serial.c                      |    1 +
 drivers/char/genrtc.c                              |    1 +
 drivers/char/hw_random/virtio-rng.c                |    3 +-
 drivers/char/istallion.c                           |    1 +
 drivers/char/nozomi.c                              |    1 +
 drivers/char/pty.c                                 |    1 +
 drivers/char/rio/riocmd.c                          |    1 +
 drivers/char/rio/rioctrl.c                         |    1 +
 drivers/char/rio/riotty.c                          |    1 +
 drivers/char/rtc.c                                 |    1 +
 drivers/char/ser_a2232.c                           |    1 +
 drivers/char/sonypi.c                              |    1 +
 drivers/char/stallion.c                            |    1 +
 drivers/char/tlclk.c                               |    1 +
 drivers/char/tpm/tpm.c                             |    3 +-
 drivers/char/tty_buffer.c                          |   31 +-
 drivers/char/virtio_console.c                      |    1 -
 drivers/char/vt_ioctl.c                            |    2 +-
 drivers/connector/cn_proc.c                        |    3 +-
 drivers/cpuidle/cpuidle.c                          |    5 +-
 drivers/crypto/padlock-sha.c                       |   14 +-
 drivers/edac/Kconfig                               |   14 +-
 drivers/edac/Makefile                              |    5 +-
 drivers/edac/amd64_edac.c                          |  100 +-
 drivers/edac/amd64_edac.h                          |   23 +-
 drivers/edac/amd64_edac_inj.c                      |   49 +-
 drivers/edac/edac_mce_amd.c                        |   32 +-
 drivers/edac/i5000_edac.c                          |    7 +-
 drivers/edac/i5400_edac.c                          |   89 +-
 drivers/edac/mpc85xx_edac.c                        |    2 +
 drivers/firewire/sbp2.c                            |   39 +-
 drivers/firmware/iscsi_ibft.c                      |    2 +-
 drivers/firmware/iscsi_ibft_find.c                 |    4 +-
 drivers/gpio/twl4030-gpio.c                        |    5 +-
 drivers/gpu/drm/drm_crtc.c                         |    2 -
 drivers/gpu/drm/drm_edid.c                         |   15 +
 drivers/gpu/drm/drm_fb_helper.c                    |  154 +-
 drivers/gpu/drm/i915/i915_dma.c                    |    1 +
 drivers/gpu/drm/i915/i915_drv.c                    |    5 +-
 drivers/gpu/drm/i915/i915_drv.h                    |    4 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   10 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   10 +
 drivers/gpu/drm/i915/i915_trace.h                  |   49 +-
 drivers/gpu/drm/i915/intel_display.c               |   15 +-
 drivers/gpu/drm/i915/intel_drv.h                   |    2 +
 drivers/gpu/drm/i915/intel_fb.c                    |   10 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |    2 +-
 drivers/gpu/drm/i915/intel_lvds.c                  |   25 +-
 drivers/gpu/drm/i915/intel_tv.c                    |    3 +-
 drivers/gpu/drm/radeon/atombios_crtc.c             |    1 +
 drivers/gpu/drm/radeon/r100.c                      |  432 ++-
 drivers/gpu/drm/radeon/r100d.h                     |  145 +-
 drivers/gpu/drm/radeon/r200.c                      |    3 +-
 drivers/gpu/drm/radeon/r300.c                      |  308 ++-
 drivers/gpu/drm/radeon/r300d.h                     |  205 ++
 drivers/gpu/drm/radeon/r420.c                      |    6 +-
 drivers/gpu/drm/radeon/r420d.h                     |   24 +-
 drivers/gpu/drm/radeon/r520.c                      |    3 +-
 drivers/gpu/drm/radeon/r600.c                      |  314 +-
 drivers/gpu/drm/radeon/r600_blit.c                 |   10 +-
 drivers/gpu/drm/radeon/r600_blit_kms.c             |    3 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |    2 +-
 drivers/gpu/drm/radeon/r600d.h                     |    1 +
 drivers/gpu/drm/radeon/radeon.h                    |   58 +-
 drivers/gpu/drm/radeon/radeon_asic.h               |  253 +--
 drivers/gpu/drm/radeon/radeon_bios.c               |   49 +-
 drivers/gpu/drm/radeon/radeon_clocks.c             |    8 +-
 drivers/gpu/drm/radeon/radeon_device.c             |  244 +--
 drivers/gpu/drm/radeon/radeon_display.c            |   45 +-
 drivers/gpu/drm/radeon/radeon_encoders.c           |    6 +-
 drivers/gpu/drm/radeon/radeon_fb.c                 |   18 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |    6 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c        |    1 +
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |    9 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |    2 +
 drivers/gpu/drm/radeon/radeon_object.c             |   17 +-
 drivers/gpu/drm/radeon/rs100d.h                    |   40 +
 drivers/gpu/drm/radeon/rs400.c                     |  275 ++-
 drivers/gpu/drm/radeon/rs400d.h                    |  160 +
 drivers/gpu/drm/radeon/rs600.c                     |  481 ++--
 drivers/gpu/drm/radeon/rs600d.h                    |  470 +++
 drivers/gpu/drm/radeon/rs690.c                     |  355 ++-
 drivers/gpu/drm/radeon/rs690d.h                    |  307 ++
 drivers/gpu/drm/radeon/rs690r.h                    |   99 -
 drivers/gpu/drm/radeon/rv200d.h                    |   36 +
 drivers/gpu/drm/radeon/rv250d.h                    |  123 +
 drivers/gpu/drm/radeon/rv350d.h                    |   52 +
 drivers/gpu/drm/radeon/rv515.c                     |    5 +-
 drivers/gpu/drm/radeon/rv770.c                     |  199 +-
 drivers/gpu/drm/ttm/ttm_global.c                   |    2 +-
 drivers/hid/hid-core.c                             |    2 +-
 drivers/hid/hid-twinhan.c                          |    4 +-
 drivers/hid/hidraw.c                               |    5 +-
 drivers/hwmon/Kconfig                              |    2 +-
 drivers/hwmon/asus_atk0110.c                       |  339 ++-
 drivers/hwmon/dme1737.c                            |   29 +-
 drivers/hwmon/fschmd.c                             |    2 +-
 drivers/hwmon/hp_accel.c                           |    5 +-
 drivers/hwmon/it87.c                               |    5 +-
 drivers/hwmon/lis3lv02d_spi.c                      |    3 +-
 drivers/hwmon/sht15.c                              |    8 +-
 drivers/i2c/busses/i2c-imx.c                       |   86 +-
 drivers/i2c/busses/i2c-mpc.c                       |   10 +-
 drivers/ide/atiixp.c                               |    2 +-
 drivers/ide/cmd64x.c                               |    6 +-
 drivers/ide/ide-proc.c                             |    8 +-
 drivers/ide/sis5513.c                              |   10 +-
 drivers/ieee1394/raw1394.c                         |    1 +
 drivers/ieee1394/video1394.c                       |    1 +
 drivers/infiniband/core/addr.c                     |    2 +-
 drivers/infiniband/core/iwcm.c                     |    3 +
 drivers/infiniband/core/ucma.c                     |    1 +
 drivers/infiniband/hw/cxgb3/iwch_provider.c        |   12 +-
 drivers/infiniband/hw/cxgb3/iwch_qp.c              |    1 +
 drivers/infiniband/hw/ipath/ipath_driver.c         |    1 +
 drivers/infiniband/hw/ipath/ipath_iba7220.c        |    1 +
 drivers/infiniband/hw/ipath/ipath_intr.c           |    1 +
 drivers/infiniband/hw/ipath/ipath_qp.c             |    1 +
 drivers/infiniband/hw/ipath/ipath_ruc.c            |    1 +
 drivers/infiniband/hw/ipath/ipath_ud.c             |    1 +
 drivers/infiniband/hw/ipath/ipath_user_pages.c     |    1 +
 drivers/infiniband/hw/ipath/ipath_user_sdma.c      |    1 +
 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c    |    1 +
 drivers/infiniband/ulp/iser/iscsi_iser.c           |    2 +-
 drivers/input/input.c                              |   65 +-
 drivers/input/joystick/xpad.c                      |    2 +
 drivers/input/keyboard/atkbd.c                     |  132 +-
 drivers/input/keyboard/gpio_keys.c                 |    1 +
 drivers/input/keyboard/hilkbd.c                    |    1 +
 drivers/input/keyboard/sunkbd.c                    |    1 +
 drivers/input/misc/Kconfig                         |    1 +
 drivers/input/misc/hp_sdc_rtc.c                    |    2 +-
 drivers/input/misc/rotary_encoder.c                |    4 +-
 drivers/input/misc/sparcspkr.c                     |    4 +-
 drivers/input/misc/wistron_btns.c                  |    9 +
 drivers/input/mouse/logips2pp.c                    |    2 +-
 drivers/input/mouse/synaptics.c                    |   10 +
 drivers/input/serio/Kconfig                        |   13 +-
 drivers/input/serio/i8042-x86ia64io.h              |   13 +-
 drivers/input/serio/i8042.c                        |   38 +-
 drivers/input/serio/libps2.c                       |    1 +
 drivers/input/serio/serio_raw.c                    |    1 +
 drivers/input/serio/serport.c                      |    1 +
 drivers/input/touchscreen/ad7879.c                 |    4 +-
 drivers/isdn/capi/capi.c                           |    2 +-
 drivers/isdn/capi/capidrv.c                        |   27 +-
 drivers/isdn/capi/kcapi.c                          |    1 +
 drivers/isdn/gigaset/asyncdata.c                   |   28 +-
 drivers/isdn/gigaset/bas-gigaset.c                 |   87 +-
 drivers/isdn/gigaset/common.c                      |  134 +-
 drivers/isdn/gigaset/ev-layer.c                    |   30 +-
 drivers/isdn/gigaset/i4l.c                         |   23 +
 drivers/isdn/gigaset/interface.c                   |    9 +
 drivers/isdn/gigaset/isocdata.c                    |   30 +-
 drivers/isdn/hisax/arcofi.c                        |    1 +
 drivers/isdn/hisax/hfc_2bds0.c                     |    1 +
 drivers/isdn/hisax/hfc_pci.c                       |    1 +
 drivers/isdn/hysdn/hysdn_procconf.c                |    1 +
 drivers/isdn/hysdn/hysdn_proclog.c                 |    1 +
 drivers/isdn/i4l/isdn_net.h                        |    6 +-
 drivers/isdn/pcbit/drv.c                           |    1 +
 drivers/isdn/pcbit/layer2.c                        |    1 +
 drivers/isdn/sc/init.c                             |    1 +
 drivers/lguest/interrupts_and_traps.c              |    1 +
 drivers/macintosh/via-pmu.c                        |   40 +-
 drivers/md/Makefile                                |   22 +-
 drivers/md/bitmap.c                                |    9 +-
 drivers/md/dm-exception-store.c                    |   38 +-
 drivers/md/dm-exception-store.h                    |    8 +-
 drivers/md/dm-log-userspace-base.c                 |    2 +-
 drivers/md/dm-snap-persistent.c                    |   16 +-
 drivers/md/dm-snap.c                               |   25 +-
 drivers/md/dm.c                                    |   27 +-
 drivers/md/md.c                                    |    2 +-
 drivers/md/raid1.c                                 |    6 +-
 drivers/md/raid10.c                                |    5 +-
 drivers/md/raid5.c                                 |  182 +-
 drivers/md/raid5.h                                 |   14 +-
 drivers/md/raid6altivec.uc                         |    2 +-
 drivers/md/raid6int.uc                             |    2 +-
 drivers/md/raid6test/Makefile                      |   42 +-
 drivers/md/unroll.awk                              |   20 +
 drivers/md/unroll.pl                               |   24 -
 drivers/media/dvb/dvb-core/dvb_net.c               |    1 +
 drivers/media/video/meye.c                         |    1 +
 drivers/media/video/videobuf-core.c                |    1 +
 drivers/media/video/videobuf-dma-sg.c              |    1 +
 drivers/message/fusion/mptlan.c                    |    1 +
 drivers/mfd/twl4030-core.c                         |   91 +-
 drivers/mfd/ucb1x00-core.c                         |    1 +
 drivers/mfd/wm831x-irq.c                           |    3 +-
 drivers/misc/hpilo.c                               |    1 +
 drivers/misc/ibmasm/command.c                      |    1 +
 drivers/misc/ibmasm/event.c                        |    1 +
 drivers/misc/ibmasm/r_heartbeat.c                  |    1 +
 drivers/misc/phantom.c                             |    1 +
 drivers/mmc/core/sdio_cis.c                        |    7 +-
 drivers/mmc/host/at91_mci.c                        |    1 -
 drivers/mmc/host/omap_hsmmc.c                      |    2 +-
 drivers/mmc/host/pxamci.c                          |    4 +-
 drivers/mtd/devices/m25p80.c                       |    1 +
 drivers/mtd/devices/sst25l.c                       |    1 +
 drivers/mtd/ubi/build.c                            |    3 +-
 drivers/mtd/ubi/scan.c                             |    7 +-
 drivers/mtd/ubi/scan.h                             |    2 -
 drivers/net/Kconfig                                |   11 +
 drivers/net/Makefile                               |   10 +-
 drivers/net/acenic.c                               |    3 +-
 drivers/net/au1000_eth.c                           |    5 +-
 drivers/net/benet/be_cmds.c                        |   34 +-
 drivers/net/benet/be_cmds.h                        |    7 +-
 drivers/net/benet/be_ethtool.c                     |    2 +-
 drivers/net/benet/be_main.c                        |   33 +-
 drivers/net/bnx2.h                                 |    9 +-
 drivers/net/bonding/bond_main.c                    |   10 +-
 drivers/net/bonding/bond_sysfs.c                   |    1 +
 drivers/net/can/sja1000/sja1000_of_platform.c      |    1 +
 drivers/net/cnic.c                                 |    6 +-
 drivers/net/davinci_emac.c                         |   36 +-
 drivers/net/depca.c                                |    1 +
 drivers/net/dm9000.h                               |    2 +-
 drivers/net/e100.c                                 |   27 +-
 drivers/net/e1000e/82571.c                         |    4 +-
 drivers/net/e1000e/defines.h                       |    2 +
 drivers/net/e1000e/e1000.h                         |   26 +
 drivers/net/e1000e/hw.h                            |    3 +
 drivers/net/e1000e/ich8lan.c                       |  628 +++-
 drivers/net/e1000e/phy.c                           |  476 ++-
 drivers/net/eql.c                                  |    1 +
 drivers/net/ethoc.c                                |  104 +-
 drivers/net/ewrk3.c                                |    1 +
 drivers/net/fec.c                                  |    2 +-
 drivers/net/fec_mpc52xx.c                          |    6 -
 drivers/net/fec_mpc52xx_phy.c                      |    1 +
 drivers/net/forcedeth.c                            |    1 +
 drivers/net/fs_enet/fs_enet-main.c                 |    1 +
 drivers/net/fs_enet/mii-bitbang.c                  |    1 +
 drivers/net/fs_enet/mii-fec.c                      |    1 +
 drivers/net/fsl_pq_mdio.c                          |    1 +
 drivers/net/gianfar.c                              |    4 +-
 drivers/net/hamachi.c                              |    1 +
 drivers/net/hamradio/baycom_epp.c                  |    1 +
 drivers/net/hamradio/baycom_ser_fdx.c              |    1 +
 drivers/net/hamradio/baycom_ser_hdx.c              |    1 +
 drivers/net/hamradio/hdlcdrv.c                     |    1 +
 drivers/net/hp100.c                                |    1 +
 drivers/net/ibm_newemac/core.c                     |    9 +-
 drivers/net/ibm_newemac/emac.h                     |    1 +
 drivers/net/ifb.c                                  |    3 +-
 drivers/net/igb/igb_ethtool.c                      |   36 +-
 drivers/net/igbvf/ethtool.c                        |   30 +-
 drivers/net/irda/sa1100_ir.c                       |    7 +-
 drivers/net/irda/toim3232-sir.c                    |    1 +
 drivers/net/ixgbe/ixgbe_82599.c                    |    2 +
 drivers/net/ixgbe/ixgbe_ethtool.c                  |   22 +-
 drivers/net/ixgbe/ixgbe_main.c                     |    4 +
 drivers/net/ixgbe/ixgbe_type.h                     |    2 +
 drivers/net/ixp2000/enp2611.c                      |   18 +-
 drivers/net/ixp2000/ixpdev.c                       |   11 +
 drivers/net/ks8851.c                               |   42 +-
 drivers/net/ks8851.h                               |    1 +
 drivers/net/mlx4/main.c                            |    2 +
 drivers/net/myri10ge/myri10ge.c                    |   17 +-
 drivers/net/netxen/netxen_nic_hdr.h                |    1 +
 drivers/net/netxen/netxen_nic_hw.c                 |   14 +-
 drivers/net/netxen/netxen_nic_init.c               |    8 +-
 drivers/net/netxen/netxen_nic_main.c               |    6 +-
 drivers/net/niu.c                                  |    2 +-
 drivers/net/ns83820.c                              |    1 +
 drivers/net/pasemi_mac_ethtool.c                   |    3 +
 drivers/net/pcmcia/3c574_cs.c                      |   13 +-
 drivers/net/pcmcia/pcnet_cs.c                      |   12 +-
 drivers/net/pcnet32.c                              |    1 +
 drivers/net/phy/mdio-gpio.c                        |    1 +
 drivers/net/pppoe.c                                |  129 +-
 drivers/net/qlge/qlge.h                            |   19 +-
 drivers/net/qlge/qlge_ethtool.c                    |    2 -
 drivers/net/qlge/qlge_main.c                       |  193 +-
 drivers/net/qlge/qlge_mpi.c                        |  128 +-
 drivers/net/r8169.c                                | 1002 ++++++-
 drivers/net/sb1000.c                               |    1 +
 drivers/net/sfc/rx.c                               |    9 +-
 drivers/net/sh_eth.c                               |    1 +
 drivers/net/sis900.c                               |    1 +
 drivers/net/skfp/skfddi.c                          |    1 +
 drivers/net/skge.c                                 |    1 +
 drivers/net/sky2.c                                 |    2 +
 drivers/net/slip.c                                 |    1 +
 drivers/net/stmmac/Kconfig                         |   53 +
 drivers/net/stmmac/Makefile                        |    4 +
 drivers/net/stmmac/common.h                        |  330 ++
 drivers/net/stmmac/descs.h                         |  163 +
 drivers/net/stmmac/gmac.c                          |  693 ++++
 drivers/net/stmmac/gmac.h                          |  204 ++
 drivers/net/stmmac/mac100.c                        |  517 +++
 drivers/net/stmmac/mac100.h                        |  116 +
 drivers/net/stmmac/stmmac.h                        |   98 +
 drivers/net/stmmac/stmmac_ethtool.c                |  395 +++
 drivers/net/stmmac/stmmac_main.c                   | 2204 +++++++++++++
 drivers/net/stmmac/stmmac_mdio.c                   |  217 ++
 drivers/net/stmmac/stmmac_timer.c                  |  140 +
 drivers/net/stmmac/stmmac_timer.h                  |   41 +
 drivers/net/sungem.c                               |    1 +
 drivers/net/tg3.c                                  |   41 +-
 drivers/net/tg3.h                                  |    1 -
 drivers/net/tokenring/ibmtr.c                      |   12 +-
 drivers/net/typhoon.c                              |    1 +
 drivers/net/usb/dm9601.c                           |    4 +
 drivers/net/usb/pegasus.c                          |   13 +
 drivers/net/usb/pegasus.h                          |    6 +-
 drivers/net/usb/rndis_host.c                       |    7 +-
 drivers/net/virtio_net.c                           |   17 +-
 drivers/net/vmxnet3/Makefile                       |   35 +
 drivers/net/vmxnet3/upt1_defs.h                    |   96 +
 drivers/net/vmxnet3/vmxnet3_defs.h                 |  535 +++
 drivers/net/vmxnet3/vmxnet3_drv.c                  | 2574 +++++++++++++++
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |  566 ++++
 drivers/net/vmxnet3/vmxnet3_int.h                  |  389 +++
 drivers/net/wan/c101.c                             |    1 +
 drivers/net/wan/cosa.c                             |    1 +
 drivers/net/wan/cycx_x25.c                         |    1 +
 drivers/net/wan/dscc4.c                            |    1 +
 drivers/net/wan/farsync.c                          |    1 +
 drivers/net/wan/hdlc_cisco.c                       |   18 +-
 drivers/net/wan/n2.c                               |    1 +
 drivers/net/wan/pci200syn.c                        |    1 +
 drivers/net/wireless/adm8211.h                     |    2 +-
 drivers/net/wireless/airo.c                        |    5 +-
 drivers/net/wireless/ath/ath9k/rc.c                |    2 +-
 drivers/net/wireless/b43/b43.h                     |  168 +-
 drivers/net/wireless/b43/dma.c                     |   15 +-
 drivers/net/wireless/b43/leds.c                    |    4 +-
 drivers/net/wireless/b43/leds.h                    |    5 +-
 drivers/net/wireless/b43/main.c                    |    6 +-
 drivers/net/wireless/b43/pio.c                     |   79 +-
 drivers/net/wireless/b43/rfkill.c                  |    3 +-
 drivers/net/wireless/b43/xmit.c                    |    5 +-
 drivers/net/wireless/b43legacy/main.c              |    1 +
 drivers/net/wireless/b43legacy/phy.c               |    1 +
 drivers/net/wireless/hostap/hostap_info.c          |    1 +
 drivers/net/wireless/hostap/hostap_ioctl.c         |    1 +
 drivers/net/wireless/ipw2x00/ipw2100.c             |    5 +-
 drivers/net/wireless/ipw2x00/ipw2200.c             |    3 +
 drivers/net/wireless/ipw2x00/libipw.h              |    1 +
 drivers/net/wireless/ipw2x00/libipw_module.c       |   14 +-
 drivers/net/wireless/iwlwifi/iwl-3945-rs.c         |    2 +-
 drivers/net/wireless/iwlwifi/iwl-3945.c            |    3 +-
 drivers/net/wireless/iwlwifi/iwl-4965.c            |    1 +
 drivers/net/wireless/iwlwifi/iwl-5000.c            |    3 +-
 drivers/net/wireless/iwlwifi/iwl-agn.c             |    3 +-
 drivers/net/wireless/iwlwifi/iwl-commands.h        |    2 +-
 drivers/net/wireless/iwlwifi/iwl-core.c            |    1 +
 drivers/net/wireless/iwlwifi/iwl-eeprom.c          |   23 +-
 drivers/net/wireless/iwlwifi/iwl-eeprom.h          |   20 +-
 drivers/net/wireless/iwlwifi/iwl-hcmd.c            |    1 +
 drivers/net/wireless/iwlwifi/iwl-rx.c              |    2 +-
 drivers/net/wireless/iwlwifi/iwl-tx.c              |    1 +
 drivers/net/wireless/iwlwifi/iwl3945-base.c        |    3 +-
 drivers/net/wireless/iwmc3200wifi/cfg80211.c       |    1 +
 drivers/net/wireless/iwmc3200wifi/commands.c       |    1 +
 drivers/net/wireless/iwmc3200wifi/main.c           |    1 +
 drivers/net/wireless/iwmc3200wifi/rx.c             |    1 +
 drivers/net/wireless/libertas/cmd.c                |    1 +
 drivers/net/wireless/libertas/cmdresp.c            |    1 +
 drivers/net/wireless/libertas/if_spi.c             |   10 +-
 drivers/net/wireless/libertas/if_usb.c             |    2 +-
 drivers/net/wireless/libertas/tx.c                 |    1 +
 drivers/net/wireless/prism54/isl_ioctl.c           |    1 +
 drivers/net/wireless/prism54/islpci_dev.c          |    1 +
 drivers/net/wireless/prism54/islpci_mgt.c          |    1 +
 drivers/net/wireless/ray_cs.c                      |    2 +-
 drivers/net/wireless/rt2x00/rt2800usb.c            |    2 +-
 drivers/net/wireless/rt2x00/rt2x00debug.c          |    1 +
 drivers/net/wireless/rt2x00/rt73usb.c              |    5 +
 drivers/net/znet.c                                 |    8 -
 drivers/of/of_mdio.c                               |   13 +-
 drivers/oprofile/event_buffer.c                    |   35 +-
 drivers/pci/dmar.c                                 |   13 +-
 drivers/pci/hotplug/cpqphp.h                       |    1 +
 drivers/pci/intel-iommu.c                          |   82 +-
 drivers/pci/pci.c                                  |   27 +-
 drivers/pci/pcie/aer/aerdrv.c                      |    3 +-
 drivers/pci/pcie/portdrv_pci.c                     |    3 +-
 drivers/pci/quirks.c                               |   38 +-
 drivers/pci/setup-res.c                            |   37 -
 drivers/pcmcia/cistpl.c                            |   20 +-
 drivers/pcmcia/cs.c                                |   69 +-
 drivers/pcmcia/cs_internal.h                       |    3 +-
 drivers/pcmcia/ds.c                                |    8 +-
 drivers/pcmcia/i82365.c                            |    4 +-
 drivers/pcmcia/m32r_cfc.c                          |   10 +-
 drivers/pcmcia/m32r_pcc.c                          |   10 +-
 drivers/pcmcia/m8xx_pcmcia.c                       |   15 +-
 drivers/pcmcia/pcmcia_ioctl.c                      |    2 +-
 drivers/pcmcia/pd6729.c                            |    6 +
 drivers/pcmcia/rsrc_nonstatic.c                    |    3 +-
 drivers/pcmcia/soc_common.c                        |    5 +-
 drivers/pcmcia/socket_sysfs.c                      |    2 +-
 drivers/pcmcia/tcic.c                              |    4 +-
 drivers/pcmcia/yenta_socket.c                      |   12 +-
 drivers/platform/x86/eeepc-laptop.c                |   31 +-
 drivers/platform/x86/fujitsu-laptop.c              |    2 +-
 drivers/rtc/interface.c                            |    1 +
 drivers/rtc/rtc-dev.c                              |    1 +
 drivers/s390/block/dasd.c                          |   18 +-
 drivers/s390/block/dasd_eckd.c                     |   13 +-
 drivers/s390/char/raw3270.c                        |    2 +
 drivers/s390/char/sclp_async.c                     |   51 +-
 drivers/s390/char/sclp_vt220.c                     |   30 +-
 drivers/s390/char/tape_block.c                     |    3 +-
 drivers/s390/cio/blacklist.c                       |   13 +-
 drivers/s390/cio/chp.c                             |    2 +-
 drivers/s390/cio/device.c                          |   13 +-
 drivers/s390/cio/device.h                          |    1 +
 drivers/s390/cio/device_fsm.c                      |   35 +-
 drivers/s390/crypto/zcrypt_pcixcc.c                |   13 +-
 drivers/s390/net/smsgiucv.c                        |    7 +-
 drivers/s390/scsi/zfcp_aux.c                       |   44 +-
 drivers/s390/scsi/zfcp_ccw.c                       |   40 +-
 drivers/s390/scsi/zfcp_cfdc.c                      |   17 +-
 drivers/s390/scsi/zfcp_erp.c                       |   22 +-
 drivers/s390/scsi/zfcp_ext.h                       |    3 +-
 drivers/s390/scsi/zfcp_fc.c                        |   11 +
 drivers/s390/scsi/zfcp_fsf.c                       |   35 +-
 drivers/s390/scsi/zfcp_sysfs.c                     |    1 +
 drivers/scsi/Kconfig                               |   11 +
 drivers/scsi/Makefile                              |    2 +
 drivers/scsi/be2iscsi/Kconfig                      |    8 +
 drivers/scsi/be2iscsi/Makefile                     |    8 +
 drivers/scsi/be2iscsi/be.h                         |  183 ++
 drivers/scsi/be2iscsi/be_cmds.c                    |  523 +++
 drivers/scsi/be2iscsi/be_cmds.h                    |  877 +++++
 drivers/scsi/be2iscsi/be_iscsi.c                   |  638 ++++
 drivers/scsi/be2iscsi/be_iscsi.h                   |   75 +
 drivers/scsi/be2iscsi/be_main.c                    | 3390 ++++++++++++++++=
++++
 drivers/scsi/be2iscsi/be_main.h                    |  837 +++++
 drivers/scsi/be2iscsi/be_mgmt.c                    |  321 ++
 drivers/scsi/be2iscsi/be_mgmt.h                    |  249 ++
 drivers/scsi/bfa/Makefile                          |   15 +
 drivers/scsi/bfa/bfa_callback_priv.h               |   57 +
 drivers/scsi/bfa/bfa_cb_ioim_macros.h              |  205 ++
 drivers/scsi/bfa/bfa_cee.c                         |  492 +++
 drivers/scsi/bfa/bfa_core.c                        |  402 +++
 drivers/scsi/bfa/bfa_csdebug.c                     |   58 +
 drivers/scsi/bfa/bfa_fcpim.c                       |  175 +
 drivers/scsi/bfa/bfa_fcpim_priv.h                  |  188 ++
 drivers/scsi/bfa/bfa_fcport.c                      | 1671 ++++++++++
 drivers/scsi/bfa/bfa_fcs.c                         |  182 ++
 drivers/scsi/bfa/bfa_fcs_lport.c                   |  940 ++++++
 drivers/scsi/bfa/bfa_fcs_port.c                    |   68 +
 drivers/scsi/bfa/bfa_fcs_uf.c                      |  105 +
 drivers/scsi/bfa/bfa_fcxp.c                        |  782 +++++
 drivers/scsi/bfa/bfa_fcxp_priv.h                   |  138 +
 drivers/scsi/bfa/bfa_fwimg_priv.h                  |   31 +
 drivers/scsi/bfa/bfa_hw_cb.c                       |  142 +
 drivers/scsi/bfa/bfa_hw_ct.c                       |  162 +
 drivers/scsi/bfa/bfa_intr.c                        |  218 ++
 drivers/scsi/bfa/bfa_intr_priv.h                   |  115 +
 drivers/scsi/bfa/bfa_ioc.c                         | 2382 ++++++++++++++
 drivers/scsi/bfa/bfa_ioc.h                         |  259 ++
 drivers/scsi/bfa/bfa_iocfc.c                       |  872 +++++
 drivers/scsi/bfa/bfa_iocfc.h                       |  168 +
 drivers/scsi/bfa/bfa_iocfc_q.c                     |   44 +
 drivers/scsi/bfa/bfa_ioim.c                        | 1311 ++++++++
 drivers/scsi/bfa/bfa_itnim.c                       | 1088 +++++++
 drivers/scsi/bfa/bfa_log.c                         |  346 ++
 drivers/scsi/bfa/bfa_log_module.c                  |  451 +++
 drivers/scsi/bfa/bfa_lps.c                         |  782 +++++
 drivers/scsi/bfa/bfa_lps_priv.h                    |   38 +
 drivers/scsi/bfa/bfa_module.c                      |   90 +
 drivers/scsi/bfa/bfa_modules_priv.h                |   43 +
 drivers/scsi/bfa/bfa_os_inc.h                      |  222 ++
 drivers/scsi/bfa/bfa_port.c                        |  460 +++
 drivers/scsi/bfa/bfa_port_priv.h                   |   90 +
 drivers/scsi/bfa/bfa_priv.h                        |  113 +
 drivers/scsi/bfa/bfa_rport.c                       |  911 ++++++
 drivers/scsi/bfa/bfa_rport_priv.h                  |   45 +
 drivers/scsi/bfa/bfa_sgpg.c                        |  231 ++
 drivers/scsi/bfa/bfa_sgpg_priv.h                   |   79 +
 drivers/scsi/bfa/bfa_sm.c                          |   38 +
 drivers/scsi/bfa/bfa_timer.c                       |   90 +
 drivers/scsi/bfa/bfa_trcmod_priv.h                 |   66 +
 drivers/scsi/bfa/bfa_tskim.c                       |  689 ++++
 drivers/scsi/bfa/bfa_uf.c                          |  345 ++
 drivers/scsi/bfa/bfa_uf_priv.h                     |   47 +
 drivers/scsi/bfa/bfad.c                            | 1182 +++++++
 drivers/scsi/bfa/bfad_attr.c                       |  649 ++++
 drivers/scsi/bfa/bfad_attr.h                       |   65 +
 drivers/scsi/bfa/bfad_drv.h                        |  295 ++
 drivers/scsi/bfa/bfad_fwimg.c                      |   95 +
 drivers/scsi/bfa/bfad_im.c                         | 1230 +++++++
 drivers/scsi/bfa/bfad_im.h                         |  150 +
 drivers/scsi/bfa/bfad_im_compat.h                  |   46 +
 drivers/scsi/bfa/bfad_intr.c                       |  214 ++
 drivers/scsi/bfa/bfad_ipfc.h                       |   42 +
 drivers/scsi/bfa/bfad_os.c                         |   50 +
 drivers/scsi/bfa/bfad_tm.h                         |   59 +
 drivers/scsi/bfa/bfad_trcmod.h                     |   52 +
 drivers/scsi/bfa/fab.c                             |   62 +
 drivers/scsi/bfa/fabric.c                          | 1278 ++++++++
 drivers/scsi/bfa/fcbuild.c                         | 1449 +++++++++
 drivers/scsi/bfa/fcbuild.h                         |  273 ++
 drivers/scsi/bfa/fcpim.c                           |  844 +++++
 drivers/scsi/bfa/fcptm.c                           |   68 +
 drivers/scsi/bfa/fcs.h                             |   30 +
 drivers/scsi/bfa/fcs_auth.h                        |   37 +
 drivers/scsi/bfa/fcs_fabric.h                      |   61 +
 drivers/scsi/bfa/fcs_fcpim.h                       |   44 +
 drivers/scsi/bfa/fcs_fcptm.h                       |   45 +
 drivers/scsi/bfa/fcs_fcxp.h                        |   29 +
 drivers/scsi/bfa/fcs_lport.h                       |  117 +
 drivers/scsi/bfa/fcs_ms.h                          |   35 +
 drivers/scsi/bfa/fcs_port.h                        |   32 +
 drivers/scsi/bfa/fcs_rport.h                       |   61 +
 drivers/scsi/bfa/fcs_trcmod.h                      |   56 +
 drivers/scsi/bfa/fcs_uf.h                          |   32 +
 drivers/scsi/bfa/fcs_vport.h                       |   39 +
 drivers/scsi/bfa/fdmi.c                            | 1223 +++++++
 drivers/scsi/bfa/include/aen/bfa_aen.h             |   92 +
 drivers/scsi/bfa/include/aen/bfa_aen_adapter.h     |   31 +
 drivers/scsi/bfa/include/aen/bfa_aen_audit.h       |   31 +
 drivers/scsi/bfa/include/aen/bfa_aen_ethport.h     |   35 +
 drivers/scsi/bfa/include/aen/bfa_aen_ioc.h         |   37 +
 drivers/scsi/bfa/include/aen/bfa_aen_itnim.h       |   33 +
 drivers/scsi/bfa/include/aen/bfa_aen_lport.h       |   51 +
 drivers/scsi/bfa/include/aen/bfa_aen_port.h        |   57 +
 drivers/scsi/bfa/include/aen/bfa_aen_rport.h       |   37 +
 drivers/scsi/bfa/include/bfa.h                     |  177 +
 drivers/scsi/bfa/include/bfa_fcpim.h               |  159 +
 drivers/scsi/bfa/include/bfa_fcptm.h               |   47 +
 drivers/scsi/bfa/include/bfa_svc.h                 |  324 ++
 drivers/scsi/bfa/include/bfa_timer.h               |   53 +
 drivers/scsi/bfa/include/bfi/bfi.h                 |  174 +
 drivers/scsi/bfa/include/bfi/bfi_boot.h            |   34 +
 drivers/scsi/bfa/include/bfi/bfi_cbreg.h           |  305 ++
 drivers/scsi/bfa/include/bfi/bfi_cee.h             |  119 +
 drivers/scsi/bfa/include/bfi/bfi_ctreg.h           |  611 ++++
 drivers/scsi/bfa/include/bfi/bfi_fabric.h          |   92 +
 drivers/scsi/bfa/include/bfi/bfi_fcpim.h           |  301 ++
 drivers/scsi/bfa/include/bfi/bfi_fcxp.h            |   71 +
 drivers/scsi/bfa/include/bfi/bfi_ioc.h             |  202 ++
 drivers/scsi/bfa/include/bfi/bfi_iocfc.h           |  177 +
 drivers/scsi/bfa/include/bfi/bfi_lport.h           |   89 +
 drivers/scsi/bfa/include/bfi/bfi_lps.h             |   96 +
 drivers/scsi/bfa/include/bfi/bfi_port.h            |  115 +
 drivers/scsi/bfa/include/bfi/bfi_pport.h           |  184 ++
 drivers/scsi/bfa/include/bfi/bfi_rport.h           |  104 +
 drivers/scsi/bfa/include/bfi/bfi_uf.h              |   52 +
 drivers/scsi/bfa/include/cna/bfa_cna_trcmod.h      |   36 +
 drivers/scsi/bfa/include/cna/cee/bfa_cee.h         |   77 +
 drivers/scsi/bfa/include/cna/port/bfa_port.h       |   69 +
 drivers/scsi/bfa/include/cna/pstats/ethport_defs.h |   36 +
 drivers/scsi/bfa/include/cna/pstats/phyport_defs.h |  218 ++
 drivers/scsi/bfa/include/cs/bfa_checksum.h         |   60 +
 drivers/scsi/bfa/include/cs/bfa_debug.h            |   44 +
 drivers/scsi/bfa/include/cs/bfa_log.h              |  184 ++
 drivers/scsi/bfa/include/cs/bfa_perf.h             |   34 +
 drivers/scsi/bfa/include/cs/bfa_plog.h             |  162 +
 drivers/scsi/bfa/include/cs/bfa_q.h                |   81 +
 drivers/scsi/bfa/include/cs/bfa_sm.h               |   69 +
 drivers/scsi/bfa/include/cs/bfa_trc.h              |  176 +
 drivers/scsi/bfa/include/cs/bfa_wc.h               |   68 +
 drivers/scsi/bfa/include/defs/bfa_defs_adapter.h   |   82 +
 drivers/scsi/bfa/include/defs/bfa_defs_aen.h       |   73 +
 drivers/scsi/bfa/include/defs/bfa_defs_audit.h     |   38 +
 drivers/scsi/bfa/include/defs/bfa_defs_auth.h      |  112 +
 drivers/scsi/bfa/include/defs/bfa_defs_boot.h      |   71 +
 drivers/scsi/bfa/include/defs/bfa_defs_cee.h       |  159 +
 drivers/scsi/bfa/include/defs/bfa_defs_driver.h    |   40 +
 drivers/scsi/bfa/include/defs/bfa_defs_ethport.h   |   98 +
 drivers/scsi/bfa/include/defs/bfa_defs_fcpim.h     |   45 +
 drivers/scsi/bfa/include/defs/bfa_defs_im_common.h |   32 +
 drivers/scsi/bfa/include/defs/bfa_defs_im_team.h   |   72 +
 drivers/scsi/bfa/include/defs/bfa_defs_ioc.h       |  152 +
 drivers/scsi/bfa/include/defs/bfa_defs_iocfc.h     |  310 ++
 drivers/scsi/bfa/include/defs/bfa_defs_ipfc.h      |   70 +
 drivers/scsi/bfa/include/defs/bfa_defs_itnim.h     |  126 +
 drivers/scsi/bfa/include/defs/bfa_defs_led.h       |   35 +
 drivers/scsi/bfa/include/defs/bfa_defs_lport.h     |   68 +
 drivers/scsi/bfa/include/defs/bfa_defs_mfg.h       |   58 +
 drivers/scsi/bfa/include/defs/bfa_defs_pci.h       |   41 +
 drivers/scsi/bfa/include/defs/bfa_defs_pm.h        |   33 +
 drivers/scsi/bfa/include/defs/bfa_defs_pom.h       |   56 +
 drivers/scsi/bfa/include/defs/bfa_defs_port.h      |  245 ++
 drivers/scsi/bfa/include/defs/bfa_defs_pport.h     |  383 +++
 drivers/scsi/bfa/include/defs/bfa_defs_qos.h       |   99 +
 drivers/scsi/bfa/include/defs/bfa_defs_rport.h     |  199 ++
 drivers/scsi/bfa/include/defs/bfa_defs_status.h    |  255 ++
 drivers/scsi/bfa/include/defs/bfa_defs_tin.h       |  118 +
 drivers/scsi/bfa/include/defs/bfa_defs_tsensor.h   |   43 +
 drivers/scsi/bfa/include/defs/bfa_defs_types.h     |   30 +
 drivers/scsi/bfa/include/defs/bfa_defs_version.h   |   22 +
 drivers/scsi/bfa/include/defs/bfa_defs_vf.h        |   74 +
 drivers/scsi/bfa/include/defs/bfa_defs_vport.h     |   91 +
 drivers/scsi/bfa/include/fcb/bfa_fcb.h             |   33 +
 drivers/scsi/bfa/include/fcb/bfa_fcb_fcpim.h       |   76 +
 drivers/scsi/bfa/include/fcb/bfa_fcb_port.h        |  113 +
 drivers/scsi/bfa/include/fcb/bfa_fcb_rport.h       |   80 +
 drivers/scsi/bfa/include/fcb/bfa_fcb_vf.h          |   47 +
 drivers/scsi/bfa/include/fcb/bfa_fcb_vport.h       |   47 +
 drivers/scsi/bfa/include/fcs/bfa_fcs.h             |   73 +
 drivers/scsi/bfa/include/fcs/bfa_fcs_auth.h        |   82 +
 drivers/scsi/bfa/include/fcs/bfa_fcs_fabric.h      |  112 +
 drivers/scsi/bfa/include/fcs/bfa_fcs_fcpim.h       |  131 +
 drivers/scsi/bfa/include/fcs/bfa_fcs_fdmi.h        |   63 +
 drivers/scsi/bfa/include/fcs/bfa_fcs_lport.h       |  226 ++
 drivers/scsi/bfa/include/fcs/bfa_fcs_rport.h       |  104 +
 drivers/scsi/bfa/include/fcs/bfa_fcs_vport.h       |   63 +
 drivers/scsi/bfa/include/log/bfa_log_fcs.h         |   28 +
 drivers/scsi/bfa/include/log/bfa_log_hal.h         |   30 +
 drivers/scsi/bfa/include/log/bfa_log_linux.h       |   44 +
 drivers/scsi/bfa/include/log/bfa_log_wdrv.h        |   36 +
 drivers/scsi/bfa/include/protocol/ct.h             |  492 +++
 drivers/scsi/bfa/include/protocol/fc.h             | 1105 +++++++
 drivers/scsi/bfa/include/protocol/fc_sp.h          |  224 ++
 drivers/scsi/bfa/include/protocol/fcp.h            |  186 ++
 drivers/scsi/bfa/include/protocol/fdmi.h           |  163 +
 drivers/scsi/bfa/include/protocol/pcifw.h          |   75 +
 drivers/scsi/bfa/include/protocol/scsi.h           | 1648 ++++++++++
 drivers/scsi/bfa/include/protocol/types.h          |   42 +
 drivers/scsi/bfa/loop.c                            |  422 +++
 drivers/scsi/bfa/lport_api.c                       |  291 ++
 drivers/scsi/bfa/lport_priv.h                      |   82 +
 drivers/scsi/bfa/ms.c                              |  759 +++++
 drivers/scsi/bfa/n2n.c                             |  105 +
 drivers/scsi/bfa/ns.c                              | 1243 +++++++
 drivers/scsi/bfa/plog.c                            |  184 ++
 drivers/scsi/bfa/rport.c                           | 2618 +++++++++++++++
 drivers/scsi/bfa/rport_api.c                       |  180 ++
 drivers/scsi/bfa/rport_ftrs.c                      |  375 +++
 drivers/scsi/bfa/scn.c                             |  482 +++
 drivers/scsi/bfa/vfapi.c                           |  292 ++
 drivers/scsi/bfa/vport.c                           |  891 +++++
 drivers/scsi/bnx2i/bnx2i.h                         |    2 +
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |    2 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |    2 +-
 drivers/scsi/cxgb3i/cxgb3i_iscsi.c                 |    2 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c         |    2 -
 drivers/scsi/dpt_i2o.c                             |    4 +
 drivers/scsi/hptiop.c                              |   37 +-
 drivers/scsi/hptiop.h                              |    3 +-
 drivers/scsi/iscsi_tcp.c                           |    2 +-
 drivers/scsi/libiscsi.c                            |    6 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |   15 +-
 drivers/scsi/mpt2sas/Kconfig                       |    2 +-
 drivers/scsi/mpt2sas/mpi/mpi2.h                    |  103 +-
 drivers/scsi/mpt2sas/mpi/mpi2_cnfg.h               |  200 ++-
 drivers/scsi/mpt2sas/mpi/mpi2_history.txt          |  334 ++
 drivers/scsi/mpt2sas/mpi/mpi2_init.h               |   18 +-
 drivers/scsi/mpt2sas/mpi/mpi2_ioc.h                |   65 +-
 drivers/scsi/mpt2sas/mpi/mpi2_tool.h               |  134 +-
 drivers/scsi/mpt2sas/mpt2sas_base.c                |  446 ++-
 drivers/scsi/mpt2sas/mpt2sas_base.h                |  106 +-
 drivers/scsi/mpt2sas/mpt2sas_config.c              |   22 +-
 drivers/scsi/mpt2sas/mpt2sas_ctl.c                 |   61 +-
 drivers/scsi/mpt2sas/mpt2sas_ctl.h                 |    2 +-
 drivers/scsi/mpt2sas/mpt2sas_debug.h               |    2 +-
 drivers/scsi/mpt2sas/mpt2sas_scsih.c               |  568 +++-
 drivers/scsi/mpt2sas/mpt2sas_transport.c           |   26 +-
 drivers/scsi/mvsas/mv_defs.h                       |    4 +
 drivers/scsi/mvsas/mv_init.c                       |    4 +
 drivers/scsi/pmcraid.c                             |   58 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |    6 +-
 drivers/scsi/scsi.c                                |   11 +-
 drivers/scsi/scsi_debug.c                          |  139 +-
 drivers/scsi/scsi_error.c                          |    3 +
 drivers/scsi/scsi_scan.c                           |    2 +
 drivers/scsi/scsi_sysfs.c                          |    7 +-
 drivers/scsi/scsi_transport_fc.c                   |    2 +
 drivers/scsi/sd.c                                  |  140 +-
 drivers/scsi/sd.h                                  |    9 +-
 drivers/scsi/sd_dif.c                              |   65 -
 drivers/scsi/sg.c                                  |   10 +-
 drivers/scsi/sr.c                                  |   22 +-
 drivers/scsi/st.c                                  |    3 -
 drivers/serial/8250_pci.c                          |   78 +
 drivers/serial/atmel_serial.c                      |    2 +-
 drivers/serial/mpc52xx_uart.c                      |    2 +-
 drivers/serial/serial_core.c                       |    7 +-
 drivers/serial/serial_cs.c                         |   20 +-
 drivers/spi/amba-pl022.c                           |    2 +-
 drivers/staging/Kconfig                            |    6 -
 drivers/staging/Makefile                           |    3 -
 drivers/staging/agnx/Kconfig                       |    5 -
 drivers/staging/agnx/Makefile                      |    8 -
 drivers/staging/agnx/TODO                          |   22 -
 drivers/staging/agnx/agnx.h                        |  156 -
 drivers/staging/agnx/debug.h                       |  416 ---
 drivers/staging/agnx/pci.c                         |  635 ----
 drivers/staging/agnx/phy.c                         |  960 ------
 drivers/staging/agnx/phy.h                         |  409 ---
 drivers/staging/agnx/rf.c                          |  893 ------
 drivers/staging/agnx/sta.c                         |  218 --
 drivers/staging/agnx/sta.h                         |  222 --
 drivers/staging/agnx/table.c                       |  168 -
 drivers/staging/agnx/table.h                       |   10 -
 drivers/staging/agnx/xmit.c                        |  836 -----
 drivers/staging/agnx/xmit.h                        |  250 --
 drivers/staging/android/Kconfig                    |    1 +
 drivers/staging/b3dfg/b3dfg.c                      |    1 +
 drivers/staging/comedi/Kconfig                     |    2 +-
 drivers/staging/comedi/comedi_fops.c               |    2 +-
 drivers/staging/comedi/drivers/cb_das16_cs.c       |    2 +-
 drivers/staging/comedi/drivers/cb_pcidio.c         |    8 +-
 drivers/staging/comedi/drivers/jr3_pci.c           |   18 +-
 drivers/staging/comedi/drivers/me_daq.c            |    1 +
 drivers/staging/comedi/drivers/ni_65xx.c           |   12 +-
 drivers/staging/comedi/drivers/ni_daq_700.c        |    2 +-
 drivers/staging/comedi/drivers/ni_daq_dio24.c      |    2 +-
 drivers/staging/comedi/drivers/ni_labpc_cs.c       |    2 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |    1 +
 drivers/staging/comedi/drivers/ni_mio_cs.c         |    2 +-
 drivers/staging/comedi/drivers/ni_pcidio.c         |    1 +
 drivers/staging/comedi/drivers/ni_pcimio.c         |   22 +-
 drivers/staging/comedi/drivers/quatech_daqp_cs.c   |    2 +-
 drivers/staging/comedi/drivers/s526.c              |  109 +-
 drivers/staging/comedi/drivers/serial2002.c        |    1 +
 drivers/staging/cowloop/Kconfig                    |   16 -
 drivers/staging/cowloop/Makefile                   |    1 -
 drivers/staging/cowloop/TODO                       |   11 -
 drivers/staging/cowloop/cowloop.c                  | 2842 ----------------
 drivers/staging/cowloop/cowloop.h                  |   66 -
 drivers/staging/et131x/et1310_address_map.h        |    2 +-
 drivers/staging/et131x/et1310_rx.c                 |   20 +-
 drivers/staging/hv/ChannelMgmt.h                   |    3 +-
 drivers/staging/hv/NetVsc.c                        |   10 +-
 drivers/staging/hv/TODO                            |    6 +
 drivers/staging/hv/osd.c                           |    1 +
 drivers/staging/hv/osd.h                           |    1 +
 drivers/staging/hv/vmbus_drv.c                     |   28 +-
 drivers/staging/iio/Kconfig                        |    1 +
 drivers/staging/iio/industrialio-core.c            |    2 +
 drivers/staging/otus/Kconfig                       |    2 +-
 drivers/staging/p9auth/p9auth.c                    |   14 +-
 drivers/staging/panel/panel.c                      |   13 +-
 drivers/staging/poch/poch.c                        |    1 +
 drivers/staging/rt2860/Kconfig                     |    2 +-
 drivers/staging/rt2860/common/cmm_data_2860.c      |    2 +
 drivers/staging/rt2860/common/cmm_info.c           |    1 +
 drivers/staging/rt2860/rt_linux.c                  |    1 +
 drivers/staging/rt2870/Kconfig                     |    2 +-
 drivers/staging/rt3090/Kconfig                     |    2 +-
 drivers/staging/rt3090/common/cmm_info.c           |    1 +
 drivers/staging/rt3090/rt_linux.c                  |    1 +
 drivers/staging/rtl8187se/Kconfig                  |    2 +-
 .../staging/rtl8187se/ieee80211/ieee80211_crypt.c  |    4 +-
 .../staging/rtl8187se/ieee80211/ieee80211_module.c |    4 +-
 .../rtl8187se/ieee80211/ieee80211_softmac.c        |   12 +-
 drivers/staging/rtl8187se/ieee80211/ieee80211_wx.c |   17 +-
 drivers/staging/rtl8192e/Kconfig                   |    2 +-
 .../staging/rtl8192e/ieee80211/ieee80211_crypt.c   |    8 +-
 .../staging/rtl8192e/ieee80211/ieee80211_module.c  |    8 +-
 .../staging/rtl8192e/ieee80211/ieee80211_softmac.c |   19 +-
 drivers/staging/rtl8192e/ieee80211/ieee80211_wx.c  |   21 +-
 drivers/staging/rtl8192e/r8192E_core.c             |    1 +
 drivers/staging/rtl8192su/Kconfig                  |    2 +-
 .../staging/rtl8192su/ieee80211/ieee80211_crypt.c  |    4 +-
 .../staging/rtl8192su/ieee80211/ieee80211_module.c |    4 +-
 .../rtl8192su/ieee80211/ieee80211_softmac.c        |   15 +-
 drivers/staging/rtl8192su/ieee80211/ieee80211_wx.c |   17 +-
 drivers/staging/sep/sep_driver.c                   |    1 +
 drivers/staging/stlc45xx/Kconfig                   |    8 -
 drivers/staging/stlc45xx/Makefile                  |    1 -
 drivers/staging/stlc45xx/stlc45xx.c                | 2594 ---------------
 drivers/staging/stlc45xx/stlc45xx.h                |  283 --
 drivers/staging/stlc45xx/stlc45xx_lmac.h           |  434 ---
 drivers/staging/vme/bridges/vme_ca91cx42.c         |    1 +
 drivers/staging/vme/bridges/vme_tsi148.c           |    1 +
 drivers/staging/vt6656/main_usb.c                  |    1 -
 drivers/staging/winbond/Kconfig                    |    2 +-
 drivers/staging/winbond/wbusb.c                    |   44 +-
 drivers/staging/wlan-ng/Kconfig                    |    2 +-
 drivers/uio/uio.c                                  |    1 +
 drivers/usb/class/usbtmc.c                         |    2 +-
 drivers/usb/gadget/Kconfig                         |    1 +
 drivers/usb/gadget/ether.c                         |    9 +-
 drivers/usb/gadget/fsl_udc_core.c                  |    2 +-
 drivers/usb/gadget/imx_udc.c                       |    8 +-
 drivers/usb/gadget/r8a66597-udc.h                  |  105 +-
 drivers/usb/host/ehci-sched.c                      |   13 +-
 drivers/usb/host/isp1362-hcd.c                     |   18 +-
 drivers/usb/host/isp1362.h                         |   12 +-
 drivers/usb/host/pci-quirks.c                      |    2 +-
 drivers/usb/host/r8a66597-hcd.c                    |   23 +-
 drivers/usb/host/whci/asl.c                        |   23 +-
 drivers/usb/host/whci/pzl.c                        |   24 +-
 drivers/usb/host/xhci-hcd.c                        |   29 +-
 drivers/usb/misc/usblcd.c                          |    3 +-
 drivers/usb/musb/Kconfig                           |    4 +-
 drivers/usb/musb/blackfin.c                        |    1 -
 drivers/usb/musb/musb_core.h                       |    7 +
 drivers/usb/musb/musb_regs.h                       |    9 -
 drivers/usb/serial/aircable.c                      |   10 +-
 drivers/usb/serial/cp210x.c                        |    1 +
 drivers/usb/serial/cypress_m8.c                    |   12 +-
 drivers/usb/serial/digi_acceleport.c               |    8 +-
 drivers/usb/serial/empeg.c                         |    2 +-
 drivers/usb/serial/ftdi_sio.c                      |  422 +--
 drivers/usb/serial/garmin_gps.c                    |   12 +-
 drivers/usb/serial/generic.c                       |    2 +-
 drivers/usb/serial/ipaq.c                          |    9 +
 drivers/usb/serial/keyspan_pda.c                   |    2 +-
 drivers/usb/serial/kl5kusb105.c                    |    2 +-
 drivers/usb/serial/mct_u232.c                      |   14 +-
 drivers/usb/serial/opticon.c                       |   13 +-
 drivers/usb/serial/option.c                        |   12 +
 drivers/usb/serial/oti6858.c                       |    6 +-
 drivers/usb/serial/pl2303.c                        |    8 +-
 drivers/usb/serial/sierra.c                        |   40 +-
 drivers/usb/serial/symbolserial.c                  |   22 +-
 drivers/usb/serial/usb-serial.c                    |   10 +-
 drivers/usb/serial/visor.c                         |   28 +-
 drivers/usb/serial/whiteheat.c                     |   10 +-
 drivers/usb/storage/transport.c                    |   46 +-
 drivers/usb/storage/unusual_devs.h                 |    7 +
 drivers/usb/wusbcore/security.c                    |   41 +-
 drivers/uwb/whc-rc.c                               |    1 +
 drivers/video/da8xx-fb.c                           |    1 -
 drivers/video/msm/mddi.c                           |    2 -
 drivers/video/omap/blizzard.c                      |   10 +-
 drivers/video/omap/omapfb_main.c                   |   22 +-
 drivers/virtio/virtio_balloon.c                    |    3 +-
 drivers/virtio/virtio_pci.c                        |   27 +-
 drivers/virtio/virtio_ring.c                       |    3 +
 drivers/watchdog/riowd.c                           |    2 +-
 firmware/Makefile                                  |    9 +-
 firmware/WHENCE                                    |    9 +
 firmware/cis/COMpad2.cis.ihex                      |   11 +
 firmware/cis/COMpad4.cis.ihex                      |    9 +
 firmware/cis/DP83903.cis.ihex                      |   14 +
 firmware/cis/NE2K.cis.ihex                         |    8 +
 firmware/cis/PE-200.cis.ihex                       |    9 +
 firmware/cis/SW_555_SER.cis.ihex                   |   12 +
 firmware/cis/SW_7xx_SER.cis.ihex                   |   13 +
 firmware/cis/SW_8xx_SER.cis.ihex                   |   13 +
 firmware/cis/tamarack.cis.ihex                     |   10 +
 fs/9p/vfs_dir.c                                    |   93 +-
 fs/9p/vfs_inode.c                                  |    5 +-
 fs/Kconfig                                         |    4 +-
 fs/block_dev.c                                     |    2 +-
 fs/btrfs/acl.c                                     |    6 +-
 fs/btrfs/async-thread.c                            |   81 +-
 fs/btrfs/async-thread.h                            |   10 +-
 fs/btrfs/btrfs_inode.h                             |   18 +-
 fs/btrfs/ctree.h                                   |   19 +-
 fs/btrfs/disk-io.c                                 |   50 +-
 fs/btrfs/extent-tree.c                             |  252 ++-
 fs/btrfs/extent_io.c                               |   42 +-
 fs/btrfs/extent_io.h                               |   18 +-
 fs/btrfs/file.c                                    |   44 +-
 fs/btrfs/inode.c                                   |  144 +-
 fs/btrfs/ioctl.c                                   |    7 +-
 fs/btrfs/ordered-data.c                            |    6 +
 fs/btrfs/relocation.c                              |    4 +-
 fs/btrfs/super.c                                   |    9 +-
 fs/btrfs/transaction.c                             |   45 +-
 fs/btrfs/transaction.h                             |    5 +
 fs/btrfs/tree-log.c                                |   56 +-
 fs/btrfs/tree-log.h                                |    3 +
 fs/btrfs/xattr.c                                   |    2 +-
 fs/cifs/connect.c                                  |    3 +-
 fs/dlm/lowcomms.c                                  |   36 +-
 fs/ecryptfs/Kconfig                                |    3 +-
 fs/ecryptfs/main.c                                 |    7 +-
 fs/ext3/super.c                                    |   13 +-
 fs/ext4/ext4.h                                     |    1 +
 fs/ext4/super.c                                    |   20 +-
 fs/file.c                                          |    1 +
 fs/hfs/btree.c                                     |    5 +
 fs/hfsplus/wrapper.c                               |    4 +
 fs/nfs/client.c                                    |    2 +-
 fs/nfs/dir.c                                       |    2 +
 fs/nfs/direct.c                                    |    1 +
 fs/nfs/nfs4namespace.c                             |   12 +-
 fs/nfs/nfs4proc.c                                  |   15 +-
 fs/nfs/nfs4renewd.c                                |    6 -
 fs/nfs/nfs4xdr.c                                   |    1 -
 fs/nfs/super.c                                     |   37 +-
 fs/nilfs2/btnode.c                                 |    4 +-
 fs/nilfs2/segment.c                                |   19 +-
 fs/notify/dnotify/dnotify.c                        |    3 +-
 fs/notify/inode_mark.c                             |    6 +-
 fs/notify/notification.c                           |    2 +-
 fs/partitions/check.c                              |   12 +-
 fs/pipe.c                                          |   41 +-
 fs/proc/kcore.c                                    |    1 -
 fs/proc/meminfo.c                                  |    2 +-
 fs/proc/page.c                                     |    5 +
 fs/romfs/storage.c                                 |    4 +-
 fs/sysfs/dir.c                                     |    3 +-
 fs/sysfs/file.c                                    |   14 +-
 fs/xfs/linux-2.6/xfs_aops.c                        |   38 +-
 fs/xfs/linux-2.6/xfs_file.c                        |    9 +-
 fs/xfs/linux-2.6/xfs_iops.c                        |   41 +-
 fs/xfs/linux-2.6/xfs_lrw.c                         |    2 +-
 fs/xfs/linux-2.6/xfs_quotaops.c                    |    2 +-
 fs/xfs/linux-2.6/xfs_super.c                       |   59 +-
 fs/xfs/linux-2.6/xfs_sync.c                        |   36 +-
 fs/xfs/quota/xfs_qm_syscalls.c                     |    1 -
 fs/xfs/xfs_dfrag.c                                 |    8 +-
 fs/xfs/xfs_dir2_leaf.c                             |    4 +-
 fs/xfs/xfs_ialloc.c                                |    1 +
 fs/xfs/xfs_inode.c                                 |    4 +-
 fs/xfs/xfs_inode.h                                 |    2 +-
 fs/xfs/xfs_inode_item.c                            |   18 +-
 fs/xfs/xfs_itable.c                                |   21 +-
 fs/xfs/xfs_vnodeops.c                              |    6 -
 include/asm-generic/hardirq.h                      |    2 +-
 include/drm/drm_crtc_helper.h                      |    3 +
 include/drm/drm_fb_helper.h                        |    7 +-
 include/drm/drm_pciids.h                           |    4 +-
 include/linux/Kbuild                               |    2 +
 include/linux/ata.h                                |    9 +-
 include/linux/blkdev.h                             |    4 -
 include/linux/cpufreq.h                            |    7 +
 include/linux/device.h                             |    4 +-
 include/linux/elf.h                                |    1 +
 include/linux/ftrace.h                             |    2 +-
 include/linux/futex.h                              |    4 +-
 include/linux/genhd.h                              |   21 +-
 include/linux/i2c/twl4030.h                        |    6 +-
 include/linux/init.h                               |    1 +
 include/linux/interrupt.h                          |    2 +-
 include/linux/kernel.h                             |    6 +
 include/linux/libata.h                             |   12 +
 include/linux/mmc/host.h                           |    1 +
 include/linux/moduleparam.h                        |    1 -
 include/linux/netdevice.h                          |    2 +-
 include/linux/pci_ids.h                            |   14 +-
 include/linux/perf_event.h                         |    9 +-
 include/linux/prctl.h                              |   12 +
 include/linux/rcupdate.h                           |   18 +-
 include/linux/rcutree.h                            |   19 +-
 include/linux/skbuff.h                             |    6 +-
 include/linux/socket.h                             |   21 +-
 include/linux/string.h                             |    2 +-
 include/linux/topology.h                           |    4 +-
 include/linux/trace_seq.h                          |    2 +-
 include/linux/usb/serial.h                         |    1 +
 include/linux/virtio_9p.h                          |    1 +
 include/linux/virtio_balloon.h                     |    1 +
 include/linux/virtio_blk.h                         |    5 +-
 include/linux/virtio_console.h                     |    1 +
 include/linux/virtio_net.h                         |    1 +
 include/linux/virtio_rng.h                         |    1 +
 include/linux/workqueue.h                          |    1 +
 include/net/9p/client.h                            |    7 +-
 include/net/inet_timewait_sock.h                   |    8 +-
 include/net/ip_fib.h                               |    3 +-
 include/net/mac80211.h                             |    2 +
 include/net/sock.h                                 |   10 +-
 include/pcmcia/ss.h                                |    4 +
 include/scsi/libiscsi.h                            |    3 +-
 include/scsi/scsi.h                                |    3 +
 include/scsi/scsi_cmnd.h                           |    4 -
 include/scsi/scsi_host.h                           |   15 +-
 include/sound/soc.h                                |    1 -
 init/Kconfig                                       |   20 +-
 init/main.c                                        |    1 -
 kernel/cgroup.c                                    |    8 +-
 kernel/exit.c                                      |    6 +-
 kernel/fork.c                                      |   12 +-
 kernel/futex.c                                     |   23 +-
 kernel/hrtimer.c                                   |    2 -
 kernel/irq/handle.c                                |    1 +
 kernel/lockdep.c                                   |   20 +-
 kernel/mutex-debug.c                               |    1 +
 kernel/panic.c                                     |    3 +-
 kernel/params.c                                    |   17 +-
 kernel/perf_event.c                                |  350 ++-
 kernel/power/hibernate.c                           |   11 +-
 kernel/power/suspend_test.c                        |    5 +-
 kernel/power/swap.c                                |   43 +-
 kernel/rcupdate.c                                  |  140 +-
 kernel/rcutorture.c                                |    4 +-
 kernel/rcutree.c                                   |  374 ++-
 kernel/rcutree.h                                   |   90 +-
 kernel/rcutree_plugin.h                            |  149 +-
 kernel/rcutree_trace.c                             |    4 +-
 kernel/sched.c                                     |   55 +-
 kernel/sched_fair.c                                |   27 +-
 kernel/sys.c                                       |   25 +-
 kernel/sysctl_check.c                              |    2 +-
 kernel/time/tick-sched.c                           |    9 +-
 kernel/time/timekeeping.c                          |    1 +
 kernel/trace/ftrace.c                              |   29 +-
 kernel/trace/kmemtrace.c                           |    2 +-
 kernel/trace/ring_buffer.c                         |   12 +-
 kernel/trace/trace.c                               |   10 +-
 kernel/trace/trace_branch.c                        |    8 +-
 kernel/trace/trace_event_profile.c                 |   15 +-
 kernel/trace/trace_events_filter.c                 |    3 +-
 kernel/trace/trace_hw_branches.c                   |    8 +-
 kernel/trace/trace_output.c                        |   23 +-
 kernel/trace/trace_syscalls.c                      |    4 +-
 kernel/workqueue.c                                 |   39 +-
 lib/Kconfig.debug                                  |    9 +-
 lib/debugobjects.c                                 |    1 +
 lib/fault-inject.c                                 |    1 +
 mm/Kconfig                                         |    8 +-
 mm/backing-dev.c                                   |   18 +-
 mm/kmemleak.c                                      |    5 +-
 mm/ksm.c                                           |   10 +-
 mm/memory-failure.c                                |   59 +-
 mm/memory.c                                        |   14 +-
 mm/mempolicy.c                                     |   13 +-
 mm/nommu.c                                         |    6 +-
 mm/page-writeback.c                                |    3 +-
 mm/page_alloc.c                                    |    3 +-
 mm/percpu.c                                        |   35 +-
 mm/swapfile.c                                      |    3 +-
 mm/vmalloc.c                                       |   50 +-
 mm/vmscan.c                                        |   14 +-
 net/9p/client.c                                    |    5 +-
 net/9p/trans_virtio.c                              |    1 -
 net/bluetooth/hci_sysfs.c                          |    4 +-
 net/bluetooth/l2cap.c                              |    9 +-
 net/core/datagram.c                                |   10 +-
 net/core/net-sysfs.c                               |    4 +-
 net/core/pktgen.c                                  |   19 +-
 net/ipv4/devinet.c                                 |   16 +-
 net/ipv4/fib_frontend.c                            |    5 +-
 net/ipv4/inet_connection_sock.c                    |   34 +-
 net/ipv4/ip_gre.c                                  |   28 +-
 net/ipv4/ip_sockglue.c                             |    7 +-
 net/ipv4/raw.c                                     |   24 +-
 net/ipv4/route.c                                   |    8 +-
 net/ipv4/tcp.c                                     |   59 +-
 net/ipv4/tcp_minisocks.c                           |    4 +-
 net/ipv4/udp.c                                     |   77 +-
 net/ipv6/ipv6_sockglue.c                           |    6 +-
 net/ipv6/udp.c                                     |    4 +-
 net/irda/ircomm/ircomm_tty_attach.c                |    1 +
 net/irda/irlan/irlan_common.c                      |    1 +
 net/irda/irlan/irlan_eth.c                         |    1 +
 net/irda/irnet/irnet_irda.c                        |    1 +
 net/irda/irnet/irnet_ppp.c                         |    1 +
 net/mac80211/agg-tx.c                              |   19 +-
 net/mac80211/cfg.c                                 |    6 +-
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ibss.c                                |   14 +-
 net/mac80211/mesh_hwmp.c                           |    2 +-
 net/mac80211/mlme.c                                |    3 +-
 net/mac80211/rc80211_pid_debugfs.c                 |    1 +
 net/mac80211/rx.c                                  |   12 +-
 net/mac80211/sta_info.c                            |    2 +
 net/mac80211/tx.c                                  |    5 +-
 net/mac80211/util.c                                |    4 +-
 net/netfilter/nf_conntrack_core.c                  |    1 +
 net/packet/af_packet.c                             |    5 +-
 net/sched/act_pedit.c                              |    2 +-
 net/sched/cls_api.c                                |    2 +-
 net/sunrpc/svcsock.c                               |   10 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |    1 +
 net/unix/af_unix.c                                 |    2 +
 net/wireless/core.c                                |    1 +
 net/wireless/core.h                                |    1 +
 net/wireless/mlme.c                                |    9 +
 net/wireless/nl80211.c                             |    3 +-
 net/wireless/sme.c                                 |   24 +-
 scripts/Kbuild.include                             |    2 +-
 scripts/Makefile.lib                               |    2 +-
 scripts/checkkconfigsymbols.sh                     |    4 +-
 scripts/checkpatch.pl                              |   84 +-
 scripts/get_maintainer.pl                          |   37 +-
 scripts/headers_install.pl                         |    2 +-
 scripts/mkcompile_h                                |   12 +-
 scripts/package/Makefile                           |   11 +-
 scripts/package/mkspec                             |    2 +-
 security/keys/keyctl.c                             |    2 +-
 sound/arm/aaci.c                                   |    1 +
 sound/core/pcm.c                                   |    5 +-
 sound/drivers/dummy.c                              |    4 +-
 sound/drivers/opl3/opl3_midi.c                     |   28 +-
 sound/drivers/pcsp/pcsp_lib.c                      |   65 +-
 sound/drivers/pcsp/pcsp_mixer.c                    |    2 +-
 sound/parisc/harmony.c                             |    6 +-
 sound/pci/Kconfig                                  |    1 -
 sound/pci/ali5451/ali5451.c                        |    2 +-
 sound/pci/bt87x.c                                  |    2 +
 sound/pci/hda/hda_intel.c                          |    1 +
 sound/pci/hda/patch_nvhdmi.c                       |   31 +-
 sound/pci/hda/patch_realtek.c                      |   98 +-
 sound/pci/hda/patch_sigmatel.c                     |   29 +-
 sound/pci/ice1712/amp.c                            |    8 +-
 sound/pci/ice1712/ice1712.c                        |    2 +-
 sound/pci/ice1712/ice1724.c                        |    8 +-
 sound/pci/via82xx.c                                |   86 +-
 sound/pcmcia/pdaudiocf/pdaudiocf.c                 |   21 +-
 sound/pcmcia/vx/vxpocket.c                         |   21 +-
 sound/ppc/Kconfig                                  |    2 +-
 sound/soc/codecs/ac97.c                            |    3 -
 sound/soc/codecs/ad1836.c                          |    6 -
 sound/soc/codecs/ad1938.c                          |    6 -
 sound/soc/codecs/ad1980.c                          |    5 -
 sound/soc/codecs/ad73311.c                         |    8 -
 sound/soc/codecs/ak4104.c                          |    8 -
 sound/soc/codecs/ak4535.c                          |    8 -
 sound/soc/codecs/ak4642.c                          |    9 -
 sound/soc/codecs/ak4671.c                          |    9 -
 sound/soc/codecs/cs4270.c                          |    7 -
 sound/soc/codecs/cx20442.c                         |    6 -
 sound/soc/codecs/pcm3008.c                         |    9 -
 sound/soc/codecs/ssm2602.c                         |    8 -
 sound/soc/codecs/stac9766.c                        |    3 -
 sound/soc/codecs/tlv320aic23.c                     |    8 -
 sound/soc/codecs/tlv320aic26.c                     |   11 -
 sound/soc/codecs/tlv320aic3x.c                     |   10 -
 sound/soc/codecs/tlv320dac33.c                     |   10 +-
 sound/soc/codecs/twl4030.c                         |   12 -
 sound/soc/codecs/uda134x.c                         |    9 -
 sound/soc/codecs/uda1380.c                         |    8 -
 sound/soc/codecs/wm8350.c                          |   11 -
 sound/soc/codecs/wm8400.c                          |    6 -
 sound/soc/codecs/wm8510.c                          |    9 +-
 sound/soc/codecs/wm8523.c                          |    8 -
 sound/soc/codecs/wm8580.c                          |    8 -
 sound/soc/codecs/wm8711.c                          |    8 -
 sound/soc/codecs/wm8727.c                          |   10 +-
 sound/soc/codecs/wm8728.c                          |    8 -
 sound/soc/codecs/wm8731.c                          |    8 -
 sound/soc/codecs/wm8750.c                          |    8 -
 sound/soc/codecs/wm8753.c                          |    9 -
 sound/soc/codecs/wm8776.c                          |    9 -
 sound/soc/codecs/wm8900.c                          |    6 -
 sound/soc/codecs/wm8903.c                          |    9 -
 sound/soc/codecs/wm8940.c                          |    6 -
 sound/soc/codecs/wm8960.c                          |    8 -
 sound/soc/codecs/wm8961.c                          |    9 -
 sound/soc/codecs/wm8971.c                          |    9 +-
 sound/soc/codecs/wm8974.c                          |    8 -
 sound/soc/codecs/wm8988.c                          |    9 -
 sound/soc/codecs/wm8990.c                          |    9 +-
 sound/soc/codecs/wm8993.c                          |    9 -
 sound/soc/codecs/wm9081.c                          |    9 -
 sound/soc/codecs/wm9705.c                          |    8 -
 sound/soc/codecs/wm9712.c                          |    8 -
 sound/soc/codecs/wm9713.c                          |    7 +-
 sound/soc/s3c24xx/s3c24xx-pcm.c                    |   17 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                    |    2 +
 sound/soc/soc-core.c                               |  475 ++--
 sound/usb/caiaq/audio.c                            |   16 +-
 sound/usb/caiaq/device.c                           |    2 +-
 tools/perf/Documentation/perf-timechart.txt        |    3 +
 tools/perf/Makefile                                |   32 +-
 tools/perf/builtin-record.c                        |    6 +
 tools/perf/builtin-sched.c                         |    4 +-
 tools/perf/builtin-stat.c                          |    8 +-
 tools/perf/builtin-timechart.c                     |   38 +-
 tools/perf/builtin-top.c                           |    3 +
 tools/perf/builtin-trace.c                         |    6 -
 tools/perf/design.txt                              |    3 +
 tools/perf/util/PERF-VERSION-GEN                   |    2 +-
 tools/perf/util/parse-events.c                     |    5 +-
 tools/perf/util/svghelper.c                        |   16 +-
 tools/perf/util/symbol.c                           |    9 +-
 tools/perf/util/symbol.h                           |   10 +
 tools/perf/util/trace-event-parse.c                |   17 +-
 virt/kvm/kvm_main.c                                |   21 +-
 1825 files changed, 90249 insertions(+), 26409 deletions(-)
 rename Documentation/ABI/testing/{sysfs-class-usb_host =3D> sysfs-class-uw=
b_rc-wusbhc} (88%)
 delete mode 100644 Documentation/ABI/testing/sysfs-devices-cache_disable
 create mode 100644 Documentation/ABI/testing/sysfs-devices-system-cpu
 create mode 100644 Documentation/vm/hwpoison.txt
 create mode 100644 arch/blackfin/ADI_BSD.txt
 create mode 100644 arch/mips/bcm63xx/dev-wdt.c
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h
 create mode 100644 arch/mips/include/asm/spram.h
 create mode 100644 arch/parisc/include/asm/syscall.h
 create mode 100644 arch/powerpc/boot/dts/mucmc52.dts
 create mode 100644 arch/powerpc/boot/dts/uc101.dts
 create mode 100644 arch/powerpc/configs/ppc64e_defconfig
 create mode 100644 drivers/gpu/drm/radeon/rs100d.h
 create mode 100644 drivers/gpu/drm/radeon/rs400d.h
 create mode 100644 drivers/gpu/drm/radeon/rs600d.h
 create mode 100644 drivers/gpu/drm/radeon/rs690d.h
 delete mode 100644 drivers/gpu/drm/radeon/rs690r.h
 create mode 100644 drivers/gpu/drm/radeon/rv200d.h
 create mode 100644 drivers/gpu/drm/radeon/rv250d.h
 create mode 100644 drivers/gpu/drm/radeon/rv350d.h
 create mode 100644 drivers/md/unroll.awk
 delete mode 100644 drivers/md/unroll.pl
 create mode 100644 drivers/net/stmmac/Kconfig
 create mode 100644 drivers/net/stmmac/Makefile
 create mode 100644 drivers/net/stmmac/common.h
 create mode 100644 drivers/net/stmmac/descs.h
 create mode 100644 drivers/net/stmmac/gmac.c
 create mode 100644 drivers/net/stmmac/gmac.h
 create mode 100644 drivers/net/stmmac/mac100.c
 create mode 100644 drivers/net/stmmac/mac100.h
 create mode 100644 drivers/net/stmmac/stmmac.h
 create mode 100644 drivers/net/stmmac/stmmac_ethtool.c
 create mode 100644 drivers/net/stmmac/stmmac_main.c
 create mode 100644 drivers/net/stmmac/stmmac_mdio.c
 create mode 100644 drivers/net/stmmac/stmmac_timer.c
 create mode 100644 drivers/net/stmmac/stmmac_timer.h
 create mode 100644 drivers/net/vmxnet3/Makefile
 create mode 100644 drivers/net/vmxnet3/upt1_defs.h
 create mode 100644 drivers/net/vmxnet3/vmxnet3_defs.h
 create mode 100644 drivers/net/vmxnet3/vmxnet3_drv.c
 create mode 100644 drivers/net/vmxnet3/vmxnet3_ethtool.c
 create mode 100644 drivers/net/vmxnet3/vmxnet3_int.h
 create mode 100644 drivers/scsi/be2iscsi/Kconfig
 create mode 100644 drivers/scsi/be2iscsi/Makefile
 create mode 100644 drivers/scsi/be2iscsi/be.h
 create mode 100644 drivers/scsi/be2iscsi/be_cmds.c
 create mode 100644 drivers/scsi/be2iscsi/be_cmds.h
 create mode 100644 drivers/scsi/be2iscsi/be_iscsi.c
 create mode 100644 drivers/scsi/be2iscsi/be_iscsi.h
 create mode 100644 drivers/scsi/be2iscsi/be_main.c
 create mode 100644 drivers/scsi/be2iscsi/be_main.h
 create mode 100644 drivers/scsi/be2iscsi/be_mgmt.c
 create mode 100644 drivers/scsi/be2iscsi/be_mgmt.h
 create mode 100644 drivers/scsi/bfa/Makefile
 create mode 100644 drivers/scsi/bfa/bfa_callback_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_cb_ioim_macros.h
 create mode 100644 drivers/scsi/bfa/bfa_cee.c
 create mode 100644 drivers/scsi/bfa/bfa_core.c
 create mode 100644 drivers/scsi/bfa/bfa_csdebug.c
 create mode 100644 drivers/scsi/bfa/bfa_fcpim.c
 create mode 100644 drivers/scsi/bfa/bfa_fcpim_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_fcport.c
 create mode 100644 drivers/scsi/bfa/bfa_fcs.c
 create mode 100644 drivers/scsi/bfa/bfa_fcs_lport.c
 create mode 100644 drivers/scsi/bfa/bfa_fcs_port.c
 create mode 100644 drivers/scsi/bfa/bfa_fcs_uf.c
 create mode 100644 drivers/scsi/bfa/bfa_fcxp.c
 create mode 100644 drivers/scsi/bfa/bfa_fcxp_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_fwimg_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_hw_cb.c
 create mode 100644 drivers/scsi/bfa/bfa_hw_ct.c
 create mode 100644 drivers/scsi/bfa/bfa_intr.c
 create mode 100644 drivers/scsi/bfa/bfa_intr_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_ioc.c
 create mode 100644 drivers/scsi/bfa/bfa_ioc.h
 create mode 100644 drivers/scsi/bfa/bfa_iocfc.c
 create mode 100644 drivers/scsi/bfa/bfa_iocfc.h
 create mode 100644 drivers/scsi/bfa/bfa_iocfc_q.c
 create mode 100644 drivers/scsi/bfa/bfa_ioim.c
 create mode 100644 drivers/scsi/bfa/bfa_itnim.c
 create mode 100644 drivers/scsi/bfa/bfa_log.c
 create mode 100644 drivers/scsi/bfa/bfa_log_module.c
 create mode 100644 drivers/scsi/bfa/bfa_lps.c
 create mode 100644 drivers/scsi/bfa/bfa_lps_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_module.c
 create mode 100644 drivers/scsi/bfa/bfa_modules_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_os_inc.h
 create mode 100644 drivers/scsi/bfa/bfa_port.c
 create mode 100644 drivers/scsi/bfa/bfa_port_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_rport.c
 create mode 100644 drivers/scsi/bfa/bfa_rport_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_sgpg.c
 create mode 100644 drivers/scsi/bfa/bfa_sgpg_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_sm.c
 create mode 100644 drivers/scsi/bfa/bfa_timer.c
 create mode 100644 drivers/scsi/bfa/bfa_trcmod_priv.h
 create mode 100644 drivers/scsi/bfa/bfa_tskim.c
 create mode 100644 drivers/scsi/bfa/bfa_uf.c
 create mode 100644 drivers/scsi/bfa/bfa_uf_priv.h
 create mode 100644 drivers/scsi/bfa/bfad.c
 create mode 100644 drivers/scsi/bfa/bfad_attr.c
 create mode 100644 drivers/scsi/bfa/bfad_attr.h
 create mode 100644 drivers/scsi/bfa/bfad_drv.h
 create mode 100644 drivers/scsi/bfa/bfad_fwimg.c
 create mode 100644 drivers/scsi/bfa/bfad_im.c
 create mode 100644 drivers/scsi/bfa/bfad_im.h
 create mode 100644 drivers/scsi/bfa/bfad_im_compat.h
 create mode 100644 drivers/scsi/bfa/bfad_intr.c
 create mode 100644 drivers/scsi/bfa/bfad_ipfc.h
 create mode 100644 drivers/scsi/bfa/bfad_os.c
 create mode 100644 drivers/scsi/bfa/bfad_tm.h
 create mode 100644 drivers/scsi/bfa/bfad_trcmod.h
 create mode 100644 drivers/scsi/bfa/fab.c
 create mode 100644 drivers/scsi/bfa/fabric.c
 create mode 100644 drivers/scsi/bfa/fcbuild.c
 create mode 100644 drivers/scsi/bfa/fcbuild.h
 create mode 100644 drivers/scsi/bfa/fcpim.c
 create mode 100644 drivers/scsi/bfa/fcptm.c
 create mode 100644 drivers/scsi/bfa/fcs.h
 create mode 100644 drivers/scsi/bfa/fcs_auth.h
 create mode 100644 drivers/scsi/bfa/fcs_fabric.h
 create mode 100644 drivers/scsi/bfa/fcs_fcpim.h
 create mode 100644 drivers/scsi/bfa/fcs_fcptm.h
 create mode 100644 drivers/scsi/bfa/fcs_fcxp.h
 create mode 100644 drivers/scsi/bfa/fcs_lport.h
 create mode 100644 drivers/scsi/bfa/fcs_ms.h
 create mode 100644 drivers/scsi/bfa/fcs_port.h
 create mode 100644 drivers/scsi/bfa/fcs_rport.h
 create mode 100644 drivers/scsi/bfa/fcs_trcmod.h
 create mode 100644 drivers/scsi/bfa/fcs_uf.h
 create mode 100644 drivers/scsi/bfa/fcs_vport.h
 create mode 100644 drivers/scsi/bfa/fdmi.c
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_adapter.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_audit.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_ethport.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_ioc.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_itnim.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_lport.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_port.h
 create mode 100644 drivers/scsi/bfa/include/aen/bfa_aen_rport.h
 create mode 100644 drivers/scsi/bfa/include/bfa.h
 create mode 100644 drivers/scsi/bfa/include/bfa_fcpim.h
 create mode 100644 drivers/scsi/bfa/include/bfa_fcptm.h
 create mode 100644 drivers/scsi/bfa/include/bfa_svc.h
 create mode 100644 drivers/scsi/bfa/include/bfa_timer.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_boot.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_cbreg.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_cee.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_ctreg.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_fabric.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_fcpim.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_fcxp.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_ioc.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_iocfc.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_lport.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_lps.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_port.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_pport.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_rport.h
 create mode 100644 drivers/scsi/bfa/include/bfi/bfi_uf.h
 create mode 100644 drivers/scsi/bfa/include/cna/bfa_cna_trcmod.h
 create mode 100644 drivers/scsi/bfa/include/cna/cee/bfa_cee.h
 create mode 100644 drivers/scsi/bfa/include/cna/port/bfa_port.h
 create mode 100644 drivers/scsi/bfa/include/cna/pstats/ethport_defs.h
 create mode 100644 drivers/scsi/bfa/include/cna/pstats/phyport_defs.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_checksum.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_debug.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_log.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_perf.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_plog.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_q.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_sm.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_trc.h
 create mode 100644 drivers/scsi/bfa/include/cs/bfa_wc.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_adapter.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_aen.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_audit.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_auth.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_boot.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_cee.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_driver.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_ethport.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_fcpim.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_im_common.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_im_team.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_ioc.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_iocfc.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_ipfc.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_itnim.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_led.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_lport.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_mfg.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_pci.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_pm.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_pom.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_port.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_pport.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_qos.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_rport.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_status.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_tin.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_tsensor.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_types.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_version.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_vf.h
 create mode 100644 drivers/scsi/bfa/include/defs/bfa_defs_vport.h
 create mode 100644 drivers/scsi/bfa/include/fcb/bfa_fcb.h
 create mode 100644 drivers/scsi/bfa/include/fcb/bfa_fcb_fcpim.h
 create mode 100644 drivers/scsi/bfa/include/fcb/bfa_fcb_port.h
 create mode 100644 drivers/scsi/bfa/include/fcb/bfa_fcb_rport.h
 create mode 100644 drivers/scsi/bfa/include/fcb/bfa_fcb_vf.h
 create mode 100644 drivers/scsi/bfa/include/fcb/bfa_fcb_vport.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs_auth.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs_fabric.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs_fcpim.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs_fdmi.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs_lport.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs_rport.h
 create mode 100644 drivers/scsi/bfa/include/fcs/bfa_fcs_vport.h
 create mode 100644 drivers/scsi/bfa/include/log/bfa_log_fcs.h
 create mode 100644 drivers/scsi/bfa/include/log/bfa_log_hal.h
 create mode 100644 drivers/scsi/bfa/include/log/bfa_log_linux.h
 create mode 100644 drivers/scsi/bfa/include/log/bfa_log_wdrv.h
 create mode 100644 drivers/scsi/bfa/include/protocol/ct.h
 create mode 100644 drivers/scsi/bfa/include/protocol/fc.h
 create mode 100644 drivers/scsi/bfa/include/protocol/fc_sp.h
 create mode 100644 drivers/scsi/bfa/include/protocol/fcp.h
 create mode 100644 drivers/scsi/bfa/include/protocol/fdmi.h
 create mode 100644 drivers/scsi/bfa/include/protocol/pcifw.h
 create mode 100644 drivers/scsi/bfa/include/protocol/scsi.h
 create mode 100644 drivers/scsi/bfa/include/protocol/types.h
 create mode 100644 drivers/scsi/bfa/loop.c
 create mode 100644 drivers/scsi/bfa/lport_api.c
 create mode 100644 drivers/scsi/bfa/lport_priv.h
 create mode 100644 drivers/scsi/bfa/ms.c
 create mode 100644 drivers/scsi/bfa/n2n.c
 create mode 100644 drivers/scsi/bfa/ns.c
 create mode 100644 drivers/scsi/bfa/plog.c
 create mode 100644 drivers/scsi/bfa/rport.c
 create mode 100644 drivers/scsi/bfa/rport_api.c
 create mode 100644 drivers/scsi/bfa/rport_ftrs.c
 create mode 100644 drivers/scsi/bfa/scn.c
 create mode 100644 drivers/scsi/bfa/vfapi.c
 create mode 100644 drivers/scsi/bfa/vport.c
 create mode 100644 drivers/scsi/mpt2sas/mpi/mpi2_history.txt
 delete mode 100644 drivers/staging/agnx/Kconfig
 delete mode 100644 drivers/staging/agnx/Makefile
 delete mode 100644 drivers/staging/agnx/TODO
 delete mode 100644 drivers/staging/agnx/agnx.h
 delete mode 100644 drivers/staging/agnx/debug.h
 delete mode 100644 drivers/staging/agnx/pci.c
 delete mode 100644 drivers/staging/agnx/phy.c
 delete mode 100644 drivers/staging/agnx/phy.h
 delete mode 100644 drivers/staging/agnx/rf.c
 delete mode 100644 drivers/staging/agnx/sta.c
 delete mode 100644 drivers/staging/agnx/sta.h
 delete mode 100644 drivers/staging/agnx/table.c
 delete mode 100644 drivers/staging/agnx/table.h
 delete mode 100644 drivers/staging/agnx/xmit.c
 delete mode 100644 drivers/staging/agnx/xmit.h
 delete mode 100644 drivers/staging/cowloop/Kconfig
 delete mode 100644 drivers/staging/cowloop/Makefile
 delete mode 100644 drivers/staging/cowloop/TODO
 delete mode 100644 drivers/staging/cowloop/cowloop.c
 delete mode 100644 drivers/staging/cowloop/cowloop.h
 delete mode 100644 drivers/staging/stlc45xx/Kconfig
 delete mode 100644 drivers/staging/stlc45xx/Makefile
 delete mode 100644 drivers/staging/stlc45xx/stlc45xx.c
 delete mode 100644 drivers/staging/stlc45xx/stlc45xx.h
 delete mode 100644 drivers/staging/stlc45xx/stlc45xx_lmac.h
 create mode 100644 firmware/cis/COMpad2.cis.ihex
 create mode 100644 firmware/cis/COMpad4.cis.ihex
 create mode 100644 firmware/cis/DP83903.cis.ihex
 create mode 100644 firmware/cis/NE2K.cis.ihex
 create mode 100644 firmware/cis/PE-200.cis.ihex
 create mode 100644 firmware/cis/SW_555_SER.cis.ihex
 create mode 100644 firmware/cis/SW_7xx_SER.cis.ihex
 create mode 100644 firmware/cis/SW_8xx_SER.cis.ihex
 create mode 100644 firmware/cis/tamarack.cis.ihex
