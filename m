From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002286]: SB Audigy LS - no sound from
	line-in
Date: Sun, 30 Jul 2006 23:31:20 +0200
Message-ID: <b320b6e8df665eea428418b03150514c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C9E2178
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 23:31:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2286> 
======================================================================
Reported By:                brazso
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2286
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               
Kernel Version:             2.6.17-r2
======================================================================
Date Submitted:             07-16-2006 12:31 CEST
Last Modified:              07-30-2006 23:31 CEST
======================================================================
Summary:                    SB Audigy LS - no sound from line-in
Description: 
Last time when I used the line-in connector of my SB Audigy LS card a half
year ago, there was no problem with it. By now I wanted to digitalise some
stuff, but my line-in is dumb. Since I often update my gentoo portage tree
included the alsa-drivers, I'm sure that with alsa-driver-1.0.11rc1 dated
on 12/13/05 it still worked. Unfortunately I cannot say more when it went
wrong precisely, because all of my attempts to restore an earlier alsa
version than 1.0.11 were failed. With kernel 2.6.17-r2 alsa 1.0.10,
1.0.11rc1 and 1.0.11rc2 cannot be compiled, and although I could install
alsa 1.0.11rc3, but the mixer did not include my line-in for unknown
reason.

======================================================================

----------------------------------------------------------------------
 jcdutton - 07-30-06 18:39 
----------------------------------------------------------------------
Thank you. This must be a bug in the ALSA driver. I will fix it when I get
a moment.


----------------------------------------------------------------------
 brazso - 07-30-06 23:31 
----------------------------------------------------------------------
It's getting to be more interesting. There is a new ALSA 1.0.12rc1 in the
gentoo portage, I have just installed it. (The kernel was also updated to
2.6.17-r4.) At first there was no change, I have heard nothing on line
in(s). But after I restarted the alsa service manually
(/etc/init.d/alsasound restart), I got sound on AC97 LINE. As for "line
in", it remained deaf. I'm afraid my recorders  (Audacity, KREC) use "line
in", for the time being I could not set them to use "AC97 LINE), but this
problem is not related to ALSA.
There is one weird thing. Alsamixer works correctly, but in KMix (in KDE)
all input volume sliders do not work. Despite I set any of them to a
value, the value of the same object in alsamixer (and amixer) is not
changed. The switch on/off leds are functional, but the volume sliders are
not. However the output volume sliders are correct. It must be some KMix
related problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 12:31 brazso         New Issue                                    
07-16-06 12:31 brazso         Kernel Version            => 2.6.17-r2       
07-16-06 22:18 brazso         Note Added: 0011030                          
07-16-06 23:01 jcdutton       Note Added: 0011031                          
07-16-06 23:01 jcdutton       Status                   assigned => feedback
07-17-06 10:15 brazso         File Added: amixer_scontents.txt                  
 
07-17-06 10:16 brazso         Note Added: 0011037                          
07-30-06 18:39 jcdutton       Note Added: 0011327                          
07-30-06 18:39 jcdutton       Status                   feedback => acknowledged
07-30-06 23:31 brazso         Note Added: 0011333                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
