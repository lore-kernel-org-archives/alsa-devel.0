From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001822]: Can't record with Hercules
	Fortissimo II
Date: Sat, 15 Jul 2006 09:13:53 +0200
Message-ID: <8ff124447878a4447fa5cfe2ecfeb72a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 62864226
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 09:13:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1822> 
======================================================================
Reported By:                atler
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1822
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               PLD
Kernel Version:             2.6.14.7
======================================================================
Date Submitted:             02-05-2006 16:16 CET
Last Modified:              07-15-2006 09:13 CEST
======================================================================
Summary:                    Can't record with Hercules Fortissimo II
Description: 
I can hear my voice from speakers but "arecord -f cd -t wav out.wav" always
produces 19K-32K file with no sound. What is weird is that I can record
through alsa oss emulation in programs that use /dev/dsp.
Similar problems already appeard here, but none of the solutions worked
for me.
======================================================================

----------------------------------------------------------------------
 atler - 07-14-06 22:28 
----------------------------------------------------------------------
Changing period size does nothing, even in verbose output the period_size
is constantly 512 (with -Dhw:0,0 switch however, it changes until value of
512, with 1024 and 2048 it's still 512).

Example codes you mentioned run fine, but I don't know what should I
expect or what to look at.

----------------------------------------------------------------------
 Raymond - 07-15-06 09:13 
----------------------------------------------------------------------
The old cs46xx driver support stereo playback and the new cs46xx driver
support multi-channels playback and hardware mixing.

cat /proc/asound/pcm

Does the example latency.c work ? (playback/capture)

Remove .asoundrc

Post the complete output of 

arecord -v -f cd -d 10 test.wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 16:16 atler          New Issue                                    
02-05-06 16:16 atler          File Added: asound.state                     
02-05-06 16:16 atler          Distribution              => PLD             
02-05-06 16:16 atler          Kernel Version            => 2.6.14.7        
02-05-06 16:19 atler          Note Added: 0007937                          
02-07-06 16:30 perex          Note Added: 0007959                          
02-11-06 20:47 atler          Note Added: 0008021                          
07-11-06 16:24 Raymond        Note Added: 0010974                          
07-11-06 16:28 Raymond        Note Edited: 0010974                         
07-14-06 22:28 atler          Note Added: 0011007                          
07-15-06 09:13 Raymond        Note Added: 0011019                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
