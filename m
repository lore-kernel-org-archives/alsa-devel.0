From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001213]: snd-via82xx on EPIA-M - 0 analog subsections not ready: no sound
Date: Fri, 1 Jul 2005 12:11:53 +0200
Message-ID: <2b2660fcf073d90c9e229f0e9f626214@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 86AD4186
	for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2005 12:11:53 +0200 (MEST)
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
Last Modified:              07-01-2005 12:11 CEST
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
 shensche - 07-01-05 12:07 
----------------------------------------------------------------------
- tried with 2.6.12-ck3 (ALSA 1.0.9rc2): no success

----------------------------------------------------------------------
 shensche - 07-01-05 12:11 
----------------------------------------------------------------------
- tried again with ALSA 1.0.8 (shipped with 2.6.11), all 4 VIA DXS channels
are at maximum. tried with module option dxs_support from 0 to 4: no
success.
- i recompiled 1.0.9 with debug support. any more info i can provide?

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
