From: Dominique De Munck <domin@ulyssis.org>
Subject: snd-via82xx full duplex problem
Date: Mon, 21 Apr 2003 22:25:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0304212222250.22247-100000@ace>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

when recording something (via sox, mencoder for example),
I can play sounds fine (for example mp3's, divx-files).
However, when I visit a flash enabled site at that moment,
my soundcard just hangs. It keeps recording, but every other
access to soundcard is not working / crashing the application.
Unloading the drivers doesn't work
(device or resource busy, fuser /dev/dsp & /dev/mixer gives nothing)
a reboot is necessary.
This is realy anoying me since I record a lot & a lot of sites are using
flash...

The problem happens with artsd running and artsd disabled.
At the end of this mail dmesg output when Opera browser with Flash
6.0.79 crashed.


greetz,

Dominique

some info :
I have a K7T Turbo motherboard with onboard
VIA 82C686B AC97 audiocard.
I'm using the alsa-drivers of Mandrake 9.1
(0.9.0-0.14rc7, 2.4.21-0.13mdk kernel )

asound proc when recording & after crash :5~

cat /proc/asound/pcm
00-00: VIA 82C686A/B rev50 : VIA 82C686A/B rev50 : playback 1 : capture 1


cat /proc/asound/cards
0 [rev50          ]: VIA686A - VIA 82C686A/B rev50
                     VIA 82C686A/B rev50 at 0xdc00, irq 11


cat /proc/asound/card0/ac97\#0
0-0/0: ICEnsemble ICE1232

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Reserved 27

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 44100Hz



cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: VIA 82C686A/B rev50
name: VIA 82C686A/B rev50
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0



cat /proc/asound/card0/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: VIA 82C686A/B rev50
name: VIA 82C686A/B rev50
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0


dmesg output :


Unable to handle kernel NULL pointer dereference at virtual address
00000018
 printing eip:
f8f361e7
*pde = 00000000
Oops: 0000
nls_iso8859-1 isofs zlib_inflate ipt_MASQUERADE iptable_nat ip_conntrack
ip_tables vmnet vmmon lp parport_pc parport mga agpgart snd-seq-midi snd-s
eq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-via82xx
snd-ac97-codec snd-pcm snd-timer snd-mpu401-uart snd-rawmidi
snd-seq-device
 snd-page-alloc snd af_packet ip_vs sr_mod floppy 8139too mii
nls_iso8859-15 nls_cp850 vfat fat ide-cd cdrom tuner tvaudio bttv videodev
i2c-algo-b
it soundcore ide-scsi scsi_mod via686a i2c-proc i2c-isa i2c-core usb-uhci
usbcore rtc reiserfs
CPU:    0
EIP:    0010:[<f8f361e7>]    Tainted: PF
EFLAGS: 00010282
EIP is at clean_via_table+0x7/0x50 [snd-via82xx]
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: d414b400
esi: 00000000   edi: ea1dd200   ebp: f39ebe60   esp: f39ebe5c
ds: 0018   es: 0018   ss: 0018
Process operamotifwrapp (pid: 5801, stackpage=f39eb000)
Stack: f7e5ab60 f39ebe78 f8f3685e 00000000 f7e5ab60 f7e7ec00 f7e5ab60
f39ebe90
       f8f533a3 f7e5ab60 fffffff5 00000000 ea1dd200 f39ebeb0 f8f5358b
ea1dd200
       00000000 f7e5ab60 f39ea000 f310c918 f310c800 f39ebf28 f8f53738
ca086c20
Call Trace:
 [<f8f3685e>] snd_via82xx_hw_free+0x1e/0x30 [snd-via82xx]
 [<f8f533a3>] snd_pcm_oss_release_file+0x73/0xa0 [snd-pcm-oss]
 [<f8f5358b>] snd_pcm_oss_open_file+0x1bb/0x1f0 [snd-pcm-oss]
 [<f8f53738>] snd_pcm_oss_open+0x178/0x2c0 [snd-pcm-oss]
 [<c0170b5e>] devfs_open+0x12e/0x190 [kernel]
 [<c013effa>] dentry_open+0xca/0x1d0 [kernel]
 [<c013ef21>] filp_open+0x51/0x60 [kernel]
 [<c013f29d>] sys_open+0x3d/0x90 [kernel]
 [<c0109093>] system_call+0x33/0x40 [kernel]

Code: 8b 43 18 85 c0 75 22 8b 43 20 85 c0 75 0b 8b 5d fc 89 ec 5d



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
