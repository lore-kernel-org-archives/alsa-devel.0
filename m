From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000615]: AC'97 broken on SB Live 24 bit
Date: Mon, 6 Dec 2004 23:27:14 +0100
Message-ID: <8a7a05794829550eac964db1efa5e244@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B113E397
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 23:27:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=615> 
======================================================================
Reported By:                MRB
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   615
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             2.6.7-gentoo-r1
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             10-29-2004 12:34 CEST
Last Modified:              12-06-2004 23:27 CET
======================================================================
Summary:                    AC'97 broken on SB Live 24 bit
Description: 
The Creative Sound Blaster 24bit is using an Audigy chip according to its
PCI ID. The driver audigyls doesn't work because AC'97 does not respond
and AC'97 0 access is not valid. When you remove the error checking the
audigyls module can be loaded but there's no sound output. See attached
file for details. 
======================================================================

----------------------------------------------------------------------
 jcdutton - 10-31-04 16:24 
----------------------------------------------------------------------
This looks like I will actually have to play with the actual card.
As you offer to donate the value of a card, I will agree to try to get it
working.
Please email me direct, and we can arrange things off list.

----------------------------------------------------------------------
 jcdutton - 12-06-04 23:27 
----------------------------------------------------------------------
I am closing this bug. The reason for this is that the audigyls driver has
changed a lot recently, and I would prefer it if you tried again with the
latest alsa-driver cvs, and try the "snd-ca0106" driver. The snd-audigyls
does not exist any more.
If the bug is still present, please re-raise the bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-04 12:34 MRB            New Issue                                    
10-29-04 12:34 MRB            File Added: details.txt                      
10-29-04 12:34 MRB            Distribution              => Gentoo Linux    
10-29-04 12:34 MRB            Kernel Version            => 2.6.7-gentoo-r1 
10-30-04 18:08 jcdutton       Note Added: 0002289                          
10-31-04 00:30 MRB            Note Added: 0002290                          
10-31-04 00:30 MRB            File Added: details2.txt                     
10-31-04 16:24 jcdutton       Note Added: 0002294                          
11-13-04 02:25 plasticzombie  Issue Monitored: plasticzombie                    
12-06-04 23:27 jcdutton       Status                   assigned => closed  
12-06-04 23:27 jcdutton       Note Added: 0002739                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
