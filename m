From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000815]: missing DESTDIR support with hotplug dir
Date: Mon, 14 Feb 2005 19:51:50 +0100
Message-ID: <2dd8d4cd889688f7e432d35670893c54@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 23B0C229
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:51:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=815> 
======================================================================
Reported By:                gvy
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   815
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             01-13-2005 20:21 CET
Last Modified:              02-14-2005 19:51 CET
======================================================================
Summary:                    missing DESTDIR support with hotplug dir
Description: 
with intoruction of hotplug dir I had to kludge in RPM buildroot into
configure parameters -- it doesn't belong there, it's rather install-time
not compile-time (and definitely not configure-time).

hardwiring /usr/lib is no good too -- bringing ilbdir in would be better
too.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-13-05 20:52 
----------------------------------------------------------------------
OK, thanks for checking.

Closing this now.

----------------------------------------------------------------------
 gvy - 02-14-05 19:51 
----------------------------------------------------------------------
Err... Takashi, I didn't get around to this issue (and another one with
alsa-tools gcc3.4 build too).

So was this "closing a ``solved'' bug" or was it actually solved?

The trouble was (is) in _differing_ handling of DESTDIR substitution
handling in different stages (in the same time differing from handling for
the other objects to be installed).

OTOH it it works for you -- well it's my trouble to get it fixed to work
for me too :-)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-13-05 20:21 gvy            New Issue                                    
01-13-05 20:33 tiwai          Note Added: 0003199                          
01-13-05 20:48 gvy            Note Added: 0003201                          
01-13-05 20:52 tiwai          Status                   new => resolved     
01-13-05 20:52 tiwai          Resolution               open => not an issue
01-13-05 20:52 tiwai          Assigned To               => tiwai           
01-13-05 20:52 tiwai          Note Added: 0003203                          
01-13-05 20:52 tiwai          Assigned To              tiwai =>            
02-14-05 19:39 tiwai          Status                   resolved => closed  
02-14-05 19:51 gvy            Status                   closed => feedback  
02-14-05 19:51 gvy            Resolution               not an issue => reopened
02-14-05 19:51 gvy            Note Added: 0003608                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
