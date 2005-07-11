From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001251]: emagic a62m: maybe bug: arecord doesn't record anything, jack+jackrec work
Date: Mon, 11 Jul 2005 16:20:13 +0200
Message-ID: <c16c9497329c6b002ae4b71ef68788f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3BCD195
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2005 16:20:13 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1251> 
======================================================================
Reported By:                Robert_Schulze
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1251
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-11-2005 14:39 CEST
Last Modified:              07-11-2005 16:20 CEST
======================================================================
Summary:                    emagic a62m: maybe bug: arecord doesn't record
anything, jack+jackrec work
Description: 
When I want to record something from my emi a62m audiointerface, arecord
doesn't work:

"arecord -D emi -f cd > test.wav"
when issuing "aplay -vvv test.wav", the histogram shows up a permanent
peak of 36% during the whole file, no sound hearable.

Starting "jackd -d alsa -D emi" and issuing "jackrec -f test.wav -d 5
alsa_pcm:capture_1 alsa_pcm:capture_2" does record a valid file.

.asoundrc:

pcm.emi 
 {
 type hw
 card 1 
 }

ctl.emi
 {
 type hw
 card 1
 }

Card 0 is a solo1.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 07-11-05 16:20 
----------------------------------------------------------------------
The "cd" format uses 44.1 Khz while Jack's default sample rate is 48 Khz.

Does arecord work with "-f dat"?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-05 14:39 Robert_Schulze New Issue                                    
07-11-05 16:20 Clemens LadischNote Added: 0005448                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
