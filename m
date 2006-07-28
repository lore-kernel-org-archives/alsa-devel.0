From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002309]: No matter what I try,
	I cannot get sound from the machine on Linux
Date: Fri, 28 Jul 2006 20:39:45 +0200
Message-ID: <c476cc620ed262db2749e96350309eda@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 151E8152
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 20:39:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2309> 
======================================================================
Reported By:                ronware
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2309
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Frugalware 0.4
Kernel Version:             2.6.17
======================================================================
Date Submitted:             07-28-2006 20:14 CEST
Last Modified:              07-28-2006 20:39 CEST
======================================================================
Summary:                    No matter what I try, I cannot get sound from the
machine on Linux
Description: 
Installed Frugalware Linux (kernel 2.6.17) on new laptop, Acer Aspire
1642ZWLCi.    Everything works except the sound.  Downloaded the RC3 build
of alsa drivers etc. to see if that would fix the problem, based on posts
I've read.  No go.

The snd_hda_intel driver is loaded, and alsamixer is able to function, but
no sound comes out (nothing is muted), neither from the speakers nor from
the earphones.

I've successfully got sound working under the same kernel on two other
Acer machines; unfortunately Acer likes to play with new hardware, so the
other machines have different sound chips than this one does.
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-28-06 20:39 
----------------------------------------------------------------------
RC3?  The latest ALSA version is 1.0.12-rc1.

Did you try the various model options described in ALSA-Configuration.txt?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-28-06 20:14 ronware        New Issue                                    
07-28-06 20:14 ronware        Distribution              => Frugalware 0.4  
07-28-06 20:14 ronware        Kernel Version            => 2.6.17          
07-28-06 20:39 rlrevell       Note Added: 0011288                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
