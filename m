From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002309]: No matter what I try,
	I cannot get sound from the machine on Linux
Date: Fri, 28 Jul 2006 22:43:51 +0200
Message-ID: <97fabaa3886bf3514145464774467426@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE2EA181
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 22:43:51 +0200 (MEST)
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
Last Modified:              07-28-2006 22:43 CEST
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
 rlrevell - 07-28-06 22:29 
----------------------------------------------------------------------
You must not be passing the model options correctly, otherwise it would not
say "trying auto-probe".

Try manually removing the module and loading it with "modprobe
snd-hda-intel model=xxx".  Repeat with each value of xxx listed for ALC882
in ALSA-Configuration.txt.

----------------------------------------------------------------------
 ronware - 07-28-06 22:43 
----------------------------------------------------------------------
That is what I did.  I manually did "modprobe snd_hda_intel model=xxx" for
the various models.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-28-06 20:14 ronware        New Issue                                    
07-28-06 20:14 ronware        Distribution              => Frugalware 0.4  
07-28-06 20:14 ronware        Kernel Version            => 2.6.17          
07-28-06 20:39 rlrevell       Note Added: 0011288                          
07-28-06 21:32 ronware        Note Added: 0011291                          
07-28-06 22:29 rlrevell       Note Added: 0011292                          
07-28-06 22:43 ronware        Note Added: 0011293                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
