From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000852]: alsa driver do not work on IBM thinkpad T42
Date: Tue, 31 May 2005 18:04:13 +0200
Message-ID: <c42806e66776b196c4d0cca49f3290f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC4D11BF
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:04:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=852> 
======================================================================
Reported By:                lithium7456
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   852
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-28-2005 05:26 CET
Last Modified:              05-31-2005 18:04 CEST
======================================================================
Summary:                    alsa driver do not work on IBM thinkpad T42
Description: 
After the installation of slackware linux 10 ,I found that the alsa driver
1.05(with slackware linux )do not work: when i run "alsamixer" it shows
that "no mixer elems". So I downloaded driver 1.08 and had it installed.
now I can run alsamixer without any error message but my computer does not
play any sound at all(I have run alsaconf and it detected the soundcard as
snd-intel8x0)
What steps shall I
take&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=65311;
please Re to lithium7456@sohu.com
Thank you
======================================================================

----------------------------------------------------------------------
 lithium7456 - 02-02-05 16:20 
----------------------------------------------------------------------
oh..it works....now I can hear music in linux now 
Thank you very much!!

----------------------------------------------------------------------
 tiwai - 02-04-05 13:14 
----------------------------------------------------------------------
Ok, moved to FIXED.
Note that the latest version doesn't enable these controls.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 05:26 lithium7456    New Issue                                    
01-28-05 17:47 tiwai          Note Added: 0003430                          
02-02-05 16:20 lithium7456    Note Added: 0003489                          
02-04-05 13:14 tiwai          Status                   new => resolved     
02-04-05 13:14 tiwai          Resolution               open => fixed       
02-04-05 13:14 tiwai          Assigned To               => tiwai           
02-04-05 13:14 tiwai          Note Added: 0003503                          
02-04-05 13:14 tiwai          Assigned To              tiwai =>            
02-18-05 18:36 mutated        Issue Monitored: mutated                     
05-31-05 18:04 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
