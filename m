From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000553]: Experimental feature for dual codecs produce choppy sound
Date: Tue, 13 Dec 2005 12:46:38 +0100
Message-ID: <49d463072eec41de200f432c6f5d2a2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2D3D01C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:46:38 +0100 (MET)
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
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-30-2004 07:51 CEST
Last Modified:              12-13-2005 12:46 CET
======================================================================
Summary:                    Experimental feature for dual codecs produce choppy
sound
Description: 
I first discovered this feature in the 2.6.9-rc2 kernel. There is a option
which allows you to enable support for dual codecs in the cs-46xx driver.
I have a Turtle Beach Santa Cruz card and it does come with dual codecs
(CS 4297A-JQ and CS 4294-JQ) and a dsp (CS 4630). If the alsa driver is
compiled with support for dual codecs the sound produced is often choppy
and way bellow ~90dB SNR (specs provided by the manufacturer and verified
by several reviewers). 
However, if the alsa driver is compiled without the experimental code and
support for only one codec the sound problems disapear compleatelly.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 12:54 
----------------------------------------------------------------------
Do you see any improvement in more recent ALSA releases?

----------------------------------------------------------------------
 jdthood - 12-13-05 12:46 
----------------------------------------------------------------------
No response to request for more information.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-30-04 07:51 cgdef          New Issue                                    
09-30-04 07:51 cgdef          Distribution              => Gentoo          
09-30-04 07:51 cgdef          Kernel Version            => 2.6.9-rc2       
11-07-04 16:37 fvdpol         Issue Monitored: fvdpol                      
03-19-05 12:54 jdthood        Note Added: 0004042                          
08-08-05 07:52 madCoder       Issue Monitored: madCoder                    
12-13-05 12:46 jdthood        Status                   new => closed       
12-13-05 12:46 jdthood        Note Added: 0007002                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
