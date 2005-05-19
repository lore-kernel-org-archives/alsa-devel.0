From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001116]: Ghost MPU 401 Device hangs my Laptop
Date: Thu, 19 May 2005 14:13:58 +0200
Message-ID: <f8b594056ace4801412dd9d8478f00fb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 93BD11F2
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2005 14:13:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1116> 
======================================================================
Reported By:                keinstein
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1116
Category:                   PCI - trident
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian/testing
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             05-18-2005 17:08 CEST
Last Modified:              05-19-2005 14:13 CEST
======================================================================
Summary:                    Ghost MPU 401 Device hangs my Laptop
Description: 
The trident driver for my Laptop (SIS 630 / SIS 7018) seems to initialize a
mpu device, which may be not present in my computer. At least I don't have
a game port  connector at that computer. Trying to access it well hang my
computer.
amidi seems to work but cannot be stopped. The computer doesn't respond to
any keyboard action as in X as on the text console. 
Running amidi -p hw:0,0 on the console fills the screen with lines
starting with 01, 03, 05 or 07. After a time this number is increased. But
it seems to end at 07.

It is very annoying as programs like noteedit, that insist on accessing
midi ports will hang my computer at start. 

======================================================================

----------------------------------------------------------------------
 tiwai - 05-19-05 14:13 
----------------------------------------------------------------------
Disabling mpu401 for SI7018 might be the easiest solution.
Is there any device with SI7018 and MPU401 at all?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-05 17:08 keinstein      New Issue                                    
05-18-05 17:08 keinstein      Distribution              => Debian/testing  
05-18-05 17:08 keinstein      Kernel Version            => 2.6.11.6        
05-19-05 14:13 tiwai          Note Added: 0004691                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
