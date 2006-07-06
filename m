From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002253]: Intel D945PSNLK : No sound on
	frontpanel output
Date: Thu, 6 Jul 2006 21:42:40 +0200
Message-ID: <d53ed2cf9b08b9585e85e4dd04496242@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51AA2187
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 21:42:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2253> 
======================================================================
Reported By:                vogelchr
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2253
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.17.3
======================================================================
Date Submitted:             07-02-2006 19:41 CEST
Last Modified:              07-06-2006 21:42 CEST
======================================================================
Summary:                    Intel D945PSNLK : No sound on frontpanel output
Description: 
Since upgrading the linux kernel from 2.6.15 to 2.6.17.3 the frontpanel
output no longer produces sound, back output works.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-06-06 19:47 
----------------------------------------------------------------------
Could you try the latest ALSA HG version?

----------------------------------------------------------------------
 vogelchr - 07-06-06 21:42 
----------------------------------------------------------------------
Here you go, latest ALSA from HG.

Please note:
  * still sound only on back connectors (nothing comes out of
"frontpanel")
  * but: mixer "PCM" does not affect the playback volume on back
connector
  * there are slight differences in /proc/asound/Intel/codec#2 compared
    to the Vanilla-Kernel-2.6.17.3 version

--- dmesg ---
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA
/usr/src/Alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:525:
hda_intel: azx_get_response timeout, switching to single_cmd mode...

--- make sure the modules loaded are the newly compiled ones ---
chris@mischief:/usr/src$ for n in `lsmod|awk '/^snd/{ print $1 }'` ; do
echo "" ; echo "--- $n ---" ; modinfo $n ; done|awk '/^filename:/{ print
$2 }' | xargs ls -l
-rw-r--r-- 1 root root  20892 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/acore/oss/snd-mixer-oss.ko
-rw-r--r-- 1 root root  46615 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/acore/oss/snd-pcm-oss.ko
-rw-r--r-- 1 root root  12993 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/acore/snd-page-alloc.ko
-rw-r--r-- 1 root root  83595 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/acore/snd-pcm.ko
-rw-r--r-- 1 root root  26529 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/acore/snd-timer.ko
-rw-r--r-- 1 root root  60444 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/acore/snd.ko
-rw-r--r-- 1 root root 179980 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/pci/hda/snd-hda-codec.ko
-rw-r--r-- 1 root root  22325 Jul  6 21:16
/lib/modules/2.6.17.3/kernel/sound/pci/hda/snd-hda-intel.ko

--- /proc/asound/cards ---
chris@mischief:/proc/asound$ cat cards 
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x48300000 irq 66

--- /proc/asound/version ---
chris@mischief:~$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.12rc1.
Compiled on Jul  6 2006 for kernel 2.6.17.3 (SMP).

--- play music ---
chris@mischief:/usr/src/Alsa/alsa-driver$ madplay -owav:-
/media/d/iTunesMusic/The\ Kleptones/A\ Night\ At\ The\ Hip\ Hopera/11\
Ride.mp3 | aplay -D hw:0,0 -
 >> sound comes out of "back" connectors
 >> frontpanel connectors have no sound

 (I also turned off the machine and rebooted cleanly so that only the
"new" drivers
  from 1.0.12rc1 did touch the hardware.)

--- /proc/asound/Intel/codec#2 ---
chris@mischief:/proc/asound/Intel$ cat codec#2
Codec: SigmaTel STAC9221 A1
Address: 2
Vendor Id: 0x83847680
Subsystem Id: 0x80860b0b
Revision Id: 0x103201
Default PCM: rates 0x7e0, bits 0x0e, types 0x1
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x79 0x79]
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x18
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM: rates 0x7e0, bits 0x0e, types 0x5
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x5
  Connection: 1
     0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0x80: HP
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01a19022: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01813021: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0824: IN Detect
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 3
     0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15* 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15* 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x02a19120: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0e 0x0e]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x1a

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-06 19:41 vogelchr       New Issue                                    
07-02-06 19:41 vogelchr       Distribution              => Ubuntu          
07-02-06 19:41 vogelchr       Kernel Version            => 2.6.17.3        
07-02-06 19:41 vogelchr       Issue Monitored: vogelchr                    
07-06-06 19:47 tiwai          Note Added: 0010874                          
07-06-06 21:42 vogelchr       Note Added: 0010882                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
