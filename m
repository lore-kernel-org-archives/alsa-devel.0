From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000611]: Can't access Digi32 with kernel 2.6.9
Date: Wed, 29 Dec 2004 14:29:56 +0100
Message-ID: <4c750f7984fa2824488e5c333f87f089@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CA21F26D
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 14:29:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=611> 
======================================================================
Reported By:                spirou
Assigned To:                martin
======================================================================
Project:                    ALSA - driver
Issue ID:                   611
Category:                   PCI - RME 32
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             2.6.9-gentoo-r1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-27-2004 03:44 CEST
Last Modified:              12-29-2004 14:29 CET
======================================================================
Summary:                    Can't access Digi32 with kernel 2.6.9
Description: 
The Driver for the digi32 in kernel 2.6.9 doesn't let me access the card.
All I get is a "Device busy". With 2.6.8 everything is fine.
lsmod shows the driver as loaded, permissions are the same as with 2.6.8.
======================================================================

----------------------------------------------------------------------
 martin - 11-28-04 18:35 
----------------------------------------------------------------------
Can I close this bug? Is it also resolved for you, if you are using newer
code?

----------------------------------------------------------------------
 tiwai - 11-29-04 15:53 
----------------------------------------------------------------------
Let's move this to resolve/fixed.  If the problem still exists, reopen
this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-04 03:44 spirou         New Issue                                    
10-27-04 03:44 spirou         Distribution              => Gentoo Linux    
10-27-04 03:44 spirou         Kernel Version            => 2.6.9-gentoo-r1 
11-09-04 19:16 tiwai          Note Added: 0002341                          
11-10-04 02:47 spirou         Note Added: 0002354                          
11-10-04 11:04 martin         Note Added: 0002360                          
11-10-04 12:08 tiwai          Note Added: 0002363                          
11-10-04 22:09 martin         File Added: rme32.stracelog.WRONG.gz              
     
11-10-04 22:10 martin         File Added: rme32.stracelog.FINE.gz               
    
11-10-04 22:33 martin         Note Added: 0002377                          
11-10-04 22:37 martin         Note Added: 0002380                          
11-11-04 15:04 tiwai          Note Added: 0002388                          
11-11-04 16:11 martin         Note Added: 0002389                          
11-14-04 15:07 martin         Note Added: 0002408                          
11-14-04 20:05 martin         File Added: pcmnative.patch                    
11-14-04 20:17 martin         Note Added: 0002409                          
11-15-04 04:59 spirou         Note Added: 0002410                          
11-15-04 20:25 martin         Note Added: 0002420                          
11-16-04 16:19 tiwai          Note Added: 0002425                          
11-16-04 23:54 martin         Note Added: 0002431                          
11-28-04 18:35 martin         Note Added: 0002627                          
11-29-04 15:53 tiwai          Status                   assigned => resolved
11-29-04 15:53 tiwai          Resolution               open => fixed       
11-29-04 15:53 tiwai          Note Added: 0002646                          
12-29-04 14:29 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
