From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000981]: I don't get any sound on nforce 3 (AMD64 plataform).
Date: Tue, 9 Aug 2005 13:44:46 +0200
Message-ID: <c2e7c54f481bbe53071856505ca53d1b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9F57B1C9
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:46 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=981> 
======================================================================
Reported By:                soulhunter
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   981
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian and Gentoo.
Kernel Version:             2.6.11
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-12-2005 01:48 CET
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    I don't get any sound on nforce 3 (AMD64 plataform).
Description: 
>From kernel version 2.6.9 and up I don't get any sound.  I currently use
2.6.8.1 (where the sound works just fine).

I even tried to compile 2.6.11 with only snd_intel8x0 as module: nothing.

I have no idea what is going on, yes I looked at the volume settings, and
unmuted the master and pcm channels.  The sound application seems to be
"playing", but I get no sound.

My motherboard is a Chaintech VNF250.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:00 
----------------------------------------------------------------------
This could have something to do with the index numbers assigned to the
drivers.  Please send the output of /proc/asound/cards.  Are you sure you
are directing sound output to the right card?

----------------------------------------------------------------------
 soulhunter - 05-16-05 21:49 
----------------------------------------------------------------------
Ok, I just solved this.  The problem went away when I muted the IEC58
(something like that) Input Capture in alsamixer..... The weird thing is
that it worked "out-of-the-box" in 2.6.8.1 and from 2.6.9 I had the
problem, I verified the problem gone in 2.6.11.

Sorry that I took so long to post this, I was offline.

Please, somebody close this bug.

Thanks for maintaining this great software.

Sincerely,

Ildefonso Camargo.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 01:48 soulhunter     New Issue                                    
03-12-05 01:48 soulhunter     Distribution              => Debian and Gentoo.
03-12-05 01:48 soulhunter     Kernel Version            => 2.6.11          
03-16-05 13:03 tiwai          Note Added: 0003953                          
03-23-05 16:00 jdthood        Note Added: 0004168                          
05-16-05 21:49 soulhunter     Note Added: 0004677                          
05-16-05 22:41 jdthood        Status                   new => resolved     
05-16-05 22:41 jdthood        Resolution               open => fixed       
05-16-05 22:41 jdthood        Assigned To               => jdthood         
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
