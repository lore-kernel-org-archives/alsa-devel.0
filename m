From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000649]: alsaplayer only works as root
Date: Fri, 8 Jul 2005 10:34:38 +0200
Message-ID: <77c0a81b33d676682f8bbaa2754f8020@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A157D1A8
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=649> 
======================================================================
Reported By:                mthoro
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   649
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-14-2004 15:37 CET
Last Modified:              07-08-2005 10:34 CEST
======================================================================
Summary:                    alsaplayer only works as root
Description: 
changed permissions on snd devices to 777.  player only works after login
as root.  after login as user in audio group, player will not work even if
I log back in as root.  I have to reboot and login as root to get the
player to work again. gnome cd player works okay, but the alsaplayer is
great!
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-15-04 18:10 
----------------------------------------------------------------------
It seems you're using a system that automatically creates device nodes
(devfs or udev).  You have to change the devfs/udev configuration so that
it sets correct permissions.  Ask the debian experts.

----------------------------------------------------------------------
 jdthood - 03-20-05 13:31 
----------------------------------------------------------------------
This report can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-04 15:37 mthoro         New Issue                                    
11-15-04 18:10 Clemens LadischNote Added: 0002417                          
03-20-05 13:31 jdthood        Note Added: 0004087                          
03-20-05 13:36 perex          Status                   new => resolved     
03-20-05 13:36 perex          Resolution               open => not an issue
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
