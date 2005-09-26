From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001261]: poor recording with emu10k1
Date: Mon, 26 Sep 2005 21:13:14 +0200
Message-ID: <90802471e0d1585c15d49bf3fd681779@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A567918B
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 21:13:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1261> 
======================================================================
Reported By:                mal
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1261
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             all 2.6 versions
======================================================================
Date Submitted:             07-16-2005 09:28 CEST
Last Modified:              09-26-2005 21:13 CEST
======================================================================
Summary:                    poor recording with emu10k1
Description: 
Sound recording does not work right with emu10k1 on linux 2.6

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144940

This problem has ben an issue for a while. People can not use sound on
linux because of it.

======================================================================

----------------------------------------------------------------------
 vladak - 09-26-05 20:14 
----------------------------------------------------------------------
Same problem here. I am not able to record any sound with:


Linux erazim.devnull-lab.cz 2.6.13-1.1524_FC4 #1 Wed Sep 21 00:00:00 EDT
2005
i686 athlon i386 GNU/Linux

[techie@erazim ~]$ more /etc/sysconfig/hwconf
-
class: OTHER
bus: PCI
detached: 0
driver: emu10k1-gp
desc: "Creative Labs SB Live! MIDI/Game Port"
vendorId: 1102
deviceId: 7002
subVendorId: 1102
subDeviceId: 0020
pciType: 1
pcidom:    0
pcibus:  0
pcidev:  a
pcifn:  1
-

class: AUDIO
bus: PCI
detached: 0
driver: snd-emu10k1
desc: "Creative Labs SB Live! EMU10k1"
vendorId: 1102
deviceId: 0002
subVendorId: 1102
subDeviceId: 8065
pciType: 1
pcidom:    0
pcibus:  0
pcidev:  a
pcifn:  0
-


[techie@erazim ~]$ lsmod
Module                  Size  Used by
radeon                 76609  1
drm                    77653  2 radeon
autofs4                42309  2
it87                   20705  0
eeprom                  7761  0
i2c_sensor              3649  2 it87,eeprom
i2c_isa                 2497  0
ipt_REJECT              5953  1
ipt_state               1985  4
ip_conntrack           41849  1 ipt_state
iptable_filter          3137  1
ip_tables              19905  3 ipt_REJECT,ipt_state,iptable_filter
video                  16197  0
button                  6737  0
battery                 9541  0
ac                      4933  0
ipv6                  292865  12
ohci1394               47113  0
ieee1394              308537  1 ohci1394
uhci_hcd               43345  0
ehci_hcd               48333  0
shpchp                 95429  0
emu10k1_gp              3905  0
i2c_viapro              8529  0
i2c_core               21697  5 it87,eeprom,i2c_sensor,i2c_isa,i2c_viapro
snd_emu10k1_synth      10049  0
snd_emux_synth         51265  1 snd_emu10k1_synth
snd_seq_virmidi         6977  1 snd_emux_synth
snd_seq_midi_emul       6977  1 snd_emux_synth
snd_emu10k1           159589  4 snd_emu10k1_synth
snd_util_mem            5057  2 snd_emux_synth,snd_emu10k1
snd_hwdep               9313  2 snd_emux_synth,snd_emu10k1
snd_via82xx            33025  0
gameport               21321  3 emu10k1_gp,snd_via82xx
snd_ac97_codec         80829  2 snd_emu10k1,snd_via82xx
snd_seq_dummy           3781  0
snd_seq_oss            42945  0
snd_seq_midi_event     10177  2 snd_seq_virmidi,snd_seq_oss
snd_seq                78033  8
snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            53105  0
snd_mixer_oss          18241  2 snd_pcm_oss
snd_pcm               112201  5
snd_emu10k1,snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              42437  3 snd_emu10k1,snd_seq,snd_pcm
snd_page_alloc         10825  3 snd_emu10k1,snd_via82xx,snd_pcm
snd_mpu401_uart        12481  1 snd_via82xx
snd_rawmidi            36321  3
snd_seq_virmidi,snd_emu10k1,snd_mpu401_uart
snd_seq_device          9165  7
snd_emu10k1_synth,snd_emux_synth,snd_emu10k1,snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi
snd                    62021  18
snd_emux_synth,snd_seq_virmidi,snd_emu10k1,snd_hwdep,snd_via82xx,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              12449  2 snd
e100                   61249  0
8139too                36289  0
mii                     5569  2 e100,8139too
floppy                 71861  0
dm_snapshot            18053  0
dm_zero                 2113  0
dm_mirror              30485  0
ext3                  138569  3
jbd                   111065  1 ext3
dm_mod                 61533  6 dm_snapshot,dm_zero,dm_mirror
sata_via                8645  1
libata                 49353  1 sata_via
sd_mod                 22209  2
scsi_mod              160681  2 libata,sd_mod
[techie@erazim ~]$

[techie@erazim ~]$ amixer
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 22 [71%] [on]
  Front Right: Playback 22 [71%] [on]
Simple mixer control 'Headphone LFE',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Headphone',1
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 75 [75%]
  Front Right: Playback 75 [75%]
Simple mixer control 'Headphone Center',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Tone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Bass',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Limits: 0 - 40
  Mono: 0 [0%]
  Front Left:
  Front Right:
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Limits: 0 - 40
  Mono: 0 [0%]
  Front Left:
  Front Right:
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control '3D Control Sigmatel - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]
Simple mixer control '3D Control Sigmatel - Rear Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 22 [71%] [on]
  Front Right: Playback 22 [71%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 75 [75%]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 75 [75%]
Simple mixer control 'Synth',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'Wave',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 75 [75%] Capture 0 [0%] [off]
  Front Right: Playback 75 [75%] Capture 0 [0%] [off]
Simple mixer control 'Wave Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 75 [75%]
Simple mixer control 'Wave LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 75 [75%]
Simple mixer control 'Wave Surround',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 75 [75%]
  Front Right: Playback 75 [75%]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 15 [48%] [off] Capture [on]
  Front Right: Playback 15 [48%] [off] Capture [on]
Simple mixer control 'Line LiveDrive',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'Line2 LiveDrive',1
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [on] Capture [off]
  Front Right: Playback 23 [74%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 22 [71%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono:
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off] Capture [off]
  Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958 Coaxial',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'IEC958 LiveDrive',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'IEC958 Optical Raw',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'IEC958 TTL',0
  Capabilities: pvolume cvolume cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] Capture 0 [0%] [off]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 11 [73%] [on]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off] Capture [off]
  Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [off]
  Front Right: Capture 0 [0%] [off]
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
Simple mixer control 'AC97',0
  Capabilities: pvolume cvolume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 0 [0%] Capture 0 [0%]
  Front Right: Playback 0 [0%] Capture 0 [0%]
Simple mixer control 'EMU10K1 PCM',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center
  Limits: 0 - 65535
  Mono: 65535 [100%]
  Front Left:
  Front Right:
  Front Center:
Simple mixer control 'EMU10K1 PCM Send',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center - Rear Left -
Rear Right - Woofer - ? - ? - ? - ? - ? - ?
  Limits: 0 - 255
  Mono: 255 [100%]
  Front Left:
  Front Right:
  Front Center:
  Rear Left:
  Rear Right:
  Woofer:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
Simple mixer control 'EMU10K1 PCM Send Routing',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center - Rear Left -
Rear Right - Woofer - ? - ? - ? - ? - ? - ?
  Limits: 0 - 15
  Mono: 0 [0%]
  Front Left:
  Front Right:
  Front Center:
  Rear Left:
  Rear Right:
  Woofer:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'SB Live Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Sigmatel 4-Speaker Stereo',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Sigmatel Output Bias',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Sigmatel Surround',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [on]
  Front Right: Playback 23 [74%] [on]
Simple mixer control 'Sigmatel Surround Phase Inversion Playback ',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
[techie@erazim ~]$

[techie@erazim ~]$ cat /proc/asound/cards
0 [Live           ]: EMU10K1 - SB Live [Unknown]
                     SB Live [Unknown] (rev.10, serial:0x80651102) at
0xb000, irq 11
[techie@erazim ~]$
[techie@erazim ~]$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28
12:20:13 2005 UTC).
[techie@erazim ~]$

----------------------------------------------------------------------
 rlrevell - 09-26-05 21:13 
----------------------------------------------------------------------
You have Mic, Mix, Capture, and AC97 all muted.  You need to unmute them
with alsamixer (press F4 to see the capture controls)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-05 09:28 mal            New Issue                                    
07-16-05 09:28 mal            Kernel Version            => all 2.6 versions
07-16-05 09:31 mal            Note Added: 0005485                          
07-16-05 09:49 rlrevell       Note Added: 0005486                          
07-16-05 10:32 mal            Note Added: 0005487                          
07-16-05 10:34 mal            Note Added: 0005488                          
07-16-05 10:38 mal            Note Added: 0005489                          
07-16-05 10:41 mal            File Added: tsts.wav                         
07-16-05 10:51 mal            File Added: t44100.wav                       
07-16-05 10:52 mal            Note Added: 0005490                          
07-16-05 10:53 mal            File Added: t44100_stereo.wav                    
07-16-05 11:00 mal            Note Added: 0005491                          
07-16-05 11:07 mal            File Added: t_cd.wav                         
07-16-05 11:08 mal            Note Added: 0005492                          
07-16-05 11:09 mal            Note Edited: 0005492                         
07-16-05 12:12 rlrevell       Note Added: 0005493                          
07-16-05 12:32 mal            File Added: cc.wav                           
07-16-05 12:33 mal            Note Added: 0005494                          
09-26-05 20:14 vladak         Note Added: 0006397                          
09-26-05 21:13 rlrevell       Note Added: 0006398                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
