From: "Marco Santamaria" <marco.santamaria@gmail.com>
Subject: snd_usb_caiaq bug?
Date: Sun, 4 Jan 2009 17:29:47 +0100
Message-ID: <31e66c9e0901040829y4bedc1ebgcf91afe10d80341a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f19.google.com (mail-fx0-f19.google.com
	[209.85.220.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 614911037F1
	for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2009 17:29:48 +0100 (CET)
Received: by fxm12 with SMTP id 12so1128499fxm.8
	for <alsa-devel@alsa-project.org>; Sun, 04 Jan 2009 08:29:47 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

it's about one year that I'm using my Native Instruments Audio Kontrol 1
(USB2 audio/MIDI interface) only with audio applications and it has been
working well so far.
Now I'm trying to use it with Rosegarden (MIDI) and, as soon as I start
Rosegarden, JACK crashes, the process jackd becomes "uninterruptible" and
with the command dmesg I find the following new lines

[ 1935.173876] BUG: unable to handle kernel NULL pointer dereference at
virtual address 00000044
[ 1935.173885] printing eip: f8a5f6fd *pde = 00000000
[ 1935.173891] Oops: 0000 [#1] PREEMPT SMP
[ 1935.173896] Modules linked in: isofs udf ipv6 af_packet i915 drm rfcomm
l2cap bluetooth ppdev acpi_cpufreq cpufreq_ondemand cpufreq_conservative
cpufreq_stats freq_table cpufreq_userspace cpufreq_powersave dock container
sbs sbshc iptable_filter ip_tables x_tables sbp2 parport_pc lp parport
snd_hda_intel snd_usb_caiaq snd_hwdep snd_pcm_oss snd_mixer_oss arc4
snd_seq_oss snd_pcm ecb blkcipher snd_seq_midi snd_page_alloc joydev
snd_rawmidi snd_seq_midi_event snd_seq iwl3945 sdhci serio_raw mmc_core
iwlwifi_mac80211 video output cfg80211 battery led_class ac snd_timer
snd_seq_device wmi_acer button snd evdev dcdbas iTCO_wdt iTCO_vendor_support
intel_agp shpchp pci_hotplug pcspkr soundcore agpgart psmouse ext3 jbd
mbcache sg sr_mod cdrom sd_mod b44 ata_generic ssb mii ohci1394 ieee1394
ata_piix pata_acpi libata scsi_mod ehci_hcd uhci_hcd usbcore thermal
processor fan fuse
[ 1935.173964]
[ 1935.173967] Pid: 1421, comm: IRQ-18 Not tainted (2.6.24-19-rt #1)
[ 1935.173970] EIP: 0060:[<f8a5f6fd>] EFLAGS: 00010292 CPU: 1
[ 1935.173979] EIP is at snd_rawmidi_transmit_peek+0x1d/0x100 [snd_rawmidi]
[ 1935.173982] EAX: 00000000 EBX: f7106264 ECX: 0000003d EDX: f7106407
[ 1935.173985] ESI: ffffffea EDI: 00000000 EBP: f7106407 ESP: df85be38
[ 1935.173988]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
preempt:00000001
[ 1935.173991] Process IRQ-18 (pid: 1421, ti=df85a000 task=f7d45320
task.ti=df85a000)
[ 1935.173993] Stack: 0000003d 00000000 f7106264 00000000 00000000 df83fc00
f8b8cc09 00000000
[ 1935.174000]        f7106264 f710630c 00000000 df83fc00 df83fc00 f710630c
f888c888 00000008
[ 1935.174007]        df83fd08 00000000 f710630c f8870770 f728a0c0 f728a0c0
ffffff8d f721e180
[ 1935.174014] Call Trace:
[ 1935.174021]  [<f8b8cc09>] snd_usb_caiaq_midi_send+0x29/0x80
[snd_usb_caiaq]
[ 1935.174034]  [<f888c888>] usb_hcd_giveback_urb+0x48/0xc0 [usbcore]
[ 1935.174064]  [<f8870770>] ehci_urb_done+0x70/0xb0 [ehci_hcd]
[ 1935.174075]  [<f887153f>] qh_completions+0x24f/0x430 [ehci_hcd]
[ 1935.174087]  [<f8870770>] ehci_urb_done+0x70/0xb0 [ehci_hcd]
[ 1935.174096]  [<f887293e>] ehci_work+0x51e/0x810 [ehci_hcd]
[ 1935.174103]  [<c010b1e3>] sched_clock+0x13/0x40
[ 1935.174116]  [<c0129199>] dequeue_task_rt+0xb9/0x1c0
[ 1935.174129]  [<f8875498>] ehci_irq+0x158/0x1c0 [ehci_hcd]
[ 1935.174142]  [<f888cb7b>] usb_hcd_irq+0x2b/0x60 [usbcore]
[ 1935.174166]  [<c016a9cc>] handle_IRQ_event+0x5c/0x100
[ 1935.174178]  [<c016b00a>] thread_simple_irq+0x4a/0x90
[ 1935.174185]  [<c016b959>] do_irqd+0x229/0x290
[ 1935.174194]  [<c016b730>] do_irqd+0x0/0x290
[ 1935.174199]  [<c0141fc2>] kthread+0x42/0x70
[ 1935.174203]  [<c0141f80>] kthread+0x0/0x70
[ 1935.174209]  [<c0105857>] kernel_thread_helper+0x7/0x10
[ 1935.174217]  =======================
[ 1935.174219] Code: 24 10 83 c4 14 c3 bf ea ff ff ff eb e3 90 83 ec 18 89
74 24 0c be ea ff ff ff 89 6c 24 14 89 d5 89 5c 24 08 89 7c 24 10 89 0c 24
<8b> 58 44 8b 7b 04 85 ff 0f 84 8e 00 00 00 8d 43 20 31 f6 89 44
[ 1935.174256] EIP: [<f8a5f6fd>] snd_rawmidi_transmit_peek+0x1d/0x100
[snd_rawmidi] SS:ESP 0068:df85be38
[ 1935.174265] ---[ end trace 9090d02b798b5496 ]---

I already asked to the Rosegarden and JACK people, but they couldn't help
me: it seems to be a driver related problem,  as I can happily use
Rosegarden if I run JACK with the internal Intel sound card.

The program versions I'm using are: jackd 0.116.1, rosegarden 1.7.2.

Here's some other outputs:

$ uname -a
Linux din6400 2.6.24-19-rt #1 SMP PREEMPT RT Thu Aug 21 02:08:03 UTC 2008
i686 GNU/Linux

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.17.
Compiled on Jan  3 2009 for kernel 2.6.24-19-rt (SMP).

$ grep VERSION_STR /usr/include/alsa/version.h
#define SND_LIB_VERSION_STR    "1.0.17a"

$ aplay -l
**** Lista di PLAYBACK dispositivi hardware ****
scheda 0: Intel [HDA Intel], dispositivo 0: STAC92xx Analog [STAC92xx
Analog]
  Sottoperiferiche: 1/1
  Sottoperiferica #0: subdevice #0
scheda 0: Intel [HDA Intel], dispositivo 1: STAC92xx Digital [STAC92xx
Digital]
  Sottoperiferiche: 1/1
  Sottoperiferica #0: subdevice #0
scheda 1: A1 [Audio Kontrol 1], dispositivo 0: Audio Kontrol 1 [Audio
Kontrol 1]
  Sottoperiferiche: 1/2
  Sottoperiferica #0: subdevice #0
  Sottoperiferica #1: subdevice #1

$ cat /proc/interrupts
           CPU0       CPU1
  0:    5438968          0   IO-APIC-edge      timer
  1:       5123          0   IO-APIC-edge      i8042
  8:          7          0   IO-APIC-edge      rtc
  9:          2          0   IO-APIC-fasteoi   acpi
 12:     570309          0   IO-APIC-edge      i8042
 14:      16584          0   IO-APIC-edge      libata
 15:       7712          0   IO-APIC-edge      libata
 16:     312032          0   IO-APIC-fasteoi   i915@pci:0000:00:02.0
 17:          2          0   IO-APIC-fasteoi   ohci1394
 18:     269358          0   IO-APIC-fasteoi   uhci_hcd:usb1, ehci_hcd:usb5
 19:       3999          0   IO-APIC-fasteoi   uhci_hcd:usb2, HDA Intel
 20:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
 21:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
 22:       7638          0   IO-APIC-fasteoi   eth0
 23:          0          0   IO-APIC-fasteoi   sdhci:slot0
221:      31667          0   PCI-MSI-edge      iwl3945
NMI:          0          0   Non-maskable interrupts
LOC:     266694    2894868   Local timer interrupts
RES:    1091345    1871342   Rescheduling interrupts
CAL:      12287      11042   function call interrupts
TLB:       1395       1581   TLB shootdowns
TRM:          0          0   Thermal event interrupts
SPU:          0          0   Spurious interrupts
ERR:          0
MIS:          0

I do not include the jackd and rosegarden outputs becouse they are quite
long, but, if you think they are useful to understand what is going on, I
can send them too.

Any ideas?

Thank you

Marco
