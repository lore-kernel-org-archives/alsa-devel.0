From: Flo Gleixner <flo@bier.homeip.net>
Subject: Re: Problem recording with via 8235
Date: Mon, 26 Jul 2004 20:16:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.60.0407261942000.26365@octopus.goldach.test>
References: <Pine.LNX.4.60.0407231650160.25456@octopus.goldach.test>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.60.0407231650160.25456@octopus.goldach.test>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Flo Gleixner <flo@bier.homeip.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hmm. you guys need probably more Information:

uname -m ; uname -r
i686
2.6.3-15mdk


lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:07.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 
AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 
74)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a3)


lsmod
...
snd-seq-oss            31232  0
snd-seq-midi-event      7552  1 snd-seq-oss
snd-seq                51024  4 snd-seq-oss,snd-seq-midi-event
snd-pcm-oss            51812  0
snd-mixer-oss          17952  1 snd-pcm-oss
snd-via82xx            24160  0
snd-pcm                93156  2 snd-pcm-oss,snd-via82xx
snd-timer              24484  2 snd-seq,snd-pcm
snd-ac97-codec         58148  1 snd-via82xx
gameport                4480  1 snd-via82xx
snd-page-alloc         11972  2 snd-via82xx,snd-pcm
snd-mpu401-uart         7072  1 snd-via82xx
snd-rawmidi            23616  1 snd-mpu401-uart
snd-seq-device          8008  3 snd-seq-oss,snd-seq,snd-rawmidi
snd                    52484  12 
snd-seq-oss,snd-seq-midi-event,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-via82xx,snd-pcm,snd-timer,snd-ac97-codec,snd-mpu401-uart,snd-rawmidi,snd-seq-device
soundcore               9248  1 snd
...


dmesg
...
via82xx: Assuming DXS channels with 48k fixed sample rate.
          Please try dxs_support=1 or dxs_support=4 option
          and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
...



I tried with dxs_support=1 and dxs_support=4 but this does not help. I 
still cannot record from microphone or line. Not a byte.


More info:

arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: V8235 [VIA 8235], device 0: VIA 8235 [VIA 8235]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: V8235 [VIA 8235], device 1: VIA 8235 [VIA 8235]
   Subdevices: 1/1
   Subdevice #0: subdevice #0


Mixer settings:

Simple mixer control 'Master',0
   Capabilities: pvolume pswitch pswitch-joined
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 16 [52%] [on]
   Front Right: Playback 16 [52%] [on]
Simple mixer control 'Master Mono',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 31
   Mono: Playback 0 [0%] [off]
Simple mixer control '3D Control - Center',0
   Capabilities: volume volume-joined
   Playback channels: Mono
   Limits: 0 - 15
   Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
   Capabilities: volume volume-joined
   Playback channels: Mono
   Limits: 0 - 15
   Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'PCM',0
   Capabilities: pvolume pswitch pswitch-joined
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 21 [68%] [on]
   Front Right: Playback 21 [68%] [on]
Simple mixer control 'Surround',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 0 [0%] [off]
   Front Right: Playback 0 [0%] [off]
Simple mixer control 'Surround Down Mix',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Center',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 31
   Mono: Playback 31 [100%] [off]
Simple mixer control 'Center/LFE Down Mix',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'LFE',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 31
   Mono: Playback 0 [0%] [off]
Simple mixer control 'Line',0
   Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 22 [71%] [on] Capture [off]
   Front Right: Playback 22 [71%] [on] Capture [off]
Simple mixer control 'Line-In As Surround',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'CD',0
   Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 0 [0%] [off] Capture [off]
   Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Mic',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Playback channels: Mono
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono: Playback 22 [71%] [on]
   Front Left: Capture [on]
   Front Right: Capture [on]
Simple mixer control 'Mic As Center/LFE',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Mic Boost (+20dB)',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Mic Select',0
   Capabilities:
   Mono:
Simple mixer control 'Video',0
   Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 0 [0%] [off] Capture [off]
   Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Phone',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Playback channels: Mono
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono: Playback 0 [0%] [off]
   Front Left: Capture [off]
   Front Right: Capture [off]
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined cswitch cswitch-joined
   Playback channels: Mono
   Capture channels: Mono
   Mono: Playback [off] Capture [off]
Simple mixer control 'IEC958 Input Monitor',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Output',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
   Capabilities: volume volume-joined
   Playback channels: Mono
   Limits: 0 - 3
   Mono: 3 [100%]
Simple mixer control 'PC Speaker',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 15
   Mono: Playback 0 [0%] [off]
Simple mixer control 'Aux',0
   Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 0 [0%] [off] Capture [off]
   Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Mono Output Select',0
   Capabilities:
   Mono:
Simple mixer control 'Capture',0
   Capabilities: cvolume cswitch cswitch-joined
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 15
   Front Left: Capture 10 [67%] [on]
   Front Right: Capture 10 [67%] [on]
Simple mixer control 'Mix',0
   Capabilities: cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Capture channels: Front Left - Front Right
   Front Left: Capture [off]
   Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
   Capabilities: cswitch cswitch-joined cswitch-exclusive
   Capture exclusive group: 0
   Capture channels: Front Left - Front Right
   Front Left: Capture [off]
   Front Right: Capture [off]
Simple mixer control 'Analog to IEC958 Output',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Duplicate Front',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Exchange Center/LFE',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'External Amplifier Power Down',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Input Source Select',0
   Capabilities:
   Mono:
Simple mixer control 'Input Source Select',1
   Capabilities:
   Mono:
Simple mixer control 'Swap Surround Slot',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'VIA DXS',0
   Capabilities: pvolume
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 31 [100%]
   Front Right: Playback 31 [100%]
Simple mixer control 'VIA DXS',1
   Capabilities: pvolume
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 31 [100%]
   Front Right: Playback 31 [100%]
Simple mixer control 'VIA DXS',2
   Capabilities: pvolume
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 31 [100%]
   Front Right: Playback 31 [100%]
Simple mixer control 'VIA DXS',3
   Capabilities: pvolume
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Front Left: Playback 31 [100%]
   Front Right: Playback 31 [100%]


Is there a general Doc for mixer settings? Or a doc that is driver 
dependant?

Please help me! What additional Info do you need?

Thanks,

Flo


On Fri, 23 Jul 2004, Flo Gleixner wrote:

>
> Sorry for crossposting, but this problem is probably more for the devels.
>
> Thanks for your time.
>
> Flo
>
> ---------- Forwarded message ----------
> Date: Thu, 22 Jul 2004 00:51:12 +0200 (CEST)
> From: Flo Gleixner <flo@bier.homeip.net>
> To: alsa-user@lists.sourceforge.net
> Subject: [Alsa-user] Problem recording with via 8235
>
>
> Hi,
>
> does somebody know what i'm doing wrong:
>
> arecord -vv & while true ; do date ; sleep 1 ; done
> RIFF$_WAVEfmt @data_Recording WAVE 'stdout' : Unsigned 8 bit, Rate 8000 Hz, 
> Mono
> Plug PCM: Hardware PCM card 0 'VIA 8235' device 0 subdevice 0
>
> Its setup is:
> stream       : CAPTURE
> access       : RW_INTERLEAVED
> format       : U8
> subformat    : STD
> channels     : 1
> rate         : 8000
> exact rate   : 8000 (8000/1)
> msbits       : 8
> buffer_size  : 4000
> period_size  : 1000
> period_time  : 125000
> tick_time    : 1000
> tstamp_mode  : NONE
> period_step  : 1
> sleep_min    : 0
> avail_min    : 1000
> xfer_align   : 1000
> start_threshold  : 1
> stop_threshold   : 4000
> silence_threshold: 0
> silence_size : 0
> boundary     : 2097152000
> [1] 4146
> Tue Jul 20 00:27:17 CEST 2004
> Tue Jul 20 00:27:18 CEST 2004
> Tue Jul 20 00:27:19 CEST 2004
> Tue Jul 20 00:27:20 CEST 2004
> Tue Jul 20 00:27:21 CEST 2004
> Tue Jul 20 00:27:22 CEST 2004
> Tue Jul 20 00:27:23 CEST 2004
> Tue Jul 20 00:27:24 CEST 2004
> Tue Jul 20 00:27:25 CEST 2004
> Tue Jul 20 00:27:26 CEST 2004
> arecord: pcm_read:1164: read error: Input/output error
> [1]+  Exit 1                  arecord -vv
> Tue Jul 20 00:27:27 CEST 2004
> Tue Jul 20 00:27:28 CEST 2004
>
>
> If i strace arecord, i see this:
>
> ....
> open("/dev/snd/pcmC0D0c", O_RDWR)       = 5
> ....
> ioctl(5, 0xc25c4111, 0xbffff384)        = 0
> ioctl(5, 0xc0684113, 0xbfffef10)        = 0
> ioctl(5, 0x4140, 0x4002d278)            = 0
> --- next one takes 10 secs. ---
> ioctl(5, 0x800c4151, 0xbffff5b0)        = -1 EIO (Input/output error)
> write(2, "arecord: pcm_read:1164: ", 24arecord: pcm_read:1164: ) = 24
> write(2, "read error: Input/output error", 30read error: Input/output error) 
> = 30
>
>
> aplay works as far as i see. I use Mandrake 10.0 which uses alsa 1.0.2
>
> Another problem i have: unreal tournament plays sounds in double speed.
>
> Thanks for the help!
>
> Flo
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
