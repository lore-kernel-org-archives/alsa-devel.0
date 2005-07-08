From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000977]: Unplug playing USB audio device: normal keyboard dies.
Date: Fri, 8 Jul 2005 10:37:20 +0200
Message-ID: <d34826dab64cec1171a7674400fc5c3e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 555A518B
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:37:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=977> 
======================================================================
Reported By:                jhje00
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   977
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian.
Kernel Version:             2.6.10 + 2.6.11.
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-09-2005 22:22 CET
Last Modified:              07-08-2005 10:37 CEST
======================================================================
Summary:                    Unplug playing USB audio device: normal keyboard
dies.
Description: 
Using an EgoSys U2A USB audio device I have observed that when unplugging
the device while it is in use by e.g. xmms or jackd a slew of error
messages appear. After that, local keyboard is unusable. Mouse and X
works, remote login is still functional, but I am unable to regain local
keyboard.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001073 Loss of keyboard response after powerin...
has duplicate       0000695 Turning off Audigy 2 NX makes keyboard ...
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 04-25-05 10:50 
----------------------------------------------------------------------
There was a bug in the USB audio driver that resulted in the kernel input
event thread being blocked.

This has been fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-05 22:22 jhje00         New Issue                                    
03-09-05 22:22 jhje00         Distribution              => Debian.         
03-09-05 22:22 jhje00         Kernel Version            => 2.6.10 + 2.6.11.
04-25-05 10:49 Clemens LadischRelationship added       duplicate of 0001073
04-25-05 10:50 Clemens LadischStatus                   assigned => resolved
04-25-05 10:50 Clemens LadischResolution               open => fixed       
04-25-05 10:50 Clemens LadischNote Added: 0004572                          
04-25-05 10:59 Clemens LadischRelationship added       has duplicate 0000695
07-08-05 10:37 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
