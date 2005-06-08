From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000332]: Unable to enable 'Mic as Center/LFE'
Date: Wed, 8 Jun 2005 20:40:58 +0200
Message-ID: <77e0059e00e2a150945e3e480af200b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 107401E9
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 20:40:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=332> 
======================================================================
Reported By:                Johan Gorter
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   332
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-11-2004 09:12 CEST
Last Modified:              06-08-2005 20:40 CEST
======================================================================
Summary:                    Unable to enable 'Mic as Center/LFE'
Description: 
In the alsa versions I have used thus far (1.0.3 and 1.0.5) I am unable to
enable the 'Mic as Center/LFE' option of my onboard AC '97. Alsamixer
cannot change its value from 0 and record / mute is also disabled. I
tracked the problem by using alsactl to store the settings. This results
in a file where this option (nr 47 on my system) is an Integer with the
comment that the value may be from 0 to 0. On other systems I found out
that this is supposed to be a Boolean which can be switched on and off.
======================================================================

----------------------------------------------------------------------
 jdthood - 05-02-05 11:10 
----------------------------------------------------------------------
In Debian bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=307087 it
was reported:

I'm unable to record the Mic input with this sound card and this
alsa-utils version : under alsamixer there is no possibility to
select the Mic for recording as I could with older versions of
alsa-utils that I used to install on a Woody.
(I launch with "alsamixer -V all")

Using an OSS mixer (aumix-gtk) or an other Alsa Mixer (gamix)
fixes the problem.

I'm using debian GNU/Linux testing, Linux 2.6.8-2-686 and
libc6 2.3.2.ds1-20

----------------------------------------------------------------------
 jdthood - 06-08-05 20:40 
----------------------------------------------------------------------
I asked the submitter of Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=307087 to test alsa-utils
version 1.0.9a.  He says:

The bug seems to be half fixed: in [All] mode of alsamixer it is still
[not] present (no control to select Mic for recording), while in [Capture]
mode the control is present.  Also the recording volume is very low, even
at 100%, but this might be because of the sound card (though I don't now
how to check that).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-04 09:12 Johan Gorter   New Issue                                    
01-22-05 03:26 rhal           Issue Monitored: rhal                        
03-20-05 15:45 jdthood        Note Added: 0004093                          
03-31-05 20:23 jdthood        Note Added: 0004284                          
05-02-05 11:10 jdthood        Note Added: 0004584                          
06-08-05 20:40 jdthood        Note Added: 0004972                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
