From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000712]: Setting <4 channels in surround40 fails
Date: Tue, 31 May 2005 18:03:19 +0200
Message-ID: <dfa51a82e4b92776c566085083d0ba46@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E19B01C8
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=712> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   712
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             12-07-2004 18:36 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    Setting <4 channels in surround40 fails
Description: 
If you try
alsa-lib/test/pcm -D surround40:0
You obtain: Channels count (1) not available for playbacks: Invalid
argument
But we have 4 channels!
I've tried to find the problem into the sources without luck :(
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 16:34 
----------------------------------------------------------------------
Submitter: Is there still an issue here or can this report be closed?

----------------------------------------------------------------------
 darkbrain - 03-19-05 18:17 
----------------------------------------------------------------------
Yes it was my mistake on openal configuration file.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:36 darkbrain      New Issue                                    
12-07-04 18:42 tiwai          Note Added: 0002757                          
12-07-04 18:51 darkbrain      Note Added: 0002759                          
12-07-04 18:54 tiwai          Note Added: 0002761                          
12-07-04 18:59 darkbrain      Note Added: 0002762                          
03-19-05 16:34 jdthood        Note Added: 0004056                          
03-19-05 18:17 darkbrain      Note Added: 0004060                          
03-22-05 15:01 jdthood        Status                   new => resolved     
03-22-05 15:01 jdthood        Resolution               open => not an issue
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
