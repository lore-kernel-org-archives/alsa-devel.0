From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000580]: usb midi devices invisible to aconnect
Date: Thu, 14 Oct 2004 09:13:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041014071316.133992C014@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 45B992A1
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2004 09:13:16 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000580
======================================================================
Reported By:                carmen
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     580
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               debian
Kernel Version:              2.6.8.1 x86_64
======================================================================
Date Submitted:             10-13-2004 07:39 CEST
Last Modified:              10-14-2004 09:13 CEST
======================================================================
Summary:                    usb midi devices invisible to aconnect
Description: 
midi devices such as Fastlane/Midisport USB, pass simple connection tests
w/ amidi, and create output on /dev/midi01, etc. but they are unpatchable
as they do not appear in aconnect...
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 10-13-2004 18:20 CEST 
----------------------------------------------------------------------
Apparently, the snd-seq-midi module isn't loaded.

----------------------------------------------------------------------
 carmen - 10-13-2004 19:33 CEST 
----------------------------------------------------------------------
yep that was it. please mark closed. everything checks out clean with
usb-audio on x86_64 (1.07-CVS) except the 0-padding i already emailed
about. (address 731/1001/1 reported as 0731/1001/0001 to shell cript..)

----------------------------------------------------------------------
 Clemens Ladisch - 10-14-2004 09:13 CEST 
----------------------------------------------------------------------
Sequencer module autoloading already fixed in CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-13-04 07:39 carmen         New Bug                                      
10-13-04 07:39 carmen         Distribution              => debian          
10-13-04 07:39 carmen         Kernel Version            =>  2.6.8.1 x86_64 
10-13-04 18:20 Clemens LadischBugnote Added: 0002129                       
10-13-04 19:33 carmen         Bugnote Added: 0002134                       
10-14-04 09:13 Clemens LadischBugnote Added: 0002137                       
10-14-04 09:13 Clemens LadischResolution               open => fixed       
10-14-04 09:13 Clemens LadischStatus                   assigned => resolved
10-14-04 09:13 Clemens LadischStatus                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
