From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002217]: Problems with ASUS A6Km
Date: Fri, 23 Jun 2006 15:27:45 +0200
Message-ID: <ce089ce418db9eb190c8e075201aea35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 926F721D
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 15:27:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2217> 
======================================================================
Reported By:                mafm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2217
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-18-2006 05:06 CEST
Last Modified:              06-23-2006 15:27 CEST
======================================================================
Summary:                    Problems with ASUS A6Km
Description: 
I have the same problems described here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898 , but I'm
opening a new report because I can't find a way to add a comment there.

I tried that asus-a6km-fix.diff but it doesn't work, in fact it doesn't
appear to have any effect at all.
======================================================================

----------------------------------------------------------------------
 mafm - 06-22-06 00:10 
----------------------------------------------------------------------
With 1.0.12-rc1, same problems, it doesn't appear to happen anything at
all.

It's the first time that I compile ALSA by hand, so don't know if this is
correct, by I only compiled and installed alsa-driver module, is that
correct? Or do I also need the libraries and other stuff, or that
alsa-kernel repository?

The output of the following commands is the same as before, just that it
uses 1.0.12-rc1.

dmes:
[   29.136132] intel8x0_measure_ac97_clock: measured 59453 usecs
[   29.136250] intel8x0: clocking to 48000

cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v1.0.12rc1 emulation code)
Kernel: Linux cernunnos 2.6.17 #1 PREEMPT Wed Jun 21 23:17:53 CEST 2006
x86_64
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
SiS SI7012 with ALC650F at 0xe400, irq 11

Audio devices:
0: SiS SI7012 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
31: system timer

Mixers:
0: Realtek ALC650F

----------------------------------------------------------------------
 mafm - 06-23-06 15:27 
----------------------------------------------------------------------
I got it working just by enabling External Amplifier (not messing up with
registers, 3D surround or other stuff; that some comments to other bug
reports talk about).

Note that the alsamixer interface is a bit confusing: it's a switch, so
"MM" means muted, and when enabled shows "00" (when using alsamixer I
thought that it was another regular slider, so since I could only get it
to show MM or 00 I thought that it was another symptom of the driver not
setting up the device properly).

I'm still using 1.0.12-rc1, but since I prefer to use kernels without
additions (so substituting them for new ones is easier), I'll try to get
it working with 2.6.17 (which needs that small patch only, and has alsa
1.0.11-rc4 or so).  I'll post here whether it works or not.

eNTi: could you please check if this fixes your problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 05:06 mafm           New Issue                                    
06-18-06 16:51 ryswic         Issue Monitored: ryswic                      
06-19-06 15:49 mafm           Issue Monitored: mafm                        
06-19-06 15:50 mafm           Note Added: 0010315                          
06-20-06 19:46 tiwai          Note Added: 0010345                          
06-20-06 20:16 mafm           Note Added: 0010354                          
06-21-06 21:37 eNTi           Note Added: 0010405                          
06-21-06 22:24 rlrevell       Note Added: 0010406                          
06-21-06 22:33 mafm           Note Added: 0010407                          
06-21-06 22:48 eNTi           Note Added: 0010408                          
06-22-06 00:10 mafm           Note Added: 0010410                          
06-23-06 15:27 mafm           Note Added: 0010451                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
