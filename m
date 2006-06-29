From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002076]: arecord gives silence
Date: Thu, 29 Jun 2006 03:29:41 +0200
Message-ID: <a42388f7b922d7a6b728d9160b3ff924@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4FF1928B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 03:29:41 +0200 (MEST)
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
Last Modified:              06-29-2006 03:29 CEST
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

----------------------------------------------------------------------
 atler - 05-08-06 12:14 
----------------------------------------------------------------------
It also seems to be the case in this bugreport:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1822

Recording with 'arecord -v -v -Dhw:0,0 -f cd test.wav' works fine.

----------------------------------------------------------------------
 Raymond - 06-29-06 03:29 
----------------------------------------------------------------------
Try the following test and post the output including the setup line output
by arecord

arecord -v -Dhw:0,0 -f cd test1.wav

arecord -v -Dplughw:0,0 -f cd test2.wav

arecord -v -f cd test3.wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 16:28 jaime          New Issue                                    
05-02-06 18:11 tiwai          Note Added: 0009568                          
05-04-06 12:11 jaime          Note Added: 0009613                          
05-08-06 12:14 atler          Note Added: 0009645                          
05-24-06 14:03 fuman          Issue Monitored: fuman                       
06-29-06 03:29 Raymond        Note Added: 0010638                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
