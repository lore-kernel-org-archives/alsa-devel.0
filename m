From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Tue, 14 Dec 2004 09:47:26 -0000 (WET)
Message-ID: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

While testing the new snd-usb-usx2y 0.8.7 hwdep pcm interface on my Tascam
US-224, and feeding it via aplay -D hw:N,2 samefile.wav, I've come to face
a couple of issues I would like to report here.

The first one is about a repeatable kernel crash happening on my SUSE 9.2
Pro box (P4/HT), but also on my Mdk 10.1 laptop (P4/UP), everytime I try
to aplay against the hw:N,2 device (N=soundcard index). See below for the
whole data and the proper oops dumps. As every kernel crash, the system is
left in a very dangerous and unstable state, so that this particular issue
should be addressed ASAP.

OTOH, on the SUSE desktop I've not been able to run jackd with the 'usx2y'
backend driver, always telling me that the 'hwdep' assertion has failed on
hwdep.c:588 (this is from memory). On the laptop, where I've been testing
the usx2y backend quite extensively, it works just fine as myself has
already praised :) Take a note that,o n either box, the snd-usb-usx2y and
kernel versions are exactly the same, so are jackd's, currently
0.99.35cvs, but it doesn't matter as the jack_usx2y backend code is still
Karsten's original. At first glance, the differences I can point between
the two are the hardware (obviously) and the SMP vs. UP kernel. One thing
that now comes to mind is that the snd-usb-usx2y is being loaded as the
third soundcard on the failing system and not as the second as once was
and I'm sure it used to work the last time I've tried long ago.

Here goes the couple of dumps I could grab about the former issue (kernel
oops), taking to note that this was taken from that SUSE/SMP box (but also
occurs on the Mdk/UP laptop).

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# uname -a
Linux gamma-suse1 2.6.10-rc2-mm3-RT-V0.7.32-20.0smp #1 SMP Mon Dec 13
20:29:56 WET 2004 i686 i686 i386 GNU/Linux

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.7 (Thu Nov 11
10:36:46 2004 UTC).

# cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1985 at 0xfebff800, irq 17
1 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xfeafe000/0xfe900000, irq 21
2 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 001/003)

# cat /proc/asound/hwdep
02-00: /proc/bus/usb/001/003
02-01: /proc/bus/usb/001/003/hwdeppcm

# cat /proc/asound/pcm
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1
01-00: CS46xx : CS46xx : playback 31 : capture 1
01-01: CS46xx - Rear : CS46xx - Rear : playback 31
01-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
01-03: CS46xx - Center LFE : CS46xx - Center LFE : playback 31
02-00: US-X2Y Audio : US-X2Y Audio #0 : playback 1 : capture 1
02-02: US-X2Y hwdep Audio : US-X2Y hwdep Audio : playback 1 : capture 1

> aplay -D hw:2,2 Startup1_1.wav
Playing WAVE 'Startup1_1.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
Segmentation fault

# dmesg
BUG: Unable to handle kernel NULL pointer dereference at virtual address
00000030
 printing eip:
f8c4118a
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: ohci1394 ieee1394 ehci_hcd usbhid uhci_hcd
intel_mch_agp agpgart evdev wacom snd_pcm_oss snd_mixer_oss snd_seq_midi
snd_seq_midi_event snd_seq snd_usb_usx2y snd_usb_lib snd_hwdep snd_cs46xx
snd_rawmidi snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
snd soundcore snd_page_alloc realtime commoncap w83781d i2c_sensor i2c_isa
i2c_i801 i2c_core sk98lin subfs dm_mod usbcore
CPU:    0
EIP:    0060:[<f8c4118a>]    Not tainted VLI
EFLAGS: 00010296   (2.6.10-rc2-mm3-RT-V0.7.32-20.0smp)
EIP is at usX2Y_usbpcm_urbs_start+0x14/0x2ac [snd_usb_usx2y]
eax: 00000000   ebx: f65a56a4   ecx: 00000000   edx: f2cf8a40
esi: 00000000   edi: f2f0c614   ebp: f2ebbea8   esp: f2ebbe3c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process aplay (pid: 8078, threadinfo=f2eba000 task=f7790dd0)
Stack: 00000286 f65a5760 00000000 f7790dd0 f8c4149b 00000000 f8c4149b
c01332e2
       f65a56a4 00000000 f2f0c614 f2ebbe7c c010e10c f65a575c f65a5760
f8c414a6
       f8c3f6f0 f65a56a4 00000000 f2f0c614 f2ebbea0 c010e10c 00000000
00000000
Call Trace:
 [<c0103624>] show_stack+0xb4/0xbc (28)
 [<c01037ba>] show_registers+0x169/0x1de (56)
 [<c01039cc>] die+0x10b/0x191 (68)
 [<c01126af>] do_page_fault+0x4d9/0x65a (220)
 [<c0103267>] error_code+0x2b/0x30 (168)
 [<f8c41504>] snd_usX2Y_usbpcm_prepare+0xe2/0x1c1 [snd_usb_usx2y] (44)
 [<f8bcd924>] snd_pcm_do_prepare+0x18/0x36 [snd_pcm] (20)
 [<f8bccd0d>] snd_pcm_action_single+0x33/0x77 [snd_pcm] (28)
 [<f8bccf26>] snd_pcm_action_nonatomic+0x6d/0x83 [snd_pcm] (36)
 [<f8bcd9c9>] snd_pcm_prepare+0x5a/0x6d [snd_pcm] (32)
 [<f8bd004d>] snd_pcm_playback_ioctl1+0x4a/0x309 [snd_pcm] (68)
 [<c017324d>] sys_ioctl+0x172/0x265 (48)
 [<c0102772>] sysenter_past_esp+0x5f/0x85 (-8124)
Code: 60 ff ff ff ff c7 44 24 04 3a 0e c4 f8 89 14 24 e8 82 e4 ff ff c9 c3
55 89 e5 57 56 53 83 ec 60 e8 74 cf 4c c7 8b 55 08 8b 42 04 <8b> 40 30 89
45 a4 83 f8 01 8b 0a 89 4d a0 0f 84 26 02 00 00 83

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# uname -a
Linux gamma-suse1 2.6.8-24.5-smp #5 SMP Mon Dec 13 22:56:42 WET 2004 i686
i686 i386 GNU/Linux

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.7rc1.
Compiled on Nov 30 2004 for kernel 2.6.8-24.5-smp (SMP).

# cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1985 at 0xfebff800, irq 201
1 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xfeafe000/0xfe900000, irq 225
2 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 002/003)

# cat /proc/asound/hwdep
02-00: /proc/bus/usb/002/003
02-01: /proc/bus/usb/002/003/hwdeppcm

# cat /proc/asound/pcm
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1
01-00: CS46xx : CS46xx : playback 31 : capture 1
01-01: CS46xx - Rear : CS46xx - Rear : playback 31
01-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
01-03: CS46xx - Center LFE : CS46xx - Center LFE : playback 31
02-00: US-X2Y Audio : US-X2Y Audio #0 : playback 1 : capture 1
02-02: US-X2Y hwdep Audio : US-X2Y hwdep Audio : playback 1 : capture 1

> aplay -D hw:2,2 Startup1_1.wav
Playing WAVE 'Startup1_1.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
Segmentation fault

# dmesg
Unable to handle kernel NULL pointer dereference at virtual address 00000030
 printing eip:
f9b330f0
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: appletalk ax25 ipx nvram wacom snd_pcm_oss
snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq snd_usb_usx2y
snd_usb_lib snd_hwdep edd snd_cs46xx snd_rawmidi snd_seq_device gameport
ipv6 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore
snd_page_alloc realtime w83781d i2c_sensor i2c_isa i2c_i801 i2c_core
usbhid joydev sg st sd_mod sr_mod scsi_mod ide_cd cdrom subfs ohci1394
ieee1394 hw_random uhci_hcd ehci_hcd intel_agp agpgart evdev sk98lin
dm_mod usbcore reiserfs
CPU:    0
EIP:    0060:[<f9b330f0>]    Tainted:  G  U VLI
EFLAGS: 00010292   (2.6.8-24.5-smp )
EIP is at usX2Y_usbpcm_urbs_start+0x10/0x300 [snd_usb_usx2y]
eax: 00000000   ebx: 00000000   ecx: cdfff680   edx: f6564714
esi: f6e4aa28   edi: f20ec614   ebp: f6564714   esp: f2745e58
ds: 007b   es: 007b   ss: 0068
Process aplay (pid: 6258, threadinfo=f2744000 task=f78081b0)
Stack: 00000282 00000021 cdfaa494 f2bb1280 f9b31e97 000003d9 f9b37060
cdfaa794
       00000000 f6564714 00000000 f78081b0 c0121650 f2745eac f2745eac
00000015
       000000d0 00000001 00000000 f78081b0 c0121650 f2745eac f2745eac
00000004
Call Trace:
 [<f9b31e97>] usX2Y_rate_set+0x157/0x240 [snd_usb_usx2y]
 [<c0121650>] autoremove_wake_function+0x0/0x50
 [<c0121650>] autoremove_wake_function+0x0/0x50
 [<f99d820f>] snd_malloc_pages+0x4f/0xa0 [snd_page_alloc]
 [<f9b334aa>] snd_usX2Y_usbpcm_prepare+0xca/0x250 [snd_usb_usx2y]
 [<f9a50fc9>] snd_pcm_do_prepare+0x9/0x20 [snd_pcm]
 [<f9a5047b>] snd_pcm_action_single+0x2b/0x90 [snd_pcm]
 [<f9a5069e>] snd_pcm_action_nonatomic+0x5e/0x60 [snd_pcm]
 [<f9a5105a>] snd_pcm_prepare+0x4a/0x70 [snd_pcm]
 [<f9a53abf>] snd_pcm_playback_ioctl1+0x5f/0x360 [snd_pcm]
 [<c011e83d>] finish_task_switch+0x3d/0x90
 [<c03464f2>] schedule+0x382/0xb90
 [<c0252720>] write_chan+0x0/0x240
 [<f9a54122>] snd_pcm_playback_ioctl+0x52/0x90 [snd_pcm]
 [<c0174de1>] sys_ioctl+0x211/0x2d0
 [<c0107029>] sysenter_past_esp+0x52/0x79
Code: 00 00 00 8b 40 20 c7 40 48 ff ff ff ff ba c0 2d b3 f9 89 c8 e9 b2 e5
ff ff 89 f6 55 89 c2 57 56 53 83 ec 68 89 44 24 24 8b 40 04 <8b> 40 30 89
44 24 18 8b 0a 48 89 4c 24 14 0f 84 60 02 00 00 83

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


Should I add this to the alsa-driver mantis bugtracker? =:)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
