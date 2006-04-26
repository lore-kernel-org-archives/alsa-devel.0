From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002027]: No sound on AD1986A (ASUS Laptop, Z62F)
Date: Wed, 26 Apr 2006 16:19:03 +0200
Message-ID: <cf97b90204c8a75b9896b03c47c87952@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87763170
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 16:19:03 +0200 (MEST)
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
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-gentoo-r2
======================================================================
Date Submitted:             04-17-2006 08:00 CEST
Last Modified:              04-26-2006 16:19 CEST
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
 rcubed - 04-26-06 16:02 
----------------------------------------------------------------------
I have the Z62F with Fedora Core 5 and have the same problems.  I am
uploading my codec#0 and codec#1 files.  Currently running Advanced Linux
Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006
UTC).

I have recently tried 1.0.11 with same results.

----------------------------------------------------------------------
 tiwai - 04-26-06 16:19 
----------------------------------------------------------------------
Did you try mdoel=laptop and model=laptop-eapd option?

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
