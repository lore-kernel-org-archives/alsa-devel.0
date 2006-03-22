From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000577]: Please make it possible for two (or more) mixer sliders to be locked together
Date: Wed, 22 Mar 2006 11:00:30 +0100
Message-ID: <7771d8393bd503f4d78c33035d6e3480@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A788219F
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 11:00:30 +0100 (MET)
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


The following issue has been REOPENED.
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
Status:                     feedback
======================================================================
Date Submitted:             10-10-2004 17:35 CEST
Last Modified:              03-22-2006 11:00 CET
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
 rlrevell - 03-22-06 03:03 
----------------------------------------------------------------------
Not a bug

----------------------------------------------------------------------
 ldarby - 03-22-06 11:00 
----------------------------------------------------------------------
That right, it's not a bug, and it still says "feature requests" on
alsa-project.org.

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
03-22-06 03:03 rlrevell       Status                   new => closed       
03-22-06 03:03 rlrevell       Note Added: 0008791                          
03-22-06 11:00 ldarby         Status                   closed => feedback  
03-22-06 11:00 ldarby         Resolution               open => reopened    
03-22-06 11:00 ldarby         Note Added: 0008852                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
