From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000307]: Can't play 6 channels wave file
Date: Mon, 11 Apr 2005 09:45:34 +0200
Message-ID: <ec069625b14381d592452bafed11e59e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 197F7295
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2005 09:45:35 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=307> 
======================================================================
Reported By:                pshou
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   307
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               Redhat7.3
Kernel Version:             2.4.18-3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-26-2004 04:28 CEST
Last Modified:              04-11-2005 09:45 CEST
======================================================================
Summary:                    Can't play 6 channels wave file
Description: 
I have a ALC655 for ICH5 motherboard.
I used the aplay to play a 5.1 channels wave file, then show a error
message "Can't use period equal to buffer size"
I used the ICH2, ICH4 and ATi motherboard have the same problem.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-04-05 22:24 
----------------------------------------------------------------------
Submitter: Do you still have this problem?

----------------------------------------------------------------------
 pshou - 04-11-05 09:03 
----------------------------------------------------------------------
The problem is fixed by the newest ALSA driver. Thank's very much your
help.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-04 04:28 pshou          New Issue                                    
05-26-04 04:28 pshou          Distribution              => Redhat7.3       
05-26-04 04:28 pshou          Kernel Version            => 2.4.18-3        
05-26-04 13:36 tiwai          Note Added: 0001251                          
04-04-05 22:24 jdthood        Note Added: 0004332                          
04-11-05 09:03 pshou          Note Added: 0004441                          
04-11-05 09:45 jdthood        Status                   new => resolved     
04-11-05 09:45 jdthood        Resolution               open => fixed       
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
