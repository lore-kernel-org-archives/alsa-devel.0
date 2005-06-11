From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001116]: Ghost MPU 401 Device hangs my Laptop
Date: Sat, 11 Jun 2005 15:04:44 +0200
Message-ID: <f1acae085ca5510b21d8db26ceb88b2a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 679691D2
	for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2005 15:04:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1116> 
======================================================================
Reported By:                keinstein
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1116
Category:                   PCI - trident
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Debian/testing
Kernel Version:             2.6.11.6
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             05-18-2005 17:08 CEST
Last Modified:              06-11-2005 15:04 CEST
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

----------------------------------------------------------------------
 tiwai - 06-11-05 15:04 
----------------------------------------------------------------------
I disabled MPU401 for SIS7018 as workaround on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-05 17:08 keinstein      New Issue                                    
05-18-05 17:08 keinstein      Distribution              => Debian/testing  
05-18-05 17:08 keinstein      Kernel Version            => 2.6.11.6        
05-19-05 14:13 tiwai          Note Added: 0004691                          
06-11-05 15:04 tiwai          Status                   new => resolved     
06-11-05 15:04 tiwai          Resolution               open => suspended   
06-11-05 15:04 tiwai          Assigned To               => tiwai           
06-11-05 15:04 tiwai          Note Added: 0004990                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
