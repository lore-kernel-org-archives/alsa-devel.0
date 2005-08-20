From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000577]: Please make it possible for two (or more) mixer sliders to be locked together
Date: Sat, 20 Aug 2005 15:57:50 +0200
Message-ID: <739398f422182f1dd81e0d73b7ffda29@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF68D1CA
	for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2005 15:57:50 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=577> 
======================================================================
Reported By:                ldarby
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   577
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-10-2004 17:35 CEST
Last Modified:              08-20-2005 15:57 CEST
======================================================================
Summary:                    Please make it possible for two (or more) mixer
sliders to be locked together
Description: 
I noticed that the only way to reduce the volume to the lowest (not muting
it tho) is reducing both Master and PCM sliders, and to get the loudest
non-distorted volume, both need to increased to almost max.  I think I
remember a mixer for a windows driver that could lock two mixer sliders
together to do this, and I've done this myself from within XMMS, but it
relies on Master and PCM elems being in a certain position (probably sound
card dependent).  Would it be a good idea to implement this in a general
way in alsamixer, or has this already been done in another mixer?
(googling for linux mixers reveals far too many to check through...)

Thanks,
Laurence
======================================================================

----------------------------------------------------------------------
 tiwai - 10-11-04 16:15 
----------------------------------------------------------------------
Please discuss on alsa-devel ML.
(This is not a bug :)

----------------------------------------------------------------------
 ldarby - 10-11-04 20:26 
----------------------------------------------------------------------
Well, what would be the point? The alsa-devel list is just full of the bug
reports from here anyway.  It seems this feature request has been added
too.  Is something wrong or what?

Laurence

----------------------------------------------------------------------
 tiwai - 10-12-04 11:49 
----------------------------------------------------------------------
Here is "bug tracking system", not a user/developer forum.

----------------------------------------------------------------------
 ldarby - 10-14-04 14:45 
----------------------------------------------------------------------
Let me make a couple of suggestions: 

1) Remove the text "feature requests" from the link on the alsa-project
front page, as I gather feature requests aren't welcome there.

2) In the docs for the bug submissions, as hard to find as they are, the
description for the severity of "feature" should be changed to reflect the
fact feature requests aren't welcome.

3) As the devel list is a user/developer forum, not a bug tracking system,
the bugs shouldn't be forwarded to it.  Or maybe I'm wrong, and no new
developments are being made to alsa.  The point is, I have implemented
this feature for myself, and I was wondering if anyone else was
interested.

Laurence

----------------------------------------------------------------------
 tiwai - 10-14-04 14:58 
----------------------------------------------------------------------
Sending bugs to alsa-devel is fine, IMO, since alsa-devel is the
place where every development process should be centralized.
(Though, the message should be shorten, containing only diffs.)

Again, BTS is not the place for DISCUSSION.  It's the place for
REPORTING.
If you ask something, or want to hear something from other people
(like this case), then alsa-devel is the appropriate place.
That's my point.

The feature request itself is fine (although it will be likely in
the low priority).

BTW, any patches are very appreciated, of course :) !!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-10-04 17:35 ldarby         New Issue                                    
10-11-04 16:15 tiwai          Note Added: 0002082                          
10-11-04 20:26 ldarby         Note Added: 0002084                          
10-12-04 11:49 tiwai          Note Added: 0002088                          
10-14-04 14:45 ldarby         Note Added: 0002147                          
10-14-04 14:58 tiwai          Note Added: 0002148                          
08-20-05 15:57 jdthood        Summary                  locking two (or more)
mixer sliders together to get full volume range => Please make it possible for
two (or more) mixer sliders to be locked together
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
