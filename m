From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000432]: Impossible de se connecter : NODIALTONE
Date: Mon, 14 Feb 2005 19:40:18 +0100
Message-ID: <724db23af6ed4a235ef5abf2c1784250@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1B6B249
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:40:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=432> 
======================================================================
Reported By:                Cyrille
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   432
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Slackware 10
Kernel Version:             2.4.24
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-08-2004 19:02 CEST
Last Modified:              02-14-2005 19:40 CET
======================================================================
Summary:                    Impossible de se connecter : NODIALTONE
Description: 
I've got a TOSHIBA SATELITTE A30 222 laptop
Sound card and modem are based upon ATI IXP
But I'm not able to run modem in spite of the differents bug-report on
ALSA web site
(https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000422
-
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
 -
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000417
) and on Unixtrix.com (http://www.unixtrix.com/)

Even if I do like Ronis or Netstar say -bugtrack.alsa-project :
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
-, I'm always in the same situation : compilation is OK, modem driver OK
but I'm not able to connect : NODIALTONE
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000422 snd-atiixp-modem driver: No CARRIER/DIA...
======================================================================

----------------------------------------------------------------------
 sashak - 08-28-04 22:37 
----------------------------------------------------------------------
Also run ATX3 command before ATDT.

----------------------------------------------------------------------
 sashak - 01-14-05 22:12 
----------------------------------------------------------------------
Solved as reported in bug 816
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=816)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-04 19:02 Cyrille        New Issue                                    
08-08-04 19:02 Cyrille        Distribution              => Slackware 10    
08-08-04 19:02 Cyrille        Kernel Version            => 2.4.24          
08-08-04 19:02 Cyrille        Issue Monitored: Cyrille                     
08-25-04 19:04 sashak         File Added: atiixp_modem.patch                    
08-25-04 19:11 sashak         Note Added: 0001624                          
08-26-04 01:16 netstar        File Added: debugging.tar.gz                    
08-26-04 01:18 netstar        Note Added: 0001630                          
08-26-04 18:54 netstar        Note Added: 0001634                          
08-26-04 21:46 Cyrille        Note Added: 0001636                          
08-26-04 21:47 Cyrille        Note Added: 0001637                          
08-27-04 15:41 Cyrille        Note Added: 0001644                          
08-27-04 19:33 tiwai          Assigned To              tiwai => sashak     
08-28-04 04:24 netstar        Note Added: 0001660                          
08-28-04 04:33 netstar        File Added: slmodemd.tar.gz                    
08-28-04 04:40 netstar        File Added: slmodemd-fixed.tar.gz                 
  
08-28-04 13:49 Cyrille        Note Added: 0001661                          
08-28-04 19:49 netstar        Note Added: 0001662                          
08-28-04 22:37 sashak         Note Added: 0001663                          
08-29-04 12:10 sashak         Relationship added       has duplicate 0000422
01-14-05 22:12 sashak         Note Added: 0003210                          
01-14-05 22:17 sashak         Status                   assigned => resolved
01-14-05 22:17 sashak         Resolution               open => fixed       
02-14-05 19:40 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
