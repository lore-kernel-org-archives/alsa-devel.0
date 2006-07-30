From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002286]: SB Audigy LS - no sound from
	line-in
Date: Sun, 30 Jul 2006 18:39:30 +0200
Message-ID: <9dd34b36177ecbea622ee5f664bc3d7f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D86D161
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 18:39:30 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
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
Last Modified:              07-30-2006 18:39 CEST
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
 brazso - 07-16-06 22:18 
----------------------------------------------------------------------
I could restore alsa 1.0.10 with kernel 2.6.15-r8 and with this
configuration the ac97 line (in) works. With alsa 1.0.11 there are more
sliders (line in, mic, phone, aux, CAPTURE, AC97 AUX, AC97 LINE, AC97 MIX
- ones with lowercase exist only in alsa 1.0.11) in the output section of
the mixer, but none of them produces sound from the line in of my audigy
ls card.

----------------------------------------------------------------------
 jcdutton - 07-16-06 23:01 
----------------------------------------------------------------------
Please attach the output of:
amixer scontents


----------------------------------------------------------------------
 brazso - 07-17-06 10:16 
----------------------------------------------------------------------
Thanks for your response, I attached the requested output content. Of
course I tried to switch on the 'Line in' and 'AC97 Line' separately, I
also played with the others without any success on 1.0.11. By the way,
what is the difference between the 2 'line in' sliders? In alsa 1.0.10
mixer there was just 'AC97 Line' slider.

----------------------------------------------------------------------
 jcdutton - 07-30-06 18:39 
----------------------------------------------------------------------
Thank you. This must be a bug in the ALSA driver. I will fix it when I get
a moment.


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
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
