From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000693]: Choppy sound with ticks noise distortion
Date: Mon, 6 Dec 2004 23:32:10 +0100
Message-ID: <8a121362e79b73ca50e7c403a3d2c939@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2FFFF3A0
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 23:32:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=693> 
======================================================================
Reported By:                unixape
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   693
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.9
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-29-2004 19:26 CET
Last Modified:              12-06-2004 23:32 CET
======================================================================
Summary:                    Choppy sound with ticks noise distortion
Description: 
The modules works fine under oss emulation but if you use a program like
mplayer, xmms where you can use alsa it will produce very choppy noise
with ticking noise distortion.
Some applications i have found this to be true with when using alsa are:
xmms, mplayer (especially when playing back avi files), xine... , or
watching quicktime movies through firefox.
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-06-04 23:32 
----------------------------------------------------------------------
I am closing this bug. The reason for this is that the audigyls driver has
changed a lot recently, and I would prefer it if you tried again with the
latest alsa-driver cvs, and try the "snd-ca0106" driver. The snd-audigyls
does not exist any more.
If the bug is still present, please re-raise the bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 19:26 unixape        New Issue                                    
11-29-04 19:26 unixape        Distribution              => Debian          
11-29-04 19:26 unixape        Kernel Version            => 2.6.9           
11-29-04 19:39 unixape        Issue Monitored: unixape                     
12-06-04 23:32 jcdutton       Status                   assigned => closed  
12-06-04 23:32 jcdutton       Note Added: 0002742                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
