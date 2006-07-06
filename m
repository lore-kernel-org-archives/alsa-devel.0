From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000952]: System freeze at end of MIDI
	playback
Date: Thu, 6 Jul 2006 10:14:07 +0200
Message-ID: <b07ed1509740daa8b12e8695131ab9d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF366227
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 10:14:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=952> 
======================================================================
Reported By:                skunk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   952
Category:                   PCI - emu10k1
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.8-2-k7
======================================================================
Date Submitted:             03-01-2005 06:28 CET
Last Modified:              07-06-2006 10:14 CEST
======================================================================
Summary:                    System freeze at end of MIDI playback
Description: 
Hardware: Sound Blaster Live! Value
Software: sfxload (for patch loading) and drvmidi (playback)

I often play a list of MIDI files. On a number of occasions---either at
the end of a MIDI song, or when I hit STOP---the computer has frozen hard.
The recurrence is rare enough to make this more an annoyance than a
showstopper, but then, I haven't been too keen on ferreting out this bug.

I am reporting this against ALSA from the 2.6.8 kernel, as that is what
I'm using now (Debian official package) but the same problem arose with
alsa-driver 1.0.8 (as compiled by me) on 2.4.29.

I could probably rig up something to start/stop MIDI playback repeatedly,
with a debug-compiled driver, but is there any way to get useful debugging
output when the bug takes the whole system down?
======================================================================

----------------------------------------------------------------------
 amarsh04 - 07-06-06 09:30 
----------------------------------------------------------------------
OK, to summarise building ALSA modules for my soundcard under kernel
2.6.17:

I downloaded the following from incoming.debian.org (now in Debian
unstable aka Sid):

alsa-base_1.0.11-3_all.deb         linux-sound-base_1.0.11-3_all.deb
alsa-source_1.0.11-3_all.deb

With linux-source-2.6.17 already installed, it was fairly 
straightforward to compile a new set of ALSA modules for the 2.6.17 by 
following the instructions installed to 
/usr/share/doc/alsa-source/README.Debian, roughly (logged in as root 
rather than using fakeroot):

   # cd /usr/src
   # rm -rf modules/alsa-driver
   # tar jxf alsa-driver.tar.bz2
   # dpkg-reconfigure alsa-source

I picked out my sound card rather than build for all sound cards.

   # cd /usr/src/linux-source-2.6.17
   # make-kpkg --append-to-version=-1-686 modules-image
   # cd ..
   # dpkg -i alsa-modules-2.6.17-1-686*.deb

Arthur.

----------------------------------------------------------------------
 amarsh04 - 07-06-06 10:14 
----------------------------------------------------------------------
After installing new ALSA modules, don't forget to reload the soundfonts!

E.G.

asfxload /usr/share/sounds/sf2/8mbgmsfx.sf2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-05 06:28 skunk          New Issue                                    
03-01-05 06:28 skunk          Distribution              => Debian testing  
03-01-05 06:28 skunk          Kernel Version            => 2.6.8-2-k7      
09-19-05 10:10 jdthood        Note Added: 0006287                          
09-19-05 10:19 skunk          Note Added: 0006290                          
04-23-06 07:57 skunk          Note Added: 0009441                          
06-07-06 18:09 pen            Note Added: 0010085                          
06-07-06 18:09 pen            Issue Monitored: pen                         
06-07-06 18:23 rlrevell       Note Added: 0010086                          
06-07-06 19:45 pen            Note Added: 0010087                          
06-07-06 19:50 rlrevell       Note Added: 0010088                          
06-08-06 09:28 skunk          Note Added: 0010109                          
06-27-06 23:35 phorn          File Added: kernel_spinlock-2.6.17.1-nosmp.txt    
               
06-27-06 23:43 phorn          Note Added: 0010602                          
06-28-06 00:03 rlrevell       Note Added: 0010603                          
06-28-06 03:50 phorn          Note Added: 0010605                          
07-02-06 15:33 amarsh04       Issue Monitored: amarsh04                    
07-02-06 15:37 amarsh04       Note Added: 0010791                          
07-02-06 20:07 riesebie       Issue Monitored: riesebie                    
07-03-06 02:57 amarsh04       Note Added: 0010796                          
07-03-06 18:04 rlrevell       File Added: alsa-timer-irqsave.patch              
     
07-03-06 18:05 rlrevell       Note Added: 0010801                          
07-03-06 20:24 riesebie       Note Added: 0010806                          
07-03-06 20:25 riesebie       Note Edited: 0010806                         
07-04-06 03:23 amarsh04       Note Added: 0010813                          
07-04-06 04:58 phorn          Note Added: 0010814                          
07-04-06 07:20 amarsh04       Note Added: 0010816                          
07-04-06 17:07 rlrevell       Note Added: 0010821                          
07-04-06 17:46 amarsh04       Note Added: 0010822                          
07-04-06 17:53 rlrevell       Note Added: 0010823                          
07-04-06 17:56 rlrevell       Note Added: 0010824                          
07-04-06 19:32 crimsunkg      Note Added: 0010825                          
07-05-06 05:34 amarsh04       Note Added: 0010831                          
07-05-06 09:32 riesebie       Note Added: 0010833                          
07-05-06 13:20 amarsh04       Note Added: 0010835                          
07-06-06 09:30 amarsh04       Note Added: 0010856                          
07-06-06 10:14 amarsh04       Note Added: 0010858                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
