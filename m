From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001365]: Dell/Creative Labs Audigy 2
	ZS: No capture control
Date: Mon, 31 Jul 2006 18:32:11 +0200
Message-ID: <68c7de11162982be5c17a4bb4ef77f25@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3A9AE185
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 18:32:12 +0200 (MEST)
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
Last Modified:              07-31-2006 18:32 CEST
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



----------------------------------------------------------------------
 phineas - 07-31-06 18:32 
----------------------------------------------------------------------
The card is etched with "SB0350" and the stickers on the back also say
"SB0350"
A part list from dell called this a SB0353 -- but I generally don't argue
with what is etched in a board.

I have been happily using the card with alsa 1.0.11rc4 (Wed Mar 22
10:27:24 2006 UTC).  However, the card is still unknown:
$ cat /proc/asound/cards 
 0 [Audigy2        ]: Audigy2 - Audigy 2 [Unknown]
                      Audigy 2 [Unknown] (rev.4, serial:0x10031102) at
0xdcc0, irq 17

I say "happily using" ... here is what little I regularly use, and have
tested:
PCM playback to analog front stereo speakers: works well
Aux 1/8" analog line in playthrough: works well
Aux 1/8" analog line in to Analog_Mix and
PCM capture from Analog_Mix: works well except very low volume (low volume
could easily just be the source signal though...)

I'll try to apply the patch again from pzad, 8-28-05, and will report back
later.

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
07-31-06 18:32 phineas        Note Added: 0011345                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
