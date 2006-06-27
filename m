From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002233]: No sound on speakers,
	low volume on the headphones, Samsung X60 Chane
Date: Tue, 27 Jun 2006 12:35:48 +0200
Message-ID: <8f52202e159582b2466c1488b1f0c1c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF7CB267
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 12:35:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2233> 
======================================================================
Reported By:                max
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2233
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               suse 10.1
Kernel Version:             2.6.16.13-4
======================================================================
Date Submitted:             06-26-2006 12:17 CEST
Last Modified:              06-27-2006 12:35 CEST
======================================================================
Summary:                    No sound on speakers, low volume on the headphones,
Samsung X60 Chane
Description: 
installation ok. (82801G)
but
no sound on speakers 
low volume on the headphones and sometimes a verry high frequenz...

thanks for help

======================================================================

----------------------------------------------------------------------
 tiwai - 06-27-06 12:12 
----------------------------------------------------------------------
Not yet to close.  Please provide the output of "lspci -nv" (only for class
0403) so that your device will be set up correctly without extra module
option.

----------------------------------------------------------------------
 max - 06-27-06 12:35 
----------------------------------------------------------------------
00:1b.0 Class 0403: 8086:27d8 (rev 02)
	Subsystem: 144d:c023
	Flags: bus master, fast devsel, latency 0, IRQ 74
	Memory at d4a40000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
	Capabilities: [70] Express Unknown type IRQ 0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-06 12:17 max            New Issue                                    
06-26-06 12:17 max            Distribution              => suse 10.1       
06-26-06 12:17 max            Kernel Version            => 2.6.16.13-4     
06-26-06 12:20 max            Note Added: 0010527                          
06-26-06 12:21 max            Note Added: 0010528                          
06-26-06 12:23 max            Note Added: 0010529                          
06-26-06 12:24 max            Note Added: 0010530                          
06-26-06 16:00 tiwai          Note Added: 0010538                          
06-27-06 09:35 max            Note Added: 0010571                          
06-27-06 12:12 tiwai          Note Added: 0010581                          
06-27-06 12:35 max            Note Added: 0010586                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
