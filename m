From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000553]: Experimental feature for dual codecs produce choppy sound
Date: Sat, 19 Mar 2005 12:54:49 +0100
Message-ID: <05e17d00383b5a02449a264322128f33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 644CA139
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 12:54:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=553> 
======================================================================
Reported By:                cgdef
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   553
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2
======================================================================
Date Submitted:             09-30-2004 07:51 CEST
Last Modified:              03-19-2005 12:54 CET
======================================================================
Summary:                    Experimental feature for dual codecs produce choppy
sound
Description: 
I first discovered this feature in the 2.6.9-rc2 kernel. There is a option
which allows you to enable support for dual codecs in the cs-46xx driver.
I have a Turtle Beach Santa Cruz card and it does come with dual codecs
(CS 4297A-JQ and CS 4294-JQ) and a dsp (CS 4630). If the alsa driver is
compiled with support for dual codecs the sound produced is often choppy
and way bellow https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21#90dB
SNR (specs provided by the manufacturer and verified
by several reviewers). 
However, if the alsa driver is compiled without the experimental code and
support for only one codec the sound problems disapear compleatelly.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 12:54 
----------------------------------------------------------------------
Do you see any improvement in more recent ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-30-04 07:51 cgdef          New Issue                                    
09-30-04 07:51 cgdef          Distribution              => Gentoo          
09-30-04 07:51 cgdef          Kernel Version            => 2.6.9-rc2       
11-07-04 16:37 fvdpol         Issue Monitored: fvdpol                      
03-19-05 12:54 jdthood        Note Added: 0004042                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
