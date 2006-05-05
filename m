From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002087]: Audio still broken for Asus A8V-MX
Date: Fri, 5 May 2006 19:59:28 +0200
Message-ID: <9139228d0f56848e55fa484000c4a056@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8185817C
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2006 19:59:28 +0200 (MEST)
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
Last Modified:              05-05-2006 19:59 CEST
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
 myxie - 05-05-06 18:40 
----------------------------------------------------------------------
This is my

==> /proc/interrupts <==
           CPU0       CPU1       
  0:    1052928  414836302    IO-APIC-edge  timer
  1:        453     135144    IO-APIC-edge  i8042
  7:          0          2    IO-APIC-edge  parport0
  8:       2194     522246    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:       1342     402817    IO-APIC-edge  i8042
 14:          0         67    IO-APIC-edge  ide0
193:          0          0   IO-APIC-level  uhci_hcd:usb4
201:   38946417          0         PCI-MSI  libata
209:       2260    1441848   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb3,
VIA8237
217:          0          0   IO-APIC-level  uhci_hcd:usb2
225:      76836  100930699   IO-APIC-level  uhci_hcd:usb5, eth0
NMI:      55961      63711 
LOC:  415838586  415838509 
ERR:          0
MIS:          0

As soon as I start (ogg123), the interrupt count goes up. During the 10
second gap the count is static. After the I/O error the count increases
steadily again. FYI 385 interrupts were generated in the first burst of
activity.

----------------------------------------------------------------------
 myxie - 05-05-06 19:59 
----------------------------------------------------------------------
It's interesting to note that mplayer does not exhibit the same problem.
strace shows it to be using ioctls on /dev/snd/pcmC0D0p rather than the
FUTEXs of aplay and ogg123.

Both aplay and mplayer use /usr/lib/libasound.so.2.0.0 .

I've attaching a couple of lsof showing libraries etc. in use.

Hope this sheds more light.

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
