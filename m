From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000916]: no sound
Date: Tue, 31 May 2005 18:03:47 +0200
Message-ID: <fee911c031203f33cb999f82e29f7cd3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 406AB1D3
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=916> 
======================================================================
Reported By:                mbarrett
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   916
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               FC3
Kernel Version:             2.6.10-1.766_FC3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-17-2005 17:00 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    no sound
Description: 
I have sound with kernel 2.6.9
It dissapeared when I installed kernel 2.6.10
Sound works on my Laptop (Dell) with the same kernel, just not my desktop
(Compaq D310m)
Any suggestions?

My sound card is an Intel 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio
======================================================================

----------------------------------------------------------------------
 manu-972 - 03-03-05 05:44 
----------------------------------------------------------------------
Just to be more precise here is the fix that I think cure this:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11772.html

----------------------------------------------------------------------
 perex - 03-03-05 09:57 
----------------------------------------------------------------------
The mentioned patch is already in CVS, so I assume that the problem is
fixed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-05 17:00 mbarrett       New Issue                                    
02-17-05 17:00 mbarrett       Distribution              => FC3             
02-17-05 17:00 mbarrett       Kernel Version            => 2.6.10-1.766_FC3
02-17-05 18:27 tiwai          Note Added: 0003631                          
03-03-05 05:42 manu-972       Note Added: 0003783                          
03-03-05 05:44 manu-972       Note Added: 0003784                          
03-03-05 09:55 perex          Category                 PCI - intel8x0 => PCI -
intel8x0m
03-03-05 09:57 perex          Status                   new => resolved     
03-03-05 09:57 perex          Resolution               open => fixed       
03-03-05 09:57 perex          Assigned To               => perex           
03-03-05 09:57 perex          Note Added: 0003785                          
03-03-05 09:57 perex          Assigned To              perex =>            
03-10-05 05:53 johnz          Issue Monitored: johnz                       
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
