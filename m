From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000603]: dshare & VIA Technologies VT82xxxxx UHCI USB 1.1 Controller pops
Date: Mon, 25 Oct 2004 23:17:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8705e5daf2e19bc34e8fab0e8f77bd0a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 834E0208
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 23:17:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=603> 
======================================================================
Reported By:                Stuart
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   603
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8-1-686
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
======================================================================
Date Submitted:             10-25-2004 23:13 CEST
Last Modified:              10-25-2004 23:17 CEST
======================================================================
Summary:                    dshare & VIA Technologies VT82xxxxx UHCI USB 1.1
Controller pops
Description: 
I changed my motherboard and now sound via dshare pops. My new (very old)
SL-67EV1 motherboard has a VIA VT82xxxxx UHCI USB 1.1 Controller.
Listening with alsaplayer to music on my USB Audiotrak Maya EX7 with
"plug" works fine but listening to music via dshare pops.
/proc/asound/version contains
Advanced Linux Sound Architecture Driver Version 1.0.7rc2.
Compiled on Oct 17 2004 for kernel 2.6.8-1-686.

======================================================================

----------------------------------------------------------------------
 Stuart - 10-25-04 23:17 
----------------------------------------------------------------------
Here is my ~/.asoundrc file in a more readable format:

pcm_slave.ex7 {
        pcm "hw:USB"
        channels 8
        rate 44100
        period_size 1024 # 2048 works bad with SL-67EV1
        buffer_size 2048 # 4096 hangs with SL-67EV1
}
pcm.ch12 {
        type dshare
        ipc_key 1234321
        slave ex7
        bindings.0 0
        bindings.1 1
}
pcm.ch34 {
        type dshare
        ipc_key 1234321
        slave ex7
        bindings.0 2
        bindings.1 3
}
pcm.phones {
        type plug
        slave.pcm ch12
}
pcm.main {
        type plug
        slave.pcm ch34
}
pcm.!default {
        type plug
        slave.pcm ch34
}
pcm.mplayer{
        type plug
        slave.pcm "hw:USB"
        ttable
        {
                0 { 2 1 }
                1 { 3 1 }
        }
}
pcm.direct{
        type plug
        slave.pcm "hw:USB"
        ttable
        {
                0 { 0 1 }
                1 { 1 1 }
        }
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-04 23:13 Stuart         New Issue                                    
10-25-04 23:13 Stuart         File Added: .asoundrc                        
10-25-04 23:13 Stuart         Distribution              => Debian          
10-25-04 23:13 Stuart         Kernel Version            => 2.6.8-1-686
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  
10-25-04 23:17 Stuart         Note Added: 0002263                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
