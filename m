From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001365]: Dell/Creative Labs Audigy 2
	ZS: No capture control
Date: Sun, 30 Jul 2006 18:10:11 +0200
Message-ID: <d749fcf21531a36f2cb7cce1ffbb709f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A50616C
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 18:10:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1365> 
======================================================================
Reported By:                phineas
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1365
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Debian testing (etch)
Kernel Version:             2.6.12.4 vanilla
======================================================================
Date Submitted:             08-24-2005 09:22 CEST
Last Modified:              07-30-2006 18:10 CEST
======================================================================
Summary:                    Dell/Creative Labs Audigy 2 ZS: No capture control
Description: 
Unless this is a user overlooking a step...

There is no mute control on the "Master" item (or most other items for
that matter).
More importantly, the capture items do not have a capture control; they
have level adjustments, but one cannot actually select an item for
capturing.
It appears that this Dell-supplied device (with Audigy subsytem 1003) is
generally unknown to the drivers -- but it does work well for sound
playback.

======================================================================

----------------------------------------------------------------------
 phineas - 12-14-05 23:03 
----------------------------------------------------------------------
The code segment posted by pzad works as provided with alsa included with
debian kernel 2.6.14.

Could someone apply the definition posted by pzad as a patch to CVS?


$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).

$ cat /proc/asound/cards   
0 [Audigy2        ]: Audigy2 - Audigy 2 ZS [SB0353]
                     Audigy 2 ZS [SB0353] (rev.4, serial:0x10031102) at
0xccc0, irq 17

----------------------------------------------------------------------
 jcdutton - 07-30-06 18:10 
----------------------------------------------------------------------
Can you please confirm what is says on the actual PCI card?
SB0353 or SB0253.

Can you also list what you tested. Just saying it worked is not very
detailed.
E.g.
Speaker outputs for front, rear, center/lfe and side work.
Mic input works
Line input works.

If you did not test everything, just say "not tested" next to it.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 09:22 phineas        New Issue                                    
08-24-05 09:22 phineas        File Added: vegan.state                      
08-24-05 09:22 phineas        Distribution              => Debian testing (etch)
08-24-05 09:22 phineas        Kernel Version            => 2.6.12.4 vanilla
08-24-05 20:58 phineas        Issue Monitored: phineas                     
08-25-05 17:11 pzad           Note Added: 0005941                          
08-26-05 22:04 phineas        Note Added: 0005958                          
09-17-05 18:54 jdthood        Summary                  Dell/Creative Labs Audigy
2 ZS mixer controls => Dell/Creative Labs Audigy 2 ZS: No capture control
12-14-05 23:03 phineas        Note Added: 0007043                          
07-18-06 14:43 jcdutton       Status                   new => assigned     
07-18-06 14:43 jcdutton       Assigned To               => jcdutton        
07-30-06 18:10 jcdutton       Note Added: 0011322                          
07-30-06 18:10 jcdutton       Status                   assigned => feedback
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
