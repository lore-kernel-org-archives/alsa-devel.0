From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002183]: Silence on riptide card
Date: Fri, 2 Jun 2006 21:21:10 +0200
Message-ID: <ab58b84d167b12b1644f111c04df85fa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 967BB15E
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 21:21:10 +0200 (MEST)
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
Last Modified:              06-02-2006 21:21 CEST
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
======================================================================
