From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000704]: low input levels
Date: Tue, 31 May 2005 17:56:59 +0200
Message-ID: <053258a45cc1788d79f108718f9f05c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 732381B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 17:56:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=704> 
======================================================================
Reported By:                spamatica
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   704
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-03-2004 21:46 CET
Last Modified:              05-31-2005 17:56 CEST
======================================================================
Summary:                    low input levels
Description: 
As was noted recently on Linx audio user. It seems atleast the DELTA cards
(I've got a Delta 44) have too low input level. Others reported that it
differs when running the same card in windows. Myself I run it exclusively
in Linux and have found that recording external signals I have to turn the
volume for the external (pro) equipment, to max to get a reasonably high
signal.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 15:20 
----------------------------------------------------------------------
Submitter:  Are "IPGA Analog Capture Volume" adjusted properly?

----------------------------------------------------------------------
 spamatica - 03-27-05 22:59 
----------------------------------------------------------------------
Sorry, was meaning to follow up on this one, this seems to have been the
problem. 
I don't know if there's a way for me to close this bug, I'd suggest doing
so anyway.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-03-04 21:46 spamatica      New Issue                                    
12-06-04 20:56 tiwai          Note Added: 0002734                          
03-23-05 15:20 jdthood        Note Added: 0004157                          
03-27-05 22:59 spamatica      Note Added: 0004225                          
03-28-05 03:58 jdthood        Status                   new => resolved     
03-28-05 03:58 jdthood        Resolution               open => fixed       
05-31-05 17:56 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
