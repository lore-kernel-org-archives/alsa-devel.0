From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000325]: Attempted use of arecord causes complete system lockup. Only a hard reset recovers.
Date: Thu, 7 Apr 2005 00:07:46 +0200
Message-ID: <df9d6d4a5b63e3790ac3859a13a5b2bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 191DF204
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 00:07:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=325> 
======================================================================
Reported By:                meg
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   325
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.5-1.358
======================================================================
Date Submitted:             06-06-2004 23:49 CEST
Last Modified:              04-07-2005 00:07 CEST
======================================================================
Summary:                    Attempted use of arecord causes complete system
lockup. Only a hard reset recovers.
Description: 
This is a bone stock Fedora Core 2 system. The sound card is a SB16 P&P.
Any attempted use of arecord, either from a console or xterm, results in a
complete system lockup. It is 100% reproducible. aplay can play a test
sound. alsamixer seems to work as well. The microphone can be heard
through the speakers and can be adjusted using alsamixer.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 00:07 
----------------------------------------------------------------------
Submitter: Was there any improvement in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-04 23:49 meg            New Issue                                    
06-06-04 23:49 meg            Distribution              => Fedora Core 2   
06-06-04 23:49 meg            Kernel Version            => 2.6.5-1.358     
06-07-04 06:02 meg            Issue Monitored: meg                         
04-07-05 00:07 jdthood        Note Added: 0004352                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
