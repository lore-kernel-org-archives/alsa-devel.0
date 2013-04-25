From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.10
Date: Thu, 25 Apr 2013 11:57:11 +0100
Message-ID: <20130425105711.GO5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5785096369939446688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B5BD2650CE
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 12:57:13 +0200 (CEST)
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


--===============5785096369939446688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v1TsIsr/WJoL6YzS"
Content-Disposition: inline


--v1TsIsr/WJoL6YzS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 22f38f792ec53e2a93be13ecb609bbe911ed8ff9:

  ASoC: ux500: Use generic dmaengine PCM (2013-04-18 15:04:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.10-3

for you to fetch changes up to 5cc50fc858a5ab37dc2744d72d7ffed96f23afd8:

  Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next (2013-04-2=
3 19:26:15 +0100)

Diffstat and log are inflated by Linus' tree again, plus git has
apparently got itself a bit confused about what to diff against and
picked the wrong side of a merge.

----------------------------------------------------------------

ASoC: More updates for v3.10

A few more fixes, nothing too major though the DMA changes fix modular
builds.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: 7692/1: iop3xx: move IOP3XX_PERIPHERAL_VIRT_BASE

Abhijeet Dharmapurikar (1):
      irqchip: gic: fix irq_trigger return

Akinobu Mita (2):
      sparc/srmmu: clear trailing edge of bitmap properly
      sparc/iommu: fix typo s/265KB/256KB/

Alban Bedel (1):
      ASoC: wm8903: Add the DAC boost control

Alex Elder (1):
      rbd: do a safe list traversal in rbd_img_request_submit()

Alexander Duyck (1):
      igb: Revert support for build_skb in igb

Alistair Popple (1):
      powerpc: Fix audit crash due to save/restore PPR changes

Andreas Schwab (1):
      kbuild: generate generic headers before recursing into scripts

Andrei Epure (1):
      drivers/video/mmp/core.c: fix use-after-free bug

Andrey Smirnov (2):
      ASoC: si476x: Convert SI476X codec to use regmap
      ASoC: si476x: Cosmetic changes to SI476X codec driver

Andy Lutomirski (2):
      userns: Check uid_map's opener's fsuid, not the current fsuid
      userns: Changing any namespace id mappings should require privileges

Antonio Quartulli (1):
      batman-adv: make is_my_mac() check for the current mesh only

Arend van Spriel (2):
      brcmfmac: remove advertising P2P device support
      brcmsmac: request firmware in .start() callback

Ariel Elior (1):
      bnx2x: Fix status blocks configuration

Arnd Bergmann (6):
      ASoC: samsung: use irq resource for idma
      ASoC: samsung: fix module_device_table
      ASoC: samsung: export idma_reg_addr_init
      ASoC: samsung: move plat/ headers to local directory
      net: ax88796: avoid 64 bit arithmetic
      ASoC: ux500: forward declare msp_i2s_platform_data

Bastian Hecht (1):
      ARM: 7697/1: hw_breakpoint: do not use __cpuinitdata for dbg_cpu_pm_nb

Ben Greear (1):
      net: rate-limit warn-bad-offload splats.

Bj=C3=B8rn Mork (4):
      net: cdc_mbim: remove bogus sizeof()
      net: qmi_wwan: fixup missing ethernet header (firmware bug workaround)
      net: qmi_wwan: fixup destination address (firmware bug workaround)
      net: qmi_wwan: prevent duplicate mac address on link (firmware bug wo=
rkaround)

Charles Keepax (12):
      ASoC: arizona: Move selection of FLL REFCLK into init
      ASoC: arizona: Tidy up SYNCCLK selection and cache values
      ASoC: arizona: Factor out check for enabled FLL
      ASoC: arizona: Factor out FLL disable
      ASoC: arizona: Factor out FLL enable
      ASoC: arizona: Improve suppression of noop FLL updates
      ASoC: arizona: Add support for directly setting the FLL REFCLK
      ASoC: arizona: Add convience define for clearing SYNCCLK
      ASoC: arizona: Don't enable FLL on REFCLK configuration
      ASoC: wm5102: Correctly use SOC_VALUE_ENUM for ISRC FSL controls
      ASoC: wm0010: Constify usage of firmware filenames
      ASoC: wm0010: Report filename when we fail to load firmware

Christian Ruppert (1):
      stmmac: prevent interrupt loop with MMC RX IPC Counter

Christoph Fritz (1):
      can: sja1000: fix handling on dt properties on little endian systems

Cong Wang (1):
      ipv6: statically link register_inet6addr_notifier()

Dan Carpenter (2):
      ASoC: tas5086: signedness bug in tas5086_hw_params()
      irda: small read past the end of array in debug code

Daniel Mack (5):
      ASoC: ak4104: convert to direct regmap API usage
      ASoC: ak4104: correct tranceiver enable handling
      ASoC: Add codec driver for AK5386
      ALSA: ASoC: add codec driver for TI TAS5086
      ASoC: davinci-mcasp: clean up davinci_hw_common_param()

David S. Miller (10):
      Merge branch 'master' of git://git.kernel.org/.../pablo/nf into netfi=
lter
      Merge branch 'fixes-for-3.9' of git://gitorious.org/linux-can/linux-c=
an
      Merge branch 'fixes' of git://git.kernel.org/.../jesse/openvswitch
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      Merge branch 'qlogic'
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch 'master' of git://git.kernel.org/.../pablo/nf
      sparc64: Fix race in TLB batch processing.
      Merge branch 'bonding'
      Merge branch 'qmi_wwan'

David Ward (1):
      net/802/mrp: fix possible race condition when calling mrp_pdu_queue()

Dmitry Kravkov (1):
      bnx2x: Prevent UNDI FW illegal host access

Dmitry Popov (1):
      tcp: incoming connections might use wrong route under synflood

Emese Revfy (1):
      kernel/signal.c: stop info leak via the tkill and the tgkill syscalls

Eric Dumazet (3):
      net: drop dst before queueing fragments
      bonding: fix l23 and l34 load balancing in forwarding path
      tcp: call tcp_replace_ts_recent() from tcp_ack()

Eric W. Biederman (1):
      userns: Don't let unprivileged users trick privileged users into sett=
ing the id_map

Felix Fietkau (2):
      ath9k_htc: accept 1.x firmware newer than 1.3
      ath9k_hw: change AR9580 initvals to fix a stability issue

Florian Westphal (2):
      netfilter: nf_nat: fix race when unloading protocol modules
      netfilter: xt_rpfilter: skip locally generated broadcast/multicast, t=
oo

Greg Rose (1):
      ixgbe: Fix a bug in setting VF VLAN via PF

H. Peter Anvin (2):
      x86, microcode: Verify the family before dispatching microcode patchi=
ng
      Merge remote-tracking branch 'efi/urgent' into x86/urgent

Heiko St=C3=BCbner (1):
      ASoC: samsung: fix neo1973-wm8753 compilation

Himanshu Madhani (1):
      qlcnic: fix beaconing test for 82xx adapter

Hong Zhiguo (1):
      openvswitch: correct an invalid BUG_ON

Illia Ragozin (1):
      ARM: 7696/1: Fix kexec by setting outer_cache.inv_all for Feroceon

Ivan Vecera (1):
      be2net: take care of __vlan_put_tag return value

Jason Gerecke (2):
      Input: wacom - fix "can not retrieve extra class descriptor" for 24HDT
      Input: wacom - correct reported resolution for Intuos4 Wireless

Jeeja KP (1):
      ASoC: compress - add support for metadata apis

Jesse Gross (1):
      openvswitch: Preallocate reply skb in ovs_vport_cmd_set().

Jitendra Kalsaria (3):
      qlcnic: Stop traffic before performing loopback test
      qlge: Fix ethtool autoneg advertising.
      qlge: Update version to 1.00.00.32.

Joe Perches (1):
      checkpatch: fix stringification macro defect

Johannes Berg (2):
      mac80211: fix LED in idle handling
      mac80211: fix cfg80211 interaction on auth/assoc request

John W. Linville (3):
      Merge branch 'for-john' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'for-john' of git://x-git.kernel.org/.../jberg/mac80211
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem

Joonsoo Kim (1):
      ARM: 7694/1: ARM, TCM: initialize TCM in paging_init(), instead of se=
tup_arch()

Josh Wu (1):
      avr32: fix build error in atstk1006_defconfig

Jozsef Kadlecsik (3):
      netfilter: ipset: list:set: fix reference counter update
      netfilter: ipset: hash:*net*: nomatch flag not excluded on set resize
      netfilter: ipset: bitmap:ip,mac: fix listing with timeout

K. Y. Srinivasan (1):
      x86, hyperv: Handle Xen emulation of Hyper-V more gracefully

Kefeng Wang (2):
      sparc:remove unused declaration smp_boot_cpus()
      sparc:cleanup unused code in smp_32.h

Kevin Hao (1):
      powerpc: add a missing label in resume_kernel

Kuninori Morimoto (58):
      ASoC: fsi: remove unused irq
      ASoC: add snd_soc_register_component()
      ASoC: add .name for snd_soc_component_driver
      ASoC: fsi: use snd_soc_register_component() instead of snd_soc_regist=
er_dais()
      ASoC: pxa2xx-ac97: move EXPORT_SYMBOL_GPL() next to definition
      ASoC: snd_soc_register_component() uses properly snd_soc_register_dai=
[s]()
      ASoC: switch over to use snd_soc_register_component() on davinci i2s
      ASoC: switch over to use snd_soc_register_component() on davinci vcif
      ASoC: switch over to use snd_soc_register_component() on davinci mcasp
      ASoC: switch over to use snd_soc_register_component() on dw i2s
      ASoC: switch over to use snd_soc_register_component() on mpc5200 ac97
      ASoC: switch over to use snd_soc_register_component() on atmel ssc
      ASoC: switch over to use snd_soc_register_component() on au1x i2sc
      ASoC: switch over to use snd_soc_register_component() on au1x psc-ac97
      ASoC: switch over to use snd_soc_register_component() on au1x psc-i2s
      ASoC: switch over to use snd_soc_register_component() on au1x ac97c
      ASoC: switch over to use snd_soc_register_component() on bf6xx i2s
      ASoC: switch over to use snd_soc_register_component() on bf5xx ac97
      ASoC: switch over to use snd_soc_register_component() on bf5xx i2s
      ASoC: switch over to use snd_soc_register_component() on bf5xx tdm
      ASoC: switch over to use snd_soc_register_component() on ep93xx ac97
      ASoC: switch over to use snd_soc_register_component() on ep93xx i2s
      ASoC: switch over to use snd_soc_register_component() on mpc5200 i2s
      ASoC: switch over to use snd_soc_register_component() on fsl ssi
      ASoC: switch over to use snd_soc_register_component() on imx ssi
      ASoC: switch over to use snd_soc_register_component() on jz4740 i2s
      ASoC: switch over to use snd_soc_register_component() on kirkwood i2s
      ASoC: switch over to use snd_soc_register_component() on sst
      ASoC: switch over to use snd_soc_register_component() on mxs saif
      ASoC: switch over to use snd_soc_register_component() on nuc900 ac97
      ASoC: switch over to use snd_soc_register_component() on omap mcbsp
      ASoC: switch over to use snd_soc_register_component() on omap mcpdm
      ASoC: switch over to use snd_soc_register_component() on omap dmic
      ASoC: switch over to use snd_soc_register_component() on omap hdmi
      ASoC: switch over to use snd_soc_register_component() on pxa ssp
      ASoC: switch over to use snd_soc_register_component() on pxa2xx ac97
      ASoC: switch over to use snd_soc_register_component() on pxa2xx i2s
      ASoC: switch over to use snd_soc_register_component() on mmp sspa
      ASoC: switch over to use snd_soc_register_component() on s6000 i2s
      ASoC: switch over to use snd_soc_register_component() on s3c24xx i2s
      ASoC: switch over to use snd_soc_register_component() on s3c i2s
      ASoC: switch over to use snd_soc_register_component() on s3c ac97
      ASoC: switch over to use snd_soc_register_component() on samsung spdif
      ASoC: switch over to use snd_soc_register_component() on samsung i2s
      ASoC: switch over to use snd_soc_register_component() on samsung pcm
      ASoC: switch over to use snd_soc_register_component() on goni_wm8994
      ASoC: switch over to use snd_soc_register_component() on sh4 ssi
      ASoC: switch over to use snd_soc_register_component() on sh4 hac
      ASoC: switch over to use snd_soc_register_component() on spear spdif =
out
      ASoC: switch over to use snd_soc_register_component() on spear spdif =
in
      ASoC: switch over to use snd_soc_register_component() on tegra30 i2s
      ASoC: switch over to use snd_soc_register_component() on tegra20 spdif
      ASoC: switch over to use snd_soc_register_component() on tegra20 ac97
      ASoC: switch over to use snd_soc_register_component() on tegra20 i2s
      ASoC: switch over to use snd_soc_register_component() on txx9aclc ac97
      ASoC: switch over to use snd_soc_register_component() on ux500 msp
      ASoC: snd_soc_[un]register_dai[s]() become non global function
      ASoC: switch over to use snd_soc_register_component() on sh4 siu

Lars-Peter Clausen (5):
      ASoC: spear_pcm: Staticize non-exported structs
      ASoC: generic-dmaengine-pcm: Add support for half-duplex
      ASoC: mxs-pcm: Set SNDRV_PCM_INFO_HALF_DUPLEX
      ASoC: mxs: Setup dma data in DAI probe
      ASoC: mxs: Use generic dmaengine PCM

Len Brown (2):
      intel_idle: additional Haswell CPU-id
      tools/power turbostat: additional Haswell CPU-id

Linus Torvalds (32):
      Merge branches 'timers-urgent-for-linus', 'irq-urgent-for-linus' and =
'core-urgent-for-linus' of git://git.kernel.org/.../tip/tip
      vm: add vm_iomap_memory() helper function
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge branch 'rc-fixes' of git://git.kernel.org/.../mmarek/kbuild
      Merge tag 'for-linus' of git://git.kernel.org/.../sfr/next-fixes
      Merge git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
      s390: move dummy io_remap_pfn_range() to asm/pgtable.h
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'for-linus' of git://git.kernel.org/.../sage/ceph-client
      Merge branch 'akpm' (fixes from Andrew)
      Merge branch 'release' of git://git.kernel.org/.../lenb/linux
      Revert "block: add missing block_bio_complete() tracepoint"
      Merge branch 'for_linus' of git://cavan.codon.org.uk/platform-drivers=
-x86
      Merge branch 'userns-fixes' of git://git.kernel.org/.../luto/linux
      Merge branch 'for-linus' of git://git.kernel.org/.../mszeredi/fuse
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      vm: convert HPET mmap to vm_iomap_memory() helper
      vm: convert mtdchar mmap to vm_iomap_memory() helper
      vm: convert fb_mmap to vm_iomap_memory() helper
      vm: convert snd_pcm_lib_mmap_iomem() to vm_iomap_memory() helper
      mtdchar: remove no-longer-used vma helpers
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      net: fix incorrect credentials passing
      Merge git://git.kernel.org/.../davem/net
      Merge git://git.kernel.org/.../davem/sparc
      Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'x86-kdump-for-linus' of git://git.kernel.org/.../tip/tip
      Merge branch 'vm_ioremap_memory-examples'
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Linux 3.9-rc8

Lucas Stach (1):
      net: fec: fix regression in link change accounting

Ludovic Desroches (1):
      dmaengine: at_hdmac: fix race condition in atc_advance_work()

Marc Kleine-Budde (1):
      can: mcp251x: add missing IRQF_ONESHOT to request_threaded_irq

Marc Zyngier (3):
      ARM: KVM: fix KVM_CAP_ARM_SET_DEVICE_ADDR reporting
      ARM: KVM: fix L_PTE_S2_RDWR to actually be Read/Write
      ARM: KVM: fix unbalanced get_cpu() in access_dcsw

Marcelo Tosatti (1):
      Merge branch 'kvm-arm-fixes-3.9' of git://github.com/columbia/linux-k=
vm-arm

Mark Brown (76):
      ASoC: arizona: Only allow input volume updates when inputs are enabled
      ASoC: wm8960: Add input boost volume control
      ASoC: arizona: If we only have a clock to synchronise with make it RE=
FCLK
      mfd: arizona: Define additional FLL control registers
      mfd: wm5102: Map in additional FLL control registers
      ASoC: arizona: Increase FLL synchroniser bandwidth for high frequenci=
es
      ASoC: arizona: Optimise FLL loop gains
      ASoC: arizona: Ensure synchroniser is disabled when not needed
      ASoC: arizona: Suppress reference calculations when setting REFCLK to=
 0
      ASoC: arizona: Provide defines for the clock rates
      ASoC: wm_adsp: Handle old .bin files
      ASoC: arizona: Ensure we clock two channels for I2S mode
      ASoC: wm8994: Support constraining the maximum number of channels clo=
cked
      mfd: wm5102: Add additional speaker control registers
      ASoC: arizona: Factor out speaker widgets from CODEC drivers
      ASoC: arizona: Log thermal events
      ASoC: arizona: Suppress speaker enable if thermal shutdown is flagged
      ASoC: arizona: Basic support for ISRC rate selection
      ASoC: wm8994: Restore AIFnCLK after reducing it for low clock rates
      extcon: arizona: Factor out magic application
      ASoC: arizona: Fix interaction between headphone outputs and identifi=
cation
      extcon: arizona: Fix interaction between headphone outputs and identi=
fication
      Merge tag 'arizona-extcon-asoc' of git://git.kernel.org/.../broonie/m=
isc into asoc-arizona
      ASoC: arizona: Add delay after powering up line level outputs
      Merge branch 'topic/pxa' of git://git.kernel.org/.../broonie/sound in=
to asoc-component
      ASoC: wm5102: Implement OSR support
      ASoC: wm2000: Expose some more registers for diagnostics
      ASoC: wm_adsp: Provide defines for firmwares
      ASoC: wm_adsp: Split ADSP1 and ADSP2 firmware controls
      Merge branch 'fix/samsung' of git://git.kernel.org/.../broonie/sound =
into asoc-samsung
      ASoC: core: Merge Samsung fixes to avoid trivial context conflict
      ASoC: wm8994: Remove duplicate revision cache
      ASoC: wm_adsp: Add support for firmware wide coefficient blocks
      Merge remote-tracking branch 'asoc/fix/compress' into asoc-next
      Merge remote-tracking branch 'asoc/fix/core' into asoc-next
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/fix/tegra' into asoc-next
      Merge remote-tracking branch 'asoc/fix/wm8903' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adau1373' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak4104' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ak5386' into asoc-next
      Merge remote-tracking branch 'asoc/topic/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/topic/atmel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/component' into asoc-next
      Merge remote-tracking branch 'asoc/topic/compress' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs4271' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs42l73' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsi' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/maintainers' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98088' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98090' into asoc-next
      Merge remote-tracking branch 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/topic/si476x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/spear' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tas5086' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tegra' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm-hubs' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm0010' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm2000' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8903' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8960' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8994' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs4271' into asoc-next
      Merge remote-tracking branch 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/max98088' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ux500' into asoc-next

Masami Hiramatsu (1):
      kprobes: Fix a double lock bug of kprobe_mutex

Matt Fleming (1):
      x86, efivars: firmware bug workarounds should be in platform code

Matthew Garrett (4):
      Move utf16 functions to kernel core and rename
      efi: Pass boot services variable info to runtime code
      efi: Distinguish between "remaining space" and actually used space
      Revert "hp-wmi: Add support for SMBus hotkeys"

Michael Bohan (1):
      hrtimer: Don't reinitialize a cpu_base lock on CPU_UP

Michael Neuling (1):
      powerpc: fix compiling CONFIG_PPC_TRANSACTIONAL_MEM when CONFIG_ALTIV=
EC=3Dn

Michal Bachraty (3):
      ASoC: davinci-mcasp: Add support for multichannel playback
      ASoC: davinci-pcm, davinci-mcasp: Clean up active_serializers
      ASoC: davinci-mcasp: Add Support BCLK-to-LRCLK ratio for TDM modes

Miklos Szeredi (1):
      fuse: fix type definitions in uapi header

Mugunthan V N (1):
      drivers: net: ethernet: cpsw: get slave VLAN id from slave node inste=
ad of cpsw node

Naoya Horiguchi (3):
      hugetlbfs: stop setting VM_DONTDUMP in initializing vma(VM_HUGETLB)
      fs/binfmt_elf.c: fix hugetlb memory check in vma_dump_size()
      hugetlbfs: add swap entry check in follow_hugetlb_page()

Oleg Nesterov (1):
      thinkpad-acpi: kill hotkey_thread_mutex

Patrick McHardy (1):
      netfilter: nf_ct_sip: don't drop packets with offsets pointing outsid=
e the packet

Paul Bolle (2):
      ASoC: samsung: remove last traces of neo1973-gta01
      ASoC: Ux500: remove test for undefined Kconfig macro

Paul Handrigan (1):
      ASoC: cs42l73: If Internal MCLK is >=3D 6.4MHz, then set SCLK to 64*F=
s.

Ping Cheng (2):
      Input: wacom - DTH2242 Grip Pen id was off by one bit
      Input: wacom - fix "can not retrieve extra class descriptor" for DTH2=
242

Rafa=C5=82 Mi=C5=82ecki (1):
      ssb: implement spurious tone avoidance

Richard Weinberger (2):
      x86,efi: Check max_size only if it is non-zero.
      x86,efi: Implement efi_no_storage_paranoia parameter

Rob Herring (1):
      ARM: highbank: fix cache flush ordering for cpu hotplug

Russell King (2):
      ARM: Do 15e0d9e37c (ARM: pm: let platforms select cpu_suspend support=
) properly
      Merge branch 'for-rmk/740t' of git://git.kernel.org/.../will/linux in=
to fixes

Ryo Tsutsui (2):
      ASoC: dapm: Remove redundant clear_walk() for supply widgets
      ASoC: dapm: Only clear paths we've walked

Sachin Kamat (5):
      ASoC: max98090: Remove unneeded version.h header include
      ASoC: max98090: Convert to devm_regmap_init_i2c()
      ASoC: max98090: Make struct dev_pm_ops const
      ASoC: max98090: Fix checkpatch errors related to spacing
      ASoC: max98090: Remove unnecessary braces

Sam Ravnborg (3):
      sparc: use generic headers
      bbc_i2c: fix section mismatch warning
      sparc: use asm-generic version of types.h

Scott Wood (4):
      kvm/powerpc/e500mc: fix tlb invalidation on cpu migration
      kvm/ppc/e500: h2g_tlb1_rmap: esel 0 is valid
      kvm/ppc/e500: g2h_tlb1_map: clear old bit before setting new bit
      kvm/ppc/e500: eliminate tlb_refs

Sergey Vlasov (2):
      x86/Kconfig: Make EFI select UCS2_STRING
      efi: Export efi_query_variable_store() for efivars.ko

Shahed Shaikh (1):
      qlcnic: Fix typo in logs

Shawn Guo (2):
      ASoC: generic-dmaengine-pcm: use a more common dma name
      ASoC: generic-dmaengine-pcm: call dma_request_slave_channel()

Sritej Velaga (2):
      qlcnic: fix TSO race condition
      qlge: Fix receive path to drop error frames

Stephane Eranian (1):
      perf/x86: Fix offcore_rsp valid mask for SNB/IVB

Stephen Boyd (1):
      ARM: 7699/1: sched_clock: Add more notrace to prevent recursion

Stephen Warren (10):
      ASoC: tegra: assume CONFIG_OF in tegra_asoc_utils_init
      ASoC: tegra_wm8753: minor cleanup
      ASoC: tegra_wm9712: assume CONFIG_OF
      ASoC: tegra_alc5632: assume CONFIG_OF, and other cleanup
      ASoC: tegra trimslice: assume CONFIG_OF, and other cleanup
      ASoC: tegra_wm8903: assume CONFIG_OF, remove platform data
      ASoC: tegra: add Tegra114 support to the AHUB driver
      ASoC: tegra: add Tegra114 support to tegra_asoc_utils.c
      ASoC: export snd_soc_register_component
      ASoC: dapm: Implement mixer control sharing

Thomas Gleixner (1):
      kthread: Prevent unpark race which puts threads on the wrong cpu

Thomas Graf (1):
      tcp: Reallocate headroom if it would overflow csum_start

Thomas Petazzoni (1):
      net: mvmdio: add select PHYLIB

Tim Gardner (2):
      ASoC: adau1373: adau1373_hw_params: Silence overflow warning
      ASoC: wm_hubs: Silence reg_r and reg_l 'may be used uninitialized' wa=
rnings

Tommi Rantala (1):
      perf: Treat attr.config as u64 in perf_swevent_init()

Vinod Koul (1):
      ASoC: mid-x86 - add support for meaadata apis

Vyacheslav Dubeyko (1):
      hfsplus: fix potential overflow in hfsplus_file_truncate()

Wei Yongjun (5):
      ASoC: tas5086: use module_i2c_driver to simplify the code
      ASoC: arizona: remove duplicated include from arizona.c
      tuntap: fix error return code in tun_set_iff()
      esp4: fix error return code in esp_output()
      pkt_sched: fix error return code in fw_change_attrs()

Will Deacon (6):
      ARM: tlbflush: remove ARMv3 support
      ARM: cache: remove ARMv3 support code
      ARM: mm: fix numerous hideous errors in proc-arm740.S
      ARM: mm: remove broken condition check for v4 flushing
      ARM: modules: don't export cpu_set_pte_ext when !MMU
      ARM: 7698/1: perf: fix group validation when using enable_on_exec

Willy Tarreau (1):
      net: mvneta: fix improper tx queue usage in mvneta_tx()

Xishi Qiu (1):
      mm/vmscan: fix error return in kswapd_run()

Yegor Yefremov (2):
      ASoC: davinci-mcasp: don't configure AFSX direction in DIT mode
      ASoC: davinci-mcasp: don't overwrite DIT settings

Yinghai Lu (4):
      x86, kdump: Set crashkernel_low automatically
      x86, kdump: Retore crashkernel=3D to allocate under 896M
      x86, kdump: Change crashkernel_high/low=3D to crashkernel=3D,high/low
      kexec: use Crash kernel for Crash kernel low

Zefir Kurtisi (1):
      ath9k: fix DFS detector called in softirq context

Zoltan Puskas (1):
      ASoC: atmel: Add slave mode support to SSC in DSP Mode A

nikolay@redhat.com (7):
      bonding: fix netdev event NULL pointer dereference
      bonding: IFF_BONDING is not stripped on enslave failure
      bonding: mc addresses don't get deleted on enslave failure
      bonding: vlans don't get deleted on enslave failure
      bonding: primary_slave & curr_active_slave are not cleaned on enslave=
 failure
      bonding: disable netpoll on enslave failure
      bonding: in bond_mc_swap() bond's mc addr list is walked without lock

stephen hemminger (1):
      bridge: make user modified path cost sticky

 Documentation/devicetree/bindings/sound/ak5386.txt |   19 +
 .../bindings/sound/nvidia,tegra30-ahub.txt         |   26 +-
 .../devicetree/bindings/sound/ti,tas5086.txt       |   32 ++
 Documentation/kernel-parameters.txt                |   29 +-
 Makefile                                           |    5 +-
 arch/arm/include/asm/glue-cache.h                  |    8 -
 arch/arm/include/asm/hardware/iop3xx.h             |    2 +-
 arch/arm/include/asm/pgtable-3level.h              |    2 +-
 arch/arm/include/asm/tlbflush.h                    |   11 +-
 arch/arm/kernel/hw_breakpoint.c                    |    2 +-
 arch/arm/kernel/perf_event.c                       |    5 +-
 arch/arm/kernel/sched_clock.c                      |    4 +-
 arch/arm/kernel/setup.c                            |    3 -
 arch/arm/kernel/tcm.c                              |    1 -
 arch/arm/kvm/arm.c                                 |    1 +
 arch/arm/kvm/coproc.c                              |    4 +-
 arch/arm/mach-highbank/hotplug.c                   |   10 +-
 arch/arm/mach-s3c24xx/dma-s3c2410.c                |    2 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c                |    2 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c                |    2 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c                |    2 -
 arch/arm/mm/Kconfig                                |    5 +-
 arch/arm/mm/Makefile                               |    1 -
 arch/arm/mm/cache-feroceon-l2.c                    |    1 +
 arch/arm/mm/cache-v3.S                             |  137 -----
 arch/arm/mm/cache-v4.S                             |    2 +-
 arch/arm/mm/mmu.c                                  |    2 +
 arch/arm/mm/proc-arm740.S                          |   30 +-
 arch/arm/mm/proc-arm920.S                          |    2 +-
 arch/arm/mm/proc-arm926.S                          |    2 +-
 arch/arm/mm/proc-mohawk.S                          |    2 +-
 arch/arm/mm/proc-sa1100.S                          |    2 +-
 arch/arm/mm/proc-syms.c                            |    2 +
 arch/arm/mm/proc-v6.S                              |    2 +-
 arch/arm/mm/proc-xsc3.S                            |    2 +-
 arch/arm/mm/proc-xscale.S                          |    2 +-
 arch/arm/{kernel =3D> mm}/tcm.h                      |    0
 arch/arm/plat-samsung/devs.c                       |    6 +
 arch/avr32/include/asm/io.h                        |    4 +
 arch/powerpc/kernel/entry_64.S                     |    4 +-
 arch/powerpc/kernel/process.c                      |    2 +
 arch/powerpc/kernel/signal_32.c                    |    2 +
 arch/powerpc/kernel/signal_64.c                    |    2 +
 arch/powerpc/kernel/tm.S                           |    2 +
 arch/powerpc/kvm/e500.h                            |   24 +-
 arch/powerpc/kvm/e500_mmu_host.c                   |   84 +--
 arch/powerpc/kvm/e500mc.c                          |    7 +-
 arch/s390/include/asm/io.h                         |    4 -
 arch/s390/include/asm/pgtable.h                    |    4 +
 arch/sparc/include/asm/Kbuild                      |    5 +
 arch/sparc/include/asm/cputime.h                   |    6 -
 arch/sparc/include/asm/emergency-restart.h         |    6 -
 arch/sparc/include/asm/mutex.h                     |    9 -
 arch/sparc/include/asm/pgtable_64.h                |    1 +
 arch/sparc/include/asm/serial.h                    |    6 -
 arch/sparc/include/asm/smp_32.h                    |    5 -
 arch/sparc/include/asm/switch_to_64.h              |    3 +-
 arch/sparc/include/asm/tlbflush_64.h               |   37 +-
 arch/sparc/include/uapi/asm/Kbuild                 |    1 -
 arch/sparc/include/uapi/asm/types.h                |   17 -
 arch/sparc/kernel/smp_64.c                         |   41 +-
 arch/sparc/lib/bitext.c                            |    6 +-
 arch/sparc/mm/iommu.c                              |    2 +-
 arch/sparc/mm/srmmu.c                              |    4 +-
 arch/sparc/mm/tlb.c                                |   38 +-
 arch/sparc/mm/tsb.c                                |   57 +-
 arch/sparc/mm/ultra.S                              |  119 +++-
 arch/x86/Kconfig                                   |    1 +
 arch/x86/boot/compressed/eboot.c                   |   47 ++
 arch/x86/include/asm/efi.h                         |    7 +
 arch/x86/include/uapi/asm/bootparam.h              |    1 +
 arch/x86/kernel/cpu/mshyperv.c                     |   18 +-
 arch/x86/kernel/cpu/perf_event_intel.c             |   20 +-
 arch/x86/kernel/microcode_core_early.c             |   38 +-
 arch/x86/kernel/setup.c                            |   45 +-
 arch/x86/platform/efi/efi.c                        |  168 +++++-
 block/blk-core.c                                   |    1 +
 drivers/block/rbd.c                                |    3 +-
 drivers/char/hpet.c                                |   14 +-
 drivers/dma/at_hdmac.c                             |    9 +-
 drivers/extcon/extcon-arizona.c                    |  107 ++--
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/efivars.c                         |   98 +---
 drivers/idle/intel_idle.c                          |    1 +
 drivers/input/tablet/wacom_wac.c                   |    8 +-
 drivers/irqchip/irq-gic.c                          |    3 +-
 drivers/md/dm.c                                    |    1 +
 drivers/md/raid5.c                                 |   11 +-
 drivers/mfd/wm5102-tables.c                        |   10 +
 drivers/mtd/mtdchar.c                              |   59 +-
 drivers/net/bonding/bond_main.c                    |   90 ++-
 drivers/net/can/mcp251x.c                          |   10 +-
 drivers/net/can/sja1000/sja1000_of_platform.c      |   31 +-
 drivers/net/ethernet/8390/ax88796.c                |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    7 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    4 +
 drivers/net/ethernet/emulex/benet/be_main.c        |    5 +-
 drivers/net/ethernet/freescale/fec.c               |    1 +
 drivers/net/ethernet/intel/igb/igb.h               |    8 -
 drivers/net/ethernet/intel/igb/igb_main.c          |  110 +---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |    6 +
 drivers/net/ethernet/marvell/Kconfig               |    2 +-
 drivers/net/ethernet/marvell/mvneta.c              |    9 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   15 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |    3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |    4 +-
 drivers/net/ethernet/qlogic/qlge/qlge.h            |    2 +-
 drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c    |    2 +-
 drivers/net/ethernet/qlogic/qlge/qlge_main.c       |   36 +-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |    1 +
 drivers/net/ethernet/ti/cpsw.c                     |    2 +-
 drivers/net/tun.c                                  |    2 +-
 drivers/net/usb/cdc_mbim.c                         |    2 +-
 drivers/net/usb/qmi_wwan.c                         |  104 ++++
 .../net/wireless/ath/ath9k/ar9580_1p0_initvals.h   |    2 +-
 .../net/wireless/ath/ath9k/dfs_pattern_detector.c  |    4 +-
 drivers/net/wireless/ath/ath9k/dfs_pri_detector.c  |    4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |    2 +-
 drivers/net/wireless/b43/phy_n.c                   |    3 +-
 .../net/wireless/brcm80211/brcmfmac/wl_cfg80211.c  |    7 +-
 .../net/wireless/brcm80211/brcmsmac/mac80211_if.c  |  264 ++++-----
 drivers/platform/x86/hp-wmi.c                      |    4 -
 drivers/platform/x86/thinkpad_acpi.c               |   10 -
 drivers/sbus/char/bbc_i2c.c                        |    4 +-
 drivers/ssb/driver_chipcommon_pmu.c                |   29 +
 drivers/video/fbmem.c                              |   39 +-
 drivers/video/mmp/core.c                           |    2 -
 fs/binfmt_elf.c                                    |    1 +
 fs/bio.c                                           |    2 -
 fs/hfsplus/extents.c                               |    2 +-
 fs/hugetlbfs/inode.c                               |    2 +-
 fs/proc/array.c                                    |    1 +
 include/linux/blktrace_api.h                       |    1 -
 include/linux/efi.h                                |    9 +-
 include/linux/kexec.h                              |    2 +
 include/linux/mfd/arizona/core.h                   |    3 +
 include/linux/mfd/arizona/registers.h              |   42 ++
 include/linux/mfd/wm8994/pdata.h                   |    8 +
 include/linux/mm.h                                 |    2 +
 include/linux/netfilter/ipset/ip_set_ahash.h       |   30 +-
 include/linux/sched.h                              |    5 +-
 include/linux/ssb/ssb_driver_chipcommon.h          |    2 +
 include/linux/swiotlb.h                            |    1 +
 include/linux/ucs2_string.h                        |   14 +
 include/net/addrconf.h                             |    1 +
 include/net/irda/irlmp.h                           |    3 +-
 include/net/scm.h                                  |    4 +-
 include/sound/dmaengine_pcm.h                      |    5 +
 include/sound/soc-dai.h                            |    8 -
 include/sound/soc.h                                |   20 +
 include/sound/tas5086.h                            |    7 +
 include/sound/tegra_wm8903.h                       |   26 -
 include/trace/events/block.h                       |    8 +-
 include/trace/events/sched.h                       |    2 +-
 include/uapi/linux/fuse.h                          |  436 +++++++--------
 kernel/events/core.c                               |    2 +-
 kernel/hrtimer.c                                   |    3 +-
 kernel/kexec.c                                     |  118 +++-
 kernel/kprobes.c                                   |   19 +-
 kernel/kthread.c                                   |   52 +-
 kernel/signal.c                                    |    2 +-
 kernel/smpboot.c                                   |   14 +-
 kernel/trace/blktrace.c                            |   26 +-
 kernel/user_namespace.c                            |   22 +-
 lib/Kconfig                                        |    3 +
 lib/Makefile                                       |    2 +
 lib/swiotlb.c                                      |   19 +-
 lib/ucs2_string.c                                  |   51 ++
 mm/hugetlb.c                                       |   12 +-
 mm/memory.c                                        |   47 ++
 mm/vmscan.c                                        |    2 +-
 net/802/mrp.c                                      |    4 +
 net/batman-adv/main.c                              |    5 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/routing.c                           |   38 +-
 net/batman-adv/translation-table.c                 |    2 +-
 net/batman-adv/vis.c                               |    4 +-
 net/bridge/br_if.c                                 |    3 +-
 net/bridge/br_private.h                            |    1 +
 net/bridge/br_stp_if.c                             |    1 +
 net/core/dev.c                                     |    3 +
 net/ipv4/esp4.c                                    |    6 +-
 net/ipv4/ip_fragment.c                             |   14 +-
 net/ipv4/netfilter/ipt_rpfilter.c                  |    8 +-
 net/ipv4/syncookies.c                              |    4 +-
 net/ipv4/tcp_input.c                               |   64 +--
 net/ipv4/tcp_output.c                              |    8 +-
 net/ipv6/addrconf.c                                |   24 +-
 net/ipv6/addrconf_core.c                           |   19 +
 net/ipv6/netfilter/ip6t_rpfilter.c                 |    8 +-
 net/ipv6/reassembly.c                              |   12 +-
 net/irda/iriap.c                                   |    3 +-
 net/irda/irlmp.c                                   |   10 +-
 net/mac80211/iface.c                               |   27 +-
 net/mac80211/mlme.c                                |   24 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c          |    6 +-
 net/netfilter/ipset/ip_set_hash_ipportnet.c        |   18 +
 net/netfilter/ipset/ip_set_hash_net.c              |   22 +-
 net/netfilter/ipset/ip_set_hash_netiface.c         |   22 +-
 net/netfilter/ipset/ip_set_hash_netport.c          |   18 +
 net/netfilter/ipset/ip_set_list_set.c              |   10 +-
 net/netfilter/nf_conntrack_sip.c                   |    6 +-
 net/netfilter/nf_nat_core.c                        |   40 +-
 net/openvswitch/datapath.c                         |   30 +-
 net/openvswitch/flow.c                             |    2 +-
 net/sched/cls_fw.c                                 |    2 +-
 scripts/checkpatch.pl                              |    1 +
 sound/core/pcm_native.c                            |   12 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   54 +-
 sound/soc/au1x/ac97c.c                             |    9 +-
 sound/soc/au1x/i2sc.c                              |    9 +-
 sound/soc/au1x/psc-ac97.c                          |    9 +-
 sound/soc/au1x/psc-i2s.c                           |    9 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |    9 +-
 sound/soc/blackfin/bf5xx-i2s.c                     |    9 +-
 sound/soc/blackfin/bf5xx-tdm.c                     |    9 +-
 sound/soc/blackfin/bf6xx-i2s.c                     |    9 +-
 sound/soc/cirrus/ep93xx-ac97.c                     |    9 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |    9 +-
 sound/soc/codecs/Kconfig                           |    8 +
 sound/soc/codecs/Makefile                          |    4 +
 sound/soc/codecs/adau1373.c                        |    5 +-
 sound/soc/codecs/ak4104.c                          |   55 +-
 sound/soc/codecs/ak5386.c                          |  152 +++++
 sound/soc/codecs/arizona.c                         |  530 +++++++++++++++-=
--
 sound/soc/codecs/arizona.h                         |   34 +-
 sound/soc/codecs/cs4271.c                          |  166 +++---
 sound/soc/codecs/cs42l73.c                         |    6 +-
 sound/soc/codecs/max98088.c                        |   32 +-
 sound/soc/codecs/max98090.c                        |   45 +-
 sound/soc/codecs/si476x.c                          |   47 +-
 sound/soc/codecs/tas5086.c                         |  591 ++++++++++++++++=
++++
 sound/soc/codecs/wm0010.c                          |    6 +-
 sound/soc/codecs/wm2000.c                          |    4 +-
 sound/soc/codecs/wm2000.h                          |    2 +
 sound/soc/codecs/wm2200.c                          |    2 +-
 sound/soc/codecs/wm5102.c                          |  129 ++---
 sound/soc/codecs/wm5102.h                          |    6 +-
 sound/soc/codecs/wm5110.c                          |   54 +-
 sound/soc/codecs/wm5110.h                          |    6 +-
 sound/soc/codecs/wm8903.c                          |    4 +
 sound/soc/codecs/wm8960.c                          |   10 +
 sound/soc/codecs/wm8994.c                          |   68 ++-
 sound/soc/codecs/wm8994.h                          |    3 +-
 sound/soc/codecs/wm_adsp.c                         |  124 +++-
 sound/soc/codecs/wm_adsp.h                         |    5 +-
 sound/soc/codecs/wm_hubs.c                         |    9 +-
 sound/soc/davinci/davinci-i2s.c                    |   15 +-
 sound/soc/davinci/davinci-mcasp.c                  |  110 ++--
 sound/soc/davinci/davinci-mcasp.h                  |    2 +-
 sound/soc/davinci/davinci-pcm.c                    |    9 +-
 sound/soc/davinci/davinci-vcif.c                   |   11 +-
 sound/soc/dwc/designware_i2s.c                     |    9 +-
 sound/soc/fsl/fsl_ssi.c                            |   11 +-
 sound/soc/fsl/fsl_ssi.h                            |    8 +
 sound/soc/fsl/imx-audmux.c                         |    3 +-
 sound/soc/fsl/imx-pcm-fiq.c                        |    2 +-
 sound/soc/fsl/imx-sgtl5000.c                       |    2 +-
 sound/soc/fsl/imx-ssi.c                            |   13 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |    8 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |    9 +-
 sound/soc/jz4740/jz4740-i2s.c                      |    9 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   11 +-
 sound/soc/mid-x86/sst_platform.c                   |   20 +-
 sound/soc/mid-x86/sst_platform.h                   |    2 +
 sound/soc/mxs/Kconfig                              |    2 +-
 sound/soc/mxs/mxs-pcm.c                            |  139 +----
 sound/soc/mxs/mxs-saif.c                           |   14 +-
 sound/soc/nuc900/nuc900-ac97.c                     |    9 +-
 sound/soc/omap/omap-dmic.c                         |    9 +-
 sound/soc/omap/omap-hdmi.c                         |    9 +-
 sound/soc/omap/omap-mcbsp.c                        |    9 +-
 sound/soc/omap/omap-mcpdm.c                        |    9 +-
 sound/soc/pxa/mmp-sspa.c                           |    9 +-
 sound/soc/pxa/pxa-ssp.c                            |    9 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   11 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    9 +-
 sound/soc/s6000/s6000-i2s.c                        |    9 +-
 sound/soc/samsung/Kconfig                          |    5 +-
 sound/soc/samsung/ac97.c                           |   14 +-
 sound/soc/samsung/goni_wm8994.c                    |   11 +-
 sound/soc/samsung/h1940_uda1380.c                  |    2 +-
 sound/soc/samsung/i2s.c                            |   16 +-
 sound/soc/samsung/idma.c                           |   11 +-
 sound/soc/samsung/neo1973_wm8753.c                 |    3 +-
 sound/soc/samsung/pcm.c                            |   11 +-
 .../include/plat =3D> sound/soc/samsung}/regs-ac97.h |    0
 .../include/plat =3D> sound/soc/samsung}/regs-iis.h  |    0
 sound/soc/samsung/rx1950_uda1380.c                 |    2 +-
 sound/soc/samsung/s3c-i2s-v2.c                     |    9 +-
 sound/soc/samsung/s3c-i2s-v2.h                     |    7 +-
 sound/soc/samsung/s3c2412-i2s.c                    |   12 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   13 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |    2 +-
 sound/soc/samsung/spdif.c                          |   11 +-
 sound/soc/sh/fsi.c                                 |   14 +-
 sound/soc/sh/hac.c                                 |   10 +-
 sound/soc/sh/migor.c                               |    2 +-
 sound/soc/sh/siu_dai.c                             |   11 +-
 sound/soc/sh/ssi.c                                 |   10 +-
 sound/soc/soc-compress.c                           |   27 +
 sound/soc/soc-core.c                               |   99 +++-
 sound/soc/soc-dapm.c                               |  319 ++++++-----
 sound/soc/soc-generic-dmaengine-pcm.c              |   44 +-
 sound/soc/soc-utils.c                              |   25 +
 sound/soc/spear/spdif_in.c                         |    9 +-
 sound/soc/spear/spdif_out.c                        |    9 +-
 sound/soc/spear/spear_pcm.c                        |    4 +-
 sound/soc/tegra/tegra20_ac97.c                     |   15 +-
 sound/soc/tegra/tegra20_i2s.c                      |   15 +-
 sound/soc/tegra/tegra20_spdif.c                    |   15 +-
 sound/soc/tegra/tegra30_ahub.c                     |   64 ++-
 sound/soc/tegra/tegra30_ahub.h                     |   16 +
 sound/soc/tegra/tegra30_i2s.c                      |   15 +-
 sound/soc/tegra/tegra_alc5632.c                    |   15 +-
 sound/soc/tegra/tegra_asoc_utils.c                 |   34 +-
 sound/soc/tegra/tegra_asoc_utils.h                 |    1 +
 sound/soc/tegra/tegra_wm8753.c                     |   15 +-
 sound/soc/tegra/tegra_wm8903.c                     |  179 +++---
 sound/soc/tegra/tegra_wm9712.c                     |    7 +-
 sound/soc/tegra/trimslice.c                        |   56 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |    9 +-
 sound/soc/ux500/ux500_msp_dai.c                    |   13 +-
 sound/soc/ux500/ux500_msp_dai.h                    |    5 -
 sound/soc/ux500/ux500_msp_i2s.h                    |    1 +
 tools/power/x86/turbostat/turbostat.c              |    5 +-
 326 files changed, 5225 insertions(+), 2620 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5386.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas5086.txt
 delete mode 100644 arch/arm/mm/cache-v3.S
 rename arch/arm/{kernel =3D> mm}/tcm.h (100%)
 delete mode 100644 arch/sparc/include/asm/cputime.h
 delete mode 100644 arch/sparc/include/asm/emergency-restart.h
 delete mode 100644 arch/sparc/include/asm/mutex.h
 delete mode 100644 arch/sparc/include/asm/serial.h
 delete mode 100644 arch/sparc/include/uapi/asm/types.h
 create mode 100644 include/linux/ucs2_string.h
 create mode 100644 include/sound/tas5086.h
 delete mode 100644 include/sound/tegra_wm8903.h
 create mode 100644 lib/ucs2_string.c
 create mode 100644 sound/soc/codecs/ak5386.c
 create mode 100644 sound/soc/codecs/tas5086.c
 rename {arch/arm/plat-samsung/include/plat =3D> sound/soc/samsung}/regs-ac=
97.h (100%)
 rename {arch/arm/plat-samsung/include/plat =3D> sound/soc/samsung}/regs-ii=
s.h (100%)

--v1TsIsr/WJoL6YzS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReQwAAAoJELSic+t+oim9/LwQAIkkb1Ntj5n/MYRQWiRcMXVG
Z1PCvGzErI/Xgj3Jf9yBGlYfu2k3dwQ3MQqlJLOanOfzDbxp3tkKupm5A+nwGLP2
mktmwQ0Xx4COSF5UhZfIsdw2Q3HZIiAHtyPB8ODfEw6uUB+qFwIIEeevPcJHCnMM
7UThPfwrbCefDbO1psYBVmVbEKNEQnYQBEuYQVLp/NJg6dEBITj1nkHfMWJwIMGu
GQ38wjouygaM8o1EPFj0hTtzKmZhMgK9jo/l+g/F8QSAABWZFgda58zDHHzKBMNd
5xuoJNNl6jgFisJi/68hsYmZxIyqmY+Nds6HofVwCGlTa0k+soa4rS0BJ5V3BVg7
X2Z7MeEs83THze35zwKojTTOr3hSX2PBkVBOHxgVWpI8U0BMdEiht5PVLZDr8Y9H
kkjgClj1ZBai9ELNxtbfGHkC7g41JXPPkuDkLRcHmIN7Byj95FbhNv7j0+Q560eU
tqEOmraXD8jKKukvK9sAr8IgsiTPzFNmm0hNvMd2qjib7l6f2nDQNflqnpSnkOEO
mZ6je8B9iaJSsrUDP5wggX0UGmck2f8qpgQY7HNB6BAxgMk528hGYfezDnT3RZE1
miYth2+XdFlEWNwTIgjRbxkdIz3muvCDDcrrTHGYxppApV7+z89dZCD+nbbsS8gs
VlVZLGZLJKv+qIM8kn2w
=Q/V9
-----END PGP SIGNATURE-----

--v1TsIsr/WJoL6YzS--

--===============5785096369939446688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5785096369939446688==--
