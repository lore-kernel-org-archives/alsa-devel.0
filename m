From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000257]: No output sound
Date: Fri, 30 Dec 2005 05:13:02 +0100
Message-ID: <d1e802b8c3fc22be7b9db5fd60b8a8a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AB24C193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:13:02 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=257> 
======================================================================
Reported By:                jordan83
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   257
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-06-2004 21:48 CEST
Last Modified:              12-30-2005 05:13 CET
======================================================================
Summary:                    No output sound
Description: 
Hi!

I bougth my pc almost one year and six months ago.
Since that day I cannot hear any sound with alsa driver  snd_via82xx (OSS
driver works). I'm quite sure it's not a configuration problem or a
permissions problem. Xmms and mpg123 don't complain about anything. They
work but I can't hear any song.

My motherboard is a QDI KuDoZ 7E/333.
South bridge VIA 8233A.
Audio: Onboard AC'97 Audio AC'97 2.1 Compliant, 16-bit Stereo Codec

You can get more information at
http://www.qdigrp.com/qdisite/eng/products/Kudoz7e333.htm

lspci returns:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333
AGP]
00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235
AC97 Audio Controller (rev 40)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX
460] (rev a3)

lsmod's output. Xmms is playing a song:
snd_seq_oss            34624  0
snd_seq_midi_event      7936  1 snd_seq_oss
snd_seq                55696  4 snd_seq_oss,snd_seq_midi_event
ppp_deflate             6208  0
zlib_deflate           22232  1 ppp_deflate
ppp_async              12224  1
ppp_generic            26260  6 ppp_deflate,ppp_async
slhc                    7808  1 ppp_generic
snd_pcm_oss            53860  1
nvidia               2070696  12
snd_mixer_oss          19840  2 snd_pcm_oss
button                  6104  0
thermal                13648  0
processor              13348  1 thermal
ipt_REJECT              6656  2
ipt_LOG                 5568  4
iptable_mangle          2752  0
snd_via82xx            25536  3
snd_pcm                97828  2 snd_pcm_oss,snd_via82xx
snd_timer              25860  2 snd_seq,snd_pcm
snd_ac97_codec         64324  1 snd_via82xx
snd_page_alloc         11332  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7872  1 snd_via82xx
snd_rawmidi            25120  1 snd_mpu401_uart
snd_seq_device          8136  3 snd_seq_oss,snd_seq,snd_rawmidi
snd                    53732  14
snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
uhci_hcd               32592  0
usbcore               105180  3 uhci_hcd
tuner                  18060  0
tda9887                 7108  0
tvaudio                22220  0
bttv                  149996  0
video_buf              21124  1 bttv
v4l2_common             6208  1 bttv
btcx_risc               4808  1 bttv
videodev                9728  1 bttv
soundcore               9888  4 snd,bttv
rtc                    12664  0



Here are other outputs:

less /dev/sndstat:
Sound Driver:3.8.1a-980706 (ALSA v1.0.4rc2 emulation code)
Kernel: Linux debian 2.6.5 #1 Mon May 3 20:59:10 CEST 2004 i686
Config options: 0
 
Installed drivers:
Type 10: ALSA emulation
 
Card config:
VIA 8233A at 0xdc00, irq 5
 
Audio devices:
0: VIA 8233A (DUPLEX)
 
Synth devices: NOT ENABLED IN CONFIG
 
Midi devices: NOT ENABLED IN CONFIG
 
Timers:
7: system timer
 
Mixers:
0: VIA Technologies VIA1612A

"amixer info" output:
Card default 'V8233A'/'VIA 8233A at 0xdc00, irq 5'
  Mixer name    : 'VIA Technologies VIA1612A'
  Components    : 'AC97a'
  Controls      : 32
  Simple ctrls  : 22

my kernel's config file:
[...]
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
                                                                          
                        
#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
                                                                          
                        
#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
[...]
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set
                                                                          
                        
#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set
                                                                          
                        [...]

modprobe.conf seems to be ok.
Finally I give you "amixer" output:

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
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
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [on]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities:
  Mono:
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [on]
  Front Right: Capture 15 [100%] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Input Source Select',0
  Capabilities:
  Mono:

That's all folks!
Please help me! I'm burning out my mind!
If you need anything else, contact me.
(if you think that it's a problem of configuration, please tell me).
Thank you very much!

Ciao!

P.S. Sorry for my bad english... 
======================================================================

----------------------------------------------------------------------
 jdthood - 04-03-05 11:48 
----------------------------------------------------------------------
Submitter: Did you ever solve this problem, either by playing with mixer
settings (try toggling 'External Amplifier') or by upgrading your
drivers/libs?

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:13 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-04 21:48 jordan83       New Issue                                    
05-06-04 21:48 jordan83       Distribution              => Debian          
05-06-04 21:48 jordan83       Kernel Version            => 2.6.5           
05-06-04 21:49 jordan83       Issue Monitored: jordan83                    
04-03-05 11:48 jdthood        Note Added: 0004304                          
12-30-05 05:13 rlrevell       Status                   new => closed       
12-30-05 05:13 rlrevell       Note Added: 0007235                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
