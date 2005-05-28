From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000901]: The onboard audigyls chip on msi k8 diamond motherboard not recognized. Path supplied.
Date: Sat, 28 May 2005 12:20:04 +0200
Message-ID: <3b6fd751820a998b80b98e85ae99fc4b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 828BB214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:20:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=901> 
======================================================================
Reported By:                kiksen
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   901
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-11-2005 23:49 CET
Last Modified:              05-28-2005 12:20 CEST
======================================================================
Summary:                    The onboard audigyls chip on msi k8 diamond
motherboard not recognized. Path supplied.
Description: 
We'll. The driver fails to load (and dmesg comlaints about a missing AC97)

Have made a path.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000987 new chipset
======================================================================

----------------------------------------------------------------------
 sHINOBI - 02-13-05 01:21 
----------------------------------------------------------------------
*nods*, seems to be better:

0 [CA0106         ]: CA0106 - CA0106
                     Live! by MSI [SB0438] at 0xde00 irq 233

----------------------------------------------------------------------
 jcdutton - 02-13-05 01:27 
----------------------------------------------------------------------
Thank you. A modified patch will be added to alsa cvs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-05 23:49 kiksen         New Issue                                    
02-11-05 23:49 kiksen         File Added: msi_audigyls_patch.patch              
     
02-11-05 23:49 kiksen         Distribution              => Gentoo          
02-11-05 23:49 kiksen         Kernel Version            => 2.6.10          
02-12-05 00:56 jcdutton       Note Added: 0003569                          
02-12-05 14:36 kiksen         Note Added: 0003571                          
02-12-05 22:43 sHINOBI        Issue Monitored: sHINOBI                     
02-12-05 22:47 sHINOBI        Note Added: 0003572                          
02-13-05 00:18 jcdutton       Note Added: 0003574                          
02-13-05 00:54 sHINOBI        Note Added: 0003575                          
02-13-05 01:08 jcdutton       Note Added: 0003576                          
02-13-05 01:21 sHINOBI        Note Added: 0003577                          
02-13-05 01:27 jcdutton       Status                   assigned => resolved
02-13-05 01:27 jcdutton       Resolution               open => fixed       
02-13-05 01:27 jcdutton       Note Added: 0003578                          
02-22-05 19:22 sHINOBI        Issue End Monitor: sHINOBI                    
03-19-05 18:17 jcdutton       Relationship added       has duplicate 0000987
05-28-05 12:20 jcdutton       Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
