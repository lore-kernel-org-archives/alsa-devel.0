From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002076]: arecord gives silence
Date: Wed, 26 Apr 2006 16:28:52 +0200
Message-ID: <0d9a781d9ecda2f25f7fda71ccbec278@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EB7B3170
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 16:28:52 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2076> 
======================================================================
Reported By:                jaime
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2076
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-26-2006 16:28 CEST
Last Modified:              04-26-2006 16:28 CEST
======================================================================
Summary:                    arecord gives silence
Description: 
IBM Thinkpad T21 with Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion
Audio Accelerator] (rev 01).

alsamixer correctly mixes the inputs over to the line out (I can hear
microphone in and line in successfully mixed) but arecord gives silence.

I've tried using a usb soundcard on the same machine, and everything works
fine there, so I think this is only the snd-cs46xx driver.

I'm not sure what other info is useful - please let me know. Thank you.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 16:28 jaime          New Issue                                    
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
