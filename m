From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000378]: Audigy LS - Video playback stutters the first 5 seconds
Date: Mon, 6 Dec 2004 23:30:06 +0100
Message-ID: <891e4460b127919e2255a46c43253c8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AC26E3A0
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 23:30:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=378> 
======================================================================
Reported By:                Luke
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   378
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.7
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-12-2004 10:41 CEST
Last Modified:              12-06-2004 23:30 CET
======================================================================
Summary:                    Audigy LS - Video playback stutters the first 5
seconds
Description: 
When playing a video (doesn't matter what kind) with mplayer, the whole
playback stutters approximately the first 5 seconds when the alsa modules
are loaded. No difference when compiling mplayer w or w/o oss/alsa
support.
======================================================================

----------------------------------------------------------------------
 jcdutton - 08-27-04 20:08 
----------------------------------------------------------------------
Can you please verify which version of the audigyls.c file you have, by
doing:
 grep Version ./alsa-driver/pci/emu10k1/audigyls.c

It should say:
 *  Version: 0.0.14

----------------------------------------------------------------------
 jcdutton - 12-06-04 23:30 
----------------------------------------------------------------------
I am closing this bug. The reason for this is that the audigyls driver has
changed a lot recently, and I would prefer it if you tried again with the
latest alsa-driver cvs, and try the "snd-ca0106" driver. The snd-audigyls
does not exist any more.
If the bug is still present, please re-raise the bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-04 10:41 Luke           New Issue                                    
07-12-04 10:41 Luke           Distribution              => Gentoo          
07-12-04 10:41 Luke           Kernel Version            => 2.6.7           
08-27-04 20:08 jcdutton       Note Added: 0001649                          
08-27-04 20:21 jcdutton       Assigned To              pzad => jcdutton    
08-27-04 20:22 jcdutton       Status                   assigned => feedback
12-06-04 23:30 jcdutton       Status                   feedback => closed  
12-06-04 23:30 jcdutton       Note Added: 0002741                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
