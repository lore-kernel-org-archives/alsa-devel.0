From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001087]: No Mic or line in capabality
Date: Sat, 28 May 2005 00:38:41 +0200
Message-ID: <4d55fb6f177c9af3279b7cd7f280cba5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 403C7149
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 00:38:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1087> 
======================================================================
Reported By:                pelias
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1087
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Fedora
Kernel Version:             2.6.11-1.14_FC3
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-05-2005 19:28 CEST
Last Modified:              05-28-2005 00:38 CEST
======================================================================
Summary:                    No Mic or line in capabality
Description: 
I am able to hear sound but I cannot switch to Mic or Line in input. 
In "nvmixer/Advance options" all the options cannot be swapped. 
In "nvmixer/Volume" all the mute bits cannot be swapped.
Briefly none control is working.

I have also tried to fix this (byt with no result) with
kmix, alsamixer
======================================================================

----------------------------------------------------------------------
 pelias - 05-05-05 20:12 
----------------------------------------------------------------------
jcdutton,

I have just see your reply in nvforum (posted 04-16-05, thread : FC3
nforce4 unsolved sound problem), telling me that no capture support is
available. 
Are planning to arrange this or does this mean that I won't be able to use
the capture features (and buy another audio card) ?

Thanks for your answer.

----------------------------------------------------------------------
 jcdutton - 05-28-05 00:38 
----------------------------------------------------------------------
We have received the needed information from Creative.
Line-in and Mic-in now work on the SB Live 24bit.
Support was added to the ALSA CVS after alsa-driver 1.0.9 was released.
So, it is only supported in version of alsa-driver after 1.0.9

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-05-05 19:28 pelias         New Issue                                    
05-05-05 19:28 pelias         Distribution              => Fedora          
05-05-05 19:28 pelias         Kernel Version            => 2.6.11-1.14_FC3 
05-05-05 20:12 pelias         Note Added: 0004589                          
05-28-05 00:38 jcdutton       Status                   assigned => closed  
05-28-05 00:38 jcdutton       Note Added: 0004756                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
