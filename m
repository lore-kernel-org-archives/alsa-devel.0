From: Alistair Grant <akgrant0710@gmail.com>
Subject: Hauppauge USB-Live2 recording fails on USB3 port
Date: Wed, 21 Jan 2015 23:08:58 +0100
Message-ID: <CA+GUGJ3REAzyVMs1EZV-ZXBngxCaYjZEgm1RuW5GrRzCLXgGkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E38260447
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 23:08:58 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id bs8so36642800wib.0
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 14:08:58 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've been attempting to capture video through a Hauppauge USB-Live2
device using:

mythffmpeg -y -loglevel debug -f alsa -i plughw:1,0 -f v4l2 -s pal
-pix_fmt yuyv422 -i /dev/video1 -b:v 2048k a.nut

This works fine from Ubuntu 14.04 on an older laptop that only has
USB2, but fails on my Dell XPS13, which only has USB3 ports (Ubuntu
14.10, Kernel 3.16, 3.18, 3.19).

I have included a larger extract from /var/log/syslog below, however
three of the lines are:

Jan 18 16:49:23 alistair-XPS13 pulseaudio[3296]: [alsa-sink-ALC3661
Analog] alsa-sink.c: ALSA woke us up to write new data to the device,
but there was actually nothing to write!
Jan 18 16:49:23 alistair-XPS13 pulseaudio[3296]: [alsa-sink-ALC3661
Analog] alsa-sink.c: Most likely this is a bug in the ALSA driver
'snd_hda_intel'. Please report this issue to the ALSA developers.
Jan 18 16:49:23 alistair-XPS13 pulseaudio[3296]: [alsa-sink-ALC3661
Analog] alsa-sink.c: We were woken up with POLLOUT set -- however a
subsequent snd_pcm_avail() returned 0 or another value < min_avail.

I have already posted this on the linux-usb mailing list and received
a confirmation from the author of the USB-Live2 USB driver that there
are problems with USB3.

So I expect that this is a USB3 xHCI problem and not an ALSA problem,
but if there is a workaround I would be very interested.  If you'd
like more information or me to do more testing, please let me know.

Thanks very much,
Alistair


Original report to Ubuntu Bugs:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1412121
linux-usb report: http://thread.gmane.org/gmane.linux.usb.general/121094
Additional discussion on linux-usb:
http://www.spinics.net/lists/linux-usb/msg120276.html

/var/log/syslog extract:
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.790754] usb 1-1: new
high-speed USB device number 5 using xhci_hcd
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.921414] usb 1-1: New USB
device found, idVendor=2040, idProduct=c200
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.921422] usb 1-1: New USB
device strings: Mfr=1, Product=2, SerialNumber=3
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.921426] usb 1-1:
Product: Hauppauge Device
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.921430] usb 1-1:
Manufacturer: Hauppauge
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.921433] usb 1-1:
SerialNumber: 0011446325
Jan 18 16:48:16 alistair-XPS13 mtp-probe: checking bus 1, device 5:
"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1"
Jan 18 16:48:16 alistair-XPS13 mtp-probe: bus: 1, device: 5 was not an
MTP device
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.985669] cx231xx 1-1:1.1:
New device Hauppauge Hauppauge Device @ 480 Mbps (2040:c200) with 6
interfaces
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.985716] cx231xx 1-1:1.1:
can't change interface 3 alt no. to 3: Max. Pkt size = 0
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.987108] cx231xx 1-1:1.1:
can't change interface 4 alt no. to 1: Max. Pkt size = 0
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.988279] cx231xx 1-1:1.1:
Identified as Hauppauge USB Live 2 (card=9)
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.988572] i2c i2c-10:
Added multiplexed i2c bus 12
Jan 18 16:48:16 alistair-XPS13 kernel: [   83.988633] i2c i2c-10:
Added multiplexed i2c bus 13
Jan 18 16:48:16 alistair-XPS13 kernel: [   84.088325] cx25840 9-0044:
cx23102 A/V decoder found @ 0x88 (cx231xx #0-0)
Jan 18 16:48:18 alistair-XPS13 kernel: [   86.036671] cx25840 9-0044:
loaded v4l-cx231xx-avcore-01.fw firmware (16382 bytes)
Jan 18 16:48:18 alistair-XPS13 kernel: [   86.067096] cx231xx 1-1:1.1:
v4l2 driver version 0.0.3
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.153723] cx231xx 1-1:1.1:
Registered video device video1 [v4l2]
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.153864] cx231xx 1-1:1.1:
Registered VBI device vbi0
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.153869] cx231xx 1-1:1.1:
video EndPoint Addr 0x84, Alternate settings: 5
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.153872] cx231xx 1-1:1.1:
VBI EndPoint Addr 0x85, Alternate settings: 2
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.153875] cx231xx 1-1:1.1:
sliced CC EndPoint Addr 0x86, Alternate settings: 2
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.154013] usbcore:
registered new interface driver cx231xx
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.176396] cx231xx 1-1:1.1:
audio EndPoint Addr 0x83, Alternate settings: 3
Jan 18 16:48:19 alistair-XPS13 kernel: [   86.176402] cx231xx 1-1:1.1:
Cx231xx Audio Extension initialized
Jan 18 16:48:19 alistair-XPS13 pulseaudio[3296]: [pulseaudio]
source.c: Default and alternate sample rates are the same.
Jan 18 16:48:19 alistair-XPS13 rtkit-daemon[2205]: Successfully made
thread 3819 of process 3296 (n/a) owned by '1000' RT at priority 5.
Jan 18 16:48:19 alistair-XPS13 rtkit-daemon[2205]: Supervising 5
threads of 1 processes of 1 users.
Jan 18 16:49:23 alistair-XPS13 pulseaudio[3296]: [alsa-sink-ALC3661
Analog] alsa-sink.c: ALSA woke us up to write new data to the device,
but there was actually nothing to write!
Jan 18 16:49:23 alistair-XPS13 pulseaudio[3296]: [alsa-sink-ALC3661
Analog] alsa-sink.c: Most likely this is a bug in the ALSA driver
'snd_hda_intel'. Please report this issue to the ALSA developers.
Jan 18 16:49:23 alistair-XPS13 pulseaudio[3296]: [alsa-sink-ALC3661
Analog] alsa-sink.c: We were woken up with POLLOUT set -- however a
subsequent snd_pcm_avail() returned 0 or another value < min_avail.
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336417] xhci_hcd
0000:00:14.0: xHCI host not responding to stop endpoint command.
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336428] xhci_hcd
0000:00:14.0: Assuming host is dying, halting host.
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336542] usb 1-1: Not
enough bandwidth for altsetting 0
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336553] cx231xx 1-1:1.1:
can't change interface 2 alt no. to 0 (err=-19)
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336554] xhci_hcd
0000:00:14.0: HC died; cleaning up
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336563] cx231xx 1-1:1.1:
failed to set alternate setting !
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336669] cx231xx 1-1:1.1:
cx231xx_send_usb_command: failed with status --19
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.336679] cx231xx 1-1:1.1:
cx231xx_send_usb_command: failed with status --19
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.337094] usb 1-1: USB
disconnect, device number 5
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.337451] cx231xx 1-1:1.1:
device video1 is open! Deregistration and memory deallocation are
deferred on close.
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.372776] usb 1-3: USB
disconnect, device number 2
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373439] usb 1-1:1.1:
V4L2 device vbi0 deregistered
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373449] ------------[
cut here ]------------
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373462] WARNING: CPU: 3
PID: 3992 at /home/apw/COD/linux/fs/sysfs/group.c:219
sysfs_remove_group+0xa3/0xb0()
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373466] sysfs group
ffffffff81cb60a0 not found for kobject 'vbi0'
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373469] Modules linked
in: cx231xx_alsa cx25840 cx231xx videobuf_vmalloc tveeprom cx2341x
rc_core videobuf_core i2c_mux pci_stub vboxpci(OE) vboxnetadp(OE)
vboxnetflt(OE) vboxdrv(OE) xt_CHECKSUM iptable_mangle ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp bridge stp llc
iptable_filter ip_tables x_tables ctr ccm dm_crypt rpcsec_gss_krb5
nfsv4 joydev arc4 snd_soc_rt5640 hid_rmi btusb dell_wmi snd_soc_rl6231
sparse_keymap intel_rapl iosf_mbi snd_soc_core uvcvideo
videobuf2_vmalloc x86_pkg_temp_thermal videobuf2_memops snd_compress
videobuf2_core v4l2_common snd_pcm_dmaengine hid_multitouch
intel_powerclamp videodev snd_seq_midi snd_seq_midi_event media
snd_rawmidi kvm_intel kvm snd_seq iwlmvm crct10dif_pclmul crc32_pclmul
mac80211 dell_laptop dcdbas ghash_clmulni_intel aesni_intel aes_x86_64
snd_hda_codec_hdmi lrw snd_hda_codec_realtek snd_hda_codec_generic
gf128mul rfcomm glue_helper iwlwifi bnep ablk_helper cryptd
snd_hda_intel snd_seq_device snd_hda_controller bluetooth
snd_hda_codec serio_raw snd_hwdep cfg80211 snd_pcm mei_me mei
snd_timer lpc_ich shpchp snd dw_dmac snd_soc_sst_acpi nfsd soundcore
i2c_hid auth_rpcgss nfs_acl i2c_designware_platform 8250_dw
dw_dmac_core i2c_designware_core spi_pxa2xx_platform nfs intel_rst
intel_smartconnect lockd grace sunrpc fscache mac_hid parport_pc ppdev
coretemp lp parport usbhid hid i915 i2c_algo_bit drm_kms_helper
psmouse ahci libahci drm wmi sdhci_acpi video sdhci
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373655] CPU: 3 PID: 3992
Comm: mythffmpeg Tainted: G           OE  3.19.0-031900rc5-generic
#201501180935
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373659] Hardware name:
Dell Inc. XPS13 9333/099TN4, BIOS A01 11/11/2013
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373662]
00000000000000db ffff8800ae8a3c68 ffffffff817c5098 0000000000000007
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373669]
ffff8800ae8a3cb8 ffff8800ae8a3ca8 ffffffff81076dd7 ffff8800ae8a3c98
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373675]
ffffffff81cb60a0 ffff8800be448898 0000000000000000 ffff8801f0f8b398
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373682] Call Trace:
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373694]
[<ffffffff817c5098>] dump_stack+0x45/0x57
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373703]
[<ffffffff81076dd7>] warn_slowpath_common+0x97/0xe0
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373710]
[<ffffffff81076ed6>] warn_slowpath_fmt+0x46/0x50
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373718]
[<ffffffff8126ab93>] ? kernfs_find_and_get_ns+0x53/0x70
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373725]
[<ffffffff8126ef43>] sysfs_remove_group+0xa3/0xb0
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373731]
[<ffffffff814fe409>] dpm_sysfs_remove+0x59/0x70
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373740]
[<ffffffff814f2166>] device_del+0x56/0x230
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373747]
[<ffffffff814f2362>] device_unregister+0x22/0x60
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373765]
[<ffffffffc0a2825d>] video_unregister_device+0x4d/0x60 [videodev]
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373777]
[<ffffffffc0d53f55>] cx231xx_release_analog_resources+0x125/0x170
[cx231xx]
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373787]
[<ffffffffc0d56666>] cx231xx_release_resources+0x16/0x60 [cx231xx]
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373797]
[<ffffffffc0d52b86>] cx231xx_close.isra.11+0x1d6/0x2a0 [cx231xx]
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373805]
[<ffffffffc0d52c8f>] cx231xx_v4l2_close+0x3f/0x60 [cx231xx]
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373818]
[<ffffffffc0a27491>] v4l2_release+0x41/0x90 [videodev]
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373825]
[<ffffffff811f7e30>] __fput+0xc0/0x250
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373832]
[<ffffffff811f800e>] ____fput+0xe/0x10
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373838]
[<ffffffff81093f3f>] task_work_run+0xaf/0xf0
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373847]
[<ffffffff81015077>] do_notify_resume+0xc7/0xd0
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373853]
[<ffffffff817d264f>] int_signal+0x12/0x17
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.373858] ---[ end trace
cfaf8b5d940102a2 ]---
Jan 18 16:50:14 alistair-XPS13 kernel: [  201.374207] usb 1-1:1.1:
V4L2 device video1 deregistered

More errors follow.
