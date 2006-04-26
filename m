From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002027]: No sound on AD1986A (ASUS Laptop, Z62F)
Date: Wed, 26 Apr 2006 17:52:43 +0200
Message-ID: <d64ab120fc05dc943d059f2ec31f8deb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8E3EA184
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 17:52:43 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2027> 
======================================================================
Reported By:                jaidormi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2027
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.16-gentoo-r2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-17-2006 08:00 CEST
Last Modified:              04-26-2006 17:52 CEST
======================================================================
Summary:                    No sound on AD1986A (ASUS Laptop, Z62F)
Description: 
Actually I am using 1.0.11rc5

I am unable to get any sound output on speakers or headphone jack.  Oddly,
it seems that the IEC958 output works (shared with headphone jack), based
on the fact that it lights up when un-muted.

I have tried a number of model= and position_fix= options with no luck.

On this machine there is a set of stereo speakers, a line-in, mic, and
shared sp-dif/headphone jack.

Is there any output or system info I can provide to help?
======================================================================

----------------------------------------------------------------------
 jaidormi - 04-26-06 17:35 
----------------------------------------------------------------------
You mean this? :

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1043:1297
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at feb3c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

----------------------------------------------------------------------
 tiwai - 04-26-06 17:52 
----------------------------------------------------------------------
Thanks, now fixed on Hg repo.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-06 08:00 jaidormi       New Issue                                    
04-17-06 08:00 jaidormi       Distribution              => Gentoo          
04-17-06 08:00 jaidormi       Kernel Version            => 2.6.16-gentoo-r2
04-17-06 08:04 rlrevell       Note Added: 0009305                          
04-17-06 08:08 jaidormi       Note Added: 0009306                          
04-17-06 08:15 jaidormi       Note Added: 0009307                          
04-17-06 08:15 jaidormi       Note Deleted: 0009306                        
04-20-06 14:47 tiwai          Note Added: 0009377                          
04-20-06 21:38 jaidormi       Note Added: 0009400                          
04-21-06 12:45 tiwai          Note Added: 0009410                          
04-26-06 16:02 rcubed         Note Added: 0009511                          
04-26-06 16:05 rcubed         File Added: codec#0                          
04-26-06 16:05 rcubed         File Added: codec#1                          
04-26-06 16:19 tiwai          Note Added: 0009512                          
04-26-06 16:20 tiwai          Note Added: 0009513                          
04-26-06 17:14 jaidormi       Note Added: 0009516                          
04-26-06 17:20 tiwai          Note Added: 0009517                          
04-26-06 17:35 jaidormi       Note Added: 0009519                          
04-26-06 17:52 tiwai          Status                   assigned => resolved
04-26-06 17:52 tiwai          Resolution               open => fixed       
04-26-06 17:52 tiwai          Note Added: 0009520                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
