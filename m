From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000680]: sounds continually stutters
Date: Mon, 6 Dec 2004 23:37:35 +0100
Message-ID: <ee5bbe3530ce8dc0bf72d762df97cace@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 263813A0
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 23:37:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=680> 
======================================================================
Reported By:                jeremysanders
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   680
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core
Kernel Version:             kernel-2.6.9-1.6_FC2
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-26-2004 14:14 CET
Last Modified:              12-06-2004 23:37 CET
======================================================================
Summary:                    sounds continually stutters
Description: 
Using Fedora Core 2 on an Athlon 64 system (x86_64), sound stutters
continually using sound directed to the alsa driver. It sounds like
someone is playing it underwater. This is using xmms. If I direct the
sound via arts (which talks to the alsa driver), I get the same problem.

If I set the sound output device to OSS (using alsa OSS emulation), the
sound is fine. If I set arts to talk to oss, then the sound is fine too.

An additional issue is that kmix crashes on its startup with this card,
but this is probably a kmix issue, as alsamixer and gnome-volume-control
both work.


======================================================================

----------------------------------------------------------------------
 jcdutton - 12-06-04 23:37 
----------------------------------------------------------------------
Currently, the alsa audigy ls driver does not support any oss mixer
elements.
This is probably because the audigy ls sound card does not have any
conventional controls like master and pcm. That is probably why kmix
fails.
The stuttering sound is due to a bug in xmms.
Playing the same audio file in xine will sound fine.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-26-04 14:14 jeremysanders  New Issue                                    
11-26-04 14:14 jeremysanders  Distribution              => Fedora Core     
11-26-04 14:14 jeremysanders  Kernel Version            => kernel-2.6.9-1.6_FC2
12-06-04 23:37 jcdutton       Status                   assigned => closed  
12-06-04 23:37 jcdutton       Note Added: 0002744                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
