From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002211]: No sound using snd-hda-intel
	drivers
Date: Fri, 7 Jul 2006 11:22:09 +0200
Message-ID: <b9303b7a7c6e26edfe741faa479b1aa6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EFFB426C
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 11:22:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2211> 
======================================================================
Reported By:                jmclennan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2211
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2133_FC5smp
======================================================================
Date Submitted:             06-15-2006 20:33 CEST
Last Modified:              07-07-2006 11:22 CEST
======================================================================
Summary:                    No sound using snd-hda-intel drivers
Description: 
On a new HP DC7600 dual core Pentium D, sound card is detected, but no
sound from either the front jack, rear jack or even the system speaker.

kernel: 2.6.16-1.2133_FC5smp
alsa-driver version: 1.0.11

Everything is unmuted, alsamixer can turn the volume controls up and down
(all levels set to 100%.)
======================================================================

----------------------------------------------------------------------
 tiwai - 07-06-06 20:29 
----------------------------------------------------------------------
OK, then we'd need new entries for such machines.

Please make sure that model=basic is the best option.  There are different
values for ALC260, for example, model=hp.  See ALSA-Configuration.txt.

Then attach the contents of /proc/asound/card0/codec#* file(s).

Finally, show the output of "lspci -nv" (only for class 0403 device).

After all these are given, I'll be able to add a proper entry to the
driver code...

----------------------------------------------------------------------
 gvidal - 07-07-06 11:22 
----------------------------------------------------------------------
Ok, I tried model=hp but it didn't work. I set it back to model = basic.

I've already upload the file /proc/asound/card0/codec#0
(I have only one codec#* file), and the output of "lspci -nv" 
(only for class 0403 device) is:

00:1b.0 0403: 8086:27d8 (rev 01)
        Subsystem: 103c:3011
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at e04c0000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-06 20:33 jmclennan      New Issue                                    
06-15-06 20:33 jmclennan      File Added: scsound.log                      
06-15-06 20:33 jmclennan      Distribution              => Fedora Core 5   
06-15-06 20:33 jmclennan      Kernel Version            => 2.6.16-1.2133_FC5smp
06-15-06 20:34 jmclennan      Note Added: 0010244                          
06-15-06 20:37 jmclennan      Note Added: 0010245                          
06-20-06 00:38 jmclennan      Note Added: 0010324                          
06-20-06 18:22 gvidal         Note Added: 0010339                          
06-20-06 19:35 tiwai          Note Added: 0010340                          
06-20-06 19:38 gvidal         Note Added: 0010342                          
06-21-06 14:35 jmclennan      Note Added: 0010397                          
06-21-06 14:59 gvidal         Note Added: 0010398                          
06-29-06 18:12 tiwai          Note Added: 0010683                          
06-30-06 11:03 gvidal         Note Added: 0010724                          
07-06-06 20:25 tiwai          Note View State: private: 10245                   

07-06-06 20:25 tiwai          Note View State: public: 10245                    
07-06-06 20:29 tiwai          Note Added: 0010879                          
07-07-06 11:18 gvidal         File Added: codec0                           
07-07-06 11:22 gvidal         Note Added: 0010903                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
