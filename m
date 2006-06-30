From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001782]: really poor sound with my SB
	Live 1024 and ALSA
Date: Fri, 30 Jun 2006 18:09:46 +0200
Message-ID: <1d10949338f3db0e15c328f642d6c995@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 271E029A
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 18:09:47 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1782> 
======================================================================
Reported By:                novazur
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1782
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo
Kernel Version:             all what I tried, actually 2.6.15-1
======================================================================
Date Submitted:             01-25-2006 06:30 CET
Last Modified:              06-30-2006 18:09 CEST
======================================================================
Summary:                    really poor sound with my SB Live 1024 and ALSA
Description: 
Each time I tried to use ALSA with my SB Live, I always had a really very
bad sound.
I spent hours and hours to make it working better, but always had to come
back to OSS. And, with OSS, I have a real perfect sound, on my 5.1 Altec
Lansing kit.

I'm afraid now to see OSS will definitively be removed from kernel.

My english is too poor too, to explain exactly what I mean by "poor
sound", but I can tell you the sound isn't good at all with ALSA and my
card.


00:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
0a)
        Subsystem: Creative Labs SBLive! 5.1 Digital Model SB0220
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1

======================================================================

----------------------------------------------------------------------
 jcdutton - 06-30-06 18:09 
----------------------------------------------------------------------
Please provide more information.
1) Which application are you using that produce bad sound with ALSA, but
good sound with OSS.

And the output from the following commands:
2) cat /proc/asound/cards
3) cat /proc/asound/version
4) amixer


Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-06 06:30 novazur        New Issue                                    
01-25-06 06:30 novazur        Distribution              => Gentoo          
01-25-06 06:30 novazur        Kernel Version            => all what I tried,
actually 2.6.15-1
01-25-06 18:58 Adrian Bunk    Issue Monitored: Adrian Bunk                    
06-30-06 18:09 jcdutton       Note Added: 0010748                          
06-30-06 18:09 jcdutton       Assigned To               => jcdutton        
06-30-06 18:09 jcdutton       Status                   new => feedback     
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
