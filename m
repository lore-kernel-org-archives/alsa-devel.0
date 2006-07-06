From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002183]: Silence on riptide card
Date: Thu, 6 Jul 2006 16:21:32 +0200
Message-ID: <9ea06ae90e33fd1b3fa3c2cf6bbfe1e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B5F3A25F
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 16:21:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2183> 
======================================================================
Reported By:                Hawk777
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2183
Category:                   PCI - riptide
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             Linux hp 2.6.16-gentoo-r7 #8 Thu Jun 1 22:10:53 PDT
2006 i686 Celeron (Mendocino) GNU/Linux
======================================================================
Date Submitted:             06-02-2006 21:03 CEST
Last Modified:              07-06-2006 16:21 CEST
======================================================================
Summary:                    Silence on riptide card
Description: 
The summary says it all: everything works perfectly, except that no matter
what I do, no sound ever comes out. I've tried the CVS version from
SourceForge as well as 1.0.11: same result.

I have some programming skill (though little experience in drivers); I can
work with you to debug this.
======================================================================

----------------------------------------------------------------------
 Hawk777 - 06-02-06 21:21 
----------------------------------------------------------------------
Oh, one thing I forgot to mention. I downloaded Linuxant's drivers for this
card, hacked them a little to make them load on a 2.6 kernel, and they
work properly (they also force firmware loading to the card, which I
notice your driver doesn't since the card reports already having firmware)
(the Linuxant drivers are for OSS). I also, some years ago, tried a trial
version of the commercial OSS which included drivers for Riptide, and they
had the same problem: everything worked, but no sound.

----------------------------------------------------------------------
 nokos - 07-06-06 16:21 
----------------------------------------------------------------------
Can you include the contents of /proc/asound/card0/riptide
while playing (multiple) streams and/or recording?
is there a difference if xou play 44100 Hz streams in comparison to
48000 Hz signed 16bit Little Endian streams.
(They take different paths through the sound HW)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-06 21:03 Hawk777        New Issue                                    
06-02-06 21:03 Hawk777        Distribution              => Gentoo          
06-02-06 21:03 Hawk777        Kernel Version            => Linux hp
2.6.16-gentoo-r7 #8 Thu Jun 1 22:10:53 PDT 2006 i686 Celeron (Mendocino)
GNU/Linux
06-02-06 21:16 Hawk777        Issue Monitored: Hawk777                     
06-02-06 21:21 Hawk777        Note Added: 0010055                          
07-06-06 16:21 nokos          Note Added: 0010867                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
