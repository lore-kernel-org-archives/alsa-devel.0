From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002082]: Mute switch not working
Date: Tue, 2 May 2006 19:29:28 +0200
Message-ID: <babb866709cae297a33db3ecdba46735@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF60D19F
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 19:29:28 +0200 (MEST)
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
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-28-2006 14:25 CEST
Last Modified:              05-02-2006 19:29 CEST
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
 fdoffizi01 - 05-02-06 19:16 
----------------------------------------------------------------------
So when I mute/unmute master channel from alsamixer o kmix or other mixer
software it's ok I continue hearing sounds till someone will add some acpi
support? I was thinking that when muting via software was a alsa-lib task
to ask hardware to mute output line.
Ok, so where could I ask support about it?

----------------------------------------------------------------------
 tiwai - 05-02-06 19:29 
----------------------------------------------------------------------
You mixed up two things -- the mute switch on a mixer application and the
"hardware" mute switch (button) on your laptop.

If the former, e.g. mute on alsamixer, doesn't work, then it's a totally
different problem from what you described in the original post.  Please
open another bug.

As mentioned, the latter has no direct relation with the sound driver. 
The button event is propagated by another mechanism like ACPI events, not
through the sound driver.

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
05-02-06 18:50 tiwai          Status                   feedback => resolved
05-02-06 18:50 tiwai          Resolution               reopened => not an issue
05-02-06 18:50 tiwai          Note Added: 0009572                          
05-02-06 19:16 fdoffizi01     Status                   resolved => feedback
05-02-06 19:16 fdoffizi01     Resolution               not an issue => reopened
05-02-06 19:16 fdoffizi01     Note Added: 0009573                          
05-02-06 19:29 tiwai          Status                   feedback => resolved
05-02-06 19:29 tiwai          Resolution               reopened => not an issue
05-02-06 19:29 tiwai          Note Added: 0009574                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
