From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002082]: Mute switch not working
Date: Tue, 2 May 2006 18:41:49 +0200
Message-ID: <b5cf62c437871d3cef0bda2c561fee2c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BC2E19F
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 18:41:50 +0200 (MEST)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2082> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2082
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-28-2006 14:25 CEST
Last Modified:              05-02-2006 18:41 CEST
======================================================================
Summary:                    Mute switch not working
Description: 
Same hw of bug #2059.
Mute switch has no effect.
The notebook I'm using has a button to enable/disable in hardware output,
that's working of course, under windows the event is caught and replied to
mixer (and from mixer the button functionality is called). On linux of
course nothing happends.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-06 18:09 
----------------------------------------------------------------------
It's rather a problem of window manager.

Such an event is handled by an applet (or a daemon) on user-space, not by
the kernel driver.

----------------------------------------------------------------------
 fdoffizi01 - 05-02-06 18:41 
----------------------------------------------------------------------
I think I didn't explain it right way.
If I use alsamixer to mute some channels output, it's done in userspace?
It's not asked to kernel/module to turn off output reproduction?
Of course hardware led and switch it's an userspace daemon work, but
making sound actually disappear when selecting mute option from mixers is
still a userspace task?
(On another notebook with i8x0 I had a wheel to controll via hw the output
BUT when I selected mute from kmix green led I got no sound, as expected.)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-06 14:25 fdoffizi01     New Issue                                    
05-02-06 18:09 tiwai          Status                   assigned => resolved
05-02-06 18:09 tiwai          Resolution               open => not an issue
05-02-06 18:09 tiwai          Note Added: 0009566                          
05-02-06 18:41 fdoffizi01     Status                   resolved => feedback
05-02-06 18:41 fdoffizi01     Resolution               not an issue => reopened
05-02-06 18:41 fdoffizi01     Note Added: 0009571                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
