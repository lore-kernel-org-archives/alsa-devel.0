From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001040]: ice1724: Invalid EEPROM (size = 255)
Date: Thu, 16 Mar 2006 08:49:09 +0100
Message-ID: <028bdf2d7821e805972fa85d674d1e9d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1AEA51FB
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:49:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1040> 
======================================================================
Reported By:                lorenb
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1040
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.11
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-08-2005 14:10 CEST
Last Modified:              03-16-2006 08:49 CET
======================================================================
Summary:                    ice1724: Invalid EEPROM (size = 255)
Description: 
Have a Shuttle SN25P based system:
http://global.shuttle.com/Product/Barebone/SN25P.asp

It comes with VIA Envy24PT audio controller:
http://www.via.com.tw/en/products/audio/controllers/envy24pt/

Every time I tried and load the ice1724 driver I get an error about
invalid EEPROM size.

I saw this old bug:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000142

Which indicated this issue was resolved in 1.0.5a.  I'm using v1.0.9rc2.

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:28 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

----------------------------------------------------------------------
 lorenb - 12-30-05 05:32 
----------------------------------------------------------------------
Yeah the card now works fine with the current ALSA in the Linux kernel. You
can close the bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-08-05 14:10 lorenb         New Issue                                    
04-08-05 14:10 lorenb         Distribution              => Gentoo          
04-08-05 14:10 lorenb         Kernel Version            => 2.6.11          
04-09-05 19:09 ungod          Note Added: 0004427                          
04-12-05 21:11 lorenb         Note Added: 0004464                          
12-30-05 05:28 rlrevell       Note Added: 0007247                          
12-30-05 05:32 lorenb         Note Added: 0007248                          
03-16-06 08:49 rlrevell       Status                   new => resolved     
03-16-06 08:49 rlrevell       Resolution               open => fixed       
03-16-06 08:49 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
