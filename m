From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001213]: snd-via82xx on EPIA-M - 0
	analog subsections not ready: no sound
Date: Mon, 17 Jul 2006 16:01:14 +0200
Message-ID: <415023d11fd4feae70260165448a8254@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CCBA120
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 16:01:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1213> 
======================================================================
Reported By:                shensche
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1213
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian (derived Knoppix->Morphix->Kunnafonix)
Kernel Version:             2.6.11.12, but also many other 2.4 and 2.6 kernels
======================================================================
Date Submitted:             06-27-2005 12:22 CEST
Last Modified:              07-17-2006 16:01 CEST
======================================================================
Summary:                    snd-via82xx on EPIA-M - 0 analog subsections not
ready: no sound
Description: 
i am working on a machine with an EPIA-M mainboard and the ICEensemble
VT1616i sound chip (see attached lspci -v). unfortunately, i cannot hear
any sound from it. it is always the same: the mixer settings seem ok,
the applications play happily the files, but i cannot hear a thing. the
speakers are ok, too.

the system is running kernel 2.6.11 with the kernel patches from Con
Kolivas (-ck10) and ALSA. i also tried OSS (not the emu) on that kernel.
i tried 2.4 kernels with Damn Small Linux and Knoppix 3.7 and 2.6.9
=66rom Knoppix 3.7 and a custom 2.6.10-ck6.
since ALSA 1.0.8 did not work, i installed 1.0.9b, including the libs
and utils. during that upgrade, the mixer lost the possibility to change
the DXS-settings. has this to do with the whitelist, introduced
recently?

i played around with lots of combinations of the options ac97_quirk and
dxs_support when loading the kernel module.

on the hardware side i disabled the front panel sockets for line-out and
mic-in, just to be sure. and i often tried all three sockets for=20
line-out, line-in and mic-in in the back to hear the output.

the chip seems to share interrupt 10 with USB, so i unloaded uhci-hcd,
but to no avail. i also dis-/enabled ACPI, reserved IRQ for non-PCI (now
USB and sound share interrupt 5) in the BIOS. the BIOS was told that
there was a/no PlugNPlay OS and the MC97 modem is disabled.
the machine does not seem to have an APIC.

i muted some IEC 958 settings in the mixer as read somewhere in the net,
but that did not help either. and one of these settings always
reenables itself as soon as i try to play a wav with aplay.

i modified alsa-kernel/pci/ac97/ac97_codec.c to goto __ready_ok also
when "0 analog subsections are ready" (weird message, btw) before line
1960. another try was to increase the end_time in line 1953 by factor
10. both did not yield a successful result, both being a shot in the
blue.


i attached /etc/asound.state (after saving with alsactl store) and the
output of dmesg. do not mind the oops from cowloop, i guess it is not
important, because all the other kernels do not work as well.

i read=20
http://alsa-project.org/alsa-doc/doc-php/template.php?company=3DVIA&card=3D=
=2E&chip=3DVIA82C686%2C+VIA8233%2C+VIA8233A%2C+VIA8235&module=3Dvia82xx
alsa-kernel/Documentation/ALSA-Configuration.txt
and many other forum entries

but still something is going wrong. why are 0 analog subdevices ready?
how to make them ready? where to wait? what to initialise?

i will try to upgrade the BIOS, soon and try with MS Windows (if i manage
to fit   it onto 1 GB)

======================================================================

----------------------------------------------------------------------
 picobyte - 06-03-06 15:50 
----------------------------------------------------------------------
I have a via 8235 also, not working. It used to work and somewhere in
kernel upgrades and/or alsa upgrades it stopped working. I succesfully had
it once in alsa 1.0.9b with an early 2.6 kernel (I am not sure which one
exactly since I did a kernel upgrade quite often, but I think it worked
from 2.6.0-2.6.10).

----------------------------------------------------------------------
 wouter - 07-17-06 16:01 
----------------------------------------------------------------------
Kernel 2.6.17.5 on VIA Epia M10000 (Nehemiah), still no sound whatsoever.

dmesg output:

ALSA sound/pci/ac97/ac97_codec.c:1972: AC'97 0 analog subsections not
ready
ALSA sound/usb/usbaudio.c:2689: 2:2:1: add audio endpoint 0x83
ALSA sound/usb/usbmixer.c:945: [2] FU [Mic Capture Switch] ch = 1, val =
0/1/1
ALSA sound/usb/usbmixer.c:388: cannot set ctl value: req = 0x4, wValue =
0x200, wIndex = 0x201, type = 4, data = 0x80/0x0
ALSA sound/usb/usbmixer.c:945: [2] FU [Mic Capture Volume] ch = 1, val =
-14080/0/256
ALSA sound/usb/usbmixer.c:945: [2] FU [Auto Gain Control] ch = 1, val =
0/1/1
usbcore: registered new driver snd-usb-audio
ALSA device list:
  #0: VIA 8235 with VT1616i at 0xe400, irq 10
  #1: Camera at usb-0000:00:10.0-2, full speed

The only way you can get any indication that the headphones are working,
is to toggle the "External Amplifier" switch -- you hear a very vague
click. Anything else, be it playing mp3s or wavs, toggling switches, using
different mixer settings or trying any physical audio in- and output,
doesn't lead anywhere.

This board is effectively mute.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-05 12:22 shensche       New Issue                                    
06-27-05 12:22 shensche       File Added: asound.conf                      
06-27-05 12:22 shensche       Distribution              => Debian (derived
Knoppix->Morphix->Kunnafonix)
06-27-05 12:22 shensche       Kernel Version            => 2.6.11.12, but also
many other 2.4 and 2.6 kernels
06-27-05 12:23 shensche       File Added: asound.state                     
06-27-05 12:27 shensche       File Added: dmesg.full                       
06-27-05 12:27 shensche       File Added: dmesg.oss                        
06-27-05 12:28 shensche       File Added: lspci                            
06-27-05 12:29 shensche       Issue Monitored: shensche                    
06-27-05 12:36 shensche       Issue End Monitor: shensche                    
06-28-05 11:31 shensche       File Added: proc_asound_card0_codec97#_ac97#0-0   
                
06-28-05 11:32 shensche       File Added:
proc_asound_card0_codec97#_ac97#0-0+regs                    
06-28-05 11:32 shensche       File Added: proc_asound_card0_via82xx             
      
06-28-05 11:32 shensche       File Added: proc_asound_cards                    
06-28-05 11:33 shensche       File Added: proc_asound_version                   

06-28-05 12:02 shensche       Note Added: 0005296                          
06-28-05 20:19 shensche       Note Added: 0005300                          
06-29-05 20:16 tiwai          Note Added: 0005310                          
07-01-05 12:07 shensche       Note Added: 0005329                          
07-01-05 12:11 shensche       Note Added: 0005330                          
07-07-05 19:07 shensche       Note Added: 0005401                          
07-08-05 11:46 tiwai          Note Added: 0005408                          
07-08-05 12:34 shensche       Note Added: 0005419                          
07-21-05 17:29 shensche       Note Added: 0005539                          
06-02-06 09:52 wouter         Note Added: 0010046                          
06-03-06 15:50 picobyte       Note Added: 0010061                          
07-17-06 16:01 wouter         Note Added: 0011041                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
