From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000618]: Can not play sound or no sound output
Date: Sun, 31 Oct 2004 05:28:28 +0100
Message-ID: <cc3bea63541ae0989cc1c582d436c473@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C3C902C3
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2004 05:28:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=618> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   618
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrake 9, Mandrake 10, Slackware 10
Kernel Version:             2.4.19, 2.6.8, 2.4.26
======================================================================
Date Submitted:             10-31-2004 04:39 CET
Last Modified:              10-31-2004 05:28 CET
======================================================================
Summary:                    Can not play sound or no sound output
Description: 
Can not play any sound with any program (mplayer, xine, aplay, vlc, totem,
and many more). ALSA version 1.0.5a works but it seems that the ALSA
developer for the ALSA version 1.0.6a module took out ADC and DAC mixer
volume controls. The ADC and DAC mixer volume controls made it worked. I
know that 1.0.6a works because the on-board intel sound works.

[cat /proc/asound/A71/ice1724]
Audiotrak Prodigy 7.1 at 0x9400, irq 7

EEPROM:
  Subvendor        : 0x33495345
  Size             : 19 bytes
  Version          : 2
  System Config    : 0x2b
  ACLink           : 0x80
  I2S              : 0xf8
  S/PDIF           : 0xc3
  GPIO direction   : 0xbfffff
  GPIO mask        : 0x0
  GPIO state       : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0x00
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x2b
  CCS05    : 0x80
  CCS06    : 0xf8
  CCS07    : 0xc3
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x00
  CCS11    : 0x00
  CCS12    : 0x33
  CCS13    : 0x80
  CCS14    : 0x00
  CCS15    : 0x10
  CCS16    : 0x00
  CCS17    : 0x00
  CCS18    : 0xff
  CCS19    : 0xff
  CCS1a    : 0xbf
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0xda
  CCS1f    : 0x00
  MT00     : 0x00
  MT01     : 0x00
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x00
  MT05     : 0x00
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x00
  MT11     : 0x00
  MT12     : 0x00
  MT13     : 0x00
  MT14     : 0x00
  MT15     : 0x00
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x00
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0x00
  MT1d     : 0x00
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0x00
  MT27     : 0x00
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x00
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00

[cat /etc/modules.conf]
# nVidia Video Card
alias char-major-195 nvidia
alias /dev/nvidia* nvidia
options nvidia NVreg_RegAGPRate=4 NVreg_EnableAGPSBA=0
NVreg_EnableAGPFW=0

# ALSA 
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
alias snd-card-1 snd-ice1724
options snd-intel8x0 index=0
options snd-ice1724 index=1

# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-slot 1 snd-card-1

# Intel Sound
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

# Audiotrak Prodigy 7.1
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss

# Haupauge PVR-250 (Model 980)
alias char-major-81     videodev
alias char-major-81-0   ivtv
#alias char-major-61 lirc_i2c
options ivtv ivtv_debug=1 mpg_buffers=100 yuv_buffers=400
options tuner type=39 debug=5
options msp3400 once=1 simple=1
add below ivtv msp3400 saa7115 tuner
#add above ivtv lirc_dev lirc_i2c


[amixer printout]
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 255
  Mono: Playback 220 [86%] [on]
Simple mixer control 'Headphone Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 101
  Mono: Playback 89 [88%]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 101
  Mono: Playback 88 [87%]
Simple mixer control 'Line',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'CD',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities:
  Mono:
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities:
  Mono:
Simple mixer control 'Aux',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 15 [48%] [on]
  Front Right: Capture 15 [48%] [on]
Simple mixer control 'AC97',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'ADC Oversampling',0
  Capabilities:
  Mono:
Simple mixer control 'DAC Deemphasis',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Front',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 101
  Front Left: Playback 88 [87%]
  Front Right: Playback 88 [87%]
Simple mixer control 'H/W',0
  Capabilities:
  Mono:
Simple mixer control 'H/W',1
  Capabilities:
  Mono:
Simple mixer control 'H/W',2
  Capabilities:
  Mono:
Simple mixer control 'H/W',3
  Capabilities:
  Mono:
Simple mixer control 'H/W',4
  Capabilities:
  Mono:
Simple mixer control 'H/W',5
  Capabilities:
  Mono:
Simple mixer control 'H/W',6
  Capabilities:
  Mono:
Simple mixer control 'H/W',7
  Capabilities:
  Mono:
Simple mixer control 'Multi Track Internal Clock',0
  Capabilities:
  Mono:
Simple mixer control 'Multi Track Peak',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center - Rear Left -
Rear Right - Woofer - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? -
? - ? - ?
  Limits: 0 - 255
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
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
Simple mixer control 'Multi Track Rate Locking',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Multi Track Rate Reset',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Rear',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 101
  Front Left: Playback 88 [87%]
  Front Right: Playback 88 [87%]
Simple mixer control 'Side',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 101
  Front Left: Playback 88 [87%]
  Front Right: Playback 88 [87%]

I do not have my parallel and seral ports enabled so there is no devices
using IRQ7. Usually parallel ports uses IRQ7.

I selected /dev/dsp1 and /dev/mixer1 but no sound.

I woud apreciate that someone fixes this ASAP.
======================================================================

----------------------------------------------------------------------
 ungod - 10-31-04 05:28 
----------------------------------------------------------------------
First of all, have you tried the 1.0.7rc2 drivers (or the CVS)? There have
been made significant changes, which impacts the Prodigy 7.1 driver.

As for DAC/ADC, these control elements still exists, however under
different names, such as Front,Rear,Center/LFE,Side and Capture

And have you tried actually playing back directly with ALSA? That is,
using aplay og selecting ALSA as output plugin. The /dev/dsp1 and
/dev/mixer1 devices are OSS devices

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-04 04:39 Electro        New Issue                                    
10-31-04 04:39 Electro        Distribution              => Mandrake 9, Mandrake
10, Slackware 10
10-31-04 04:39 Electro        Kernel Version            => 2.4.19, 2.6.8, 2.4.26
10-31-04 05:28 ungod          Note Added: 0002292                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
