From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001073]: Loss of keyboard response after powering down Extigy
Date: Fri, 8 Jul 2005 10:37:22 +0200
Message-ID: <c5192bbd418c5038d8aba041e3d5b111@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0EC8518A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:37:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1073> 
======================================================================
Reported By:                mrnoonan81
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1073
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.11-r6
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-24-2005 04:47 CEST
Last Modified:              07-08-2005 10:37 CEST
======================================================================
Summary:                    Loss of keyboard response after powering down Extigy
Description: 
After powering down my Sound Blaster Extigy using the snd-usb-audio driver,
my keyboard becomes non-responsive and in addition, I am unable to shut
down properly (using the mouse, of course).  I use a PS/2 keyboard, so I
don't expect this is an issue with the USB driver(s).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000977 Unplug playing USB audio device: normal...
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 04-25-05 10:42 
----------------------------------------------------------------------
There was a bug in the USB audio driver that resulted in the kernel input
event thread being blocked.

This has been fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 04:47 mrnoonan81     New Issue                                    
04-24-05 04:47 mrnoonan81     Distribution              => Gentoo          
04-24-05 04:47 mrnoonan81     Kernel Version            => 2.6.11-r6       
04-25-05 10:42 Clemens LadischStatus                   assigned => resolved
04-25-05 10:42 Clemens LadischResolution               open => fixed       
04-25-05 10:42 Clemens LadischNote Added: 0004569                          
04-25-05 10:49 Clemens LadischRelationship added       has duplicate 0000977
07-08-05 10:37 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
