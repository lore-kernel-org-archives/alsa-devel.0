From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000444]: Need a way to select analog I/O levels on Delta66/44
Date: Sat, 31 Dec 2005 07:21:26 +0100
Message-ID: <7a1f6d858707a089a07ca0f16f94c1b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AE61F176
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 07:21:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=444> 
======================================================================
Reported By:                c0ff
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   444
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.8-rc4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-15-2004 17:21 CEST
Last Modified:              12-31-2005 07:21 CET
======================================================================
Summary:                    Need a way to select analog I/O levels on Delta66/44
Description: 
Delta66/44 cards support 3 analog level settings (+4dBu, Consumer, -10dBV).
One setting for all outputs, and per-input settings. We need a way to
change them :). Thank you.

======================================================================

----------------------------------------------------------------------
 c0ff - 08-30-04 15:15 
----------------------------------------------------------------------
Thanks a lot. You are right. That input levels are called IPGA-levels in
alsa dirver. But where is the output level control? Or it is another
simplification for poor windoze users who don't even get a chance to get
what they want from their own hardware? ;)

----------------------------------------------------------------------
 rlrevell - 12-31-05 07:21 
----------------------------------------------------------------------
Not a bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 17:21 c0ff           New Issue                                    
08-15-04 17:21 c0ff           Distribution              => Gentoo          
08-15-04 17:21 c0ff           Kernel Version            => 2.6.8-rc4       
08-27-04 22:17 edrz           Note Added: 0001658                          
08-30-04 15:15 c0ff           Note Added: 0001669                          
12-31-05 07:21 rlrevell       Status                   new => closed       
12-31-05 07:21 rlrevell       Note Added: 0007349                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
