From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000539]: Problem with changing size of etram
Date: Tue, 23 Nov 2004 16:12:24 +0100
Message-ID: <ca17d6e42b47a6bf275006c6c0058be8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C09782D3
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2004 16:12:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=539> 
======================================================================
Reported By:                mikma
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   539
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-24-2004 23:55 CEST
Last Modified:              11-23-2004 16:12 CET
======================================================================
Summary:                    Problem with changing size of etram
Description: 
It doesn't work to double the etram size, because of a bad comparison
statement.

patch of emufx.c:
-       if (emu->fx8010.etram_pages.bytes == size)
+       if ((emu->fx8010.etram_pages.bytes / 2) == size)

======================================================================

----------------------------------------------------------------------
 pzad - 11-22-04 22:09 
----------------------------------------------------------------------
Can be this aplied to CVS, please ???

----------------------------------------------------------------------
 tiwai - 11-23-04 16:12 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 23:55 mikma          New Issue                                    
09-24-04 23:55 mikma          Distribution              => Debian          
09-24-04 23:55 mikma          Kernel Version            => 2.6.5           
11-13-04 21:51 pzad           Note Added: 0002402                          
11-18-04 17:44 pzad           Note Added: 0002450                          
11-22-04 21:31 mikma          Note Added: 0002512                          
11-22-04 22:09 pzad           Note Added: 0002513                          
11-23-04 16:12 tiwai          Status                   assigned => resolved
11-23-04 16:12 tiwai          Resolution               open => fixed       
11-23-04 16:12 tiwai          Note Added: 0002519                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
