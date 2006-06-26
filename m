From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002202]: model is not autodetected
	correctly
Date: Mon, 26 Jun 2006 11:37:13 +0200
Message-ID: <386914410d9c4b17228cfd5b9da48efd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A456195
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 11:37:14 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2202> 
======================================================================
Reported By:                el
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2202
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu Dapper
Kernel Version:             2.6.15-23
======================================================================
Date Submitted:             06-12-2006 09:45 CEST
Last Modified:              06-26-2006 11:37 CEST
======================================================================
Summary:                    model is not autodetected correctly
Description: 
I am using a Fujitsu-Siemens Amilo M3438G (Datasheet here:
http://www.fujitsu-siemens.com/Resources/59/562938810.pdf )

When I load the module via modprobe snd-hda-intel I get the following
controls in alsamixer: 
playback: PCM, Headphones, Internal Speaker, CD, Mic
capture: 3x Capture
I can not get the Microphone to work, no matter what I select as Input
Source for the Capture channels.

When I use modprobe snd-hda-intel model=auto I get
playback: PCM, front(controls headphones), side(controls internal
speaker), center, lfe, internal mic, mic, ...
capture: 3x Capture
The Microphone (Internal, or external if connected) works when I unmute
the first capture channel and set its input source to Front Mic.
Sometimes the center channel controls the speaker at the bottom of the
laptop, sometimes it doesnt, seems kind of random.

Documentation states, that model=auto is the default, but as you can see
it is not
======================================================================

----------------------------------------------------------------------
 el - 06-14-06 17:20 
----------------------------------------------------------------------
el@eltopo:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.11.
Compiled on Jun 12 2006 for kernel 2.6.15-23-386.

el@eltopo:~$ sudo modprobe snd-hda-intel

el@eltopo:~$ cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfebf8000 irq 169

el@eltopo:~$ cat /sys/module/snd_hda_intel/parameters/model
<NULL>

el@eltopo:~$ amixer
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Caller ID',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',2
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Internal Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Off-hook',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
el@eltopo:~$ sudo modprobe -r snd-hda-intel




el@eltopo:~$ sudo modprobe snd-hda-intel model=auto

el@eltopo:~$ cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfebf8000 irq 169

el@eltopo:~$ cat /sys/module/snd_hda_intel/parameters/model
auto

el@eltopo:~$ amixer
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 0 [0%] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 0 [0%] [off]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [off] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Caller ID',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Input Source',2
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Off-hook',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

----------------------------------------------------------------------
 el - 06-26-06 11:37 
----------------------------------------------------------------------
Is there any other data I should provide?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 09:45 el             New Issue                                    
06-12-06 09:45 el             Distribution              => Kubuntu Dapper  
06-12-06 09:45 el             Kernel Version            => 2.6.15-23       
06-14-06 17:20 el             Note Added: 0010215                          
06-26-06 11:37 el             Note Added: 0010526                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
