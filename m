From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000420]: driver blocks/times out after suspend on IBM Thinkpad 390E (2626E0U)
Date: Tue, 12 Apr 2005 21:37:54 +0200
Message-ID: <e04799c3bc92eba1f9640eee75764470@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2499827C
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 21:37:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=420> 
======================================================================
Reported By:                jmartin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   420
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             unmodified Linux 2.6.7, compiled from sources
======================================================================
Date Submitted:             08-03-2004 12:14 CEST
Last Modified:              04-12-2005 21:37 CEST
======================================================================
Summary:                    driver blocks/times out after suspend on IBM
Thinkpad 390E (2626E0U)
Description: 
When I suspend (to ram) my Thinkpad and then resume it again, sound does
not work any more. Programs trying to use the sound device block for a
long time and time out eventually. There are no kernel messages.

The problem existed also in earlier ALSA and OSS versions. Sometimes I
received messages about lost interrupts or similar (if I remember
correctly).

In earlier versions, I also tried to 
- unload/reload the module after resume,
- unload the module before suspend, reload after resume,
both with now success.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-08-05 22:36 
----------------------------------------------------------------------
Submitter: Has the (re)initialization problem been fixed?

----------------------------------------------------------------------
 jmartin - 04-12-05 21:37 
----------------------------------------------------------------------
I just tried with a plain 2.6.11.7 kernel. The problem is as before.
Sample rates up to 11025 Hz work fine after a suspend, higher rates
produce scrambled output.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-04 12:14 jmartin        New Issue                                    
08-03-04 12:14 jmartin        Distribution              => Debian GNU/Linux
08-03-04 12:14 jmartin        Kernel Version            => unmodified Linux
2.6.7, compiled from sources
08-03-04 19:37 tiwai          Note Added: 0001529                          
08-03-04 21:19 jmartin        Note Added: 0001530                          
08-04-04 08:41 jmartin        Note Added: 0001532                          
08-04-04 12:38 tiwai          Note Added: 0001533                          
08-04-04 12:42 tiwai          File Added: es1938-pm.dif                    
08-04-04 17:56 jmartin        Note Added: 0001534                          
04-08-05 22:36 jdthood        Note Added: 0004379                          
04-12-05 21:37 jmartin        Note Added: 0004465                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
