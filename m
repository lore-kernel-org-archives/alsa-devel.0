From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002016]: Choppy/skippy sound on onboard SiS SI7012-controller
Date: Sun, 23 Apr 2006 06:31:18 +0200
Message-ID: <26627fc5a3173def5da5f23a87e127d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DAB3117E
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 06:31:18 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2016> 
======================================================================
Reported By:                Ensnared
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2016
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 "Breezy Badger"
Kernel Version:             2.6.x
======================================================================
Date Submitted:             04-12-2006 04:40 CEST
Last Modified:              04-23-2006 06:31 CEST
======================================================================
Summary:                    Choppy/skippy sound on onboard SiS SI7012-controller
Description: 
The sound on my specific sound controller is very bad. The times it even
plays, the quality is very choppy and it skips almost like a scratched CD,
which makes it pretty much unusable.

I suspect this might be specific for my model laptop as I'm having a hard
time finding anyone else with the same problem, but I've tried several
distros and kernel versions, and the card works in Windows.

The laptop is an Elite Group G732, which has a SiS mainboard chipset with
the SI7012 onboard controller (Realtek ALC202 chip).

I've tried messing with the buffer_size and period_size in asound.conf,
which seem to have some impact on the "pattern" of the chopping and
skipping, but there are no values that I've found that will get rid of
them entirely.

I'm assuming this is an incompatibility with the driver and this specific
hardware, but I could obviously be wrong.

I've tried using the version of ALSA in the 2.6.10, 2.6.12 and 2.6.16.2
kernels, as well as compiled the latest stable and developement releases
of ALSA myself. The result is the same for them all.
======================================================================

----------------------------------------------------------------------
 Ensnared - 04-13-06 22:06 
----------------------------------------------------------------------
Recompiled the drivers --with-debug=all now and set the xrun_debug to 2 for
all three of my pcm-entries. The result from my syslog when playing a file
using aplay (with no other arguments than the filename) is this:

Apr 13 21:58:13 localhost kernel: [4294957.754000] ALSA
/home/roy/download/alsa/alsa-driver-1.0.11rc5/acore/../alsa-kernel/core/pcm_lib.c:209:
Unexpected hw_pointer value [1] (stream = 0, delta: -1023, max jitter =
8192): wrong interrupt acknowledge?
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+545175187/1069872128] snd_pcm_period_elapsed+0x3c3/0x3d0 [snd_pcm]
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+544844389/1069872128] snd_intel8x0_interrupt+0x185/0x260
[snd_intel8x0]
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[handle_IRQ_event+57/109] handle_IRQ_event+0x39/0x6d
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [__do_IRQ+163/252]
__do_IRQ+0xa3/0xfc
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [__do_softirq+66/145]
__do_softirq+0x42/0x91
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [do_IRQ+25/36]
do_IRQ+0x19/0x24
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[common_interrupt+26/32] common_interrupt+0x1a/0x20
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+542386745/1069872128] acpi_processor_idle+0x0/0x27f [processor]
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[pg0+542387000/1069872128] acpi_processor_idle+0xff/0x27f [processor]
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [cpu_idle+60/81]
cpu_idle+0x3c/0x51
Apr 13 21:58:13 localhost kernel: [4294957.754000]  [start_kernel+369/429]
start_kernel+0x171/0x1ad
Apr 13 21:58:13 localhost kernel: [4294957.754000] 
[unknown_bootoption+0/474] unknown_bootoption+0x0/0x1da
Apr 13 21:58:14 localhost kernel: [4294958.052000] ALSA
/home/roy/download/alsa/alsa-driver-1.0.11rc5/acore/../alsa-kernel/core/pcm_lib.c:209:
Unexpected hw_pointer value [1] 

It seems to be the same thing repeated over and over for as long as the
soundfile plays, but if the full log needs to be posted, let me know.

----------------------------------------------------------------------
 razorbroom - 04-23-06 06:31 
----------------------------------------------------------------------
Finally got hold of another card to test with (an Ensoniq of the 1371
variety).  The problem was still present.  This leads me to believe it's
probably a kernel issue.  What's weird is that you've tried with various
distros and kernels to the same effect.  My hardware has not changed since
the 2.4.x days and I didn't have problems back then.  I have a notebook
(SiS 7018) that displays similar problems too ... and that's all
integrated.  I'll post my kernel config and dmesg with errors.

---dmesg---
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<c0107f82>] convert_fxsr_from_user+0x22/0xf0
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<c0107f82>] convert_fxsr_from_user+0x22/0xf0
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<c0107f82>] convert_fxsr_from_user+0x22/0xf0
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<c0107f82>] convert_fxsr_from_user+0x22/0xf0
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<c0107f82>] convert_fxsr_from_user+0x22/0xf0
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c011ab33>] __do_softirq+0x43/0x90
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<c0107f82>] convert_fxsr_from_user+0x22/0xf0
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
XRUN: pcmC0D0p
 [<f8ba2d77>] snd_pcm_period_elapsed+0x1a7/0x350 [snd_pcm]
 [<c0107f82>] convert_fxsr_from_user+0x22/0xf0
 [<f8bb7c1d>] snd_audiopci_interrupt+0x13d/0x1f0 [snd_ens1371]
 [<c013154d>] handle_IRQ_event+0x3d/0x70
 [<c01315e3>] __do_IRQ+0x63/0xc0
 [<c0104a59>] do_IRQ+0x19/0x30
 [<c0102d12>] common_interrupt+0x1a/0x20
---dmesg---

---kconfig---
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16.1
# Sat Apr 22 18:53:34 2006
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
CONFIG_DOUBLEFAULT=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_TCP_CONG_ADVANCED=y

#
# TCP congestion control
#
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=m
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
CONFIG_NETFILTER_XT_MATCH_MAC=m
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
# CONFIG_IP_NF_MATCH_POLICY is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=m

#
# IrDA protocols
#
# CONFIG_IRLAN is not set
# CONFIG_IRNET is not set
# CONFIG_IRCOMM is not set
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
# CONFIG_IRTTY_SIR is not set

#
# Dongle support
#

#
# Old SIR device drivers
#
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_VIA_FIR is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=m

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_CS5535=m
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT821X=m
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=m
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_VIAPRO is not set
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_HDAPS=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_SAA6588=m
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_CX88=m
# CONFIG_VIDEO_EM28XX is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_TVEEPROM=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CFB_FILLRECT is not set
# CONFIG_FB_CFB_COPYAREA is not set
# CONFIG_FB_CFB_IMAGEBLIT is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_DETECT is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
CONFIG_USB_WACOM=m
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
CONFIG_USB_ATI_REMOTE=m
CONFIG_USB_ATI_REMOTE2=m
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_ET61X251 is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
CONFIG_USB_OV511=m
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
CONFIG_USB_PWC=m

#
# USB Network Adapters
#
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_LD is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y
---kconfig---

I'm not sure where to progress from here and it can't really be ruled out
as being an ALSA bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-06 04:40 Ensnared       New Issue                                    
04-12-06 04:40 Ensnared       Distribution              => Ubuntu 5.10 "Breezy
Badger"
04-12-06 04:40 Ensnared       Kernel Version            => 2.6.x           
04-12-06 06:57 razorbroom     Note Added: 0009239                          
04-13-06 21:47 Ensnared       Note Added: 0009271                          
04-13-06 22:06 Ensnared       Note Added: 0009276                          
04-23-06 06:31 razorbroom     Note Added: 0009440                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
