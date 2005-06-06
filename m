From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000908]: suport for ESI Juli@ - ICE1724
Date: Mon, 6 Jun 2005 10:41:11 +0200
Message-ID: <b8cf9014051ab2ad3d1ff929d09ef872@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 27DEB17A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 10:41:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=908> 
======================================================================
Reported By:                arsen
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   908
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.11-rc4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-14-2005 19:38 CET
Last Modified:              06-06-2005 10:41 CEST
======================================================================
Summary:                    suport for ESI Juli@ - ICE1724
Description: 
Hello. I have soundcard ESI Juli@ on chipset ICE1724.
I tried run her with alsa 1.0.8 on kernel 2.6.10 and 2.6.11.
Unfortunely soundcard don't work. In my logs i found that:

- ice1724: No matching model found for ID 0x31305345
- ice1724: Invalid EEPROM (size = 120)
- ICE1724: probe of 0000:00:0a.0 failed with error -5
- ALSA device list:
- No soundcards found

I know that other cards work correctly on this chipset and
if it's necesarry i could help in tests of driver for this
soundcard.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000930 Ego Sys <a href="mailto:Juli@ does" tar...
======================================================================

----------------------------------------------------------------------
 perex - 06-06-05 10:41 
----------------------------------------------------------------------
The driver is available now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-14-05 19:38 arsen          New Issue                                    
02-14-05 19:38 arsen          Distribution              => Gentoo          
02-14-05 19:38 arsen          Kernel Version            => 2.6.11-rc4      
02-15-05 07:32 arsen          Issue Monitored: arsen                       
02-22-05 10:07 perex          Status                   new => assigned     
02-22-05 10:07 perex          Assigned To               => perex           
02-22-05 10:07 perex          Relationship added       related to 0000930  
06-06-05 10:41 perex          Status                   assigned => resolved
06-06-05 10:41 perex          Resolution               open => fixed       
06-06-05 10:41 perex          Note Added: 0004897                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
