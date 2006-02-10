From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001836]: Cannot capture sound on Shark Predator ISA (AD1816a based)
Date: Fri, 10 Feb 2006 08:04:11 +0100
Message-ID: <604981a9e2f32090c11a19ded8ecaf76@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A556914F
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 08:04:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1836> 
======================================================================
Reported By:                arromdee
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1836
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrake Linux
Kernel Version:             2.6.8.1-12mdk
======================================================================
Date Submitted:             02-10-2006 07:28 CET
Last Modified:              02-10-2006 08:04 CET
======================================================================
Summary:                    Cannot capture sound on Shark Predator ISA (AD1816a
based)
Description: 
Attempting to capture sound using arecord produces the following error:

arecord: pcm_read:1196: read error: Input/output error

The resulting capture file is always 44 bytes long (basically empty).

Capturing sound works fine under Windows 98.

I've never tried to capture sound before this and my guess is that nobody
other than me uses this driver.
======================================================================

----------------------------------------------------------------------
 arromdee - 02-10-06 07:50 
----------------------------------------------------------------------
The card is PNP.  I have no /etc/modules.conf or conf.modules.  The driver
for the card is loaded by having several lines in /etc/rc.d/rc.local:

modprobe snd
modprobe snd-ad1816a
modprobe snd-pcm-oss
modprobe snd-seq-oss
modprobe snd-mixer-oss

/proc% cat dma
 1: AD1816A - 1
 3: AD1816A - 2
 4: cascade
/proc% cat ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0200-0207 : ns558-pnp
0213-0213 : ISAPnP
02f8-02ff : serial
0300-0301 : MPU401 UART
0376-0376 : ide1
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0500-050f : AD1816A
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
  6000-607f : via686a-sensor
d000-dfff : PCI Bus #01
  d000-d0ff : 0000:01:00.0
e000-e00f : 0000:00:07.1
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : 0000:00:07.2
  e400-e41f : uhci_hcd
e800-e81f : 0000:00:07.3
  e800-e81f : uhci_hcd

The above statement about nobody else using the driver seems to be wrong,
since other people have reported ad1816a bugs.

----------------------------------------------------------------------
 arromdee - 02-10-06 08:04 
----------------------------------------------------------------------
In /proc/asound:

cards:
0 [AD1816A        ]: AD1816A - ADI SoundPort AD1816A
                     ADI SoundPort AD1816A, SS at 0x500, irq 5, dma 1&3
devices:
  0: [0- 0]: ctl
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer

hwdep:
00-00: OPL3 FM

modules:
0 snd-ad1816a

pcm:
00-00: AD1816A : AD1816A : playback 1 : capture 1

timers:
G0: system timer : 1000.000us (10000000 ticks)
C0-1: AdLib timer #1 : 80.000us (256 ticks)
C0-2: AdLib timer #2 : 320.000us (256 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

version:
Advanced Linux Sound Architecture Driver Version 1.0.6.
Compiled on Oct  1 2004 for kernel 2.6.8.1-12mdk.

/proc/asound/card0/id:
AD1816A

/proc/asound/card0/pcm0c/info:
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: AD1816A
name: AD1816A
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

prealloc is 64, and head, status, and sw_params are closed.

/proc/asound/card0/pcm0p/info:

card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: AD1816A
name: AD1816A
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

prealloc is 64, and head, status, and sw_params are closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 07:28 arromdee       New Issue                                    
02-10-06 07:28 arromdee       Distribution              => Mandrake Linux  
02-10-06 07:28 arromdee       Kernel Version            => 2.6.8.1-12mdk   
02-10-06 07:50 arromdee       Note Added: 0007994                          
02-10-06 08:04 arromdee       Note Added: 0007995                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
