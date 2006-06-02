From: Lars Bergmann <lars.bergmann@ecomine.de>
Subject: ALSA support for ARM XScale
Date: Fri, 02 Jun 2006 18:51:45 +0200
Message-ID: <44806CA1.4080800@ecomine.de>
Reply-To: lars.bergmann@ecomine.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to setup kernel 2.6.16.16 with ALSA to work on an embedded 
platform (ARM XScale IXP425, originally network appliance).

While I am now able to setup a basic board support package with a recent 
kernel (2.6.16.16) and basic hardware support, I encountered fundamental 
problems with ALSA on the target platform. Basically, I am getting lots 
of page faults and other symptoms when accessing the ALSA API.

According to my research this may be a well known problem with 
non-coherent architectures and ALSA DMA access and I/O mapping. This is 
just a blind guess (since it is the only hint that I have found on the 
web). Although everyone and everything suggest that ARM / ALSA / DMA 
coherency has been fixed years ago - at the end ALSA still does not work 
here and I have no clue where to search. I also stumbled across this 
issue on MIPS mailing list yesterday, there is an ALSA patch for this 
architecture and this one is very recent:
http://www.spinics.net/lists/mips/msg22773.html

History for reference:
http://thread.gmane.org/gmane.linux.alsa.devel/12676/focus=12711
http://lkml.org/lkml/2004/2/29/74

I would like to donate all required hardware if I can find someone who 
wants to help and is capable of debugging this, e.g.:
- samples of the embedded board ( 
http://www.gateworks.com/avila_gw2348_4.htm )
- passive MiniPCI-to-PCI adapters for testing
- active (PCI-bridge) MiniPCI-to-PCI adapters
   (in order to get various standard PCI boards working)
- some PCI soundcards (VT1712, VT1724, pro-audio RME Digi96/8)
- USB sound card

Any help is appreciated!


Regards
Lars


#####################################################################
# error descriptions
#####################################################################

I see two types of failure:
1) PCI audio device drivers exit with snd_pcm_mmap_data_nopage (see below)
2) USB audio driver plays for some seconds (reporting underruns) and 
will then fail:

# /usr/local/bin/aplay /home/lars/tori-test-48k.wav
Playing WAVE '/home/lars/tori-test-48k.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
underrun!!! (at least 4.662 ms long)
underrun!!! (at least 0.134 ms long)
underrun!!! (at least 25.856 ms long)
underrun!!! (at least 0.138 ms long)
underrun!!! (at least 5.296 ms long)
...
aplay: pcm_write:1222: write error: Input/output error
timeout: still 12 active urbs..
# usb 1-2: USB disconnect, address 2

Playback via USB audio will also produce stack traces from either khubd 
or pdflush (see below).

PCI and USB problems might be completely unrelated: Looking at the USB 
audio driver, I think they did not use ALSA API for memory allocation 
and I/O mapping - instead they create URBs allocated by the USB core.


#####################################################################
# PCI audio device (snd_ice1724)
#####################################################################

Unable to handle kernel paging request at virtual address cc33cc37
pgd = c3bd4000
[cc33cc37] *pgd=00000000
Internal error: Oops: f3 [#1]
Modules linked in: "snd_ice1724" "snd_ac97_codec" "snd_ac97_bus" 
"snd_ice17xx_ak4xxx" "snd_ak4xxx_adda" "snd_ak4114" "snd_mpu401_uart" 
"snd_usb_audio" "snd_usb_lib" "snd_rawmidi" "snd_hwdep" "snd_pcm_oss" 
"snd_pcm" "snd_timer" "snd_page_alloc" "snd_mixer_oss" "snd" 
"ixp400_eth" ixp400
CPU: 0
PC is at snd_pcm_mmap_data_nopage+0xc0/0xe4 ["snd_pcm"]
LR is at 0x4034a000
pc : [<bf103358>]    lr : [<4034a000>]    Tainted: PF
sp : c380de58  ip : cc33cc33  fp : c380de6c
r10: c0021060  r9 : 00000800  r8 : 4034a000
r7 : c3421b80  r6 : c3ad5b1c  r5 : c380de9c  r4 : c3460c00
r3 : 00000093  r2 : 00000013  r1 : 00000000  r0 : c1af9040
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment user
Control: 39FF  Table: 03BD4000  DAC: 00000015
Process aplay (pid: 89, stack limit = 0xc380c198)
Stack: (0xc380de58 to 0xc380e000)
de40:                                                       00000000 
00000000
de60: c380dec8 c380de70 c006d9a0 bf1032a4 00000000 00000000 c0668bc0 
c3c19020
de80: c0668bc0 c380dec8 c380de94 00000000 00000000 c3c8e000 c3bd5008 
00000002
dea0: ffffffeb c3db73e0 c3ad5b1c c0021060 c0021094 c380dfb0 4034a000 
c380df04
dec0: c380decc c003206c c006d6fc ffffffe7 0002ac00 00000800 00000817 
ffffffff
dee0: c037a164 00000817 c380dfb0 4034a000 4006f9f4 400d6eb4 c380dfac 
c380df08
df00: c00322dc c0031f98 c037bf08 c3445720 ffffffe7 0002ac00 00000000 
c002ad24
df20: 400d6eb4 c380df40 c380df34 bf102d18 bf1023a4 c380df5c c380df44 
c00904a8
df40: bf102cf8 00000004 c3445720 0002ac00 c380df84 c380df60 c0090784 
c0090478
df60: c380df7c c380df70 c3445720 fffffff7 c0844123 00000036 c380dfa4 
c380df88
df80: c00907e4 c0090500 00000000 ffffffff 00033880 0000176f 00000004 
00000008
dfa0: 00000000 c380dfb0 c002ab28 c00322ac 00000040 00000000 00001770 
00000000
dfc0: 4034a000 00033880 0000176f 00000004 00000008 4006f9f4 400d6eb4 
00000000
dfe0: 00000020 bedcdab4 0001f108 4006f880 00000010 ffffffff 33cc33cc 
33cc33cc
Backtrace:
[<bf103298>] (snd_pcm_mmap_data_nopage+0x0/0xe4 ["snd_pcm"]) from 
[<c006d9a0>] (__handle_mm_fault+0x2b0/0x810)
 r5 = 00000000  r4 = 00000000
[<c006d6f0>] (__handle_mm_fault+0x0/0x810) from [<c003206c>] 
(do_page_fault+0xe0/0x214)
[<c0031f8c>] (do_page_fault+0x0/0x214) from [<c00322dc>] 
(do_DataAbort+0x3c/0xa0)
[<c00322a0>] (do_DataAbort+0x0/0xa0) from [<c002ab28>] 
(ret_from_exception+0x0/0x10) r8 = 00000008  r7 = 00000004  r6 = 
0000176F  r5 = 00033880
 r4 = FFFFFFFF
Code: 1590c00c e10f2000 e3823080 e121f003 (e59c3004)


#####################################################################
# USB audio device (snd_usb_audio), trace 1
#####################################################################

Unable to handle kernel paging request at virtual address 000040c0
pgd = c0004000
[000040c0] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in: "snd_ice1724" "snd_ac97_codec" "snd_ac97_bus" 
"snd_ice17xx_ak4xxx" "snd_ak4xxx_adda" "snd_ak4114" "snd_mpu401_uart" 
"snd_usb_audio" "snd_usb_lib" "snd_rawmidi" "snd_hwdep" "snd_pcm_oss" 
"snd_pcm" "snd_timer" "snd_page_alloc" "snd_mixer_oss" "snd" 
"ixp400_eth" ixp400
CPU: 0
PC is at 0x40c0
LR is at __wake_up_common+0x50/0x78
pc : [<000040c0>]    lr : [<c003dda4>]    Tainted: PF
sp : c0549de8  ip : c0000039  fp : c0549e10
r10: 00000003  r9 : c0549e2c  r8 : 00000000
r7 : 000040c0  r6 : c00000c8  r5 : 000038c0  r4 : 00000001
r3 : c0549e2c  r2 : 00000000  r1 : 00000003  r0 : c0000039
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 39FF  Table: 007E8000  DAC: 00000017
Process pdflush (pid: 11, stack limit = 0xc0548198)
Stack: (0xc0549de8 to 0xc054a000)
9de0:                   80000013 00000003 c3e7cbbc c06ccc00 c3e7cc70 
c0549f28
9e00: 00000000 c0549e28 c0549e14 c003ddf8 c003dd60 c0549e2c c3e7ccf4 
c0549e40
9e20: c0549e2c c0054efc c003ddd8 c3e7ccf4 00000003 c0549e58 c0549e44 
c0054f28
9e40: c0054ed8 00000001 00000000 c0549e68 c0549e5c c0097ca8 c0054f10 
c0549ecc
9e60: c0549e6c c00a0ac8 c0097c9c c03e0868 0000001f 00040000 c0549eb4 
c0549e88
9e80: c002bbb8 c004633c 00040000 c0549f28 ffffffff 0000001f c0549eb8 
c0549ea8
9ea0: c010b13c c06ccc00 c3e7cbbc c066f1ac c0548000 c0549f28 c06ccc94 
00000000
9ec0: c0549efc c0549ed0 c00a0f60 c00a07b4 ffffc58e c06ccc00 c06ccc3c 
c037d400
9ee0: c0549f28 c0549f28 00000000 fffffffc c0549f1c c0549f00 c00a11f8 
c00a0d74
9f00: 00000449 ffffc782 c037bf08 c037cce8 c0549f80 c0549f20 c0066138 
c00a1190
9f20: ffffb9d6 c03e1d70 00000000 00000000 c0549f20 00000400 00000000 
00000000
9f40: 00000000 00000000 00000000 a0000000 00000008 00000000 000001da 
00000000
9f60: 00000001 c0548000 c0549f88 c037cd34 c037bf08 c0549fc0 c0549f84 
c0066c94
9f80: c0066088 00000001 c04b8060 c006607c 00000000 c0549f94 c0549f94 
ffffc39a
9fa0: 00000000 c0548000 c04bbf64 c0066b34 00000001 c0549ff4 c0549fc4 
c00548e0
9fc0: c0066b40 00000001 ffffffff ffffffff 00000000 00000000 00000000 
00000000
9fe0: 00000000 00000000 00000000 c0549ff8 c004364c c0054800 76c4319c 
134033ec
Backtrace:
[<c003dd54>] (__wake_up_common+0x0/0x78) from [<c003ddf8>] 
(__wake_up+0x2c/0x34)
[<c003ddcc>] (__wake_up+0x0/0x34) from [<c0054efc>] 
(__wake_up_bit+0x30/0x38)
 r4 = C3E7CCF4
[<c0054ecc>] (__wake_up_bit+0x0/0x38) from [<c0054f28>] 
(wake_up_bit+0x24/0x28)
[<c0054f04>] (wake_up_bit+0x0/0x28) from [<c0097ca8>] 
(wake_up_inode+0x18/0x1c)
 r5 = 00000000  r4 = 00000001
[<c0097c90>] (wake_up_inode+0x0/0x1c) from [<c00a0ac8>] 
(__writeback_single_inode+0x320/0x350)
[<c00a07a8>] (__writeback_single_inode+0x0/0x350) from [<c00a0f60>] 
(sync_sb_inodes+0x1f8/0x2bc)
[<c00a0d68>] (sync_sb_inodes+0x0/0x2bc) from [<c00a11f8>] 
(writeback_inodes+0x74/0xa4)
[<c00a1184>] (writeback_inodes+0x0/0xa4) from [<c0066138>] 
(wb_kupdate+0xbc/0x138)
 r7 = C037CCE8  r6 = C037BF08  r5 = FFFFC782  r4 = 00000449
[<c006607c>] (wb_kupdate+0x0/0x138) from [<c0066c94>] (pdflush+0x160/0x234)
 r8 = C037BF08  r7 = C037CD34  r6 = C0549F88  r5 = C0548000
 r4 = 00000001
[<c0066b34>] (pdflush+0x0/0x234) from [<c00548e0>] (kthread+0xec/0x11c)
 r8 = 00000001  r7 = C0066B34  r6 = C04BBF64  r5 = C0548000
 r4 = 00000000
[<c00547f4>] (kthread+0x0/0x11c) from [<c004364c>] (do_exit+0x0/0x7b8)
Code: bad PC value.


#####################################################################
# USB audio device (snd_usb_audio), trace 2
#####################################################################

Unable to handle kernel paging request at virtual address 000040c0
pgd = c0004000
[000040c0] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in: snd_usb_audio snd_usb_lib snd_rawmidi snd_hwdep 
snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd 
ixp400_eth ixp400
CPU: 0
PC is at 0x40c0
LR is at __wake_up_common+0x50/0x7c
pc : [<000040c0>]    lr : [<c003e21c>]    Tainted: P
sp : c0539d44  ip : c0000039  fp : c0539d6c
r10: 00000003  r9 : c0539d88  r8 : 00000000
r7 : 00000001  r6 : c00000c8  r5 : 000040c0  r4 : 000038c0
r3 : c0539d88  r2 : 00000000  r1 : 00000003  r0 : c0000039
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 39FF  Table: 03A1C000  DAC: 00000017
Process khubd (pid: 18, stack limit = 0xc0538194)
Stack: (0xc0539d44 to 0xc053a000)
9d40:          80000013 00000003 c0673cc8 c038f698 c04e3000 c04e3000 
00000002
9d60: c0539d84 c0539d70 c003e274 c003e1d8 c0539d88 c06aa390 c0539d9c 
c0539d88
9d80: c0056a4c c003e254 c06aa390 00000003 c0539db4 c0539da0 c0056a78 
c0056a28
9da0: 00000000 c06aa28c c0539dc4 c0539db8 c009547c c0056a60 c0539ddc 
c0539dc8
9dc0: c0095a08 c0095470 c06aa28c c06732b0 c0539df0 c0539de0 c0094a90 
c0095954
9de0: c06aa2fc c0539e00 c0539df4 c0093b18 c0094a1c c0539e28 c0539e04 
c0262e14
9e00: c0093a80 c038f6c8 c06ae400 c06ae400 c038f698 c04e3000 00000002 
c0539ee0
9e20: c0539e2c c02632bc c0262d40 c01e4c38 c0539e5c c0539e40 c01e405c 
c01e3fd0
9e40: c0697ee0 c01e407c c06ae400 c038f698 c0539e6c c0539e60 c01e4090 
c01e3ff4
9e60: c0539e84 c0539e70 c01e4ca8 c01e4088 c0697ec0 c06ae400 c0539e94 
c0539e88
9e80: c01e3fe0 c01e4c38 c0539ea4 c0539e98 c020ce04 c01e3fd0 c0539eb8 
c0539ea8
9ea0: c020d3c4 c020cdf8 c038f688 c0539ee0 c0539ebc c0261dc0 c020d3b4 
c01e4088
9ec0: c038f6c8 c06ae400 00000002 c038f698 c04e3000 c0539f00 c0539ee4 
c0261e70
9ee0: c0262fb0 c06ae440 ffffffff c06ae400 c04e3240 c0539f10 c0539f04 
c026203c
9f00: c0261e1c c0539f30 c0539f14 c0256d40 c026202c 00000501 00000000 
c0671320
9f20: 00000003 c0539fc0 c0539f34 c0258a9c c0256c88 c0539f40 00000008 
c067139d
9f40: c067134c c0671350 00000000 00000009 c06afa14 c04e3000 c06afa14 
c06afa00
9f60: 00000000 c04dda60 c0056920 c0539f80 c0539f80 00000000 c04dda60 
c0056920
9f80: c0539f80 c0539f80 00000000 05010000 00030501 c04ddb88 00000000 
c0538000
9fa0: c04b3f5c c0258228 00000001 00000000 fffffffc c0539ff4 c0539fc4 
c0056408
9fc0: c0258234 00000001 ffffffff ffffffff 00000000 00000000 00000000 
00000000
9fe0: 00000000 00000000 00000000 c0539ff8 c00434e0 c005630c 76c4319c 
134033ec
Backtrace:
[<c003e1cc>] (__wake_up_common+0x0/0x7c) from [<c003e274>] 
(__wake_up+0x2c/0x34)
[<c003e248>] (__wake_up+0x0/0x34) from [<c0056a4c>] 
(__wake_up_bit+0x30/0x38)
 r4 = C06AA390
[<c0056a1c>] (__wake_up_bit+0x0/0x38) from [<c0056a78>] 
(wake_up_bit+0x24/0x28)
[<c0056a54>] (wake_up_bit+0x0/0x28) from [<c009547c>] 
(wake_up_inode+0x18/0x1c)
 r5 = C06AA28C  r4 = 00000000
[<c0095464>] (wake_up_inode+0x0/0x1c) from [<c0095a08>] 
(generic_delete_inode+0xc0/0xf4)
[<c0095948>] (generic_delete_inode+0x0/0xf4) from [<c0094a90>] 
(iput+0x80/0x98)
 r5 = C06732B0  r4 = C06AA28C
[<c0094a10>] (iput+0x0/0x98) from [<c0093b18>] (d_delete+0xa4/0xb8)
 r4 = C06AA2FC
[<c0093a74>] (d_delete+0x0/0xb8) from [<c0262e14>] 
(fs_remove_file+0xe0/0x200)
[<c0262d34>] (fs_remove_file+0x0/0x200) from [<c02632bc>] 
(usbfs_notify+0x318/0x3ac)[<c0262fa4>] (usbfs_notify+0x0/0x3ac) from 
[<c0261e70>] (usb_notifier_call_chain+0x60/0xa0)
 r8 = C04E3000  r7 = C038F698  r6 = 00000002  r5 = C06AE400
 r4 = C038F6C8
[<c0261e10>] (usb_notifier_call_chain+0x0/0xa0) from [<c026203c>] 
(usb_notify_remove_device+0x1c/0x24)
 r7 = C04E3240  r6 = C06AE400  r5 = FFFFFFFF  r4 = C06AE440
[<c0262020>] (usb_notify_remove_device+0x0/0x24) from [<c0256d40>] 
(usb_disconnect+0xc4/0x184)
[<c0256c7c>] (usb_disconnect+0x0/0x184) from [<c0258a9c>] 
(hub_thread+0x874/0xbf8)
 r7 = 00000003  r6 = C0671320  r5 = 00000000  r4 = 00000501
[<c0258228>] (hub_thread+0x0/0xbf8) from [<c0056408>] (kthread+0x108/0x134)
[<c0056300>] (kthread+0x0/0x134) from [<c00434e0>] (do_exit+0x0/0xb74)
Code: bad PC value.
