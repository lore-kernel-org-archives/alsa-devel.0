From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002087]: Audio still broken for Asus A8V-MX
Date: Fri, 5 May 2006 21:30:34 +0200
Message-ID: <33dadace80e618dc1d643553c91c08f9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4BAD18C
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2006 21:30:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2087> 
======================================================================
Reported By:                myxie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2087
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-30-2006 23:33 CEST
Last Modified:              05-05-2006 21:30 CEST
======================================================================
Summary:                    Audio still broken for Asus A8V-MX
Description: 
The patches integrated (see issue 0001622) into the latest release of ALSA
make the on-board audio more usuable, but there are still significant
issues.

Playing an audio file results in a freeze for 10 seconds, followed by a
write error and then the audio continues normally. I noticed a second
write error later on in the stream.

I am happy to try patches, turn on debugging flags etc. Let me know.

======================================================================

----------------------------------------------------------------------
 karsten - 05-05-06 20:59 
----------------------------------------------------------------------
if this is for a VIA K8T800 chipset, irq's look weired:
That VIA8237 Southbridge has all USB (usb1 to usb5) interrupts on the same
fixed interrupt line, when IO-APIC is used.
Here (rt kernel, single cpu) /proc/interrupts looks like:

  0:   11453807  IO-APIC-edge   [........N/  0]  pit
  1:      10513  IO-APIC-edge   [........./  0]  i8042
  4:         16  IO-APIC-edge   [........./  4]  serial
  7:          2  IO-APIC-edge   [..P....../  0]  parport0
  9:          0  IO-APIC-level  [........./  0]  acpi
 12:     573205  IO-APIC-edge   [........./  0]  i8042
 14:     135570  IO-APIC-edge   [........./  0]  ide0
 15:     741608  IO-APIC-edge   [........./  0]  ide1
 17:    1441592  IO-APIC-level  [........./  0]  nvidia, eth0
 18:        595  IO-APIC-level  [........./  0]  VIA8237
 19:    5241193  IO-APIC-level  [........./  0]  ehci_hcd:usb1,
uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5

please post lspci.

----------------------------------------------------------------------
 myxie - 05-05-06 21:30 
----------------------------------------------------------------------
It's a VT8251.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-30-06 23:33 myxie          New Issue                                    
04-30-06 23:33 myxie          Distribution              => Debian          
04-30-06 23:33 myxie          Kernel Version            => 2.6.16          
05-02-06 17:57 tiwai          Note Added: 0009562                          
05-05-06 18:40 myxie          Note Added: 0009628                          
05-05-06 19:58 myxie          File Added: lsof.ogg123                      
05-05-06 19:58 myxie          File Added: lsof.mplayer                     
05-05-06 19:59 myxie          Note Added: 0009629                          
05-05-06 20:59 karsten        Note Added: 0009630                          
05-05-06 21:29 myxie          File Added: lspci.txt                        
05-05-06 21:30 myxie          Note Added: 0009631                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
